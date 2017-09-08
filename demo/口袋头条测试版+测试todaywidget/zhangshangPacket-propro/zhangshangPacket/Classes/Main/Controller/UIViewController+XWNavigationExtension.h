//
//  UIViewController+XWNavigationExtension.h
//  zhangshangPacket
//
//  Created by apple on 2017/5/11.
//  Copyright © 2017年 apple-fangqiu. All rights reserved.
//

#import <UIKit/UIKit.h>
@class XWNavigationVC;
@interface UIViewController (XWNavigationExtension)

@property (nonatomic, assign) BOOL xw_fullScreenPopGestureEnabled;
@property (nonatomic, strong) XWNavigationVC *xw_navigationController;


@end
