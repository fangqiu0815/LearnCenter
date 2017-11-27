//
//  PYHUD.m
//  Gank
//
//  Created by 谢培艺 on 2017/3/13.
//  Copyright © 2017年 CoderKo1o. All rights reserved.
//

#import "PYHUD.h"

@interface PYHUD ()

/** 网络错误重新刷新Block */
@property (nonatomic, copy) PYHUDRefresghWhenNetworkErorBlock block;

@end

@implementation PYHUD

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // 添加手势
        [self addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap)]];
    }
    return self;
}

#pragma mark - tap
- (void)tap
{
    if (_block) _block(self);
}

- (void)refreshWhenNwrworkError:(PYHUDRefresghWhenNetworkErorBlock)block {
    
    _block = [block copy];
}


@end
