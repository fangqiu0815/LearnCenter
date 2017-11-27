//
//  PhotoScrollView.m
//  HWMovie
//
//  Created by hyrMac on 15/7/23.
//  Copyright (c) 2015年 hyrMac. All rights reserved.
//

#import "PhotoScrollView.h"
#import "UIImageView+WebCache.h"

@implementation PhotoScrollView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        _imageView = [[UIImageView alloc] initWithFrame:self.bounds];
        _imageView.contentMode = UIViewContentModeScaleAspectFit;
        [self addSubview:_imageView];
        
        self.delegate = self;   // 滑动视图，缩放代理
        self.maximumZoomScale = 3;
        self.minimumZoomScale = 1;
        
        // 双击手势
//        UIGestureRecognizer是父类
        UITapGestureRecognizer *doubleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(doubleTap)];
        doubleTap.numberOfTapsRequired = 2; // 连续点击2次激活
        doubleTap.numberOfTouchesRequired = 1;  // 单触点激活（单指）
        [self addGestureRecognizer:doubleTap];
        // 单击手势
        UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(singleTap)];
        singleTap.numberOfTouchesRequired = 1;
        singleTap.numberOfTapsRequired = 1;
        [self addGestureRecognizer:singleTap];
        // 排除干扰，双击时不包含单击
        [singleTap requireGestureRecognizerToFail:doubleTap];
    }
    return self;
}

- (void)setImageUrlStr:(NSString *)imageUrlStr {
    _imageUrlStr = imageUrlStr;
//    self.zoomScale = 1;    // 缩放倍数还原，可行
    [self setNeedsLayout];
}

- (void)layoutSubviews {
    [_imageView sd_setImageWithURL:[NSURL URLWithString:_imageUrlStr]];
}

#pragma mark - Actions

- (void)singleTap {
//    NSLog(@"singleTap");
    [[NSNotificationCenter defaultCenter] postNotificationName:@"hideNavigationBarNotification" object:nil];
}

- (void)doubleTap {
    if (self.zoomScale == 1) {
        [self setZoomScale:3 animated:YES];
    } else {
        [self setZoomScale:1 animated:YES];
    }
}

#pragma mark - UIScrollViewDelegate

- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView {
    return _imageView;
}



@end
