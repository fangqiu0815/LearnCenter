//
//  XWHotSearchCell.m
//  demo
//
//  Created by apple on 2017/8/7.
//  Copyright © 2017年 apple-fangqiu. All rights reserved.
//

#import "XWHotSearchCell.h"

@implementation XWHotSearchCell

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        [self addSubview:self.titleLab];
        
        [self addView];
    }
    return self;
}

- (void)addView
{
    WeakType(self);
    
    
}

- (UILabel *)titleLab
{
    if (!_titleLab) {
        
    }
    return _titleLab;
}


@end
