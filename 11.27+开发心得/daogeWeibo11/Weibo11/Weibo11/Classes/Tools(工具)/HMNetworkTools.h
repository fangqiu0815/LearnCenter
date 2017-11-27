//
//  HMNetworkTools.h
//  Weibo11
//
//  Created by 刘凡 on 15/12/6.
//  Copyright © 2015年 itheima. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"

typedef enum : NSUInteger {
    GET,
    POST,
} HMRequestMethod;

/// 网络请求回调类型
///
/// @param result 返回结果
/// @param error  错误信息
typedef void (^HMRequestCallBack)(id result, NSError *error);

/// 回调地址
extern NSString *const WB_REDIRECT_URL;

@interface HMNetworkTools : AFHTTPSessionManager

/// 网络工具单例
+ (instancetype)sharedTools;

/// OAuth 授权 URL
@property (nonatomic, strong, readonly) NSURL *oauthURL;

/// 使用授权码获取 Access Token
///
/// @param code     授权码
/// @param finished 完成回调
- (void)accessTokenWithCode:(NSString *)code finised:(HMRequestCallBack)finished;

/// 使用用户 ID 加载用户账户信息
///
/// @param uid         用户代号
/// @param accessToken accessToken
/// @param finished    完成回调
- (void)loadUserWithUID:(NSString *)uid accessToken:(NSString *)accessToken finished:(HMRequestCallBack)finished;

/// 加载微博数据
///
/// @param accessToken accessToken
/// @param since_id    since_id 若指定此参数，则返回ID比since_id大的微博
/// @param max_id      max_id 若指定此参数，则返回ID小于或等于max_id的微博
/// @param finished    完成回调
- (void)loadStatusWithAccessToken:(NSString *)accessToken since_id:(UInt64)since_id max_id:(UInt64)max_id finished:(HMRequestCallBack)finished;

/// 发布微博
///
/// @param status   微博文字
/// @param image    微博图片，如果为 nil，则发布纯文本微博
/// @param finished 完成回调
- (void)postStatus:(NSString *)status image:(UIImage *)image finished:(HMRequestCallBack)finished;

@end
