//
//  HMUserAccountViewModel.m
//  Weibo11
//
//  Created by 刘凡 on 15/12/8.
//  Copyright © 2015年 itheima. All rights reserved.
//

#import "HMUserAccountViewModel.h"
#import "HMUserAccount.h"

/// 保存至用户偏好的 KEY
NSString *const WB_USER_ACCOUNT_KEY = @"WB_UserAccount";

@implementation HMUserAccountViewModel
@synthesize userAccount = _userAccount;

+ (instancetype)sharedUserAccount {
    static id instance;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[self alloc] init];
    });
    
    return instance;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        [self loadUserAccount];
    }
    return self;
}

#pragma mark - 只读属性
/// 用户是否登录
- (BOOL)isLogon {
    return !self.isExpired;
}

/// 用户头像 URL
- (NSURL *)avatarURL {
    return [NSURL URLWithString:_userAccount.avatar_large];
}

#pragma mark - 加载/保存用户账户
/// 加载用户账户
- (void)loadUserAccount {
    
    NSDictionary *dict = [[NSUserDefaults standardUserDefaults] objectForKey:WB_USER_ACCOUNT_KEY];
    
    _userAccount = [HMUserAccount userAccountWithDict:dict];
    
    if ([self isExpired]) {
        _userAccount = nil;
    }
}

/// 判断 access_token 是否过期
/// 类似于 Swift 的只读属性
///
/// @return 是否过期
- (BOOL)isExpired {
    
    // 开发时，可以指定一个日期，测试日期比较函数是否正确
    // - 负数是遭遇当前时间的日期
    // - 正数是晚于当前时间的日期
    // _userAccount.expiresDate = [NSDate dateWithTimeIntervalSinceNow:-1];
    //
    // 测试 userAccount = nil，即第一次运行时，对过期日期的判断
    // _userAccount = nil;
    return ([_userAccount.expiresDate compare:[NSDate date]] != NSOrderedDescending);
}

/// 保存用户账户
- (void)saveUserAccount {
    // 要将一个自定义对象，保存至用户偏好之前，需要将对象转换成 NSDictionary
    // 注意：不要保存 expires_in，该属性只有在登录成功后，用于设置 token 过期日期
    NSArray *keys = @[@"access_token", @"uid", @"screen_name", @"avatar_large", @"expiresDate"];
    
    NSDictionary *dict = [_userAccount dictionaryWithValuesForKeys:keys];
    
    [[NSUserDefaults standardUserDefaults] setObject:dict forKey:WB_USER_ACCOUNT_KEY];
    DDLogInfo(@"用户账户保存成功 %@", NSHomeDirectory());
}

#pragma mark - 封装网路访问方法
/// 发起网路请求加载 token
- (void)accessTokenWithCode:(NSString *)code completed:(void (^)(BOOL))completed {
    
    NSAssert(completed != nil, @"必须传入完成回调");
    
    [[HMNetworkTools sharedTools] accessTokenWithCode:code finised:^(id result, NSError *error) {
        
        if (error != nil) {
            completed(NO);
            return;
        }
        
        // 字典转模型
        _userAccount = [HMUserAccount userAccountWithDict:result];
        
        [self loadUserInfoCompleted:completed];
    }];
}

/// 加载用户信息
- (void)loadUserInfoCompleted:(void (^)(BOOL))completed {

    NSAssert(completed != nil, @"必须传入完成回调");
    
    [[HMNetworkTools sharedTools] loadUserWithUID:_userAccount.uid accessToken:_userAccount.access_token finished:^(id result, NSError *error) {
        
        if (error != nil) {
            completed(NO);
            return;
        }
        
        // 记录用户名和头像地址
        _userAccount.screen_name = result[@"screen_name"];
        _userAccount.avatar_large = result[@"avatar_large"];
        
        DDLogVerbose(@"%@", _userAccount);
        // 保存用户账户
        [self saveUserAccount];
        
        // 完成回调
        completed(YES);
    }];
}

@end
