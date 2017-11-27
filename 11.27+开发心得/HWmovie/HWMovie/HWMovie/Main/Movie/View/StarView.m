//
//  StarView.m
//  HWMovie
//
//  Created by hyrMac on 15/7/21.
//  Copyright (c) 2015年 hyrMac. All rights reserved.
//

#import "StarView.h"
#import "UIViewExt.h"

@implementation StarView

- (void)awakeFromNib {
    [self _createSubviews];
}

- (void)_createSubviews {
    UIImage *image1 = [UIImage imageNamed:@"gray"];
    UIImage *image2 = [UIImage imageNamed:@"yellow"];
    
    _grayView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, image1.size.width*5, image1.size.height)];
    _yellowView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, image2.size.width*5, image2.size.height)];
    _grayView.backgroundColor = [UIColor colorWithPatternImage:image1];
    _yellowView.backgroundColor = [UIColor colorWithPatternImage:image2];
    
    // 放大图片
    CGFloat scale = self.frame.size.height/_grayView.frame.size.height;
    CGFloat scale1 = self.frame.size.width/_grayView.frame.size.width;
    _grayView.transform = CGAffineTransformScale(_grayView.transform, scale1, scale);
    _yellowView.transform = CGAffineTransformScale(_yellowView.transform, scale1, scale);
    
    _grayView.origin = CGPointZero;
    _yellowView.origin = CGPointZero;
    
    [self addSubview:_grayView];
    [self addSubview:_yellowView];
}

- (void)setAverage:(float)average {
    _average = average;
    [self setNeedsLayout];
}

- (void)layoutSubviews {
//    float width = _average/10*_yellowView.frame.size.height;
//    CGRect frame = _yellowView.frame;
//    frame.size.width = width;
//    _yellowView.frame = frame;
    [super layoutSubviews];
    _yellowView.width = _average/10*_grayView.frame.size.width;
}



/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
