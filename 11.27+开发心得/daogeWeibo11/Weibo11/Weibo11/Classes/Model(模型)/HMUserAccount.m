//
//  HMUserAccount.m
//  Weibo11
//
//  Created by 刘凡 on 15/12/6.
//  Copyright © 2015年 itheima. All rights reserved.
//

#import "HMUserAccount.h"

@implementation HMUserAccount

#pragma mark - 构造函数
+ (instancetype)userAccountWithDict:(NSDictionary *)dict {
    id obj = [[self alloc] init];
    
    [obj setValuesForKeysWithDictionary:dict];
    
    return obj;
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key {}

/// 对象描述信息
- (NSString *)description {
    NSArray *keys = @[@"access_token", @"expires_in", @"uid", @"screen_name", @"avatar_large", @"expiresDate"];
    
    return [self dictionaryWithValuesForKeys:keys].description;
}

#pragma mark - 重写属性方法
- (void)setExpires_in:(NSTimeInterval)expires_in {
    _expires_in = expires_in;
    
    self.expiresDate = [NSDate dateWithTimeIntervalSinceNow:expires_in];
}

@end
