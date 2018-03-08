//
//  JiaMiObject.h
//  OneYuanShop
//
//  Created by yujie on 15-4-20.
//  Copyright (c) 2015年 yujie. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <CommonCrypto/CommonDigest.h>

typedef struct _KDJiaMiObject {
    NSString* (*TYEncryptionAlgorithm)(NSString *cipcheStr);
}KDJiaMiObject_t ;



@interface KDJiaMiObject : NSObject

+ (KDJiaMiObject_t *)sharedJiaMiObject;

+ (NSString *) MD5Encryption:(NSString *)str;

+ (NSString *)md5:(NSString *)str;

+ (BOOL) isBlankString:(NSString *)string;


@end


