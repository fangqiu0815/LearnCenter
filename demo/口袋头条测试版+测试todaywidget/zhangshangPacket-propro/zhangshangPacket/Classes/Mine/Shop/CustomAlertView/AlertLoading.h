//
//  AlertLoading.h
//  BSS
//
//  Created by zhangbo on 13-11-4.
//  Copyright (c) 2013年 TGNET. All rights reserved.
//

#import <UIKit/UIKit.h>

#define TAG_RIGHTIMG 100

@interface AlertLoading : UIView

+(UIView *)alertLoadingWithMessage:(NSString *)msg andFrame:(CGRect)frame isBelowNav:(BOOL)isBelowNav;

+(UIView *)alertLoadingWithMessage:(NSString *)msg Image:(UIImage *)img AndTestBg:(UIColor *)color;

+(UIView *)alertLoadingWithMessage:(NSString *)msg leftImage:(UIImage *)imgleft rightImage:(UIImage *)imgRight;

@end
