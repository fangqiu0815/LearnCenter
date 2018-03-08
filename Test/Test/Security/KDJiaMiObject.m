//
//  JiaMiObject.m
//  OneYuanShop
//
//  Created by yujie on 15-4-20.
//  Copyright (c) 2015年 yujie. All rights reserved.
//

#import "KDJiaMiObject.h"

@implementation KDJiaMiObject


#pragma mark - MD5加密
+ (NSString *)md5:(NSString *)str{
    const char *cStr = [str UTF8String];
    unsigned char result[16];
    CC_MD5(cStr, strlen(cStr), result); // This is the md5 call

    return [NSString stringWithFormat:
            @"%02x%02x%02x%02x%02x%02x%02x%02x",
            result[4], result[5], result[6], result[7],
            result[8], result[9], result[10], result[11]];
}

+ (BOOL) isBlankString:(NSString *)string {
    if (string == nil || string == NULL) {
        return YES;
    }
    if ([string isKindOfClass:[NSNull class]]) {
        return YES;
    }
    if ([[string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] length]==0) {
        return YES;
    }
    if ([string isEqualToString:@"(null)"]) {
        return YES;
    }
    if ([string isEqualToString:@"<null>"]) {
        return YES;
    }
    if ([string isEqualToString:@""]) {
        return YES;
    }
    return NO;
}


#pragma mark - md5加密
+ (NSString *)MD5Encryption:(NSString *)str{
    const char *cStr = [str UTF8String];
    unsigned char result[16];
    CC_MD5(cStr, strlen(cStr), result); // This is the md5 call
    return [NSString stringWithFormat:
            @"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x",
            result[0], result[1], result[2], result[3],
            result[4], result[5], result[6], result[7],
            result[8], result[9], result[10], result[11],
            result[12], result[13], result[14], result[15]
            ];
}

#pragma mark - 
static NSString* TYEncryptionAlgorithm (NSString*cipcheStr){
    if (cipcheStr == nil) {
        return @"";
    }
    NSMutableDictionary *resultsMDict1 = [[NSMutableDictionary alloc] init];
    NSMutableDictionary *resultsMDict2 = [[NSMutableDictionary alloc] init];
    // ***
    NSArray *array= [cipcheStr componentsSeparatedByString:@"^:^"];
    if (array.count != 3) {
        return @"";
    }
    if (![array[0] isEqualToString:@"m86j10x"] && ![array[1] isEqualToString:@"i31gk"]) {
        // ***
        NSString *firstCipcheStr = array[0];
        firstCipcheStr = [[[[[[firstCipcheStr stringByReplacingOccurrencesOfString:@"%" withString:@"~"]
                         stringByReplacingOccurrencesOfString:@"^" withString:@"~"]
                        stringByReplacingOccurrencesOfString:@"&" withString:@"~"]stringByReplacingOccurrencesOfString:@"*" withString:@"~"]
                        stringByReplacingOccurrencesOfString:@"(" withString:@"~"]
                        stringByReplacingOccurrencesOfString:@")" withString:@"~"];
        
        // ***
        NSArray *array1 = [firstCipcheStr componentsSeparatedByString:@"~"];
        NSMutableArray *firstCipcheMArr = [[NSMutableArray alloc] init];
        for (int i = 0; i< array1.count;i++) {
            NSString *tempStr = array1[i];
            // ***
            if (tempStr != nil && ![tempStr isEqualToString:@""]) {
                [firstCipcheMArr insertObject:tempStr atIndex:0];
            }
        }
        
        // ***
        NSArray *secondArr = [array[1] componentsSeparatedByString:@"."];
        
        
        NSMutableString *secondStr = [[NSMutableString alloc] init];
        for (int i = 0; i < secondArr.count; i++) {
            NSString *tempInt = secondArr[i];
            NSString *shijinzhi = toDecimalSystemWithBinarySystem(tempInt);
            if (shijinzhi.length == 9 || i == secondArr.count - 1) {
                if (i == secondArr.count - 1) {
                    NSString *tempAppend = [NSString stringWithFormat:@"%@%@",secondStr,shijinzhi];
                    if (tempAppend.length != firstCipcheMArr.count + 1) {
                        NSInteger tempLength = firstCipcheMArr.count + 1 - tempAppend.length;
                        for (int j = 0; j < tempLength; j++) {
                            shijinzhi = [NSString stringWithFormat:@"0%@",shijinzhi];
                        }
                    }
                }
                [secondStr appendString:shijinzhi];
            }else{
                NSInteger tempLength = 9 - shijinzhi.length;
                for (int j = 0; j < tempLength; j++) {
                    shijinzhi = [NSString stringWithFormat:@"0%@",shijinzhi];
                }
                [secondStr appendString:shijinzhi];
            }
        }
        
        // ***
        [secondStr deleteCharactersInRange:NSMakeRange(0,1)];
        
        // ***
        NSMutableArray *secondCipcheMArr = [[NSMutableArray alloc] init];
        for (int i = 0; i < secondStr.length; i++) {
            NSString *tempStr = [secondStr substringWithRange:NSMakeRange(i, 1)];
            [secondCipcheMArr insertObject:tempStr atIndex:i];
        }
        
        // ***
        for (int i = 0; i< secondCipcheMArr.count; i++) {
            NSString *tempKey = firstCipcheMArr[i];
            if (tempKey.length > 1) {
                tempKey = getReverseString(tempKey);
            }
            [resultsMDict1 setObject:secondCipcheMArr[i] forKey:tempKey];
        }
    }
    
    if (![array[2] isEqualToString:@"&*%~!@"]) {
        NSMutableString *thirdStr = [[NSMutableString alloc] init];
        thirdStr.string = array[2];
        
        NSMutableArray *thirdKeyMArr =[[NSMutableArray alloc] init];
        NSMutableArray *thirdObjectMArr =[[NSMutableArray alloc] init];
        
        // ***
        int i = 0;
        while (thirdStr.length > 0) {
            NSString *keyStr = [NSString stringWithFormat:@"%@",[thirdStr substringWithRange:NSMakeRange(i, 1)]];
            if (isPureInt(keyStr)) {
                i++;
            }else{
                NSString *tempKey = [thirdStr substringWithRange:NSMakeRange(0, i)];
                if (tempKey.length > 1) {
                    tempKey = getReverseString(tempKey);
                }
                [thirdKeyMArr addObject:tempKey];
                [thirdObjectMArr addObject:[thirdStr substringWithRange:NSMakeRange(i, 1)]];
                
                [thirdStr deleteCharactersInRange:NSMakeRange(0, i+1)];
                i = 0;
            }
        }
        
        // ***
        for (int i = 0; i< thirdObjectMArr.count; i++) {
            [resultsMDict2 setObject:thirdObjectMArr[i] forKey:thirdKeyMArr[i]];
        }
        
    }
    
    // ***
    NSMutableDictionary *resultsMDict = [[NSMutableDictionary alloc] initWithDictionary:resultsMDict1];
    [resultsMDict addEntriesFromDictionary:resultsMDict2];
    
    // ***
    NSArray *keys = [resultsMDict allKeys];
    keys = [keys sortedArrayUsingComparator:^(NSNumber *number1,NSNumber *number2) {
        int val1 = [number1 intValue];
        int val2 = [number2 intValue];
        if (val1 < val2) {
            return NSOrderedAscending;
        } else {
            return NSOrderedDescending;
        }
    }];
    
    
    // ***
    NSMutableString *signKeyMStr = [[NSMutableString alloc]init];
    for (int i = 0; i < keys.count; i++) {
        NSString *tempKey = keys[i];
        [signKeyMStr appendString:[resultsMDict objectForKey:tempKey]];
    }
    
    return signKeyMStr;
}


static NSString* toDecimalSystemWithBinarySystem(NSString *binary){
    int ll = 0 ;
    int  temp = 0 ;
    for (int i = 0; i < binary.length; i ++){
        temp = [[binary substringWithRange:NSMakeRange(i, 1)] intValue];
        temp = temp * powf(8, binary.length - i - 1);
        ll += temp;
    }
    NSString * result = [NSString stringWithFormat:@"%d",ll];
    return result;
}

static bool isPureInt(NSString *string){
    NSScanner* scan = [NSScanner scannerWithString:string];
    int val;
    return [scan scanInt:&val] && [scan isAtEnd];
}

static NSString* getReverseString (NSString *tempString){
    NSMutableString * reverseString = [NSMutableString string];
    for(int i = 0 ; i < tempString.length; i ++){
        unichar c = [tempString characterAtIndex:tempString.length- i -1];
        [reverseString appendFormat:@"%c",c];
    }
    tempString = reverseString;
    
    return tempString;
    
}



static KDJiaMiObject_t * util = NULL;


+(KDJiaMiObject_t *)sharedJiaMiObject{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        util = malloc(sizeof(KDJiaMiObject_t));
        util->TYEncryptionAlgorithm = TYEncryptionAlgorithm;
    });
    return util;
}

+ (void)destroy{
    util ? free(util): 0;
    util = NULL;
}


@end

