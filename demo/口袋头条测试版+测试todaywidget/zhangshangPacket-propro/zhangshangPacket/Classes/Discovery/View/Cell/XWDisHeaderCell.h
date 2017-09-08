//
//  XWDisHeaderCell.h
//  zhangshangPacket
//
//  Created by apple on 2017/8/2.
//  Copyright © 2017年 apple-fangqiu. All rights reserved.
//

#import "XWCell.h"
#import "XWDiscoveryModel.h"
@interface XWDisHeaderCell : XWCell

@property (nonatomic, strong) UIButton *button1;

@property (nonatomic, strong) UIButton *button2;


@property (nonatomic, strong) XWEditSelected *selectModel;

- (void)setDataWithFirstPic:(NSString *)picStr1 andFirstTitle:(NSString *)titleStr1 withTwicePic:(NSString *)picStr2 andTwiceTitle:(NSString *)titleStr2;

@end
