//
//  XWNewestenterCell.h
//  zhangshangPacket
//
//  Created by apple on 2017/8/1.
//  Copyright © 2017年 apple-fangqiu. All rights reserved.
//

#import "XWCell.h"
#import "XWDiscoveryModel.h"
#import "XWDisMoreDataModel.h"
@interface XWNewestenterCell : XWCell

@property (nonatomic, strong) UIImageView *iconImageView;

@property (nonatomic, strong) UILabel *lblTitle;

@property (nonatomic, strong) UILabel *detailLab;

@property (nonatomic, strong) UIView *lineView;

@property (nonatomic, strong) UIImageView *imgView;

@property (nonatomic, strong) XWNewestenter *dataModel;

-(void)setcell:(NSDictionary *)dic withindex:(NSInteger )index;

@property (nonatomic, strong) MoreDataListModel *model;

@end
