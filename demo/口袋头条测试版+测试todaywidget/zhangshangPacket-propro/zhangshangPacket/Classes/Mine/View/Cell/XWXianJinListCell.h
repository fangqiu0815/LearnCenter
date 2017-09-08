//
//  XWXianJinListCell.h
//  zhangshangPacket
//
//  Created by apple on 2017/6/17.
//  Copyright © 2017年 apple-fangqiu. All rights reserved.
//

#import "XWCell.h"
#import "XWPacketModel.h"
#import "XWIncomeDetailInfoModel.h"
@interface XWXianJinListCell : XWCell


@property (nonatomic, strong) UILabel *titleLab;

@property (nonatomic, strong) UILabel *timeLab;

@property (nonatomic, strong) UILabel *moneyLab;

//@property (nonatomic, strong) UIImageView *iconImage;

- (void)setCellWithDic:(NSDictionary *)dic;

@property (nonatomic, strong) XWPacketInfoDetail *detailModel;

@end
