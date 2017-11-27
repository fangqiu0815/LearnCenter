//
//  MovieTableViewCell.m
//  HWMovie
//
//  Created by hyrMac on 15/7/20.
//  Copyright (c) 2015年 hyrMac. All rights reserved.
//

#import "MovieTableViewCell.h"
#import "MovieModal.h"
#import "StarView.h"
#import "UIImageView+WebCache.h"

@implementation MovieTableViewCell

- (void)setMovieMessage:(MovieModal *)movieMessage {
    _movieMessage = movieMessage;
    _star.average = _movieMessage.average;
    [self setNeedsLayout];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    _titleLabel.text = _movieMessage.title;
    _titleLabel.textColor = [UIColor orangeColor];
    _titleLabel.font = [UIFont systemFontOfSize:18];
    
    _yearLabel.text = [NSString stringWithFormat:@"年份:%@",_movieMessage.year];
    _yearLabel.textColor = [UIColor whiteColor];
    _yearLabel.font = [UIFont systemFontOfSize:14];
    
    _averageLabel.text = [NSString stringWithFormat:@"%.1f",_movieMessage.average];
    _averageLabel.textColor = [UIColor whiteColor];
    
    NSString *imageStr = _movieMessage.images[@"small"];
    NSURL *imageUrl = [NSURL URLWithString:imageStr];
    [_iconImageView sd_setImageWithURL:imageUrl];
    
    // 取消单元格选中属性
    self.selectionStyle =  UITableViewCellSelectionStyleNone;
    
    // 星星效果 （已封装）
//    UIImage *image1 = [UIImage imageNamed:@"yellow"];
//    UIImage *image2 = [UIImage imageNamed:@"gray"];
//    UIView *view1 = [[UIView alloc] initWithFrame:CGRectMake(100, 35, image1.size.width*(_movieMessage.average/10)*5, image1.size.height)];
//    UIView *view2 = [[UIView alloc] initWithFrame:CGRectMake(100, 35, image2.size.width*5, image2.size.height)];
//    view1.backgroundColor = [UIColor colorWithPatternImage:image1];
//    view2.backgroundColor = [UIColor colorWithPatternImage:image2];
//    
//    [self addSubview:view2];
//    [self addSubview:view1];
}

- (void)awakeFromNib {
    // Initialization code
    self.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"bg_main"]];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
