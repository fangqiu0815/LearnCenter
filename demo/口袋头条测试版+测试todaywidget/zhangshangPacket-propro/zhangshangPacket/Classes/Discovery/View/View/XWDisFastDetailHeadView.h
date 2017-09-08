//
//  XWDisFastDetailHeadView.h
//  zhangshangPacket
//
//  Created by apple on 2017/8/4.
//  Copyright © 2017年 apple-fangqiu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XWDisFastRecommendModel.h"

@interface XWDisFastDetailHeadView : UIView

@property (nonatomic, strong) UIImageView *iconImageView;

@property (nonatomic, strong) UILabel *wechatName;

@property (nonatomic, strong) UILabel *wechatID;

@property (nonatomic, strong) UILabel *typeAndAccount;

@property (nonatomic, strong) UILabel *contentLab;

@property (nonatomic, strong) UIButton *gotoWechat;

@property (nonatomic, strong) DisFastRecommendList *dataModel;

@end
