//
//  UIBarButtonItem+Extension.h
//  新浪微博
//
//  Created by 谢培艺 on 15/12/8.
//  Copyright © 2015年 iphone5solo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (PYExtension)
+ (instancetype)py_itemWithViewController:(UIViewController *)viewController action:(SEL)action image:(NSString *)image highlightImage:(NSString *)highlightImage;

+ (instancetype)py_itemWithViewController:(UIViewController *)viewController action:(SEL)action title:(NSString *)title;
@end
