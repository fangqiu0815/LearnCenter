//
//  NewsTableViewCell.m
//  HWMovie
//
//  Created by hyrMac on 15/7/21.
//  Copyright (c) 2015年 hyrMac. All rights reserved.
//

#import "NewsTableViewCell.h"
#import "NewsModal.h"
#import "UIImageView+WebCache.h"
#import "UIViewExt.h"

@implementation NewsTableViewCell

- (void)awakeFromNib {
    // Initialization code
    
}

- (void)setNewsMessage:(NewsModal *)newsMessage {
    _newsMessage = newsMessage;
    [self setNeedsLayout];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    _titleLabel.text = _newsMessage.title;
    _titleLabel.textColor = [UIColor blackColor];
    _titleLabel.font = [UIFont boldSystemFontOfSize:18];
    
    _summaryLabel.text = _newsMessage.summary;
    _summaryLabel.textColor = [UIColor orangeColor];
    _summaryLabel.font = [UIFont boldSystemFontOfSize:14];
    
    NSString *str = _newsMessage.image;
    NSURL *url = [NSURL URLWithString:str];
    [_iconImageView sd_setImageWithURL:url];
    
    if (_newsMessage.type == 0) {
        // 仅文字
        _typeImageView.image = nil;
    }
    if (_newsMessage.type == 1) {
        // 图片新闻
        _typeImageView.image = [UIImage imageNamed:@"sctpxw"];
    }
    if (_newsMessage.type == 2) {
        // 视频新闻
        _typeImageView.image = [UIImage imageNamed:@"scspxw"];
    }
    self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
