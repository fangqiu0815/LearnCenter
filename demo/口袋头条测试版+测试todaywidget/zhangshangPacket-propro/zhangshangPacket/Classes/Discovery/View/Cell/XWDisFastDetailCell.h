//
//  XWDisFastDetailCell.h
//  zhangshangPacket
//
//  Created by apple on 2017/8/4.
//  Copyright © 2017年 apple-fangqiu. All rights reserved.
//

#import "XWCell.h"
#import "XWDisFastRecommendModel.h"

@interface XWDisFastDetailCell : XWCell
@property (nonatomic, strong) UILabel *lblTitle;

@property (nonatomic, strong) UILabel *detailLab;

@property (nonatomic, strong) UILabel *authorLab;

@property (nonatomic, strong) UIImageView *iconImageView;

@property (nonatomic, strong) UIView *lineView;

//@property (nonatomic, strong) SearchPostListModel *dataModel;
@end
