//
//  SBMap.h
//  SmartBus
//
//  Created by 飞瞳凡想 on 14-5-6.
//  Copyright (c) 2014年 飞瞳凡想. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SBABaseData.h"

#pragma mark -Color Type

#define ColorBlue [UIColor colorWithRed:0.0 green:153/255.0 blue:204/255.0 alpha:1.0]
#define ColorGreen [UIColor colorWithRed:153/255.0 green:204/255.0 blue:51/255.0 alpha:1.0]
#define ColorOrange [UIColor colorWithRed:1.0 green:153/255.0 blue:51/255.0 alpha:1.0]
#define ColorRed [UIColor colorWithRed:1.0 green:51/255.0 blue:51/255.0 alpha:1.0]
#define ColorYellow [UIColor colorWithRed:1.0 green:220/255.0 blue:0.0 alpha:1.0]
#define ColorDefault [UIColor colorWithRed:0.5 green:0.5 blue:0.5 alpha:1.0]

/** 执行数据反馈操作 */
@protocol SBAMapViewDataSource;
/** 提供绘图数据 */
@protocol SBAMapViewDelegate;

#pragma mark -SBAMapView API

/** 地图绘制类 */
@interface SBAMapView : UIView

/** delegate对象，执行数据反馈操作 */
@property (nonatomic,assign) id<SBAMapViewDelegate> delegate;
/** dataSource对象，提供绘图数据 */
@property (nonatomic,assign) id<SBAMapViewDataSource> dataSource;
/** 是否隐藏空白坐标，默认为NO */
@property (nonatomic,assign) BOOL shouldHiddenPosition;
/** 是否开启触摸事件，默认为NO */
@property (nonatomic,assign) BOOL shouldTouchEvent;
/** 是否值追踪即将到站的公交，默认为NO */
@property (nonatomic,assign) BOOL onlyTrackArriving;
/** 背景图片 */
@property (nonatomic,strong) UIImage *bground;
/** 默认颜色 */
@property (nonatomic,strong) UIColor *dColor;
/** 
 * 刷新地图公交数据
 * @param bus
 */
-(void) reloadBusData:(SBABus *)bus;
/**
 * 刷新当前站台信息
 * @param stop
 */
- (void) reloadStopData:(SBAStop *)stop;
/**
 * 刷新标志线路信息
 * @param mapView
 * @param SBALine
 * @param color
 */
- (void) reloadLineData:(SBALine *)line withColor:(UIColor *)color;
/** 刷新地图所有信息 */
-(void) reloadAllData;

@end

#pragma  mark -SBMapView Delegate

@protocol SBAMapViewDelegate <NSObject>
@optional
/**
 * 选中站台的回调操作
 * @param mapView
 * @param positionId
 */
-(void) mapView:(SBAMapView *)mapView didSelectStop:(NSString *)stopId;
/**
 * 选中坐标的回调操作
 * @param mapView
 * @param positionId
 */
-(void) mapView:(SBAMapView *)mapView didSelectPosition:(NSString *)positionId;
/**
 * 选中空白的回调操作
 * @param mapView
 */
-(void) didSelectOutSide:(SBAMapView *)mapView;

@end
#pragma mark -SBMapView DataSource

@protocol SBAMapViewDataSource <NSObject>
@required
/**
 * 设置地图绘图信息
 * NSArray 为 SBPosition 数组
 * @param SBMapView
 * @return NSArray
 */
- (NSArray *) drawMapData:(SBAMapView *)mapView;
@optional
/**
 * 设置线路绘图信息
 * NSArray 为 SBLine 数组
 * @param SBMapView
 * @return NSArray
 */
- (NSArray *) drawLineData:(SBAMapView *)mapView;
/**
 * 设置公交绘图信息
 * NSArray 为 SBBus 数组
 * @param SBMapView
 * @return NSArray
 */
- (NSArray *) drawBusData:(SBAMapView *)mapView;
/**
 * 设置站台绘图信息
 * NSArray 为 SBStop 数组
 * @param SBMapView
 * @return NSArray
 */
- (NSArray *) drawStopData:(SBAMapView *)mapView;

@end