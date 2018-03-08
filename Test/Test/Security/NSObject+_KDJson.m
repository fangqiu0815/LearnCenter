//
//  NSObject+_KDJson.m
//  KDAdsDemo
//
//  Created by OneByte  on 2017/7/18.
//  Copyright © 2017年 kd. All rights reserved.
//

#import "NSObject+_KDJson.h"
#import "NSString+_KDSecurity.h"

@implementation NSObject (_KDJson)

- (NSString *)jsonString
{
    if (![self isKindOfClass:[NSDictionary class]] && ![self isKindOfClass:[NSArray class]])
    {
        return nil;
    }
    
    NSError *parseError = nil;
    NSString *jsonString;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:self options:NSJSONWritingPrettyPrinted error:&parseError];
    if (parseError)
    {
        NSLog(@"json转化失败：%@",parseError);
        return nil;
    }
    
    jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    
    NSMutableString *mutStr = [NSMutableString stringWithString:jsonString];
    
    NSRange range = {0,jsonString.length};
    
    //去掉字符串中的空格
    
    [mutStr replaceOccurrencesOfString:@" " withString:@"" options:NSLiteralSearch range:range];
    
    NSRange range2 = {0,mutStr.length};
    
    //去掉字符串中的换行符
    
    [mutStr replaceOccurrencesOfString:@"\n" withString:@"" options:NSLiteralSearch range:range2];
    
    return mutStr;
}

- (id)jsonObject
{
    id obj = self;
    
    if (!obj)return nil;

    NSData *jsonData;
    if ([obj isKindOfClass:[NSString class]])
    {
        jsonData = [obj dataUsingEncoding:NSUTF8StringEncoding];
    }
    
    if ([obj isKindOfClass:[NSData class]])
    {
        jsonData = obj;
    }
    
    NSError *err;
    if (jsonData)
    {
        obj = [NSJSONSerialization JSONObjectWithData:jsonData
                                                            options:NSJSONReadingAllowFragments
                                                              error:&err];
        
    }
    
    if(err)
    {
        NSLog(@"json解析失败：%@",err);
        obj = nil;
    }
    
    return obj;
}

@end
