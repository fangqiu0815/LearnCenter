//
//  XWCashInfoHeaderCell.h
//  zhangshangPacket
//
//  Created by apple on 2017/6/1.
//  Copyright © 2017年 apple-fangqiu. All rights reserved.
//

#import "XWCell.h"

@interface XWCashInfoHeaderCell : UIView

@property (nonatomic, strong) UILabel *everydayLab;

@property (nonatomic, strong) UILabel *cornLab;

@property (nonatomic, strong) UILabel *timeLab;

- (void)setCellMidTitle:(NSString *)midTitle;

@end
