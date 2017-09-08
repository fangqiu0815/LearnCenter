//
//  XWNavigationVC.h
//  zhangshangnews
//
//  Created by apple on 2017/5/8.
//  Copyright © 2017年 apple-fangqiu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIViewController+XWNavigationExtension.h"
@interface XWNavigationVC : UINavigationController

@property (nonatomic, assign) BOOL fullScreenPopGestureEnabled;
@property (nonatomic, copy, readonly) NSArray *xw_viewControllers;

@end
