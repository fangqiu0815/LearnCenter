//
//  HMEmoticonManager.h
//  Weibo11
//
//  Created by 刘凡 on 15/12/15.
//  Copyright © 2015年 itheima. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HMEmoticonPackage.h"
#import "HMEmoticon.h"

/// 表情工具类 - 类似于视图模型，提供表情视图的所有数据
@interface HMEmoticonManager : NSObject

/// 表情管理器单例
+ (instancetype)sharedManager;

/// 表情包数组
@property (nonatomic, strong) NSMutableArray *packages;

/// 添加最近使用表情
- (void)addRecentEmoticon:(HMEmoticon *)emoticon;

#pragma mark - 表格键盘数据源方法
/// 返回 section 对应的表情包中包含表情页数
///
/// @param section 表情分组下标
///
/// @return 对应页数
- (NSInteger)numberOfPagesInSection:(NSInteger)section;

/// 根据 indexPath 返回对应分页的表情模型数组，每页 20 个
- (NSArray *)emoticonsWithIndexPath:(NSIndexPath *)indexPath;

@end
