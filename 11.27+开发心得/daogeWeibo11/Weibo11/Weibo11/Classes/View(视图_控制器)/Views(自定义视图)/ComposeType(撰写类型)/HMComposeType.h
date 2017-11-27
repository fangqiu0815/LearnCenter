//
//  HMComposeType.h
//  Weibo11
//
//  Created by 刘凡 on 15/12/14.
//  Copyright © 2015年 itheima. All rights reserved.
//

#import <Foundation/Foundation.h>

/// 撰写微博类型模型
@interface HMComposeType : NSObject
/// 标题
@property (nonatomic, copy) NSString *title;
/// 图片
@property (nonatomic, copy) NSString *icon;
/// 操作名
@property (nonatomic, copy) NSString *actionName;
/// 控制器名称
@property (nonatomic, copy) NSString *controllerName;

+ (instancetype)composeTypeWithDict:(NSDictionary *)dict;

/// 返回撰写类型列表
+ (NSArray *)composeTypeList;

@end
