//
//  XWGetCoinCell.h
//  zhangshangPacket
//
//  Created by apple on 2017/6/2.
//  Copyright © 2017年 apple-fangqiu. All rights reserved.
//

#import "XWCell.h"

@interface XWGetCoinCell : XWCell

@property (nonatomic, strong) UILabel *canGetLab;

@property (nonatomic, strong) UILabel *cashLab;

@property (nonatomic, strong) UIButton *tixianBtn;

@property (nonatomic, copy) void (^GotoChargeBlock)();


@end
