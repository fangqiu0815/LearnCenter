//
//  XWTodayDetailCell.h
//  zhangshangPacket
//
//  Created by apple on 2017/8/3.
//  Copyright © 2017年 apple-fangqiu. All rights reserved.
//

#import "XWCell.h"
#import "XWDisHeaderModel.h"

@interface XWTodayDetailCell : XWCell

@property (nonatomic, strong) UIImageView *imageTitleView;

@property (nonatomic, strong) UILabel *lblTitle;

@property (nonatomic, strong) UILabel *detailLab;

@property (nonatomic, strong) UILabel *resourceLab;

@property (nonatomic, strong) UIButton *authorLab;

@property (nonatomic, strong) UIView *bottomLine;

@property (nonatomic, strong) DisHeaderModel *dataModel;





@end
