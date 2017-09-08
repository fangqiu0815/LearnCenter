//
//  XWTripleImageCell.h
//  zhangshangPacket
//
//  Created by apple on 2017/5/15.
//  Copyright © 2017年 apple-fangqiu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XWHomeModel.h"

@interface XWTripleImageCell : XWCell

@property (nonatomic, strong) UILabel *lblTitle;
@property (nonatomic, strong) UIImageView *imageLeft;
@property (nonatomic, strong) UIImageView *imageCenter;
@property (nonatomic, strong) UIImageView *imageRight;

@property (nonatomic, strong) UIImageView *adImageIcon;

@property (nonatomic, strong) UIImageView *adRewardImage;

@property (nonatomic, strong) UILabel *detailLab;

@property (nonatomic, strong) UILabel *resourceLab;

@property (nonatomic, strong) NewsListDataModel *model;
@property (nonatomic, strong) UIView *bottomLine;




@end
