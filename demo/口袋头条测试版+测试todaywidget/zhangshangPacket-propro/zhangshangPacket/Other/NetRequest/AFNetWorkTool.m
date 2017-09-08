//
//  AFNetWorkTool.m
//  zhangshangPacket
//
//  Created by apple on 2017/7/28.
//  Copyright © 2017年 apple-fangqiu. All rights reserved.
//

#import "AFNetWorkTool.h"
static AFHTTPSessionManager *mgr;
#define VideoDatasUrl @"http://dailyapi.ibaozou.com/api/v30/documents/videos/latest"//视频接口

@implementation AFNetWorkTool
+ (void)initialize{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        mgr = [AFHTTPSessionManager manager];
        mgr.requestSerializer.timeoutInterval=6.f;
        mgr.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html", @"text/plain",nil];
        mgr.requestSerializer = [AFJSONRequestSerializer serializer];
    });
}

+ (void)GET:(NSString *)URLString
 parameters:(id)parameters
    success:(void (^)(NSURLSessionDataTask * task, id responseObject))success
    failure:(void (^)(NSURLSessionDataTask * task, NSError * error))failure
{
    [mgr GET:URLString parameters:parameters progress:nil success:success failure:failure];
}


+ (void)POST:(NSString *)URLString
  parameters:(id)parameters
     success:(void (^)(NSURLSessionDataTask * task, id responseObject))success
     failure:(void (^)(NSURLSessionDataTask * task, NSError *error))failure
{
    [mgr POST:URLString parameters:parameters progress:nil success:success failure:failure];
}

+(void)getBaoZouVideoData:(void(^)(id))datas failure:(void (^)(NSURLSessionDataTask * task, NSError * error))failure{
    [self GET:VideoDatasUrl parameters:nil success:^(NSURLSessionDataTask * task, id responseObject) {
        if(datas){
            datas(responseObject);
        }
    } failure:failure];
}

+(void)getBaoZouVideoTimestamp:(NSString *)timestamp moreData:(void(^)(id))datas failure:(void (^)(NSURLSessionDataTask * task, NSError * error))failure{
    [self GET:VideoDatasUrl parameters:@{@"timestamp":timestamp} success:^(NSURLSessionDataTask *task, id responseObject) {
        if(datas){
            datas(responseObject);
        }
    } failure:failure];
}


@end
