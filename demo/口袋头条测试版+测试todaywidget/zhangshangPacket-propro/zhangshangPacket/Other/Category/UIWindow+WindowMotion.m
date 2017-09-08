//
//  UIWindow+WindowMotion.m
//  zhangshangPacket
//
//  Created by apple on 2017/7/19.
//  Copyright © 2017年 apple-fangqiu. All rights reserved.
//

#import "UIWindow+WindowMotion.h"

@implementation UIWindow (WindowMotion)

/**检测到摇动*/
- (void)motionBegan:(UIEventSubtype)motion withEvent:(UIEvent *)event{
    //处理波浪颜色
    [[NSNotificationCenter defaultCenter] postNotificationName:@"isNighting" object:nil];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"cutFromNight" object:nil];
//    NSUserDefaults *def=[NSUserDefaults standardUserDefaults];
    if (XWDayAndNightModeDay == [[XWNightModeManager shareManager] contentMode]) {
//        [def setBool:NO forKey:@"isNight"];
        STUserDefaults.isnight = NO;
        //切换到正常模式
        [[XWNightModeManager shareManager] dayMode];
        
    } else {
//        [def setBool:YES forKey:@"isNight"];
        STUserDefaults.isnight = YES;

        //切换到夜间模式
        [[XWNightModeManager shareManager] nightMode];
        
    }
}
-(BOOL)canBecomeFirstResponder
{
    return YES;
}


@end
