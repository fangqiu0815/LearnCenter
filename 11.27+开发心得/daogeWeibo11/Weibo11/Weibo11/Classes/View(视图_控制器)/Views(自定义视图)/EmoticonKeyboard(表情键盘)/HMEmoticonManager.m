//
//  HMEmoticonManager.m
//  Weibo11
//
//  Created by 刘凡 on 15/12/15.
//  Copyright © 2015年 itheima. All rights reserved.
//

#import "HMEmoticonManager.h"
#import "HMEmoticonPackage.h"

// 每页显示的表情数量
static NSInteger kEmoticonsCountOfPage = 20;
// 最近表情缓存文件名
static NSString *const kEmoticonsRecentCacheFileName = @"RecentEmoticon.json";

@interface HMEmoticonManager()
/// 表情包 bundle 文件
@property (nonatomic, strong) NSBundle *emoticonBundle;
@end

@implementation HMEmoticonManager

#pragma mark - 单例 & 构造函数
+ (instancetype)sharedManager {
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
        [self loadPackages];
    }
    return self;
}

#pragma mark - 公共方法
/// 添加最近使用表情
- (void)addRecentEmoticon:(HMEmoticon *)emoticon {
    // 1. 增加使用次数
    emoticon.times++;
    
    // 2. 检查表情是否已经在最近表情分组中
    NSMutableArray *emoticonsList = [self.packages[0] emoticonsList];
    if (![emoticonsList containsObject:emoticon]) {
        // 插入表情
        [emoticonsList insertObject:emoticon atIndex:0];
        
        // 判断表情数组数量是否超出一页，如果超出，删除末尾表情
        if (emoticonsList.count > kEmoticonsCountOfPage) {
            [emoticonsList removeLastObject];
        }
    }
    
    // 3. 表情排序
    [emoticonsList sortUsingComparator:^NSComparisonResult(HMEmoticon *obj1, HMEmoticon *obj2) {
        return obj1.times < obj2.times;
    }];
    
    [self saveRecentEmoticons];
}

#pragma mark - 最近表情相关方法
/// 保存最近表情
- (void)saveRecentEmoticons {
    
    // 1. 使用过的表情数组
    NSMutableArray *usedList = [NSMutableArray array];
    
    // 过滤所有使用次数 > 1 的表情
    for (NSInteger index = 1; index < self.packages.count; index++) {
        HMEmoticonPackage *package = self.packages[index];
        
        // 使用谓词过滤数组
        [usedList addObjectsFromArray:[package.emoticonsList filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"times > 0"]]];
    }
    
    // 2. 获取当前最近使用的表情包
    HMEmoticonPackage *recentPackage = self.packages[0];
    // 删除表情包中的数据
    [usedList removeObjectsInArray:recentPackage.emoticonsList];
    
    // 降序排序
    [usedList sortUsingComparator:^NSComparisonResult(HMEmoticon *obj1, HMEmoticon *obj2) {
        return obj1.times < obj2.times;
    }];

    // 3. 转换成字典数组
    NSMutableArray *dictList = [NSMutableArray array];
    
    // 1> 保存当前最近表情包中的表情
    for (HMEmoticon *emoticon in recentPackage.emoticonsList) {
        [dictList addObject:emoticon.jsonDictionary];
    }
    
    // 2> 保存剩余 times > 0 的表情
    for (HMEmoticon *emoticon in usedList) {
        [dictList addObject:emoticon.jsonDictionary];
    }
    
    // 4. 序列化
    NSData *json = [NSJSONSerialization dataWithJSONObject:dictList options:0 error:nil];
    
    // 5. 写入到缓存文件
    [json writeToFile:[self recentCachePath] atomically:YES];
}

/// 从沙盒加载最近使用表情
- (void)loadRecentEmoticons {
    
    // 1. 读取最近表情缓存文件
    NSData *json = [NSData dataWithContentsOfFile:[self recentCachePath]];
    
    // 如果不存在缓存文件，直接返回
    if (json == nil) {
        return;
    }
    
    // 2. 反序列化
    NSMutableArray *dictList = [NSJSONSerialization JSONObjectWithData:json options:0 error:NULL];
    
    // 3. 检查最近表情包数组是否创建
    HMEmoticonPackage *recentPackage = self.packages[0];
    // 清空最近表情包数组
    [recentPackage.emoticonsList removeAllObjects];
    
    // 4. 遍历数组，设置表情使用次数
    NSInteger count = 0;
    for (NSDictionary *dict in dictList) {
        
        // 遍历表情包数组
        for (NSInteger i = 1; i < self.packages.count; i++) {
            HMEmoticonPackage *package = self.packages[i];
            
            NSArray *filter = [package.emoticonsList filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"chs CONTAINS %@ OR code CONTAINS %@", dict[@"chs"], dict[@"code"]]];

            // 判断是否找到
            if (filter.count != 1) {
                continue;
            }
            
            // 设置使用次数
            HMEmoticon *em = filter[0];
            em.times = [dict[@"times"] integerValue];
            
            if (count++ < kEmoticonsCountOfPage) {
                [recentPackage.emoticonsList addObject:em];
            }
        }
    }
}

/// 返回最近使用表情缓存路径
- (NSString *)recentCachePath {
    NSString *cacheDir = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES).lastObject;
    
    return [cacheDir stringByAppendingPathComponent:kEmoticonsRecentCacheFileName];
}

#pragma mark - 表格键盘数据源方法
- (NSInteger)numberOfPagesInSection:(NSInteger)section {
    // 1. 根据 section 获取表情包
    HMEmoticonPackage *package = self.packages[section];
    
    // 2. 计算页数
    // 注意：需要将 count 转换成 NSInteger，否则会作为无符号整数计算，当 count == 0 时，结果会很大
    NSInteger pageCount = ((NSInteger)package.emoticonsList.count - 1) / kEmoticonsCountOfPage + 1;
    
    return pageCount;
}

- (NSArray *)emoticonsWithIndexPath:(NSIndexPath *)indexPath {
    // 1. 根据 indexPath 获取表情包
    HMEmoticonPackage *package = self.packages[indexPath.section];

    // 2. 根据 indexPath.item(页数)计算数组偏移位置，并返回子数组
    // 1> 起始位置
    NSInteger location = indexPath.item * kEmoticonsCountOfPage;
    NSInteger length = kEmoticonsCountOfPage;
    
    // 判断是否越界
    if ((location + length) > package.emoticonsList.count) {
        length = package.emoticonsList.count - location;
    }
    
    // 2> 创建数据范围
    NSRange range = NSMakeRange(location, length);
    
    // 3> 截取子数组
    return [package.emoticonsList subarrayWithRange:range];
}

#pragma mark - 私有方法
/// 加载表情包数据
- (void)loadPackages {
    
    // 0. 添加最近分组
    [self.packages addObject:[HMEmoticonPackage emoticonPackageWithDict:@{@"group_name_cn": @"最近"}]];
    
    // 1. 读取 emoticons.plist
    NSString *path = [self.emoticonBundle pathForResource:@"emoticons" ofType:@"plist"];
    NSDictionary *dict = [NSDictionary dictionaryWithContentsOfFile:path];
    
    // 利用 kvc 转换 id 字符串数组
    NSArray *dirs = [dict[@"packages"] valueForKey:@"id"];
    
    // 2. 遍历数组，读取每个目录中的 info.plist
    for (NSString *dir in dirs) {
        NSString *infoPath = [self.emoticonBundle pathForResource:@"info" ofType:@"plist" inDirectory:dir];
        
        // 加载表情包字典
        NSDictionary *packageDict = [NSDictionary dictionaryWithContentsOfFile:infoPath];
        
        // 字典转模型
        [self.packages addObject:[HMEmoticonPackage emoticonPackageWithDict:packageDict]];
    }
    
    // 3. 加载最近表情数组 - 注意，一定要在表情包数据初始化完成之后，再调用此方法
    [self loadRecentEmoticons];
}

#pragma mark - 懒加载属性
- (NSMutableArray *)packages {
    if (_packages == nil) {
        _packages = [NSMutableArray array];
    }
    return _packages;
}

- (NSBundle *)emoticonBundle {
    if (_emoticonBundle == nil) {
        NSString *bundlePath = [[NSBundle mainBundle] pathForResource:@"Emoticons" ofType:@"bundle"];
        
        _emoticonBundle = [NSBundle bundleWithPath:bundlePath];
    }
    return _emoticonBundle;
}

@end
