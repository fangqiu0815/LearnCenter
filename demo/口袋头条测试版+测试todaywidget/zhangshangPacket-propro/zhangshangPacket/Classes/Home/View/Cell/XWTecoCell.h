//
//  XWTecoCell.h
//  zhangshangPacket
//
//  Created by apple on 2017/6/14.
//  Copyright © 2017年 apple-fangqiu. All rights reserved.
//

#import "XWCell.h"
#import "XWHomeTecoModel.h"
@interface XWTecoCell : XWCell

@property (nonatomic, strong) UIImageView *imageTitleView;

@property (nonatomic, strong) UILabel *lblTitle;

@property (nonatomic, strong) UILabel *detailLab;

@property (nonatomic, strong) UIImageView *adImageIcon;

@property (nonatomic, strong) UIImageView *adRewardImage;

@property (nonatomic, strong) UILabel *resourceLab;


@property (nonatomic, strong) TecoListDataModel *model;

@property (nonatomic, strong) UILabel *authorLab;

@end
