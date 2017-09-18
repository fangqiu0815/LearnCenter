//
//  XWHobbyItemManager.h
//  zhangshangPacket
//
//  Created by apple-gaofangqiu on 2017/9/6.
//  Copyright © 2017年 apple-fangqiu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "XWHobbyItemModel.h"

#pragma mark =================   XWChannelStyle  =====================
@interface XWChannelStyle : NSObject

/** 频道tag距离两边的间距 */
@property (nonatomic, assign) CGFloat padding;
/** 关闭按钮的宽 */
@property (nonatomic, assign) CGFloat closeBtnW;
/** 关闭按钮切图 */
@property (nonatomic, strong) UIImage *closeImage;
/** 字体大小 */
@property (nonatomic, strong) UIFont *font;
/** 默认状态下的字体颜色 默认为黑色 */
@property (nonatomic, strong) UIColor *normalTextColor;
/** 选中状态下的字体颜色 默认是红色 */
@property (nonatomic, strong) UIColor *selectedTextColor;
/** 火热频道切图 */
@property (nonatomic, strong) UIImage *hotImage;
/** 火热频道切图的宽 */
@property (nonatomic, assign) CGFloat hotImageW;
/** 顶部label的背景图 */
@property (nonatomic, strong) UIImage *coverTopImage;
/** 底部label的背景图 */
@property (nonatomic, strong) UIImage *coverBottomImage;
/** 是否展示频道边框 默认是有圆角的边框,可在WyhChannelView中自定义 */
@property (nonatomic, assign) BOOL isShowBorder;
/** 是否展示频道背景图 注意一旦设置为YES需要对top、bottom都进行设置 默认NO  */
@property (nonatomic, assign) BOOL isShowCover;
/** 是否存在火热频道需要显示 默认YES */
@property (nonatomic, assign) BOOL isShowHot;

/** 是否显示移动占位图 */
@property (nonatomic, assign) BOOL isShowPlaceHolderView;
/** 是否显示大背景图 */
@property (nonatomic, assign) BOOL isShowBackCover;

@end


#pragma mark =================== XWHobbyItemManager ======================

typedef void(^updateCallBack)(NSArray<XWHobbyItemModel *> * top,NSArray<XWHobbyItemModel *> *bottom, NSUInteger chooseIndex);

@interface XWHobbyItemManager : NSObject

/** 顶部的频道数组 */
@property (nonatomic, strong) NSMutableArray<XWHobbyItemModel *> * topChannelArr;
/** 底部的频道数组 */
@property (nonatomic, strong) NSMutableArray<XWHobbyItemModel *> * bottomChannelArr;
/** 当前选中的model */
@property (nonatomic, strong) XWHobbyItemModel *initialModel;
/** 当前的index值 */
@property (nonatomic, assign) NSInteger initialIndex;
/** 当前的样式 */
@property (nonatomic, strong) XWChannelStyle *style;
/** 回调更新的block */
@property (nonatomic, copy) updateCallBack callBack;

/**
 *  更新频道方法
 *
 *  @param top          顶部频道数组
 *  @param bottom       底部频道数组
 *  @param initialIndex 当前选中的index
 *  @param style        当前的样式
 *  @return self
 */
+(instancetype)updateWithTopArr:(NSArray<XWHobbyItemModel *> *)top BottomArr:(NSArray<XWHobbyItemModel *> *)bottom InitialIndex:(NSUInteger)initialIndex newStyle:(XWChannelStyle *)style;

/**
 *  单例创建,方便外界取值,用updateWithTopArr进行创建
 */
+(instancetype)defaultManager;

/**
 *  选中后或消失页面的回调频道
 *  注意若将选中的频道删掉，回调的index为最后一个频道
 */
+(void)updateChannelCallBack:(updateCallBack)callback;


/**
 *  页面消失时调用此方法,告诉管理器现在需要回调频道信息
 */
+(void)setUpdateIfNeeds;

@end
