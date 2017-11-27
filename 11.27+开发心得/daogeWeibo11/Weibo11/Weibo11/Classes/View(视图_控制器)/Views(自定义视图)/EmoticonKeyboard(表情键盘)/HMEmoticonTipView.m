//
//  HMEmoticonTipView.m
//  Weibo11
//
//  Created by 刘凡 on 15/12/16.
//  Copyright © 2015年 itheima. All rights reserved.
//

#import "HMEmoticonTipView.h"
#import "HMEmoticonButton.h"

@interface HMEmoticonTipView()
@property (nonatomic, strong) HMEmoticonButton *tipButton;
@end

@implementation HMEmoticonTipView

#pragma mark - 设置数据
- (void)setEmoticon:(HMEmoticon *)emoticon {
    if (self.tipButton.emoticon == emoticon) {
        return;
    }
    
    self.tipButton.emoticon = emoticon;
    
    CGPoint center = self.tipButton.center;
    self.tipButton.center = CGPointMake(center.x, center.y + 16);
    [UIView animateWithDuration:0.25
                          delay:0
         usingSpringWithDamping:0.4
          initialSpringVelocity:0
                        options:UIViewAnimationOptionCurveEaseOut
                     animations:^{
                         self.tipButton.center = center;
                     }
                     completion:nil];
}

#pragma mark - 构造函数
- (instancetype)init {
    self = [super initWithImage:[UIImage imageNamed:@"emoticon_keyboard_magnifier"]];
    if (self) {
        _tipButton = [[HMEmoticonButton alloc] init];
        [self addSubview:_tipButton];

        // 计算按钮位置
        CGFloat width = 32;
        CGFloat x = (self.bounds.size.width - width) * 0.5;
        CGRect rect = CGRectMake(x, 8, width, width);
        
        _tipButton.frame = rect;
    }
    return self;
}

@end
