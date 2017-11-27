//
//  HMStatusCell.h
//  Weibo11
//
//  Created by 刘凡 on 15/12/9.
//  Copyright © 2015年 itheima. All rights reserved.
//

#import <UIKit/UIKit.h>
@class HMStatusViewModel;

@interface HMStatusCell : UITableViewCell
/// 微博数据模型
@property (nonatomic, strong) HMStatusViewModel *viewModel;
@end
