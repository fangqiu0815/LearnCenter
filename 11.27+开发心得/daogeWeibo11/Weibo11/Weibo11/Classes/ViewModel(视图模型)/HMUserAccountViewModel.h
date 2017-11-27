//
//  HMUserAccountViewModel.h
//  Weibo11
//
//  Created by 刘凡 on 15/12/8.
//  Copyright © 2015年 itheima. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HMUserAccount.h"

@interface HMUserAccountViewModel : NSObject
/// 用户账户单例
+ (instancetype)sharedUserAccount;

/// 用户账户模型只读属性
@property (nonatomic, strong, readonly) HMUserAccount *userAccount;
/// 用户是否登录
@property (nonatomic, assign, readonly) BOOL isLogon;
/// 用户头像 URL
@property (nonatomic, assign, readonly) NSURL *avatarURL;

/// 发起网路请求，加载 access token
/// token 加载完成后，会再次加载用户信息并保存
///
/// @param code      授权码
/// @param completed 完成回调
- (void)accessTokenWithCode:(NSString *)code completed:(void (^) (BOOL isSuccessed))completed;

@end
