//
//  KDHttpRequest.m
//  Shopping
//
//  Created by admin on 2017/6/29.
//  Copyright © 2017年 admin. All rights reserved.
//

#import "KDHttpRequest.h"
#import "KDSecurity.h"
#import "NSObject+_KDJson.h"
#import "NSString+_KDSecurity.h"

static NSString *kMd5SecurityKey;
static NSTimeInterval kTimeDeviation;
int RequestTimeout = 20;

@implementation KDHttpRequest

static NSString *kUid;
+ (NSString *)uid
{
    return kUid;
}

+ (void)setUid:(NSString *)uid
{
    @synchronized (kUid)
    {
        kUid = [uid copy];
    }
}

static NSString *kAppID;
+ (NSString *)appID
{
    return kAppID;
}

+ (void)setAppID:(NSString *)appID
{
    @synchronized (kAppID)
    {
        kAppID = [appID copy];
    }
}

static NSString *kAppKey;
+ (NSString *)appKey
{
    return kAppKey;
}

+ (void)setAppKey:(NSString *)appKey
{
    @synchronized (kMd5SecurityKey)
    {
        if (![kAppKey isEqualToString:appKey])
        {
            NSString *securityKey  = [NSString stringWithFormat:@"%@",kATMSecurityKey];
            kMd5SecurityKey =  securityKey;
        }
    }
    
    @synchronized (kAppKey)
    {
        kAppKey = [appKey copy];
    }
}

static NSDictionary *kPublicParams;
+ (NSDictionary *)publicParams
{
    @synchronized (kPublicParams)
    {
        if (!kPublicParams) kPublicParams = @{};
        return kPublicParams;
    }
}

+ (void)setPublicParams:(NSDictionary *)publicParams
{
    @synchronized (kPublicParams)
    {
        kPublicParams = [publicParams copy];
    }
}

+ (void)requestWithRequesturl:(NSString * _Nullable)urlString
                   headerSign:(NSString * _Nullable)headerSign
                   httpMethod:(httpMethod)httpMethod
                    paramters:(_Nullable id)paramters
              blockCompletion: (nullable void(^)(id  _Nullable responseObject))finishBlock
                    withError:(nullable void(^)(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error))errorBlock{
    if (urlString == nil) {
        urlString = @"";
    }
    
    urlString = [urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    AFHTTPSessionManager *HttpSession = [AFHTTPSessionManager manager];
    HttpSession.responseSerializer.acceptableContentTypes = [HttpSession.responseSerializer.acceptableContentTypes setByAddingObject:@"text/html"];
    
    // 公共参数字典
    NSDictionary *publicParams = paramters;
    // 合成 data 参数
    NSMutableDictionary *rSecurityParams = [[NSMutableDictionary alloc] initWithDictionary:publicParams];
    [rSecurityParams setValuesForKeysWithDictionary:paramters];
    
    NSString *jsonString = [rSecurityParams jsonString];
    
    NSLog(@"112---jsonString---%@",jsonString);
    NSString *securityKey  = [NSString stringWithFormat:@"%@",kATMSecurityKey];
    //加密数据
    NSString *aesData = [jsonString kd_aesEncryptWitKey:securityKey andIV:kATMSecurityIV];
    NSLog(@"aesData---%@",aesData);
    NSMutableDictionary *rParams = [NSMutableDictionary dictionary];
    [rParams setObject:aesData  forKey:@"aesdata"];
    [rParams setObject:kATMSecurityIV forKey:@"iv"];
    
    void (^mySuccess)(NSURLSessionDataTask * _Nonnull, id _Nullable) = ^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject)
    {
        NSLog(@"responseObject---%@",responseObject);
        
        NSString *dataResult =  responseObject[@"resdata"];
        NSLog(@"dataResult---%@",dataResult);
        NSString *ivResult =  responseObject[@"iv"];

        NSString *jsonResult = [dataResult kd_aesDecryptWitKey:kATMSecurityKey andIV:ivResult];
        
        id tempData = [jsonResult jsonObject];
        NSLog(@"tempData---%@",tempData);
        
        if (finishBlock)
        {
            finishBlock(tempData);
        }
    };
    
    void (^myFailure)(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) = ^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error)
    {
        if (errorBlock)
        {
            errorBlock(task,error);
        }
    };
    
    
    if (httpMethod == POST) {
        
        [HttpSession.requestSerializer setValue:headerSign forHTTPHeaderField:@"sign"];
        [HttpSession.requestSerializer willChangeValueForKey:@"timeoutInterval"];
        HttpSession.requestSerializer.timeoutInterval = RequestTimeout;
        [HttpSession.requestSerializer didChangeValueForKey:@"timeoutInterval"];
        
        [HttpSession POST:urlString parameters:rParams progress:nil success:mySuccess failure: myFailure];
        
    }else if (httpMethod == GET) {
        
        [HttpSession.requestSerializer setValue:headerSign forHTTPHeaderField:@"sign"];
        [HttpSession.requestSerializer willChangeValueForKey:@"timeoutInterval"];
        HttpSession.requestSerializer.timeoutInterval = RequestTimeout;
        [HttpSession.requestSerializer didChangeValueForKey:@"timeoutInterval"];
        
        [HttpSession GET:urlString parameters:rParams progress:nil success:mySuccess failure:myFailure];

        
        
    }
    
}



+ (NSString*)urlEncodedString:(NSString *)string
{
    NSString * encodedString = (__bridge_transfer  NSString*) CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault, (__bridge CFStringRef)string, NULL, (__bridge CFStringRef)@"!*'();:@&=+$,/?%#[]", kCFStringEncodingUTF8 );
    return encodedString;
}

//返回32位大小写字母和数字
+(NSString *)return32LetterAndNumber{
    //定义一个包含数字，大小写字母的字符串
    NSString * strAll = @"0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ";
    //定义一个结果
    NSString * result = [[NSMutableString alloc]initWithCapacity:32];
    for (int i = 0; i < 32; i++)
    {
        //获取随机数
        NSInteger index = arc4random() % (strAll.length-1);
        char tempStr = [strAll characterAtIndex:index];
        result = (NSMutableString *)[result stringByAppendingString:[NSString stringWithFormat:@"%c",tempStr]];
    }
    
    return result;
}


@end
