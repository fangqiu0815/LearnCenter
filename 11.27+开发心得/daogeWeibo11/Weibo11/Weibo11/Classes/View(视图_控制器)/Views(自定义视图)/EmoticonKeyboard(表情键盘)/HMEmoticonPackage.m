//
//  HMEmoticonPackage.m
//  Weibo11
//
//  Created by 刘凡 on 15/12/15.
//  Copyright © 2015年 itheima. All rights reserved.
//

#import "HMEmoticonPackage.h"
#import "HMEmoticon.h"

@implementation HMEmoticonPackage

#pragma mark - 构造函数
+ (instancetype)emoticonPackageWithDict:(NSDictionary *)dict {
    return [[self alloc] initWithDict:dict];
}

- (instancetype)initWithDict:(NSDictionary *)dict {
    
    self = [super init];
    if (self) {
        _groupName = dict[@"group_name_cn"];
        
        // 从 info.plist 中读取所在路径
        NSString *dir = dict[@"id"];
        
        NSArray *array = dict[@"emoticons"];
        
        // 遍历字典生成完整的表情数组
        for (NSDictionary *dict in array) {
            HMEmoticon *em = [HMEmoticon emoticonWithDict:dict];
            
            // 如果是图片设置图片路径
            if (em.type == 0) {
                em.dir = dir;
            }
            
            [self.emoticonsList addObject:em];
        }
    }
    return self;
}

- (NSString *)description {
    NSArray *keys = @[@"groupName", @"emoticonsList"];
    
    return [self dictionaryWithValuesForKeys:keys].description;
}

#pragma mark - 懒加载属性
- (NSMutableArray *)emoticonsList {
    if (_emoticonsList == nil) {
        _emoticonsList = [[NSMutableArray alloc] init];
    }
    return _emoticonsList;
}

@end
