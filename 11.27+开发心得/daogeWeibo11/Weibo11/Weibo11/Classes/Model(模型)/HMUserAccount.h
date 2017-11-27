//
//  HMUserAccount.h
//  Weibo11
//
//  Created by 刘凡 on 15/12/6.
//  Copyright © 2015年 itheima. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HMUserAccount : NSObject
/// 用于调用access_token，接口获取授权后的access token
@property (nonatomic, copy) NSString *access_token;
/// access_token的生命周期，单位是秒数
/// 提示：OC 中使用 NSString 也可以，Swift 中必须使用 NSTimeInterval
@property (nonatomic, assign) NSTimeInterval expires_in;
/// access token 的过期日期，由设置 expires_in 时设置
@property (nonatomic, strong) NSDate *expiresDate;
/// 当前授权用户的UID
@property (nonatomic, copy) NSString *uid;
/// 用户昵称
@property (nonatomic, copy) NSString *screen_name;
/// 用户头像
@property (nonatomic, copy) NSString *avatar_large;

+ (instancetype)userAccountWithDict:(NSDictionary *)dict;

@end
