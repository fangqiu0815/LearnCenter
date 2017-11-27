//
//  NSDictionary+EntityHelper.h
//  SmartBus
//
//  Created by 飞瞳凡想 on 14-5-9.
//  Copyright (c) 2014年 飞瞳凡想. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDictionary (EntityHelper)
/**
 * 字典转换为实体对象
 * 若如果实体属性为NSArray,属性名应该设置为首字母小写的除去前缀的类名
 * 如 NSArray<SBABus> bus;
 * 实体对可象通过实现 specialConvert 方法来实现对某些属性的特殊转换方法转换方法
 * 如 将 @“1,2,3” 转换为数组
 * @param class
 * @param entity
 */
- (id) dictionaryToEntity:(Class)clazz;

@end
