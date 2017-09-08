
#import "AFHTTPRequest.h"

#define RequestTimeout 60


@implementation AFHTTPRequest


+ (NSString*)urlEncodedString:(NSString *)string{
    NSString * encodedString = (__bridge_transfer  NSString*) CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault, (__bridge CFStringRef)string, NULL, (__bridge CFStringRef)@"!*'();:@&=+$,/?%#[]", kCFStringEncodingUTF8 );
    
    return encodedString;
}

+(BOOL) judgeRequestStatus:(NSDictionary*)backDict{
    
    NSString * upgrade = [NSString stringWithFormat:@"%@",[[backDict objectForKey:@"result"] objectForKey:@"upgrade"]];

    
    if ([upgrade isEqualToString:@"1"]) {
        //当更新字段为 1 时显示更新
        
        [[NSNotificationCenter defaultCenter] postNotificationName:@"Appupgrade" object:nil];

        
    }
    
    
    NSString *status = [NSString stringWithFormat:@"%@",[[backDict objectForKey:@"result"] objectForKey:@"code"]];
    if ([status isEqualToString:@"10000"]) {
        return YES;
    }
    return NO;
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
    
    AFHTTPSessionManager *session = [AFHTTPSessionManager manager];
    
    session.responseSerializer.acceptableContentTypes = [session.responseSerializer.acceptableContentTypes setByAddingObject:@"text/html"];
    
    if (httpMethod == GET) {
        
        [session.requestSerializer setValue:headerSign forHTTPHeaderField:@"sign"];
        
        
        [session.requestSerializer willChangeValueForKey:@"timeoutInterval"];
        session.requestSerializer.timeoutInterval = RequestTimeout;
        [session.requestSerializer didChangeValueForKey:@"timeoutInterval"];
    
        
        
        [session GET:urlString parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            
            if ([responseObject isKindOfClass:[NSDictionary class]]) {
                NSDictionary *backDict = responseObject;
                if ([[NSString stringWithFormat:@"%@",[backDict objectForKey:@"msg"]] isEqualToString:@"校验失败"]) {
                    [[NSNotificationCenter defaultCenter] postNotificationName:@"AgainGetCipher" object:nil];
                }
            }else{
                if (![responseObject isKindOfClass:[NSArray class]]) {
                    JLLog(@"返回信息：%@",responseObject);
                }
            }
            
            
            if (finishBlock) {
                finishBlock(responseObject);
            }
            
            
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            
            if (errorBlock) {
                errorBlock(task,error);
            }
        }];
        
    }
    
    if (httpMethod == POST) {
        
        AFJSONRequestSerializer *serializer = [AFJSONRequestSerializer serializer];
        [serializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
        [serializer setValue:@"application/json" forHTTPHeaderField:@"Accept"];
        [serializer setValue:headerSign forHTTPHeaderField:@"sign"];
        
        [serializer willChangeValueForKey:@"timeoutInterval"];
        serializer.timeoutInterval = RequestTimeout;
        [serializer didChangeValueForKey:@"timeoutInterval"];
        
        session.requestSerializer = serializer;
        
        
        [session POST:urlString parameters:paramters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            
            
            if ([responseObject isKindOfClass:[NSDictionary class]]) {
                NSDictionary *backDict = responseObject;
                if ([[NSString stringWithFormat:@"%@",[backDict objectForKey:@"msg"]] isEqualToString:@"校验失败"]) {
                    [[NSNotificationCenter defaultCenter] postNotificationName:@"AgainGetCipher" object:nil];
                }
            }else{
                if (![responseObject isKindOfClass:[NSArray class]]) {
                    JLLog(@"返回信息：%@",[[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding]);
                }
            }
        
            
            
            if (finishBlock) {
                finishBlock(responseObject);
            }
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            if (errorBlock) {
                errorBlock(task,error);
            }
        }];
        
    }
}

+ (void)requestWithRequesturl:(NSString * _Nullable)URLString
                   headerSign:(NSString * _Nullable)headerSign
                fristImageURL:(NSString * _Nullable)fristImageURL
               secondImageURL:(NSString * _Nullable)secondImageURL
                thirdImageURL:(NSString * _Nullable)thirdImageURL
                      success:(nullable void (^)(id _Nonnull responseObject))success
                      failure:(nullable void (^)(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error))failure{
    
    if (URLString == nil) {
        URLString = @"";
    }
    URLString = [URLString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    
    AFHTTPSessionManager *session = [AFHTTPSessionManager manager];
    
    session.responseSerializer.acceptableContentTypes = [session.responseSerializer.acceptableContentTypes setByAddingObject:@"text/html"];
    
    [session.requestSerializer setValue:headerSign forHTTPHeaderField:@"sign"];
    
    [session.requestSerializer willChangeValueForKey:@"timeoutInterval"];
    session.requestSerializer.timeoutInterval = RequestTimeout;
    [session.requestSerializer didChangeValueForKey:@"timeoutInterval"];
    
    [session POST:URLString parameters:nil constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        NSArray *paths = NSSearchPathForDirectoriesInDomains( NSDocumentDirectory,                                                                          NSUserDomainMask, YES);
        NSString *documentsDirectory = [paths objectAtIndex:0];
        
        
        if (fristImageURL != nil && ![fristImageURL isEqualToString:@""]) {
            [formData appendPartWithFileData:[NSData dataWithContentsOfFile:[documentsDirectory stringByAppendingPathComponent:fristImageURL]] name:@"img1" fileName:fristImageURL mimeType:@"image/png"];
        }
        if (secondImageURL != nil && ![secondImageURL isEqualToString:@""]) {
            [formData appendPartWithFileData:[NSData dataWithContentsOfFile:[documentsDirectory stringByAppendingPathComponent:secondImageURL]] name:@"img2" fileName:secondImageURL mimeType:@"image/png"];
        }
        if (thirdImageURL != nil && ![thirdImageURL isEqualToString:@""]) {
            [formData appendPartWithFileData:[NSData dataWithContentsOfFile:[documentsDirectory stringByAppendingPathComponent:thirdImageURL]] name:@"img3" fileName:thirdImageURL mimeType:@"image/png"];
        }
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if ([responseObject isKindOfClass:[NSDictionary class]]) {
            NSDictionary *backDict = responseObject;
            if ([[NSString stringWithFormat:@"%@",[backDict objectForKey:@"msg"]] isEqualToString:@"校验失败"]) {
                [[NSNotificationCenter defaultCenter] postNotificationName:@"AgainGetCipher" object:nil];
            }
        }else{
            if (![responseObject isKindOfClass:[NSArray class]]) {
                JLLog(@"%@",responseObject);
            }
        }
        
        if (success) {
            success(responseObject);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failure) {
            failure(task,error);
        }
    }];
    
    
}




@end
