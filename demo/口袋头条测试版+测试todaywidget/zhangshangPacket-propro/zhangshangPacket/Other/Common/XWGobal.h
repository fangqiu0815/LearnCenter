//
//  XWGobal.h
//  zhangshangPacket
//
//  Created by apple on 2017/5/24.
//  Copyright © 2017年 apple-fangqiu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XWGobal : NSObject


/** 常量类  */
/** 导航条最大的Y值 */
UIKIT_EXTERN const NSInteger XWMaxNavY;
/** 标题栏的高度 */
UIKIT_EXTERN const NSInteger XWTitleViewH;
/** tabBar的高度 */
UIKIT_EXTERN const NSInteger XWTabBarH;

/** 通用间隔 */
UIKIT_EXTERN const NSInteger XWMargin;

/** tabBar 被点击的通知 */
UIKIT_EXTERN NSString *const XWTabBarDidSelectedNotification;
/** tabBar 被点击的通知 - 被点击的控制器的 index key */
UIKIT_EXTERN  NSString *const XWSelectedControllerIndexKey;
/** tabBar 被点击的通知 - 被点击的控制器 key */
UIKIT_EXTERN  NSString *const XWSelectedControllerKey;




@end
