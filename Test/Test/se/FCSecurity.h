//
//  FCSecurity.h
//  Weather
//
//  Created by admin  on 2017/7/11.
//  Copyright © 2017年 zhenhui huang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FCSecurity : NSObject

+ (NSData *)aes256EncryptWithData:(NSData *)data;
+ (NSData *)aes256DecryptWithData:(NSData *)data;
+ (NSData*)aes256EncryptWithString:(NSString*)string;
+ (NSString*)aes256DecryptStringWithData:(NSData *)data;

@end
