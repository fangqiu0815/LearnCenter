//
//  XWMineImageView.h
//  zhangshangPacket
//
//  Created by apple on 2017/7/17.
//  Copyright © 2017年 apple-fangqiu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XWMineImageView : UIView

/**
 * 头像
 */
@property(nonatomic, strong) UIImageView *iconImageView;

/**
 * 名字或是id
 */
@property(nonatomic, strong) UILabel *nameLab;

/**
 * 设置
 */
@property(nonatomic, strong) UIButton *setBtn;

@property (nonatomic, strong) UIImageView *boLangImgView;


@property (nonatomic, copy) void (^GotoChargeBlock)();


@end
