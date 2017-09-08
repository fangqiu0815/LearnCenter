//
//  XWCollectCell.m
//  zhangshangPacket
//
//  Created by apple on 2017/7/28.
//  Copyright © 2017年 apple-fangqiu. All rights reserved.
//

#import "XWCollectCell.h"
#import "XWHomeCheckCollectTool.h"
@interface XWCollectCell ()

@property (nonatomic, strong) NSMutableArray *dataArr;

@end
@implementation XWCollectCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if ([super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        [self.contentView addSubview:self.titleLab];
        [self.contentView addSubview:self.imgView];
        [self.contentView addSubview:self.timeLab];
        [self.contentView addSubview:self.bottomLine];
        self.contentView.dk_backgroundColorPicker = DKColorPickerWithColors(WhiteColor,NightMainBGColor,MainRedColor);
        
        
        [self addView];
    }
    return self;
    
}

- (void)setModel:(NewsCheckList *)model
{
    _model = model;
    
    self.titleLab.text = model.title;
    self.titleLab.dk_textColorPicker = DKColorPickerWithColors(BlackColor,WhiteColor,MainRedColor);

    
    [self.imgView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",model.imglist[0].imgurl]] placeholderImage:MyImage(@"bg_default")];
    //    self.timeLab.text = [NSString stringWithFormat:@"当前时间"];
    self.bottomLine.dk_backgroundColorPicker = DKColorPickerWithColors(MainBGColor,NightBolangBGColor,MainRedColor);
    
}



- (void)addView{
    WeakType(self);
    
    [self.imgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-10*AdaptiveScale_W);
        make.top.mas_equalTo(10*AdaptiveScale_W);
        make.bottom.mas_equalTo(-10*AdaptiveScale_W);
        make.width.mas_equalTo(120*AdaptiveScale_W);
    }];
    
    [self.titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15*AdaptiveScale_W);
        make.top.mas_equalTo(10*AdaptiveScale_W);
        make.right.mas_equalTo(weakself.imgView.mas_left).offset(-5);
        make.height.mas_equalTo(60*AdaptiveScale_W);
    }];
    
    [self.timeLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15*AdaptiveScale_W);
        make.bottom.mas_equalTo(-10*AdaptiveScale_W);
        make.width.mas_equalTo(80);
        make.height.mas_equalTo(30);
    }];
    
    [self.bottomLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(5*AdaptiveScale_H);
        make.right.mas_equalTo(0);
        make.bottom.mas_equalTo(0);
        make.height.mas_equalTo(1);
    }];
}

- (UIView *)bottomLine
{
    if (!_bottomLine) {
        _bottomLine = [[UIView alloc]init];
        
    }
    return _bottomLine;
}

- (UILabel *)titleLab
{
    if (!_titleLab) {
        _titleLab = [[UILabel alloc]init];
        _titleLab.font = [UIFont systemFontOfSize:RemindFont(14, 15, 16)];
        _titleLab.textAlignment = NSTextAlignmentLeft;
        _titleLab.numberOfLines = 2;
        
        
    }
    return _titleLab;
}

- (UIImageView *)imgView
{
    if (!_imgView) {
        _imgView = [[UIImageView alloc]init];
        //        _imgView.contentMode = UIViewContentModeScaleAspectFill;
        //        _imgView.clipsToBounds = YES;
    }
    return _imgView;
}

- (UILabel *)timeLab
{
    if (!_timeLab) {
        _timeLab = [[UILabel alloc]init];
        _timeLab.font = [UIFont systemFontOfSize:RemindFont(12, 13, 14)];
        _timeLab.textAlignment = NSTextAlignmentLeft;
        _timeLab.textColor = MainGrayTextColor;
    }
    return _timeLab;
}

- (NSMutableArray *)dataArr
{
    if (!_dataArr) {
        _dataArr = [NSMutableArray array];
    }
    return _dataArr;
}


@end
