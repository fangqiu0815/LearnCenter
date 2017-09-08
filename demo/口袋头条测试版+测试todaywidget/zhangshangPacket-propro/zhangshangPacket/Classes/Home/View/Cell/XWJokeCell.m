//
//  XWJokeCell.m
//  zhangshangPacket
//
//  Created by apple on 2017/5/27.
//  Copyright © 2017年 apple-fangqiu. All rights reserved.
//

#import "XWJokeCell.h"
static NSString *cellID = @"XWJokeCell";
#define iconH 100
#define iconW 100
#define padding 13*AdaptiveScale_W
#import "XWHomeJokeModel.h"
@interface XWJokeCell ()


@property (nonatomic, strong) UIImageView *iconImageView;

@property (nonatomic, strong) UILabel *nameLab;

@property (nonatomic, strong) UILabel *contentLab;

@property (nonatomic, strong) UILabel *originLab;

@property (nonatomic, strong) UIImageView *imgView;

@property (nonatomic, strong) UILabel *commentLab;

@property (nonatomic, strong) UIImageView *iconImg;

@property (nonatomic, assign) CGFloat contentH;

@property (nonatomic, assign) CGFloat commentH;



@end

@implementation XWJokeCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        
        [self.contentView addSubview:self.iconImageView];
        [self.contentView addSubview:self.nameLab];
        [self.contentView addSubview:self.contentLab];
        [self.contentView addSubview:self.originLab];
        
        [self setupUI];

        
    }
    return self;
}

- (void)setDataModel:(JokeData *)dataModel
{
    _dataModel = dataModel;
    NSString *str = [NSString stringWithFormat:@"http:%@",dataModel.img];
    [self.iconImageView sd_setImageWithURL:[NSURL URLWithString:str] placeholderImage:MyImage(@"bg_default")];
    self.nameLab.text = dataModel.uname;
    self.contentLab.text = dataModel.content;
    
    self.originLab.text = dataModel.origin;
    [self.contentView layoutIfNeeded];

}

/**
 *  计算文本的宽高
 *
 *  @param str     需要计算的文本
 *  @param font    文本显示的字体
 *  @param maxSize 文本显示的范围
 *
 *  @return 文本占用的真实宽高
 */
//- (CGSize)sizeWithString:(NSString *)str font:(UIFont *)font maxSize:(CGSize)maxSize
//{
//    NSDictionary *dict = @{NSFontAttributeName : font};
//    // 如果将来计算的文字的范围超出了指定的范围,返回的就是指定的范围
//    // 如果将来计算的文字的范围小于指定的范围, 返回的就是真实的范围
//    CGSize size =  [str boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:dict context:nil].size;
//    return size;
//}


- (void)setupUI
{
    WeakType(self);
    [_iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(padding);
        make.top.mas_equalTo(padding);
        make.width.height.mas_equalTo(40);
        
    }];
    
    [_nameLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(weakself.iconImageView.mas_right).offset(padding);
        make.centerY.mas_equalTo(weakself.iconImageView.mas_centerY);
        make.right.mas_equalTo(weakself).offset(-padding);
        make.height.mas_equalTo(35);
    }];
    
    [_originLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(weakself).offset(-padding);
        make.centerY.mas_equalTo(weakself.nameLab.mas_centerY);
        make.width.mas_equalTo(60);
        make.height.mas_equalTo(30);
    }];
    
    [_contentLab mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.mas_equalTo(padding);
        make.right.mas_equalTo(weakself).offset(-padding);
        make.top.mas_equalTo(weakself.iconImageView.mas_bottom).offset(padding);;
//        constraint_content = make.top.mas_equalTo(weakself.iconImageView.mas_bottom).offset(5).priorityHigh();
    }];
    

}


- (CGSize)sizeThatFits:(CGSize)size
{
    CGFloat totalHeight = 0;
    totalHeight += self.iconImageView.yj_height;
    totalHeight += [self.contentLab sizeThatFits:size].height;
    totalHeight += 3*padding;
    return CGSizeMake(size.width, totalHeight);
}

- (UIImageView *)iconImageView
{
    if (!_iconImageView) {
        _iconImageView = [[UIImageView alloc]init];
        _iconImageView.layer.masksToBounds = YES;
        _iconImageView.layer.cornerRadius = 20;
    }
    return _iconImageView;
}

- (UILabel *)nameLab
{
    if (!_nameLab) {
        _nameLab = [[UILabel alloc]init];
       // _nameLab.text = @"haohaohaohao";
        _nameLab.textAlignment = NSTextAlignmentLeft;
        _nameLab.font = [UIFont systemFontOfSize:RemindFont(14, 15, 16)];
        _nameLab.dk_textColorPicker = DKColorPickerWithColors(BlackColor,WhiteColor,MainRedColor);

    }
    return _nameLab;
}

- (UILabel *)contentLab
{
    if (!_contentLab) {
        _contentLab = [[UILabel alloc]init];
      //  _contentLab.text = @"haohaohaohaohaoahaidahdkajbjkxzuhjkqnjkzhicuhqncjkzhciuahkcjnzjkxchiua";
        _contentLab.dk_textColorPicker = DKColorPickerWithColors(BlackColor,WhiteColor,MainRedColor);
        _contentLab.numberOfLines = 0;
        _contentLab.textAlignment = NSTextAlignmentLeft;
        _contentLab.font = [UIFont systemFontOfSize:15];
    }
    return _contentLab;
}

- (UILabel *)originLab
{
    if (!_originLab) {
        _originLab = [[UILabel alloc]init];
        _originLab.textColor = MainTextColor;
        _originLab.textAlignment = NSTextAlignmentRight;
        _originLab.font = [UIFont systemFontOfSize:RemindFont(12, 13, 14)];
        
    }
    return _originLab;
}


@end
