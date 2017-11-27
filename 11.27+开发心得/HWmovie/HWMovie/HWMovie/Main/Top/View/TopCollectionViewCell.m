//
//  TopCollectionViewCell.m
//  HWMovie
//
//  Created by hyrMac on 15/7/21.
//  Copyright (c) 2015年 hyrMac. All rights reserved.
//

#import "TopCollectionViewCell.h"
#import "StarView.h"
#import "TopModal.h"
#import "UIImageView+WebCache.h"

@implementation TopCollectionViewCell
- (void)setTopMessage:(TopModal *)topMessage {
    _topMessage = topMessage;
    _star.average = _topMessage.average;
    [self setNeedsLayout];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    NSString *str = _topMessage.images[@"medium"];
    NSURL *url = [NSURL URLWithString:str];
    [_iconImageView sd_setImageWithURL:url];
    
    _titleLabel.text = _topMessage.title;
    _titleLabel.textColor = [UIColor whiteColor];
    _titleLabel.backgroundColor = [UIColor blackColor];
    _titleLabel.textAlignment = NSTextAlignmentCenter;
    _titleLabel.font = [UIFont boldSystemFontOfSize:12];
    _titleLabel.alpha = 0.6;
    
    _averageLabel.text = [NSString stringWithFormat:@"%.1f",_topMessage.average];
    _averageLabel.textColor = [UIColor orangeColor];
    _averageLabel.font = [UIFont boldSystemFontOfSize:10];
}

- (void)awakeFromNib {
    // Initialization code
     self.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"bg_main"]];
}

@end
