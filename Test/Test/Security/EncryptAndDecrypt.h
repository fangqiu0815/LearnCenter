//
//  EncryptAndDecrypt.h
//  Test
//
//  Created by apple-gaofangqiu on 2017/10/19.
//  Copyright © 2017年 apple-fangqiu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface EncryptAndDecrypt : NSObject
- (NSData *)AES256EncryptWithKey:(NSData *)key;   //加密
- (NSData *)AES256DecryptWithKey:(NSData *)key;   //解密




@end
