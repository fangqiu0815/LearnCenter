//
//  MoreTableViewCell.m
//  HWMovie
//
//  Created by hyrMac on 15/7/22.
//  Copyright (c) 2015年 hyrMac. All rights reserved.
//

#import "MoreTableViewCell.h"
#import "UIImageView+WebCache.h"

@implementation MoreTableViewCell

- (void)awakeFromNib {
    // Initialization code
    self.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"bg_main"]];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setModal:(moreModal *)modal {
    _modal = modal;
    [self setNeedsLayout];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    _iconImageView.image = [UIImage imageNamed:_modal.icon];
    
    _titleLabel.text = _modal.title;
    _titleLabel.textColor = [UIColor whiteColor];
    
    if ([_titleLabel.text isEqualToString:@"清除缓存"]) {
        
        SDImageCache *cache = [SDImageCache sharedImageCache];
        NSUInteger sizeValue = [cache getSize];
        
        _label1.text = [NSString stringWithFormat:@"%.1fM",sizeValue/1000.0/1000];
        
        _label1.textColor = [UIColor whiteColor];
    } else {
        _label1.text = nil;
    }
}

@end
