//
//  XWMidHistoryCashCell.h
//  zhangshangPacket
//
//  Created by apple on 2017/6/7.
//  Copyright © 2017年 apple-fangqiu. All rights reserved.
//

#import "XWCell.h"

@interface XWMidHistoryCashCell : XWCell


@property (nonatomic, strong) UILabel *titleLab;

@property (nonatomic, strong) UILabel *detailLab;

- (void)setCellDataWithTitle:(NSString *)titleStr andRightTitle:(NSString *)rightTitle;

@end
