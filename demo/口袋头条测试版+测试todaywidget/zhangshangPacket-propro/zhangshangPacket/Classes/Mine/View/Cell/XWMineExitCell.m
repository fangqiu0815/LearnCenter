//
//  XWMineExitCell.m
//  zhangshangPacket
//
//  Created by apple on 2017/5/17.
//  Copyright © 2017年 apple-fangqiu. All rights reserved.
//

#import "XWMineExitCell.h"

@implementation XWMineExitCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        [self.contentView addSubview:self.quitLab];
        
        [self addView];
    }
    return self;
}

- (void)addView
{

    WeakType(self)
    [_quitLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(weakself);
        make.centerY.mas_equalTo(weakself);
        make.width.mas_equalTo([weakself.quitLab.text widthWithfont:weakself.quitLab.font] + 10*AdaptiveScale_W);
        make.height.mas_equalTo(30*AdaptiveScale_W);
    }];
    
}

- (UILabel *)quitLab
{
    if (!_quitLab) {
        _quitLab = [[UILabel alloc]init];
        _quitLab.textAlignment = NSTextAlignmentCenter;
        _quitLab.textColor = [UIColor blackColor];
//        _quitLab.text = [NSString stringWithFormat:@"版本 %@",SYS_NEWS_VERSION];
        _quitLab.font = [UIFont systemFontOfSize:RemindFont(14, 16, 18)];
    }
    return _quitLab;
}


@end
