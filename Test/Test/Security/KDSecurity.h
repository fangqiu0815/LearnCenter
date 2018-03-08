//
//  ATMSecurity.h
//  Weather
//
//  Created by OneByte  on 2017/7/11.
//  Copyright © 2017年 zhenhui huang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface KDSecurity : NSObject

+ (NSData *)aes256EncryptWithData:(NSData *)data key:(NSString *)key iv:(NSString *)iv;
+ (NSData *)aes256DecryptWithData:(NSData *)data key:(NSString *)key iv:(NSString *)iv;

+ (NSData *)aes256EncryptWithString:(NSString*)string key:(NSString *)key andIV:(NSString *)iv;
+ (NSString *)aes256DecryptStringWithData:(NSData *)data key:(NSString *)key andIV:(NSString *)iv;

@end
