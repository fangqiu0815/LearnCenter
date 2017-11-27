//
//  PhotoCollectionViewCell.m
//  HWMovie
//
//  Created by hyrMac on 15/7/23.
//  Copyright (c) 2015年 hyrMac. All rights reserved.
//

#import "PhotoCollectionViewCell.h"

@implementation PhotoCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        _scrollView = [[PhotoScrollView alloc] initWithFrame:self.bounds];
        _scrollView.tag = 100;
        [self.contentView addSubview:_scrollView];  // 在单元项里添加东西使用self.contentView来调用add方法
    }
    return self;
}

- (void)setImageUrlStr:(NSString *)imageUrlStr {
    _imageUrlStr = imageUrlStr;
    _scrollView.imageUrlStr = imageUrlStr;
    
//    [self setNeedsLayout];
}

//- (void)layoutSubviews {
//    
//}

@end
