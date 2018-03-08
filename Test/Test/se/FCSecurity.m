//
//  FCSecurity.m
//  Weather
//
//  Created by admin  on 2017/7/11.
//  Copyright © 2017年 zhenhui huang. All rights reserved.
//

#import "FCSecurity.h"
#import "GTMBase64.h"
#import <CommonCrypto/CommonDigest.h>
#import <CommonCrypto/CommonCryptor.h>

//@ppea1_g00dty123
#define kFCSecurityKey [[NSString alloc] initWithData:[[NSData alloc] initWithBase64EncodedString:kATMSecurityKey options:0]  encoding:NSUTF8StringEncoding]

@implementation FCSecurity

+(NSData *)aes256EncryptWithData:(NSData *)data
{
    NSString *key = kFCSecurityKey;
//    if (!key || key.length !=16) {
//        NSLog(@"key length must be 16");
//        return nil;
//    }
    char keyPtr[kCCKeySizeAES256+1];
    bzero(keyPtr, sizeof(keyPtr));
    [key getCString:keyPtr maxLength:sizeof(keyPtr) encoding:NSUTF8StringEncoding];
    NSUInteger dataLength = data.length;
    size_t bufferSize = dataLength + kCCBlockSizeAES128;
    void *buffer = malloc(bufferSize);
    size_t numBytesEncrypted = 0;
    CCCryptorStatus cryptStatus = CCCrypt(kCCEncrypt, kCCAlgorithmAES128,
                                          kCCOptionPKCS7Padding | kCCOptionECBMode,
                                          keyPtr, kCCBlockSizeAES128,
                                          NULL,
                                          data.bytes, dataLength,
                                          buffer, bufferSize,
                                          &numBytesEncrypted);
    if (cryptStatus == kCCSuccess) {
        return [NSData dataWithBytesNoCopy:buffer length:numBytesEncrypted];
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
+(NSData *)aes256DecryptWithData:(NSData *)data
{
    NSString *key = kFCSecurityKey;
//    if (!key || key.length !=16)
//    {
//        return nil;
//    }
    char keyPtr[kCCKeySizeAES256+1];
    bzero(keyPtr, sizeof(keyPtr));
    [key getCString:keyPtr maxLength:sizeof(keyPtr) encoding:NSUTF8StringEncoding];
    NSUInteger dataLength = data.length;
    size_t bufferSize = dataLength + kCCBlockSizeAES128;
    void *buffer = malloc(bufferSize);
    size_t numBytesDecrypted = 0;
    CCCryptorStatus cryptStatus = CCCrypt(kCCDecrypt, kCCAlgorithmAES128,
                                          kCCOptionPKCS7Padding | kCCOptionECBMode,
                                          keyPtr, kCCBlockSizeAES128,
                                          NULL,
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
+(NSData*)aes256EncryptWithString:(NSString*)string
{
    NSString *key = kFCSecurityKey;
//    if (!key || key.length !=16)
//    {
//        return nil;
//    }
    NSData *data = [string dataUsingEncoding:NSUTF8StringEncoding];
    NSData *encryptedData = [self aes256EncryptWithData:data];
    return encryptedData;
}

/**
 *  get source string from aes256 encrypt data
 *
 *  @param data aes256 encrypt data
 *
 *  @return source string
 */
+(NSString*)aes256DecryptStringWithData:(NSData *)data
{
    NSString *key = kFCSecurityKey;
//    if (!key || key.length !=16)
//    {
//        return nil;
//    }
    
    NSData *decryData = [self aes256DecryptWithData:data];
    NSString *string = [[NSString alloc] initWithData:decryData encoding:NSUTF8StringEncoding];
    return string;
}

@end
