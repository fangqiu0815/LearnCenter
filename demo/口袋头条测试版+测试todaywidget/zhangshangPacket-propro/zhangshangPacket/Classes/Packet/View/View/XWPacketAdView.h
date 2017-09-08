//
//  XWPacketAdView.h
//  zhangshangPacket
//
//  Created by apple on 2017/5/17.
//  Copyright © 2017年 apple-fangqiu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XWPacketAdView : UIView

/**
 * ad图片
 */
@property(nonatomic, strong) UIImageView *iconImageView;

/**
 * 标题
 */
@property(nonatomic, strong) UILabel *nameLab;


/**
 * info
 */
@property(nonatomic, strong) UILabel *detailLab;

/**
 * ad标识图片
 */
@property(nonatomic, strong) UIImageView *adImageView;

@property (nonatomic, copy) void (^GotoAdBlock)();


@end
