//
//  NSString+ATMSecurity.m
//  Weather
//
//  Created by OneByte  on 2017/7/11.
//  Copyright © 2017年 zhenhui huang. All rights reserved.
//

#import "NSString+_KDSecurity.h"
#import "KDSecurity.h"
#import "KDBase64.h"

@implementation NSString (_KDSecurity)

- (NSString *)kd_aesEncryptWitKey:(NSString *)key andIV:(NSString *)iv
{
    NSData *data = [KDSecurity aes256EncryptWithString:self key:key andIV:iv];
    if (data)
    {
        return  [KDBase64 stringByEncodingData:data];
    }
    return nil;
}

- (NSString *)kd_aesDecryptWitKey:(NSString *)key andIV:(NSString *)iv
{
    NSData *data = [KDBase64 decodeString:self];
    return  [KDSecurity aes256DecryptStringWithData:data key:key andIV:iv];
}

@end
