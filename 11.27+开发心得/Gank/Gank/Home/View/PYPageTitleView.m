//
//  PYPageTitleView.m
//  PopTest
//
//  Created by 谢培艺 on 2017/2/27.
//  Copyright © 2017年 CoderKo1o. All rights reserved.
//

#import "PYPageTitleView.h"
#import <pop/POP.h>

@implementation PYPageTitleView

#pragma mark - 懒加载
- (UIImageView *)pageTitleImageView
{
    if (!_pageTitleImageView) {
        CGFloat x = 3;
        CGFloat y = x;
        CGFloat w = self.bounds.size.width - 2 * x;
        CGFloat h = w;
        UIImageView *pageTitleImageView = [[UIImageView alloc] initWithFrame:CGRectMake(x, y, w, h)];
        pageTitleImageView.layer.cornerRadius = 5;
        pageTitleImageView.clipsToBounds = YES;
        [self addSubview:pageTitleImageView];
        _pageTitleImageView = pageTitleImageView;
    }
    return _pageTitleImageView;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.layer.cornerRadius = 5;
        self.userInteractionEnabled = NO;
    }
    return self;
}

- (void)touchEnd:(NSInteger)index
{
    // 计算下标差
    NSInteger marginIndex = ABS(index-self.tag);
    // 调整动画
    CGFloat centerY = marginIndex == 0 ? self.bounds.size.height * 0.5 + 5 : self.bounds.size.height * 1.5 - 5 - 20;
    [self updateAnimation:centerY];
}

- (void)updateAnimation:(CGFloat)centerY
{
    POPSpringAnimation *anim = [POPSpringAnimation animationWithPropertyNamed:kPOPViewCenter];
    anim.toValue = [NSValue valueWithCGPoint:CGPointMake(self.center.x, centerY)];
    anim.springBounciness = 12;
    anim.springSpeed = 8;
    [self pop_addAnimation:anim forKey:@"center"];
}

@end
