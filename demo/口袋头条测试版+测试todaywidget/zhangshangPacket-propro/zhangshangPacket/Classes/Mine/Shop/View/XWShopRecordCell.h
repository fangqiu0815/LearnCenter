//
//  XWShopRecordCell.h
//  zhangshangPacket
//
//  Created by 高方秋 on 2017/6/7.
//  Copyright © 2017年 apple-fangqiu. All rights reserved.
//

#import "XWCell.h"
#import "XWUserGoodslist.h"

@interface XWShopRecordCell : XWCell

@property (nonatomic, strong) UILabel *titleLab;

@property (nonatomic, strong) UILabel *accountExLab;

@property (nonatomic, strong) UILabel *moneyLab;

@property (nonatomic, strong) UILabel *addressLab;

@property (nonatomic, strong) UILabel *signLab;

@property (nonatomic, strong) UILabel *timeLab;

@property (nonatomic, strong) UserGoodsList *goodsModel;

@property (nonatomic, strong) UIView *bottomView;

-(void)setcell:(NSDictionary *)dic;

@end
