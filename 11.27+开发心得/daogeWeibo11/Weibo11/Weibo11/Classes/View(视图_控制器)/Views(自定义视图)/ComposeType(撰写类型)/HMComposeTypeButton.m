//
//  HMComposeTypeButton.m
//  Weibo11
//
//  Created by 刘凡 on 15/12/12.
//  Copyright © 2015年 itheima. All rights reserved.
//

#import "HMComposeTypeButton.h"
#import "HMComposeType.h"

@implementation HMComposeTypeButton

- (void)setComposeType:(HMComposeType *)composeType {
    _composeType = composeType;
    
    [self setTitle:composeType.title forState:UIControlStateNormal];
    [self setImage:[UIImage imageNamed:composeType.icon] forState:UIControlStateNormal];
}

#pragma mark - 构造函数
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        self.titleLabel.font = [UIFont systemFontOfSize:14];
        
        [self setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
    }
    return self;
}

/// 重写高亮属性
- (void)setHighlighted:(BOOL)highlighted {}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    CGRect imageRect = self.bounds;
    imageRect.size.height = imageRect.size.width;
    self.imageView.frame = imageRect;

    CGRect labelRect = self.bounds;
    labelRect.origin.y = labelRect.size.width;
    labelRect.size.height -= labelRect.size.width;
    self.titleLabel.frame = labelRect;
}

@end
