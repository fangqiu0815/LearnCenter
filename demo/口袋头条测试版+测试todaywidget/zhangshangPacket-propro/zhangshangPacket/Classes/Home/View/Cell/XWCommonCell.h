//
//  XWCommonCell.h
//  zhangshangPacket
//
//  Created by apple on 2017/5/15.
//  Copyright © 2017年 apple-fangqiu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XWHomeModel.h"

@interface XWCommonCell : XWCell

@property (nonatomic, strong) UIImageView *imageTitleView;

@property (nonatomic, strong) UILabel *lblTitle;

@property (nonatomic, strong) UILabel *detailLab;

@property (nonatomic, strong) UIImageView *adImageIcon;

@property (nonatomic, strong) UIImageView *adRewardImage;

@property (nonatomic, strong) UILabel *resourceLab;


@property (nonatomic, strong) NewsListDataModel *model;

@property (nonatomic, strong) UILabel *authorLab;
@property (nonatomic, strong) UIView *bottomLine;

@end
