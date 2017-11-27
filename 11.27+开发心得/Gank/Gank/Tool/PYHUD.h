//
//  PYHUD.h
//  Gank
//
//  Created by 谢培艺 on 2017/3/13.
//  Copyright © 2017年 CoderKo1o. All rights reserved.
//

#import <JHUD/JHUD.h>
@class PYHUD;

// 网络异常后点击刷新调用此block
typedef void(^PYHUDRefresghWhenNetworkErorBlock)(PYHUD *hud);

@interface PYHUD : JHUD

#pragma mark - refresh when network error
- (void)refreshWhenNwrworkError:(PYHUDRefresghWhenNetworkErorBlock)block;

@end
