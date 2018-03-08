//
//  NSString+FCSecurity.m
//  Weather
//
//  Created by admin  on 2017/7/11.
//  Copyright © 2017年 zhenhui huang. All rights reserved.
//

#import "NSString+FCSecurity.h"
#import "FCSecurity.h"
#import "GTMBase64.h"



@implementation NSString (FCSecurity)

- (NSString *)aesEncrypt
{
    NSData *data = [FCSecurity aes256EncryptWithString:self];
    if (data)
    {
        return  [GTMBase64 stringByEncodingData:data];
    }
    return nil;
}

- (NSString *)aesDecrypt
{
    NSData *data = [GTMBase64 decodeString:self];
    return  [FCSecurity aes256DecryptStringWithData:data];
}

@end
