//
//  UIView+XWNightView.h
//  zhangshangPacket
//
//  Created by apple on 2017/7/19.
//  Copyright © 2017年 apple-fangqiu. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 *  日间模式和夜间模式的闭包函数类型
 *
 *  @param view 当前的控件
 */

typedef void(^DAY_AND_NIGHT_MODE_BLOCK)(UIView *view);

/**
 *  模式改变的监听事件
 */
extern NSString *const XWChangeModeNotification;

@interface UIView (XWNightView)

/**
 *  设置控件日间模式和夜间模式的内容
 *
 *  @param dayMode   日间模式设置内容
 *  @param nightMode 夜间模式设置内容
 */

- (void)xw_setDayMode:(DAY_AND_NIGHT_MODE_BLOCK)dayMode nightMode:(DAY_AND_NIGHT_MODE_BLOCK)nightMode;

@end
