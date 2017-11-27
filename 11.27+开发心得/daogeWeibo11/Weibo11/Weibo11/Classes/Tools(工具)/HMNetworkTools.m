//
//  HMNetworkTools.m
//  Weibo11
//
//  Created by 刘凡 on 15/12/6.
//  Copyright © 2015年 itheima. All rights reserved.
//

#import "HMNetworkTools.h"

/// 微博服务器 BASE URL
NSString *const WB_SERVER_URL = @"https://api.weibo.com/";
/// App Key
NSString *const WB_APP_KEY = @"3995771732";
/// App Secret
NSString *const WB_APP_SECRET = @"c7b253a8381da34eb612a190fee5d100";
/// 回调地址
NSString *const WB_REDIRECT_URL = @"http://www.baidu.com";

@protocol HMNetworkToolsProxy <NSObject>

@optional
/// AFN 内部的数据访问方法
///
/// @param method           HTTP 方法
/// @param URLString        URLString
/// @param parameters       请求参数字典
/// @param uploadProgress   上传进度
/// @param downloadProgress 下载进度
/// @param success          成功回调
/// @param failure          失败回调
///
/// @return NSURLSessionDataTask，需要 resume
- (NSURLSessionDataTask *)dataTaskWithHTTPMethod:(NSString *)method
                                       URLString:(NSString *)URLString
                                      parameters:(id)parameters
                                  uploadProgress:(nullable void (^)(NSProgress *uploadProgress)) uploadProgress
                                downloadProgress:(nullable void (^)(NSProgress *downloadProgress)) downloadProgress
                                         success:(void (^)(NSURLSessionDataTask *, id))success
                                         failure:(void (^)(NSURLSessionDataTask *, NSError *))failure;

@end

@interface HMNetworkTools() <HMNetworkToolsProxy>

@end

@implementation HMNetworkTools

#pragma mark - 单例 & 构造函数
+ (instancetype)sharedTools {
    
    static HMNetworkTools *instance;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[self alloc] initWithBaseURL:[NSURL URLWithString:WB_SERVER_URL]];
    });
    
    return instance;
}

- (instancetype)initWithBaseURL:(NSURL *)url {
    self = [super initWithBaseURL:url];
    
    if (self) {
        [self.reachabilityManager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
            NSLog(@"Reachability: %@", AFStringFromNetworkReachabilityStatus(status));
        }];
        [self.reachabilityManager startMonitoring];
        
        self.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript", @"text/plain", nil];
        [(AFJSONResponseSerializer *)self.responseSerializer setRemovesKeysWithNullValues:YES];
    }
    return self;
}

#pragma mark - 新浪微博相关方法 & 属性
/// OAuth 授权 URL
- (NSURL *)oauthURL {
    
    NSString *urlString = [NSString stringWithFormat:@"https://api.weibo.com/oauth2/authorize?client_id=%@&redirect_uri=%@", WB_APP_KEY, WB_REDIRECT_URL];
    
    return [NSURL URLWithString:urlString];
}

/// 使用授权码获取 Access Token
- (void)accessTokenWithCode:(NSString *)code finised:(HMRequestCallBack)finished {
    
    NSString *urlString = @"oauth2/access_token";
    NSDictionary *parameters = @{@"client_id": WB_APP_KEY,
                                 @"client_secret": WB_APP_SECRET,
                                 @"grant_type": @"authorization_code",
                                 @"code": code,
                                 @"redirect_uri": WB_REDIRECT_URL};
    
    [self requestWithMethod:POST URLString:urlString parameters:parameters finished:finished];
}

#pragma mark - 加载用户信息
/// 使用用户 ID 加载用户账户信息
- (void)loadUserWithUID:(NSString *)uid accessToken:(NSString *)accessToken finished:(HMRequestCallBack)finished {
    
    NSString *urlString = @"2/users/show.json";
    
    NSDictionary *params = @{@"access_token": accessToken, @"uid": uid};
    
    [self requestWithMethod:GET URLString:urlString parameters:params finished:finished];
}

#pragma mark - 加载微博数据
/// 加载微博数据
- (void)loadStatusWithAccessToken:(NSString *)accessToken since_id:(UInt64)since_id max_id:(UInt64)max_id finished:(HMRequestCallBack)finished {
    
    NSString *urlString = @"/2/statuses/home_timeline.json";
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"access_token"] = accessToken;
    
    // 下拉 / 上拉刷新数据
    if (since_id > 0) {
        params[@"since_id"] = @(since_id);
    } else if (max_id > 0) {
        params[@"max_id"] = @(max_id - 1);
    }
    
    [self requestWithMethod:GET URLString:urlString parameters:params finished:finished];
}

/// 发布微博
- (void)postStatus:(NSString *)status image:(UIImage *)image finished:(HMRequestCallBack)finished {
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
#warning TODO - TOKEN 抽取，以及账号过期判断
    params[@"access_token"] = [HMUserAccountViewModel sharedUserAccount].userAccount.access_token;
    params[@"status"] = status;
    
    // 根据 image 是否为 nil，判断是否发布纯文本微博
    if (image == nil) {
        
        NSString *urlString = @"/2/statuses/update.json";
        
        [self requestWithMethod:POST URLString:urlString parameters:params finished:finished];
    } else {
        
        NSString *urlString = @"/2/statuses/upload.json";
        NSData *data = UIImagePNGRepresentation(image);
        
        [self uploadData:data URLString:urlString name:@"pic" parameters:params finished:finished];
    }
}

#pragma mark - 封装 AFN 网络访问方法
/// 发起网络请求
///
/// @param method     GET / POST
/// @param URLString  URLString
/// @param parameters 请求参数字典
/// @param finished   完成回调
- (void)requestWithMethod:(HMRequestMethod)method URLString:(NSString *)URLString parameters:(id)parameters finished:(HMRequestCallBack)finished {
    
    NSString *methodName = (method == GET) ? @"GET" : @"POST";
    
    [[self dataTaskWithHTTPMethod:methodName URLString:URLString parameters:parameters uploadProgress:nil downloadProgress:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        
        finished(responseObject, nil);
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
        DDLogError(@"网络请求错误 %@", error.localizedDescription);
        
        finished(nil, error);
    }] resume];
}

/// POST 上传二进制数据
///
/// @param data       二进制数据
/// @param URLString  URLString
/// @param name       服务器字段名
/// @param parameters 请求参数字典
/// @param finished   完成回调
- (void)uploadData:(NSData *)data URLString:(NSString *)URLString name:(NSString *)name parameters:(id)parameters finished:(HMRequestCallBack)finished {
    
    [self POST:URLString parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        
        [formData appendPartWithFileData:data name:name fileName:@"oooxxx" mimeType:@"application/octet-stream"];
    } progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        finished(responseObject, nil);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        DDLogError(@"网络请求错误 %@", error.localizedDescription);
        
        finished(nil, error);
    }];
}

@end
