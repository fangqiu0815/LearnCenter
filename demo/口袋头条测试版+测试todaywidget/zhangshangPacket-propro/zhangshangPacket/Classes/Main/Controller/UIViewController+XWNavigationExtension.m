//
//  UIViewController+XWNavigationExtension.m
//  zhangshangPacket
//
//  Created by apple on 2017/5/11.
//  Copyright © 2017年 apple-fangqiu. All rights reserved.
//

#import "UIViewController+XWNavigationExtension.h"
#import <objc/runtime.h>
#import "XWNavigationVC.h"
@implementation UIViewController (XWNavigationExtension)

- (BOOL)xw_fullScreenPopGestureEnabled {
    return [objc_getAssociatedObject(self, _cmd) boolValue];
}

- (void)setXw_fullScreenPopGestureEnabled:(BOOL)fullScreenPopGestureEnabled {
    objc_setAssociatedObject(self, @selector(xw_fullScreenPopGestureEnabled), @(fullScreenPopGestureEnabled), OBJC_ASSOCIATION_ASSIGN);
}

- (XWNavigationVC *)xw_navigationController {
    return objc_getAssociatedObject(self, _cmd);
}

- (void)setXw_navigationController:(XWNavigationVC *)navigationController {
    objc_setAssociatedObject(self, @selector(xw_navigationController), navigationController, OBJC_ASSOCIATION_RETAIN);
}



@end
