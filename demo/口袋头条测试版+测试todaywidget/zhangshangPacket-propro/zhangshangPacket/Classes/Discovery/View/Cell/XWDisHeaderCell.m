//
//  XWDisHeaderCell.m
//  zhangshangPacket
//
//  Created by apple on 2017/8/2.
//  Copyright © 2017年 apple-fangqiu. All rights reserved.
//

#import "XWDisHeaderCell.h"

@implementation XWDisHeaderCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self.contentView addSubview:self.button1];
        [self.contentView addSubview:self.button2];
        
        [self addView];
    }
    return self;

}

- (void)setDataWithFirstPic:(NSString *)picStr1 andFirstTitle:(NSString *)titleStr1 withTwicePic:(NSString *)picStr2 andTwiceTitle:(NSString *)titleStr2
{
    
    
    
}

- (void)addView
{

}

- (UIButton *)button1
{
    if (!_button1) {
        _button1 = [[UIButton alloc]init];
    }
    return _button1;
    
}

- (UIButton *)button2
{
    if (!_button2) {
        _button2 = [[UIButton alloc]init];

    }
    return _button2;

}


@end
