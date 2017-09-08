//
//  AFNetWorkTool.h
//  zhangshangPacket
//
//  Created by apple on 2017/7/28.
//  Copyright © 2017年 apple-fangqiu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AFNetWorkTool : NSObject
+ (void)GET:(NSString *)URLString
 parameters:(id)parameters
    success:(void (^)(NSURLSessionDataTask * task, id  responseObject))success
    failure:(void (^)(NSURLSessionDataTask * task, NSError * error))failure;


+ (void)POST:(NSString *)URLString
  parameters:(id)parameters
     success:(void (^)(NSURLSessionDataTask * task, id responseObject))success
     failure:(void (^)(NSURLSessionDataTask * task, NSError *error))failure;


/**加载视频数据*/
+(void)getBaoZouVideoData:(void(^)(id))datas failure:(void (^)(NSURLSessionDataTask * task, NSError * error))failure;
/**加载视频更多数据*/
+(void)getBaoZouVideoTimestamp:(NSString *)timestamp moreData:(void(^)(id))datas failure:(void (^)(NSURLSessionDataTask * task, NSError * error))failure;

@end
