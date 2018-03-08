//
//  KDHttpRequest.h
//  Shopping
//
//  Created by admin on 2017/6/29.
//  Copyright © 2017年 admin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"

typedef enum
{
    GET,
    POST
}httpMethod;

@interface KDHttpRequest : NSObject
+ (void)requestWithRequesturl:(NSString * _Nullable)urlString
                   headerSign:(NSString * _Nullable)headerSign
                   httpMethod:(httpMethod)httpMethod
                    paramters:(_Nullable id)paramters
              blockCompletion: (nullable void(^)(id  _Nullable responseObject))finishBlock
                    withError:(nullable void(^)(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error))errorBlock;

@property (class,nonatomic, copy) NSDictionary * _Nullable publicParams;
@property (class,nonatomic, copy) NSString * _Nullable appKey;


@end
