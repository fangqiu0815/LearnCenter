//
//  SSDKDecryption.h
//  QuanZhou
//
//  Created by 黄裕杰 on 16/12/2.
//  Copyright © 2016年 黄裕杰. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SSDKDecryption : NSObject

+(void) decryptionAllRSA;
+(NSString*) MD5EncryptionWithStr:(NSString*)str;

@end
