//
//  SBJson.m
//  SmartBus
//
//  Created by 飞瞳凡想 on 14-5-6.
//  Copyright (c) 2014年 飞瞳凡想. All rights reserved.
//

#import "SBAJson.h"

#define getBusInfoUrl @"http://115.29.46.61:8080/SmartBus/Services/App/Get_bus_info/"
#define updateUrl @"http://115.29.46.61:8080/SmartBus/Services/App/Update/"
#define getTrackBusesNearStopUrl @"http://115.29.46.61:8080/SmartBus/Services/App/Find_track_buses/"
typedef  NS_ENUM(NSInteger, HttpMothed){
    HttpGet,
    HttpPost
};

@implementation SBAJson

-(NSDictionary *) getBusData:(NSString *)busId{
    NSString *url = getBusInfoUrl;
    url = [url stringByAppendingString:busId];
    return [self _sendMessage:url];
}

-(NSDictionary *) getTrackBusNearStop:(NSString *)stopId inLine:(NSString *)lineId{
    return nil;
}

-(NSDictionary *) getTrackBusesNearStop:(NSString *)stopId{
    NSString *url = getTrackBusesNearStopUrl;
    url = [url stringByAppendingString:stopId];
    return [self _sendMessage:url];
}

-(NSDictionary *) update:(NSString *)version{
    NSString *url = updateUrl;
    url = [url stringByAppendingString:version];
    return [self _sendMessage:url];
}

/**
 * 发送http请求,默认mothed=get,data=nil
 * @param url
 * @return dictionary
 */
- (NSDictionary *) _sendMessage:(NSString *)url{
    return [self _sendMessage:url mothed:HttpGet withData:nil];
}
/**
 * 发送http请求
 * @param url
 * @param mothed
 * @param data
 * @return dictionary
 */
-(NSDictionary *) _sendMessage:(NSString *)url mothed:(HttpMothed)mothed withData:(NSData *)data{
    NSURL *post=[NSURL URLWithString:url];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:post cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:10];
    [request setURL:post];
    if (mothed == HttpGet) {
        [request setHTTPMethod:@"GET"];
    }else if (mothed == HttpPost){
        [request setHTTPMethod:@"POST"];
        [request setHTTPBody:data];
        [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
        [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
        [request setValue:[NSString stringWithFormat:@"%lu",(unsigned long)[data length]] forHTTPHeaderField:@"Content-Length"];
    }
    NSData *response = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    return [self _analysisJson:response];
}
/**
 * 解析json数据
 * @param data
 * @return dictionary
 */
-(NSDictionary *) _analysisJson:(NSData *) jsonData{
    NSError *error;
    NSDictionary *data;
    if (jsonData == nil) {
        data = nil;
    }else{
        //JSON解析为Dictionary
        data = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:&error];
    }
    return data;
}
@end
