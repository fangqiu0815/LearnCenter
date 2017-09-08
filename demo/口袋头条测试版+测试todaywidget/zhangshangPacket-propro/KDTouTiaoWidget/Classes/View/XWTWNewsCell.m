//
//  XWTWNewsCell.m
//  zhangshangPacket
//
//  Created by apple on 2017/8/8.
//  Copyright © 2017年 apple-fangqiu. All rights reserved.
//

#import "XWTWNewsCell.h"
#import "UIImageView+WebCache.h"
#import "Masonry.h"
#define WeakType(type) __weak typeof(type) weak##type = type;
#pragma mark ================== 最小广告id ===================
#define SYS_AD_MINID 10000

#pragma mark ================== 最大广告id ===================
#define SYS_AD_MAXID 200000
#define ScreenW [UIScreen mainScreen].bounds.size.width
#define ScreenH [UIScreen mainScreen].bounds.size.height

@implementation XWTWNewsCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self.contentView addSubview:self.imageTitleView];
        [self.contentView addSubview:self.lblTitle];
        [self.contentView addSubview:self.resourceLab];
        [self.contentView addSubview:self.detailLab];
        [self.contentView addSubview:self.authorLab];
        
        [self addView];
        
    }
    return self;
}



- (void)setModel:(TWNewsModel *)model
{
    if (!_model) {
        self.lblTitle.text = model.title;
        // self.detailLab.text = model.content;
        [self.imageTitleView sd_setImageWithURL:[NSURL URLWithString:model.imgsUrl[@"imgsUrl1"]] placeholderImage:[UIImage imageNamed:@"bg_default_long"]];
        
        
        if ([model.id integerValue] < SYS_AD_MINID || [model.id integerValue] > SYS_AD_MAXID) {
            
            //            [self.imageTitleView yl_setNoImageModelWithUrl:[NSURL URLWithString:model.imgsUrl[@"imgsUrl1"]]
            //                                          placeHolderImage:MyImage(@"bg_default_long")];
            if ([model.type integerValue] == 0) {//普通新闻
                
                self.resourceLab.text = model.resource;
                if (model.author) {
                    self.authorLab.text = [NSString stringWithFormat:@"%@",model.author];
                } else {
                    
                }
                
            }else{
                self.resourceLab.hidden = NO;
                self.resourceLab.text = model.resource;
                
            }
            
        } else {
            
            if ([model.type integerValue] == 0) {//普通广告
                self.resourceLab.text = model.resource;
                self.resourceLab.hidden = YES;
                
            }else if([model.type integerValue] == 1){//看广告文章奖励
                self.resourceLab.text = model.resource;
                self.resourceLab.hidden = YES;
                
            }else if ([model.type integerValue] == 2){//分享广告奖励
            
                self.resourceLab.text = model.resource;
                self.resourceLab.hidden = YES;
                
            }
            
        }
        
    }
    
}


- (void)addView
{
    WeakType(self);
    [_imageTitleView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(weakself);
        make.width.mas_equalTo(110);
        make.height.mas_equalTo(80);
        make.left.mas_equalTo(weakself).offset(15);
    }];
    
    [_lblTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(weakself.imageTitleView.mas_right).offset(15);
        make.top.mas_equalTo(weakself.imageTitleView.mas_top);
        make.right.mas_equalTo(weakself).offset(-15);
    }];
    
    [_resourceLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(weakself.imageTitleView.mas_bottom);
        make.left.mas_equalTo(weakself.imageTitleView.mas_right).offset(15);
        make.width.mas_equalTo(ScreenW*0.3);
        make.height.mas_equalTo(25);
    }];
    
    [_authorLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(weakself.imageTitleView.mas_bottom);
        make.left.mas_equalTo(weakself.resourceLab.mas_right).offset(5);
        make.width.mas_equalTo(ScreenW*0.2);
        make.height.mas_equalTo(15);
    }];
    
}



- (UIImageView *)imageTitleView
{
    if (!_imageTitleView) {
        _imageTitleView = [[UIImageView alloc]init];
        _imageTitleView.image = [UIImage imageNamed:@"czym"];
        _imageTitleView.contentMode = UIViewContentModeScaleAspectFill;
        _imageTitleView.clipsToBounds = YES;
        
    }
    return _imageTitleView;
}

- (UILabel *)lblTitle
{
    if (!_lblTitle) {
        _lblTitle = [[UILabel alloc]init];
        //_lblTitle.text = @"哈局领导开讲啦处女座选举哦亲离开农村，名字那是的囧文件夹里快乐";
        _lblTitle.font = [UIFont systemFontOfSize:15];
        _lblTitle.textColor = [UIColor blackColor];
        _lblTitle.textAlignment = NSTextAlignmentLeft;
        _lblTitle.numberOfLines = 2;
        [_lblTitle sizeToFit];
        _lblTitle.lineBreakMode = NSLineBreakByTruncatingTail;
    }
    return _lblTitle;
}

- (UILabel *)detailLab
{
    if (!_detailLab) {
        _detailLab = [[UILabel alloc]init];
        // _detailLab.text = @"哈局领导开讲啦处女座选举哦亲离开农村，名字那是的囧文件夹里快乐";
        _detailLab.font = [UIFont systemFontOfSize:12];
//        _detailLab.dk_textColorPicker = DKColorPickerWithColors(BlackColor,WhiteColor,MainRedColor);
        _detailLab.textAlignment = NSTextAlignmentLeft;
        _detailLab.numberOfLines = 2;
        
    }
    return _detailLab;
}

- (UILabel *)resourceLab
{
    if (!_resourceLab) {
        _resourceLab = [[UILabel alloc]init];
        _resourceLab.textColor = [UIColor lightGrayColor];
        _resourceLab.textAlignment = NSTextAlignmentLeft;
        _resourceLab.font = [UIFont systemFontOfSize:13];
    }
    return _resourceLab;
}

- (UILabel *)authorLab
{
    if (!_authorLab) {
        _authorLab = [[UILabel alloc]init];
        _authorLab.textColor = [UIColor blackColor];
        _authorLab.textAlignment = NSTextAlignmentLeft;
        _authorLab.font = [UIFont systemFontOfSize:11];
    }
    return _authorLab;
    
}


@end
