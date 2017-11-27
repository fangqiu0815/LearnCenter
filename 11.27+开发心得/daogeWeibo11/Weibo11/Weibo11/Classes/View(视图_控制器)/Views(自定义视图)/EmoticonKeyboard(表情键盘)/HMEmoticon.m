//
//  HMEmoticon.m
//  Weibo11
//
//  Created by 刘凡 on 15/12/15.
//  Copyright © 2015年 itheima. All rights reserved.
//

#import "HMEmoticon.h"
#import "NSString+Emoji.h"

@implementation HMEmoticon

#pragma mark - getter & setter
- (void)setCode:(NSString *)code {
    _code = code;
    _emoji = code.emoji;
}

- (BOOL)isEmoji {
    return self.type == 1;
}

- (NSString *)imagePath {
    if (self.isEmoji) {
        return nil;
    } else {
        NSString *path = [NSString stringWithFormat:@"/Emoticons.bundle/%@/%@", self.dir, self.png];
        
        // 提示：如果 Bundle pathForResource 需要文件名完全匹配(包含 @2x/@3x)，否则无法加载成功
        return [[NSBundle mainBundle].bundlePath stringByAppendingString:path];
    }
}

#pragma mark - 公共方法
- (NSDictionary *)jsonDictionary {
    return [self dictionaryWithValuesForKeys:@[@"chs", @"code", @"times"]];
}

#pragma mark - 构造函数
+ (instancetype)emoticonWithDict:(NSDictionary *)dict {
    id obj = [[self alloc] init];
    
    [obj setValuesForKeysWithDictionary:dict];
    
    return obj;
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key {}

- (NSString *)description {
    NSArray *keys = @[@"type", @"chs", @"dir", @"png", @"code", @"times"];
    
    return [self dictionaryWithValuesForKeys:keys].description;
}

@end
