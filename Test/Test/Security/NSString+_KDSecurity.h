//
//  NSString+ATMSecurity.h
//  Weather
//
//  Created by OneByte  on 2017/7/11.
//  Copyright © 2017年 zhenhui huang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (_KDSecurity)

- (NSString *)kd_aesEncryptWitKey:(NSString *)key andIV:(NSString *)iv;
- (NSString *)kd_aesDecryptWitKey:(NSString *)key andIV:(NSString *)iv;
@end

