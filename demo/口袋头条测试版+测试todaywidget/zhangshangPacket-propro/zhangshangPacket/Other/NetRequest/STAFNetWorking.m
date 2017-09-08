//
//  STNetWork.m
//  HomeSeeWorld
//
//  Created by WuYanZu on 16/11/11.
//  Copyright © 2016年 WuYanZu. All rights reserved.
//

#import "STAFNetWorking.h"
/**
 *  存放 网络请求的线程
 */
static NSMutableArray *sg_requestTasks;

/*
 domain = 192.168.1.55
 preurl = http://domain/kdplatts/api/

 */

static NSString *const MAIN_URLL = @"http://api.kuaileduobao.com/kdplatts/api/";

static NSString *const TEMP_URL = @"http://192.168.1.55/kdplatts/api/";

@interface STAFNetWorking()

@property (nonatomic, strong) AFHTTPSessionManager  *manager;
@property (nonatomic, assign, getter=isConnected) BOOL connected;/**<网络是否连接*/
@property (nonatomic, retain) NSURLSessionTask *task;
@end

@implementation STAFNetWorking

-(AFHTTPSessionManager *)manager{
    static AFHTTPSessionManager *rmanager = nil;
    static dispatch_once_t onceToken;
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(changeHeader) name:@"changeHeader" object:nil];

    dispatch_once(&onceToken, ^{
        rmanager = [AFHTTPSessionManager manager];
        rmanager.responseSerializer = [AFJSONResponseSerializer serializer];
        rmanager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html",@"text/plain",@"image/jpg",@"application/json",@"keep-alive", nil];
        rmanager.requestSerializer  = [AFJSONRequestSerializer serializer];
        [rmanager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
        
        NSString *udid = DeviceInfo_shared->_value();
        if ([udid isEqualToString:@"a4d2f177eb466a7d08f8f2b340b77129"]) {
            if ([self isBlankString:STUserDefaults.shebeiID]) {
                udid = DeviceInfo_shared->_value();
            }else{
                udid = STUserDefaults.shebeiID;
            }
        } else {
            udid = DeviceInfo_shared->_value();
        }
        
        NSString *idfa = DeviceInfo_shared->getIDFA();
        NSString *idfv = DeviceInfo_shared->getAPPIDFV();
        NSTimeInterval interval = [[NSDate date] timeIntervalSince1970];
        NSString *secretkey = @"8f300413136366dd8d84aeda7a22f49d";
        NSString *tempStr;

        if (STUserDefaults.token == nil)
        {
            STUserDefaults.token = @"";
        }
        if (STUserDefaults.uid == nil)
        {
            STUserDefaults.uid = @"";
        }
        if (SYS_NEWS_VERSION == nil)
        {
            [SYS_NEWS_VERSION  isEqualToString: @""];
        }
        
//        STUserDefaults.uid = @"35";
//        STUserDefaults.version = @"1.0.0";
//        STUserDefaults.token = @"28177d8f8f5b94c685d3206ae8749a39";
        
        tempStr = [NSString stringWithFormat:@"%@:idfa|%@:idfv|%d:s|%@:token|%@:udid|%@:uid|%@:version|%@:screctkey",idfa,idfv,(int)interval,STUserDefaults.token,udid,STUserDefaults.uid,SYS_NEWS_VERSION,secretkey];
        
#pragma mark ----- sign -----

        NSString *sign = [WXPaySign MD5ForLower32Bate:tempStr];
        JLLog(@"sign=%@",sign);
        [rmanager.requestSerializer setValue:sign forHTTPHeaderField:@"sign"];
        
#pragma mark ----- ostype -----
        
        NSString *ostype = [NSString stringWithFormat:@"0"];
        [rmanager.requestSerializer setValue:ostype forHTTPHeaderField:@"ostype"];
#pragma mark ----- Channel -----
        
        NSString *channel = [NSString stringWithFormat:@"120"];
        [rmanager.requestSerializer setValue:channel forHTTPHeaderField:@"channel"];
        
        // 设置超时时间
        [rmanager.requestSerializer willChangeValueForKey:@"timeoutInterval"];
        rmanager.requestSerializer.timeoutInterval = 60.f;
        [rmanager.requestSerializer didChangeValueForKey:@"timeoutInterval"];
        
    });
    return rmanager;
}
-(void)changeHeader
{
//    static dispatch_once_t onceToken;
//    dispatch_once(&onceToken, ^{

    self.manager.responseSerializer = [AFJSONResponseSerializer serializer];
    self.manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html",@"text/plain",@"image/jpg",@"application/json",@"keep-alive", nil];
    self.manager.requestSerializer  = [AFJSONRequestSerializer serializer];
    [self.manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    
    NSString *udid = DeviceInfo_shared->_value();
    if ([udid isEqualToString:@"a4d2f177eb466a7d08f8f2b340b77129"]) {
        if ([self isBlankString:STUserDefaults.shebeiID]) {
            udid = DeviceInfo_shared->_value();
        }else{
            udid = STUserDefaults.shebeiID;
        }
    } else {
        udid = DeviceInfo_shared->_value();
    }
    
    NSString *idfa = DeviceInfo_shared->getIDFA();
    
    NSString *idfv = DeviceInfo_shared->getAPPIDFV();
    
    NSTimeInterval interval = [[NSDate date] timeIntervalSince1970]  ;

    NSString *secretkey = @"8f300413136366dd8d84aeda7a22f49d";
    
    NSString *tempStr;
    
    if (STUserDefaults.token == nil)
    {
        STUserDefaults.token = @"";
    }
    if (STUserDefaults.uid == nil)
    {
        STUserDefaults.uid = @"";
    }
    if (SYS_NEWS_VERSION == nil)
    {
        [SYS_NEWS_VERSION  isEqualToString: @""];
    }
    
//        STUserDefaults.uid = @"35";
//    
//        STUserDefaults.version = @"1.0.0";
//    
//        STUserDefaults.token = @"28177d8f8f5b94c685d3206ae8749a39";

        tempStr = [NSString stringWithFormat:@"%@:idfa|%@:idfv|%d:s|%@:token|%@:udid|%@:uid|%@:version|%@:screctkey",idfa,idfv,(int)interval,STUserDefaults.token,udid,STUserDefaults.uid,SYS_NEWS_VERSION,secretkey];
    
        JLLog(@"tempStr = %@",tempStr);
        
#pragma mark ----- sign -----
        NSString * sign = [WXPaySign MD5ForUpper32Bate:tempStr];
        JLLog(@"sign = %@",sign);
        [self.manager.requestSerializer setValue:sign forHTTPHeaderField:@"sign"];
#pragma mark ----- ostype -----
        int ostype = 0;
        [self.manager.requestSerializer setValue:[NSString stringWithFormat:@"%d",ostype] forHTTPHeaderField:@"ostype"];
#pragma mark ----- channel -----
        int channel = 120;
        [self.manager.requestSerializer setValue:[NSString stringWithFormat:@"%d",channel] forHTTPHeaderField:@"channel"];

        // 设置超时时间
        [self.manager.requestSerializer willChangeValueForKey:@"timeoutInterval"];
        self.manager.requestSerializer.timeoutInterval = 60.f;
        [self.manager.requestSerializer didChangeValueForKey:@"timeoutInterval"];
//    });
}

- (BOOL)isConnected {
    struct sockaddr zeroAddress;
    bzero(&zeroAddress, sizeof(zeroAddress));
    zeroAddress.sa_len = sizeof(zeroAddress);
    zeroAddress.sa_family = AF_INET;
    
    SCNetworkReachabilityRef defaultRouteReachability =
    SCNetworkReachabilityCreateWithAddress(NULL, (struct sockaddr *)&zeroAddress);
    SCNetworkReachabilityFlags flags;
    
    BOOL didRetrieveFlags =
    SCNetworkReachabilityGetFlags(defaultRouteReachability, &flags);
    CFRelease(defaultRouteReachability);
    
    if (!didRetrieveFlags) {
        printf("Error. Count not recover network reachability flags\n");
        return NO;
    }
    
    BOOL isReachable = flags & kSCNetworkFlagsReachable;
    BOOL needsConnection = flags & kSCNetworkFlagsConnectionRequired;
    return (isReachable && !needsConnection) ? YES : NO;
}


-(void)requsetWithPath:(NSString *)path Withparams:(NSDictionary *)params withRequestType:(NetworkRequestType)type withResult:(ZmzBlock)resultBlock{
    
    if (!self.isConnected) {
        [SVProgressHUD showErrorWithStatus:@"没有网络,建议在手机设置中打开网络"];
        return;
    }
    
    switch (type) {
        case NetworkGetType:
        {
            NSString *cutPath = [NSString stringWithFormat:@"%@%@",MAIN_URLL,path];
            [self.manager GET:cutPath parameters:params progress:^(NSProgress * _Nonnull downloadProgress) {
                
            } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                [self handleRequestResultWithDataTask:task responseObject:responseObject error:nil resultBlock:resultBlock];
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                [self handleRequestResultWithDataTask:task responseObject:nil error:error resultBlock:resultBlock];
            }];
        }
            break;
        case NetworkPostType:
        {
            NSString *cutPath = [NSString stringWithFormat:@"%@%@",MAIN_URLL,path];
            [self changeHeader];
            [self.manager POST:cutPath parameters:params progress:^(NSProgress * _Nonnull uploadProgress) {
                
            } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                [self handleRequestResultWithDataTask:task responseObject:responseObject error:nil resultBlock:resultBlock];
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                [self handleRequestResultWithDataTask:task responseObject:nil error:error resultBlock:resultBlock];
            }];
            
        }
            break;
        case NetworkDeleteType:
        {
            NSString *cutPath = [NSString stringWithFormat:@"%@%@",MAIN_URLL,path];
            if (STUserDefaults.token)
            {
                [self.manager.requestSerializer setValue:STUserDefaults.token forHTTPHeaderField:@"token"];
            }
            [self.manager DELETE:cutPath parameters:params success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                
                [self handleRequestResultWithDataTask:task responseObject:responseObject error:nil resultBlock:resultBlock];

            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                [self handleRequestResultWithDataTask:task responseObject:nil error:error resultBlock:resultBlock];

            }];
        }
            break;
        default:
            break;
    }
}



-(void)downloadWithrequest:(NSString *)urlString downloadpath:(NSString *)downloadpath downloadblock:(ZmzDownBlock)downloadblock{
    if (!self.connected) {
        return;
    }
    
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:urlString]];
    self.task = [self.manager downloadTaskWithRequest:request progress:nil destination:^NSURL *(NSURL *targetPath, NSURLResponse *response) {
        NSURL *desturl = [NSURL fileURLWithPath:downloadpath];
        return desturl;
    } completionHandler:^(NSURLResponse *response, NSURL *filePath, NSError *error) {
        downloadblock(response,filePath,error);
    }];
    [self.task resume];
    
}


- (void)handleRequestResultWithDataTask:(NSURLSessionDataTask *)task
                         responseObject:(id)responseObject
                                  error:(NSError *)error
                            resultBlock:(ZmzBlock)resultBlock {
    //do something here...
    // NSLog(@"%@==-==%@",responseObject,error);
    if(resultBlock) {
        resultBlock(responseObject,error);
    }
}




- (NSURLSessionTask *)uploadImageWithUrl:(NSString *)url
                              WithParams:(NSDictionary*)params
                                   image:(NSData *)imageData
                                filename:(NSString *)name
                                mimeType:(NSString *)mimetype
                              completion:(requestSuccessBlock)completion
                              errorBlock:(requestFailureBlock)errorBlock{
    
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    AFHTTPSessionManager *manager = [self manager];
    NSURLSessionTask *operation = [manager POST:url parameters:params constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        formatter.dateFormat = @"yyyyMMddHHmmss";
        NSString *str = [formatter stringFromDate:[NSDate date]];
        NSString *fileName = [NSString stringWithFormat:@"%@.jpg",str];
        
        // 上传图片，以文件流的格式
        [formData appendPartWithFileData:imageData name:name fileName:fileName mimeType:mimetype];
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        
        completion(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        errorBlock(error);
        
    }];
    
    return operation;
    
    
    
}
- (NSURLSessionTask *)uploadVedioWithUrl:(NSString *)url
                              WithParams:(NSDictionary*)params
                                   image:(NSData *)vedioData
                                filename:(NSString *)name
                                mimeType:(NSString *)mimetype
                              completion:(requestSuccessBlock)completion
                              errorBlock:(requestFailureBlock)errorBlock{
    
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    AFHTTPSessionManager *manager = [self manager];
    
    NSURLSessionTask *operation = [manager POST:url parameters:params constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        formatter.dateFormat = @"yyyyMMddHHmmss";
        NSString *str = [formatter stringFromDate:[NSDate date]];
        NSString *fileName = [NSString stringWithFormat:@"%@.mp4",str];
        [formData appendPartWithFileData:vedioData name:name fileName:fileName mimeType:mimetype];
        
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        completion(responseObject);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        errorBlock(error);
    }];
    
    return operation;
}







- (void)cancelRequestWithURL:(NSString *)url {
    
    if (url == nil) {
        return;
    }
    
    @synchronized(self) {
        [[self allTasks] enumerateObjectsUsingBlock:^(NSURLSessionTask * _Nonnull task, NSUInteger idx, BOOL * _Nonnull stop) {
            if ([task isKindOfClass:[NSURLSessionTask class]]
                && [task.currentRequest.URL.absoluteString hasSuffix:url]) {
                [task cancel];
                [[self allTasks] removeObject:task];
                return;
            }
        }];
    };
}

- (void)cancelAllRequest {
    @synchronized(self) {
        [[self allTasks] enumerateObjectsUsingBlock:^(NSURLSessionTask * _Nonnull task, NSUInteger idx, BOOL * _Nonnull stop) {
            if ([task isKindOfClass:[NSURLSessionTask class]]) {
                [task cancel];
            }
        }];
        
        [[self allTasks] removeAllObjects];
    };
}

- (NSMutableArray *)allTasks {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (sg_requestTasks == nil) {
            sg_requestTasks = [[NSMutableArray alloc] init];
        }
    });
    
    return sg_requestTasks;
}

-(BOOL)isBlankString:(NSString *)string {
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
    return NO;
}

@end
