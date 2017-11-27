//
//  HMUser.m
//  Weibo11
//
//  Created by 刘凡 on 15/12/9.
//  Copyright © 2015年 itheima. All rights reserved.
//

#import "HMUser.h"

@implementation HMUser

+ (instancetype)userWithDict:(NSDictionary *)dict {
    id obj = [[self alloc] init];
    
    [obj setValuesForKeysWithDictionary:dict];
    
    return obj;
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key {}

- (NSString *)description {
    NSArray *keys = @[@"id", @"screen_name", @"profile_image_url", @"verified_type", @"mbrank"];
    
    return [self dictionaryWithValuesForKeys:keys].description;
}

@end
