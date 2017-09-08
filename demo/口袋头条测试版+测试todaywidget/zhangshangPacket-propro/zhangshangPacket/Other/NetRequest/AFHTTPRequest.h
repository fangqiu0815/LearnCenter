
#import <Foundation/Foundation.h>

#import "AFNetworking.h"



typedef enum
{
    GET,
    POST
}httpMethod;

@interface AFHTTPRequest : NSObject


+(BOOL) judgeRequestStatus:(NSDictionary *_Nullable)backDict;



/**
 *  网络请求GET/POST
 *
 *  @param urlString 接口的地址
 *  @param headerSign 接口的加密MD5
 *  @param httpMethod 请求类型 GET/POST
 *  @param paramters  请求字典数据
 */
+ (void)requestWithRequesturl:(NSString * _Nullable)urlString
                   headerSign:(NSString * _Nullable)headerSign
                   httpMethod:(httpMethod)httpMethod
                    paramters:(_Nullable id)paramters
              blockCompletion: (nullable void(^)(id  _Nullable responseObject))finishBlock
                    withError:(nullable void(^)(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error))errorBlock;



/**
 *  上传图片
 *
 */
+ (void)requestWithRequesturl:(NSString * _Nullable)URLString
                   headerSign:(NSString * _Nullable)headerSign
                fristImageURL:(NSString * _Nullable)fristImageURL
               secondImageURL:(NSString * _Nullable)secondImageURL
                thirdImageURL:(NSString * _Nullable)thirdImageURL
                      success:(nullable void (^)(id _Nonnull responseObject))success
                      failure:(nullable void (^)(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error))failure;


@end
