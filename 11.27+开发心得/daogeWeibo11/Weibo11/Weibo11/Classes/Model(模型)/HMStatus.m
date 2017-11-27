//
//  HMStatus.m
//  Weibo11
//
//  Created by 刘凡 on 15/12/9.
//  Copyright © 2015年 itheima. All rights reserved.
//

#import "HMStatus.h"

@implementation HMStatus

+ (instancetype)statusWithDict:(NSDictionary *)dict {
    id obj = [[self alloc] init];
    
    [obj setValuesForKeysWithDictionary:dict];
    
    return obj;
}

- (void)setValue:(id)value forKey:(NSString *)key {
    // 判断 key 是否是 user
    if ([key isEqualToString:@"user"]) {
        self.user = [HMUser userWithDict:value];
        
        return;
    }
    // 判断 key 是否是 retweeted_status
    if ([key isEqualToString:@"retweeted_status"]) {
        self.retweeted_status = [HMStatus statusWithDict:value];
        
        return;
    }
    // 判断 key 是否是 pic_urls
    if ([key isEqualToString:@"pic_urls"]) {
        
        NSMutableArray *urls = [NSMutableArray array];
        
        // 遍历数组，生成 url 数组
        for (NSDictionary *dict in value) {
            [urls addObject:[NSURL URLWithString:dict[@"thumbnail_pic"]]];
        }
        
        self.pic_urls = urls.copy;
        
        return;
    }
    
    [super setValue:value forKey:key];
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key {}

- (NSString *)description {
    NSArray *keys = @[@"id", @"text", @"created_at", @"source", @"user", @"reposts_count", @"comments_count", @"attitudes_count", @"retweeted_status", @"pic_urls"];
    
    return [self dictionaryWithValuesForKeys:keys].description;
}

#pragma mark - 重写 setter 属性
/// 设置来源 - 过滤来源字符串
- (void)setSource:(NSString *)source {
    
    if ([source containsString:@"\">"]) {
        NSRange startRange = [source rangeOfString:@"\">"];
        NSRange endRange = [source rangeOfString:@"</a>"];

        NSUInteger start = NSMaxRange(startRange);
        _source = [NSString stringWithFormat:@"来自 %@", [source substringWithRange:NSMakeRange(start, endRange.location - start)]];
    }
}

/// 设置日期字符串 - 转换成日期对象
- (void)setCreated_at:(NSString *)created_at {
    _created_at = created_at;
    
    // 将创建日期转换成 NSDate
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    fmt.locale = [NSLocale localeWithLocaleIdentifier:@"en"];
    fmt.dateFormat = @"EEE MMM dd HH:mm:ss zzz yyyy";
    
    _createdDate = [fmt dateFromString:created_at];
}

@end
