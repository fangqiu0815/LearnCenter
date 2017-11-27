//
//  HMComposeTypeView.h
//  Weibo11
//
//  Created by 刘凡 on 15/12/12.
//  Copyright © 2015年 itheima. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HMComposeType.h"

@interface HMComposeTypeView : UIView

/// 构造函数
///
/// @param completed 完成回调
///
/// @return 撰写类型视图
- (instancetype)initWithSelectedComposeType:(void (^)(HMComposeType *type))completed;

/// 显示在指定视图中
- (void)showInView:(UIView *)view;

@end
