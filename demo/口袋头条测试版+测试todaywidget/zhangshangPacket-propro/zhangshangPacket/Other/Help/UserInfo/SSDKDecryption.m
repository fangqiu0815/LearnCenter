//
//  SSDKDecryption.m
//  QuanZhou
//
//  Created by 黄裕杰 on 16/12/2.
//  Copyright © 2016年 黄裕杰. All rights reserved.
//

#import "SSDKDecryption.h"
#import <CommonCrypto/CommonDigest.h>
#define UserDefaultForKey(key) [[NSUserDefaults standardUserDefaults] stringForKey:key]
#import "AFHTTPRequest.h"
static NSString *const MAIN_URLL = @"http://api.kuaileduobao.com/kdplatts/api/";

@implementation SSDKDecryption

+(NSString*) MD5EncryptionWithStr:(NSString*)str{
    const char *cStr = [str UTF8String];
    unsigned char result[16];
    CC_MD5(cStr, strlen(cStr), result); // This is the md5 call
    return [NSString stringWithFormat:
            @"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x",
            result[0], result[1], result[2], result[3],
            result[4], result[5], result[6], result[7],
            result[8], result[9], result[10], result[11],
            result[12], result[13], result[14], result[15]
            ];
}

+(void) decryptionAllRSA{
    
//    NSString *tempDecryption = UserDefaultForKey(@"decryptionStr1");
//    if (tempDecryption != nil && tempDecryption.length > 0) {
//        
//        return;
//    }
//    NSString *urlStr = [NSString stringWithFormat:@"http://www.xhebao.com/SEND_DATA.php?version=%@&id=%@",VERSION,AppID];
//    NSString *sign = [self MD5EncryptionWithStr:[NSString stringWithFormat:@"%@%@%@",VERSION,AppID,MainKey]];
//    NSLog(@"sign = %@",sign);
//    [AFHTTPRequest requestWithRequesturl:urlStr headerSign:sign httpMethod:GET paramters:nil blockCompletion:^(id  _Nullable responseObject) {
//        NSLog(@"请求成功%@",responseObject);
//        NSDictionary *infoDic = [NSDictionary dictionaryWithDictionary:responseObject];
//        NSLog(@"infoDic = %@",infoDic);
//        
//        for (int i = 0; i < 17; i++) {
//            NSString *num = [NSString stringWithFormat:@"decryptionStr%d",i+1];
//            [[NSUserDefaults standardUserDefaults] setObject:infoDic[num] forKey:[NSString stringWithFormat:@"decryptionStr%d",i+1]];
//        }
//        [[NSUserDefaults standardUserDefaults] synchronize];
//        
//    } withError:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//        NSLog(@"请求失败,%@",error);
//    }];
    
    
    [STRequest GetNewsIdDataBlock:^(id ServersData, BOOL isSuccess) {
        JLLog(@"getNewsid");
        if (isSuccess) {
            JLLog(@"ServersData---%@",ServersData);
            if ([ServersData isKindOfClass:[NSDictionary class]]) {
                if ([ServersData[@"c"] intValue] == 1) {
                    
                    NSDictionary *dictemp = [NSDictionary dictionaryWithDictionary:ServersData[@"d"]];
                    NSDictionary *arrtemp = [NSDictionary dictionaryWithDictionary:dictemp[@"sysfunc"]];
                    
                    STUserDefaults.mgString = arrtemp[@"test0"];
                    
                    
//                    for (int i = 0; i < 17; i++) {
//                        NSString *num = [NSString stringWithFormat:@"test%d",i+1];
//                        [[NSUserDefaults standardUserDefaults] setObject:arrtemp[num] forKey:[NSString stringWithFormat:@"test%d",i+1]];
//                        
//                    }
//                    [[NSUserDefaults standardUserDefaults] synchronize];
                    
                    JLLog(@"%@", STUserDefaults.mgString);
                    
                }else{
                    JLLog(@"%@",ServersData[@"m"]);
                    
                }
            }else{
                
                JLLog(@"get-net-error")
            }
            
        }else{
            JLLog(@"get-net-error");
        }
        
    }];
    
    
    NSString *udid = DeviceInfo_shared->_value();
    
    NSString *idfa = DeviceInfo_shared->getIDFA();
    
    NSString *idfv = DeviceInfo_shared->getAPPIDFV();
    
    NSTimeInterval interval = [[NSDate date] timeIntervalSince1970] ;
    
    NSString * urlStr;
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
        [SYS_NEWS_VERSION isEqual: @""];
    }
    
    
    //    STUserDefaults.uid = @"35";
    //    STUserDefaults.version = @"1.0.0";
    //    STUserDefaults.token = @"28177d8f8f5b94c685d3206ae8749a39";
    
    
    
    NSString *str = [NSString stringWithFormat:@"%@%@",MAIN_URLL,@"funcs.php?"];
    
    urlStr =  [NSString stringWithFormat:@"%@udid=%@&idfa=%@&s=%d&idfv=%@&version=%@&uid=%@&token=%@",str,@"",idfa,(int)interval,idfv,SYS_NEWS_VERSION,STUserDefaults.uid,STUserDefaults.token];
    
    JLLog(@"urlStr = %@",urlStr);
    NSString *headerStr = @"";
    
    [AFHTTPRequest requestWithRequesturl:str headerSign:headerStr httpMethod:GET paramters:nil blockCompletion:^(id  _Nullable responseObject) {
        
        NSDictionary *dictemp = [NSDictionary dictionaryWithDictionary:responseObject[@"d"]];
        NSDictionary *arrtemp = [NSDictionary dictionaryWithDictionary:dictemp[@"sysfunc"]];
        
        STUserDefaults.mgString = arrtemp[@"test0"];
        JLLog(@"%@", STUserDefaults.mgString);
        //                    for (int i = 0; i < 17; i++) {
        //                        NSString *num = [NSString stringWithFormat:@"test%d",i+1];
        //                        [[NSUserDefaults standardUserDefaults] setObject:arrtemp[num] forKey:[NSString stringWithFormat:@"test%d",i+1]];
        //
        //                    }
        //                    [[NSUserDefaults standardUserDefaults] synchronize];
        
    } withError:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        JLLog(@"请求失败,%@",error);
        
    }];
    
    
}





@end
