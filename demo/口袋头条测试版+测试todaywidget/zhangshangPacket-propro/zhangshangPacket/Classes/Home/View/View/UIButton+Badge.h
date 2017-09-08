//
//  UIButton+Badge.h
//  zhangshangPacket
//
//  Created by apple on 2017/5/16.
//  Copyright © 2017年 apple-fangqiu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIButton (Badge)

@property (strong, nonatomic) UILabel *badge;

// 角标数值
@property (nonatomic) NSString *badgeValue;
// 角标的背景颜色
@property (nonatomic) UIColor *badgeBGColor;
// 角标的文本颜色
@property (nonatomic) UIColor *badgeTextColor;
// 角标字体大小
@property (nonatomic) UIFont *badgeFont;
// 角标的padding
@property (nonatomic) CGFloat badgePadding;
// 角标的最小尺寸
@property (nonatomic) CGFloat badgeMinSize;
// 角标的起始X值
@property (nonatomic) CGFloat badgeOriginX;
// 角标的起始Y值
@property (nonatomic) CGFloat badgeOriginY;
// 零的时候移除角标
@property BOOL shouldHideBadgeAtZero;
// 角标数值改变时带动画
@property BOOL shouldAnimateBadge;



@end
