//
//  XWImageCell.m
//  zhangshangPacket
//
//  Created by apple on 2017/6/2.
//  Copyright © 2017年 apple-fangqiu. All rights reserved.
//

#import "XWImageCell.h"

@implementation XWImageCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self.contentView addSubview:self.imgView];
        
        [self setupUI];
    }
    return self;
}

- (void)setDataCellWithImage:(UIImage *)adImage
{
    self.imgView.image = adImage;
}

- (void)setupUI
{
    [self.imgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.left.right.mas_equalTo(0);
    }];

}

- (UIImageView *)imgView
{
    if (!_imgView) {
        _imgView = [[UIImageView alloc]init];
    }
    return _imgView;
}


@end
