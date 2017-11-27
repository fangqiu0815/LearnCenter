//
//  HMStatusToolBar.h
//  Weibo11
//
//  Created by 刘凡 on 15/12/9.
//  Copyright © 2015年 itheima. All rights reserved.
//

#import <UIKit/UIKit.h>
@class HMStatusViewModel;

/// 微博底部视图
@interface HMStatusToolBar : UIView

/// 微博数据模型
@property (nonatomic, strong) HMStatusViewModel *viewModel;
@end
