//
//  XWTaskListHeaderCell.h
//  zhangshangPacket
//
//  Created by apple on 2017/5/31.
//  Copyright © 2017年 apple-fangqiu. All rights reserved.
//

#import "XWCell.h"

@interface XWTaskListHeaderCell : XWCell

@property (nonatomic, strong) UIView *redView;

@property (nonatomic, strong) UILabel *itemLab;

@property (nonatomic, strong) UILabel *rightLab;

/**
 设置任务cell的头视图
 @param titleStr            标题
 @param rightTitleStr       右标题
 
 */

- (void)setCellDataTitle:(NSString *)titleStr andrightTitle:(NSString *)rightTitleStr ;




@end
