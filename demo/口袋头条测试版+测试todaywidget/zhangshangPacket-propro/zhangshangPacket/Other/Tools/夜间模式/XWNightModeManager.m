//
//  XWNightModeManager.m
//  zhangshangPacket
//
//  Created by apple on 2017/7/19.
//  Copyright © 2017年 apple-fangqiu. All rights reserved.
//

#import "XWNightModeManager.h"

@interface XWNightModeManager ()

@property (nonatomic, readwrite, assign) XWDayAndNightMode contentMode;

@end

@implementation XWNightModeManager

+ (XWNightModeManager *)shareManager {
    
    static XWNightModeManager *dayAndNightManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        dayAndNightManager = [[XWNightModeManager alloc] init];
        dayAndNightManager.contentMode = XWDayAndNightModeDay;
        
    });
    return dayAndNightManager;
}

- (void)dayMode {
    [self p_saveSettingWithNight:NO];
    [[NSNotificationCenter defaultCenter] postNotificationName:XWChangeModeNotification object:nil];
    
}

- (void)nightMode {
    [self p_saveSettingWithNight:YES];
    [[NSNotificationCenter defaultCenter] postNotificationName:XWChangeModeNotification object:nil];
}


- (XWDayAndNightMode)contentMode {
    return [[NSUserDefaults standardUserDefaults] boolForKey:@"XWDayAndNight"] ? XWDayAndNightModeNight : XWDayAndNightModeDay;
}


- (void)p_saveSettingWithNight:(BOOL)isNight {
    [[NSUserDefaults standardUserDefaults] setBool:isNight forKey:@"XWDayAndNight"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}



@end
