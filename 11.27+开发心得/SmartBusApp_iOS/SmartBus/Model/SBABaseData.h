//
//  SBBaseInfo.h
//  SmartBus
//
//  Created by 飞瞳凡想 on 14-5-6.
//  Copyright (c) 2014年 飞瞳凡想. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NSDictionary+EntityHelper.h"

#pragma mark -SBAPosition
/**
 * 数据封装类
 */
@interface SBAData : NSObject
/**
 * 标志位
 */
@property (nonatomic,strong) NSString *flag;
/**
 * bus数组
 */
@property (nonatomic,strong) NSArray *bus;
/**
 * line数组
 */
@property (nonatomic,strong) NSArray *line;
/**
 * stop数组
 */
@property (nonatomic,strong) NSArray *stop;
/**
 * position数组
 */
@property (nonatomic,strong) NSArray *position;
/**
 * 错误信息
 */
@property (nonatomic,strong) NSString *error;
/**
 * 版本号
 */
@property (nonatomic,assign) NSNumber *version;
/**
 * 由NSDictionary初始化SBData
 * @param dict
 * @return SBData
 */
-(SBAData *) initWithDicationary:(NSDictionary *)dict;
@end

/**
 * position对象
 */
@interface SBAPosition : NSObject

@property (nonatomic,strong) NSString *positionId;
@property (nonatomic,assign) NSNumber *x;
@property (nonatomic,assign) NSNumber *y;

@end

#pragma mark -SBABus
/**
 * bus对象
 */
@interface SBABus : NSObject

@property (nonatomic,strong) NSString *busId;
@property (nonatomic,assign) NSNumber *speed;
@property (nonatomic,assign) NSNumber *numberOfPeople;
@property (nonatomic,strong) NSString *positionId;

@end

#pragma mark -SBAStop
/**
 * stop1对象
 */
@interface SBAStop : NSObject

@property (nonatomic,strong) NSString *stopId;
@property (nonatomic,strong) NSString *stopName;
@property (nonatomic,strong) NSString *positionId;

@end

#pragma mark -SBALine
/**
 * line对象
 */
@interface SBALine : NSObject

@property (nonatomic,strong) NSString *lineId;
@property (nonatomic,strong) NSArray *stops;
@property (nonatomic,strong) NSArray *positions;

-(void) specialConvert;
@end
