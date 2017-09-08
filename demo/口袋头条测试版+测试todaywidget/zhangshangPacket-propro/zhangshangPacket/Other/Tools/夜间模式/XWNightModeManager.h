//
//  XWNightModeManager.h
//  zhangshangPacket
//
//  Created by apple on 2017/7/19.
//  Copyright © 2017年 apple-fangqiu. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum : NSUInteger {
    XWDayAndNightModeDay, // 日间模式
    XWDayAndNightModeNight, // 夜间模式
} XWDayAndNightMode;

@interface XWNightModeManager : NSObject

/**
 *  获取当前的模式
 */

@property (nonatomic,readonly,assign) XWDayAndNightMode contentMode;

/**
 *  单例
 *
 */
+ (XWNightModeManager *)shareManager;

/**
 *  开启日间模式
 */
- (void)dayMode;
/**
 *  开启夜间模式
 */
- (void)nightMode;



@end
