//
//  UIView+XWNightView.m
//  zhangshangPacket
//
//  Created by apple on 2017/7/19.
//  Copyright © 2017年 apple-fangqiu. All rights reserved.
//

#import "UIView+XWNightView.h"
#import <objc/runtime.h>

NSString *const XWChangeModeNotification = @"XWDNNotification";

static void *XWViewDayKey = "XWViewDayKey";
static void *XWViewNightKey = "XWViewNightKey";

@implementation UIView (XWNightView)

- (void)xw_dealloc {
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:XWChangeModeNotification object:nil];
    
    [self xw_dealloc];
    
}

+ (void)load {
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        Method deallocMethod = class_getInstanceMethod([self class], NSSelectorFromString(@"dealloc"));
        Method xw_deallocMethod = class_getInstanceMethod([self class], @selector(xw_dealloc));
        method_exchangeImplementations(deallocMethod, xw_deallocMethod);
    });
    
}


- (void)xw_setDayMode:(DAY_AND_NIGHT_MODE_BLOCK)dayMode nightMode:(DAY_AND_NIGHT_MODE_BLOCK)nightMode {
    objc_setAssociatedObject(self, XWViewDayKey, dayMode, OBJC_ASSOCIATION_COPY)
    ;
    objc_setAssociatedObject(self, XWViewNightKey, nightMode, OBJC_ASSOCIATION_COPY)
    ;
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(p_changeMode) name:XWChangeModeNotification object:nil];
    [self p_changeMode];
    
}

- (void)p_changeMode {
    DAY_AND_NIGHT_MODE_BLOCK dayModeBlock = objc_getAssociatedObject(self, XWViewDayKey);
    DAY_AND_NIGHT_MODE_BLOCK nightModeBlock = objc_getAssociatedObject(self, XWViewNightKey);
    
    if (XWDayAndNightModeDay == [[XWNightModeManager shareManager] contentMode]) {
        dayModeBlock(self);
    } else {
        nightModeBlock(self);
    }
    
}



@end
