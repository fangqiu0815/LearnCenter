//
//  HMEmoticonPackage.h
//  Weibo11
//
//  Created by 刘凡 on 15/12/15.
//  Copyright © 2015年 itheima. All rights reserved.
//

#import <Foundation/Foundation.h>

/// 表情包模型
@interface HMEmoticonPackage : NSObject
/// 表情包分组名
@property (nonatomic, copy) NSString *groupName;
/// 表情包中的表情模型数组
@property (nonatomic, strong) NSMutableArray *emoticonsList;

+ (instancetype)emoticonPackageWithDict:(NSDictionary *)dict;
- (instancetype)initWithDict:(NSDictionary *)dict;

@end
