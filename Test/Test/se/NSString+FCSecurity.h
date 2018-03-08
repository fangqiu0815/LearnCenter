//
//  NSString+FCSecurity.h
//  Weather
//
//  Created by admin  on 2017/7/11.
//  Copyright © 2017年 zhenhui huang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (FCSecurity)

- (NSString *)aesEncrypt;
- (NSString *)aesDecrypt;

@end

