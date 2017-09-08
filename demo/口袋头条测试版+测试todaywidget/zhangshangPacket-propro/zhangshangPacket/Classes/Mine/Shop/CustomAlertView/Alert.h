//
//  Alert.h
//  BSS
//
//  Created by zhangbo on 13-9-22.
//  Copyright (c) 2013年 YANGZQ. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface Alert : NSObject

+(void)show:(NSString *)str;

+(void)show:(NSString *)str hasSuccessIcon:(BOOL)hasSuccessIcon AndShowInView:(UIView *)parentView;

@end
