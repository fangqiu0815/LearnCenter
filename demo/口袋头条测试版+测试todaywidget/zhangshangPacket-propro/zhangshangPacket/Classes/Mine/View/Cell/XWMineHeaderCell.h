//
//  XWMineHeaderCell.h
//  zhangshangPacket
//
//  Created by apple on 2017/5/17.
//  Copyright © 2017年 apple-fangqiu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XWMineHeaderCell : UIView

/**
 * 头像
 */
@property(nonatomic, strong) UIImageView *iconImageView;

/**
 * 名字或是id
 */
@property(nonatomic, strong) UILabel *nameLab;




@property (nonatomic, copy) void (^GotoChargeBlock)();



@end
