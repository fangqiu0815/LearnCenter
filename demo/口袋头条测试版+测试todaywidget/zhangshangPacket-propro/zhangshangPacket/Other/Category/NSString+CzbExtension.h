//
//  NSString+CzbExtension.h
//  czb_ios_proj
//
//  Created by jg on 2017/3/9.
//  Copyright © 2017年 唯城. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (CzbExtension)

/**
 根据运营商的英文简写返回汉字

 @param shortString 英文简写
 @return 联通 电信 移动
 */
+ (NSString *)carrieropterWithShort:(NSString *)shortString;


/**
 判断当前字符是否包含在限制字符串内

 @param limitString 限制字符串
 @return YES 在 NO  不在
 */
- (BOOL)shouldChangeCharaetersWithLimitString:(NSString *)limitString;


/**
 限制字符串的长度

 @param length 限制的长度
 @return limitString
 */
- (NSString *)limitStringLengthWithLength:(NSInteger)length;

/**
 判断是否是正确的手机号

 @return YES  是  NO 不是
 */
- (BOOL)isPhoneNo;


/**
 生成时间戳

 @return 时间戳
 */
+ (NSString *)timestamp;


/**
 md5加密

 @return 加密后的字符串
 */
- (NSString *)md5;


/**
 获取rid

 @return rid
 */
+ (NSString *)rid;


/**
 生成指定格式的时间

 @param dateFormat 格式
 @return dateString
 */
- (NSString *)dateStringWithDateFormat:(NSString *)dateFormat;


/**
 密码校验

 @return YES 符合 NO 不符合
 */
- (BOOL)verifyPassword;


- (BOOL)passwordMinmumLength;

+ (NSString *)IPAddress:(BOOL)preferIPv4;
//截取字符串，并获得数组格式
+ (NSString *)CutStringWithArray:(NSMutableArray *)strArr;

- (BOOL)isBlankString:(NSString *)string ;

@end
