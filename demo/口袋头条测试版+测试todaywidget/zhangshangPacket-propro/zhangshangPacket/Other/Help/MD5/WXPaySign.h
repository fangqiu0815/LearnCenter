//
//  WXPaySign.h
//  SanWangTong
//
//  Created by 黄裕杰 on 16/6/17.
//  Copyright © 2016年 黄裕杰. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <CommonCrypto/CommonDigest.h>


@interface WXPaySign : NSObject


+(NSString *)getSign:(NSDictionary*)backDict;

+ (NSString *)md5:(NSString *)str;



// MD5加密
/*
 *由于MD5加密是不可逆的,多用来进行验证
 */
// 32位小写
+(NSString *)MD5ForLower32Bate:(NSString *)str;
// 32位大写
+(NSString *)MD5ForUpper32Bate:(NSString *)str;
// 16为大写
+(NSString *)MD5ForUpper16Bate:(NSString *)str;
// 16位小写
+(NSString *)MD5ForLower16Bate:(NSString *)str;



@end
