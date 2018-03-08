//
//  KDHeaderView.h
//  KDMediDetail
//
//  Created by apple-gaofangqiu on 2018/3/5.
//  Copyright © 2018年 apple-fangqiu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface KDHeaderView : UIView

/**
 * 分栏
 */
@property (nonatomic, strong) UISegmentedControl *segmentedControl;


/**
 创建headerview视图的方法

 @param frame headerview的frame
 @param titleStr 标题内容
 @param dicountStr 账号内容
 @param discriptionStr 描述内容
 
 */
- (instancetype)initWithFrame:(CGRect)frame title:(NSString *)titleStr discount:(NSString *)dicountStr description:(NSString *)discriptionStr;


@end
