//
//  TopMovieDetailTableViewCell.m
//  HWMovie
//
//  Created by hyrMac on 15/7/27.
//  Copyright (c) 2015年 hyrMac. All rights reserved.
//

#import "TopMovieDetailTableViewCell.h"
#import "UIImageView+WebCache.h"

@implementation TopMovieDetailTableViewCell

- (void)setTopCommentModal:(TopCommentModal *)topCommentModal {
    _topCommentModal = topCommentModal;
    [self setNeedsLayout];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    NSString *str = _topCommentModal.userImage;
    [_userImageView sd_setImageWithURL:[NSURL URLWithString:str]];
    
    _nacknameLabel.text = _topCommentModal.nickname;
    _nacknameLabel.textColor = [UIColor orangeColor];
    
    _ratingLabel.text = _topCommentModal.rating;
    
    _contentLabel.text = _topCommentModal.content;
}

- (void)awakeFromNib {
    // Initialization code
    self.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"bg_main"]];
    _contentLabel.numberOfLines = 0;  // 自动换行
    
    _bgView.layer.borderWidth = 1;
    _bgView.layer.borderColor = [UIColor lightGrayColor].CGColor;
    _bgView.layer.cornerRadius = 10;
    _bgView.layer.masksToBounds = YES;
    
    _userImageView.layer.borderWidth = 1;
    _userImageView.layer.borderColor = [UIColor lightGrayColor].CGColor;
    _userImageView.layer.cornerRadius = 10;
    _userImageView.layer.masksToBounds = YES;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    // Configure the view for the selected state
}

@end
