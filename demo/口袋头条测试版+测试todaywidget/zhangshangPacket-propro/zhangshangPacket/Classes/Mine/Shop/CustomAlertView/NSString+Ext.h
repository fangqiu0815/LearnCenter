//
//  NSString+Ext.h
//  CustomAlertView
//
//  Created by YHIOS001 on 16/10/10.
//  Copyright © 2016年 YH_kongdw. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface NSString (Ext)

- (CGSize)sizeWithFont:(UIFont *)font maxW:(CGFloat)maxW;

- (CGSize)sizeWithFont:(UIFont *)font maxSize:(CGSize)maxSize;

- (CGSize)sizeWithFont:(UIFont *)font;


@end
