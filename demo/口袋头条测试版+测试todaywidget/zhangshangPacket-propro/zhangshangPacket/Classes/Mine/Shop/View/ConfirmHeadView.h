//
//  ConfirmHeadView.h
//  CrazyPacket
//
//  Created by WuYanZu on 17/3/1.
//  Copyright © 2017年 WuYanZu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PPNumberButton.h"

@interface ConfirmHeadView : UIView
@property (nonatomic, copy) void (^NumberChangeBlock)(NSString *);
@property (nonatomic, strong) UIImageView *photoImageView;
@property (nonatomic, strong) UILabel *titleLab;
@property (nonatomic, strong) UILabel *integralLab;
@property (nonatomic, strong) UILabel *allIntegralLab;
@property (nonatomic, strong) PPNumberButton *numberButton;
@property (nonatomic, strong) UILabel *balanceLab;
@property (nonatomic, assign) NSInteger maxNumber;
@end
