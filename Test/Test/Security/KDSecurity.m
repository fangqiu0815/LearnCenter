//
//  ATMSecurity.m
//  Weather
//
//  Created by OneByte  on 2017/7/11.
//  Copyright © 2017年 zhenhui huang. All rights reserved.
//

#import "KDSecurity.h"
#import "KDBase64.h"
#import <CommonCrypto/CommonDigest.h>
#import <CommonCrypto/CommonCryptor.h>



@implementation KDSecurity

+(NSData *)aes256EncryptWithData:(NSData *)data key:(NSString *)key iv:(NSString *)iv
{
    if (!key || key.length !=16)
    {
        NSLog(@"key length must be 16");
        return nil;
    }
    
    if (!iv || iv.length !=16)
    {
        NSLog(@"iv length must be 16");
        return nil;
    }
    
    char keyPtr[kCCKeySizeAES256+1];
    bzero(keyPtr, sizeof(keyPtr));
    [key getCString:keyPtr maxLength:sizeof(keyPtr) encoding:NSUTF8StringEncoding];
    
    char ivPtr[kCCBlockSizeAES128+1];
    memset(ivPtr, 0, sizeof(ivPtr));
    
    [iv getCString:ivPtr maxLength:sizeof(ivPtr) encoding:NSUTF8StringEncoding];
    
    NSUInteger dataLength = data.length;
    size_t bufferSize = dataLength + kCCBlockSizeAES128;
    void *buffer = malloc(bufferSize);
    size_t numBytesEncrypted = 0;
    
    CCCryptorStatus cryptStatus = CCCrypt(kCCEncrypt, kCCAlgorithmAES128,
                                          kCCOptionPKCS7Padding,
                                          keyPtr, kCCBlockSizeAES128,
                                          ivPtr,
                                          data.bytes, dataLength,
                                          buffer, bufferSize,
                                          &numBytesEncrypted);
    
    if (cryptStatus == kCCSuccess) {
        NSLog(@"成功");
        return [NSData dataWithBytesNoCopy:buffer length:numBytesEncrypted];
    }else{
        NSLog(@"失败");
    }
    free(buffer);
    return nil;
}

/**
 *  get source data from aes256 encrypt data
 *
 *  @param data aes256 encrypt data
 *
 *  @return source data
 */
+(NSData *)aes256DecryptWithData:(NSData *)data key:(NSString *)key iv:(NSString *)iv
{
    if (!key || key.length != 16)
    {
        return nil;
    }
    
    if (!iv || iv.length != 16)
    {
        return nil;
    }
    
    char keyPtr[kCCKeySizeAES256+1];
    bzero(keyPtr, sizeof(keyPtr));
    [key getCString:keyPtr maxLength:sizeof(keyPtr) encoding:NSUTF8StringEncoding];
    
    char ivPtr[kCCBlockSizeAES128+1];
    memset(ivPtr, 0, sizeof(ivPtr));
    [iv getCString:ivPtr maxLength:sizeof(ivPtr) encoding:NSUTF8StringEncoding];
    
    NSUInteger dataLength = data.length;
    size_t bufferSize = dataLength + kCCBlockSizeAES128;
    void *buffer = malloc(bufferSize);
    size_t numBytesDecrypted = 0;
    CCCryptorStatus cryptStatus = CCCrypt(kCCDecrypt, kCCAlgorithmAES128,
                                          kCCOptionPKCS7Padding,
                                          keyPtr, kCCBlockSizeAES128,
                                          ivPtr,
                                          data.bytes, dataLength,
                                          buffer, bufferSize,
                                          &numBytesDecrypted);
    if (cryptStatus == kCCSuccess) {
        return [NSData dataWithBytesNoCopy:buffer length:numBytesDecrypted];
    }
    free(buffer);
    return nil;
}

/**
 *  get string's aes256 encrypt data
 *
 *  @param string source string
 *
 *  @return aes256 encrypt data
 */
+(NSData*)aes256EncryptWithString:(NSString*)string key:(NSString *)key andIV:(NSString *)iv
{
    if (!key || key.length != 16)
    {
        NSLog(@"key---%@",key);
        return nil;
    }
    
    if (!iv || iv.length != 16)
    {
        return nil;
    }
    
    NSData *data = [string dataUsingEncoding:NSUTF8StringEncoding];
    
    NSData *encryptedData = [self aes256EncryptWithData:data key:key iv:iv];
    
    return encryptedData;
}

/**
 *  get source string from aes256 encrypt data
 *
 *  @param data aes256 encrypt data
 *
 *  @return source string
 */
+(NSString*)aes256DecryptStringWithData:(NSData *)data key:(NSString *)key andIV:(NSString *)iv
{
    if (!key || key.length != 16)
    {
        return nil;
    }
    
    if (!iv || iv.length != 16)
    {
        return nil;
    }
    
    NSData *decryData = [self aes256DecryptWithData:data key:key iv:iv];
    NSString *string = [[NSString alloc] initWithData:decryData encoding:NSUTF8StringEncoding];
    return string;
}

@end
