//
//  GCD_Timer.m
//  zhangshangPacket
//
//  Created by apple on 2017/7/13.
//  Copyright © 2017年 apple-fangqiu. All rights reserved.
//

#import "GCD_Timer.h"

@interface GCD_Timer ()

{
    
    dispatch_source_t timer;
    
}


@end


@implementation GCD_Timer

+ (instancetype)timerWithInterval:(NSTimeInterval)interval repeats:(BOOL)repeats target:(id)target selector:(SEL)selector {
    return [[self alloc]initWithInterval:interval repeats:repeats target:target selector:selector];
}
- (instancetype)initWithInterval:(NSTimeInterval)interval repeats:(BOOL)repeats target:(id)target selector:(SEL)selector {
    if (self = [super init]) {
        _interval = interval;
        _repeats = repeats;
        _target = target;
        _selector = selector;
    }
    return self;
}

+ (instancetype)timerWithInterval:(NSTimeInterval)interval repeats:(BOOL)repeats task:( void(^)() )task {
    return [[self alloc]initWithInterval:interval repeats:(BOOL)repeats task:task];
}
- (instancetype)initWithInterval:(NSTimeInterval)interval repeats:(BOOL)repeats task:( void(^)() )task {
    
    if (self = [super init]) {
        _interval = interval;
        _repeats = repeats;
        _Task = task;
    }
    return self;
}

- (void)createTimer {
    
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    
    timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
    
    //第二个参数self.interval是延迟开始时间
    dispatch_time_t start = dispatch_time(DISPATCH_TIME_NOW, (int64_t)( self.interval * NSEC_PER_SEC ));
    
    //self.interval是定时间隔
    dispatch_source_set_timer(timer, start, (int64_t)( self.interval * NSEC_PER_SEC ), 0);
    
    dispatch_source_set_event_handler(timer, ^{
        
        if (self.Task) self.Task();
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
        if ([self.target respondsToSelector:self.selector]) {
            [self.target performSelector:self.selector];
        }
        if ( !self.isRepeats ) {
            [self removeTimer];
        }
    });
    
}

- (instancetype)resumeTimer {
    [self createTimer];
    dispatch_resume(timer);
    return self;
}

- (void)removeTimer {
    dispatch_cancel(timer);
}



@end
