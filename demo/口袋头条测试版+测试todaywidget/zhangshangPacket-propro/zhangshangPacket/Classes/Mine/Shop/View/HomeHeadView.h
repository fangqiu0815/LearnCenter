//
//  HomeHeadView.h
//  zhangshangPacket
//
//  Created by zhenhui huang on 2017/6/3.
//  Copyright © 2017年 apple-fangqiu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SDCycleScrollView.h"

@interface HomeHeadView : UIView
@property (nonatomic, strong) UILabel *NumLab;

@property (nonatomic, strong) SDCycleScrollView *bannerScrollView;
@property (nonatomic, copy) void (^AdClickBlock)(NSInteger);

@property (nonatomic, strong) UIButton *exchangeBtn;

@end
