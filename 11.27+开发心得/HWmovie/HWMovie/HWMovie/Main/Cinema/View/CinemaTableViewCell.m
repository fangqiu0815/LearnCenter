//
//  CinemaTableViewCell.m
//  HWMovie
//
//  Created by hyrMac on 15/7/22.
//  Copyright (c) 2015年 hyrMac. All rights reserved.
//

#import "CinemaTableViewCell.h"

@implementation CinemaTableViewCell

- (void)awakeFromNib {
    // Initialization code
    self.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"bg_main"]];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setCModal:(cinemaModal *)cModal {
    _cModal = cModal;
    [self setNeedsLayout];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    _nameLabel.text = _cModal.name;
    _nameLabel.textColor = [UIColor whiteColor];
    _nameLabel.font = [UIFont boldSystemFontOfSize:19];
//    [_nameLabel sizeToFit];
    
    _gradeLabel.text = _cModal.grade;
    _gradeLabel.textColor = [UIColor orangeColor];
    _gradeLabel.font = [UIFont systemFontOfSize:14];
    
    _addressLabel.text = _cModal.address;
    _addressLabel.textColor = [UIColor whiteColor];
    _addressLabel.font = [UIFont systemFontOfSize:15];
    
    _lowPriceLabel.text = [NSString stringWithFormat:@"¥ %@",_cModal.lowPrice ];
    _lowPriceLabel.textColor = [UIColor orangeColor];
    _lowPriceLabel.font = [UIFont systemFontOfSize:20];
    
    if ([_cModal.isSeatSupport isEqualToString:@"1"]) {
        _isSeatSupportImageView.image = [UIImage imageNamed:@"cinemaSeatMark@2x"];
    } else {
        _isSeatSupportImageView.image = nil;
    }
    
    if ([_cModal.isCouponSupport isEqualToString:@"1"]) {
        _isCouponSupport.image = [UIImage imageNamed:@"cinemaCouponMark@2x"];
    } else {
        _isCouponSupport.image = nil;
    }
}

@end
