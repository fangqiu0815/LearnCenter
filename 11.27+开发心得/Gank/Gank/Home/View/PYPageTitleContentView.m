//
//  PYPageTitleContentView.m
//  Gank
//
//  Created by 谢培艺 on 2017/2/28.
//  Copyright © 2017年 CoderKo1o. All rights reserved.
//

#import "PYPageTitleContentView.h"
#import "PYPageTitleView.h"
#import "UIView+PYExtension.h"

@interface PYPageTitleContentView () <UIGestureRecognizerDelegate>

/** 是否是移动结束 */
@property (nonatomic, assign) BOOL moveEnd;

@end

@implementation PYPageTitleContentView
- (void)handleOnTouch:(NSSet<UITouch *> *)touches end:(BOOL)touchEnd
{
    UIView *pageTitleView = [self subviews][0];
    // 取出触摸点
    CGPoint touchPoint = [[touches anyObject] locationInView:self];
    // 获取触摸的下标
    NSInteger index = touchPoint.x / (pageTitleView.bounds.size.width + 5);
    index = MIN(index, [[self subviews] count]-1);
    // cell的最小y值
    CGFloat minItemY = 0;
    [UIView animateWithDuration:0.35 delay:0 usingSpringWithDamping:0.4 initialSpringVelocity:1 options:UIViewAnimationOptionAllowAnimatedContent animations:^{
        for (int i = 0; i < [self subviews].count; i++) {
            PYPageTitleView *pageTitleView = (PYPageTitleView *)[self subviews][i];
            CGFloat gap = ABS((i-index) * 8.0);
            pageTitleView.py_y = minItemY + gap;
        }
    } completion:nil];
    if (touchEnd) { // 结束触摸
        if ([self.delegate respondsToSelector:@selector(pageTitleContentView:selectedPageTitleView:)]) {
            [self.delegate pageTitleContentView:self selectedPageTitleView:index];
        }
    }
}

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    // 取出子view
    if ([[self subviews] count] == 0) {
        [super touchesEnded:touches withEvent:event];
        return;
    }
    
    self.moveEnd = YES;
    
    [self handleOnTouch:touches end:NO];
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    if (self.moveEnd) {
        [self handleOnTouch:touches end:YES];
        self.moveEnd = NO;
    }
}

- (void)touchesCancelled:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self handleOnTouch:touches end:YES];
}

@end
