//
//  HMVisitorView.h
//  Weibo11
//
//  Created by 刘凡 on 15/12/5.
//  Copyright © 2015年 itheima. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HMVisitorView : UIView
/// 注册按钮
@property (nonatomic, strong) UIButton *registerButton;
/// 登录按钮
@property (nonatomic, strong) UIButton *loginButton;

/// 设置访客视图信息
///
/// @param imageName 图像名称 - 首页图像传入 nil
/// @param title     信息文本
- (void)visitorInfoWithImageName:(NSString *)imageName message:(NSString *)message;

@end
