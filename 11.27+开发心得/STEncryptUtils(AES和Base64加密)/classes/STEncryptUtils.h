//
//  NSData+STExts.h
//  NSData+STExts
//
//  Created by yanglishuan on 13-8-9.
//  Copyright (c) 2013年 yls. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSData (STEncrypt)

////////////////////////////// aes加密、解密  /////////////////////////////////

/** 加密 */
- (NSData *)aes256EncryptWithKey:(NSString *)key;

/** 解密 */
- (NSData *)aes256DecryptWithKey:(NSString *)key;

/**  */
+(NSData *)dataWithBase64String:(NSString *)base64String;
-(NSString *)base64String;

@end

@interface NSString (STEncrypt)

////////////////////////////// base64加密、解密  /////////////////////////////////

/** md5 */
- (NSString *)md5;

/** base64 */
- (NSString *)base64;
- (NSString *)stringFromBase64;

/** aes256 */
- (NSString *)encryptWithKey:(NSString *)key;
- (NSString *)decryptWithKey:(NSString *)key;

@end
