//
//  XWBigPicCell.h
//  zhangshangPacket
//
//  Created by apple on 2017/6/5.
//  Copyright © 2017年 apple-fangqiu. All rights reserved.
//

#import "XWCell.h"
#import "XWHomeModel.h"

@interface XWBigPicCell : XWCell

@property (nonatomic, strong) UILabel *titleLab;

@property (nonatomic, strong) UIImageView *iconImageView;

@property (nonatomic, strong) NewsListDataModel *model;

@property (nonatomic, strong) UIImageView *adImageIcon;

@property (nonatomic, strong) UIImageView *adRewardImage;

@property (nonatomic, strong) UILabel *resourceLab;

@property (nonatomic, strong) UIView *bottomLine;


@end
