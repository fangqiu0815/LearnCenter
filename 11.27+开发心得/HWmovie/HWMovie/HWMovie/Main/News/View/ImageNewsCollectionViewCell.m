//
//  ImageNewsCollectionViewCell.m
//  HWMovie
//
//  Created by hyrMac on 15/7/22.
//  Copyright (c) 2015年 hyrMac. All rights reserved.
//

#import "ImageNewsCollectionViewCell.h"
#import "UIImageView+WebCache.h"
#import "ImageNewsModal.h"

@implementation ImageNewsCollectionViewCell

- (void)setImageModal:(ImageNewsModal *)imageModal {
    _imageModal = imageModal;
    [self setNeedsLayout];
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self _createViews];
    }
    return self;
}

- (void)_createViews {
    _iconImageView = [[UIImageView alloc] initWithFrame:self.bounds];
    _iconImageView.layer.borderWidth = 1;
    _iconImageView.layer.borderColor = [UIColor whiteColor].CGColor;
    _iconImageView.layer.cornerRadius = 10;
    _iconImageView.layer.masksToBounds = YES;
    
    [self.contentView addSubview:_iconImageView];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    NSString *str = _imageModal.image;
    NSURL *url = [NSURL URLWithString:str];
    [_iconImageView sd_setImageWithURL:url];
}

@end
