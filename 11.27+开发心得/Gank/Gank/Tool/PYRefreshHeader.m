//
//  PYRefreshHeader.m
//  Gank
//
//  Created by 谢培艺 on 2017/2/27.
//  Copyright © 2017年 CoderKo1o. All rights reserved.
//

#import "PYRefreshHeader.h"

@implementation PYRefreshHeader

#pragma mark 基本设置

- (void)prepare
{
    [super prepare];
    
    self.lastUpdatedTimeLabel.hidden = YES;
    self.stateLabel.hidden = YES;
}

- (void)setFrame:(CGRect)frame
{
    frame.origin = CGPointMake(frame.origin.x, 300-54);
    [super setFrame:frame];
}

@end
