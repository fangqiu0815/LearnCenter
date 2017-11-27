//
//  NSDictionary+EntityHelper.m
//  SmartBus
//
//  Created by 飞瞳凡想 on 14-5-9.
//  Copyright (c) 2014年 飞瞳凡想. All rights reserved.
//

#import "NSDictionary+EntityHelper.h"
#import <objc/runtime.h>

@implementation NSDictionary (EntityHelper)


- (id) dictionaryToEntity:(Class)clazz
{
    
    NSObject *entity = [[clazz alloc]init];
    unsigned int outCount;
    /* 获取属性列表 */
    objc_property_t *properties = class_copyPropertyList(clazz, &outCount);
    for (int i = 0; i < outCount; i ++) {
        objc_property_t property = properties [i];
        const char *name = property_getName(property);
        /* 获取属性名 */
        NSString *propertyName = [NSString stringWithUTF8String:name];
        /* 属性set方法 */
        NSString *setMethodName = [NSString stringWithFormat:@"set%@:",[self _upperFirstChar:propertyName]];
        /* 获取属性值 */
        NSObject *propertyValue = [self objectForKey:propertyName];
        /* 实体属性为数组类型 */
        if (propertyValue != nil && [propertyValue isKindOfClass:[NSArray class]]) {
            [entity performSelector:NSSelectorFromString(setMethodName) withObject:[self _convertArray:(NSArray *)propertyValue toEntity:propertyName]];
        }else if (propertyValue != nil && [entity respondsToSelector:NSSelectorFromString(setMethodName)]) {
            [entity performSelector:NSSelectorFromString(setMethodName) withObject:propertyValue];
        }
    }
    /* 如果实体实现了特殊转换方法 */
    if ([entity respondsToSelector:NSSelectorFromString(@"specialConvert")]) {
        [entity performSelector:NSSelectorFromString(@"specialConvert") withObject:nil];
    }
    return entity;
}
/**
 * 首字母大写
 * @param str
 * @param NString
 */
-(NSString *) _upperFirstChar:(NSString *)str{
    NSMutableString *mstr = [NSMutableString stringWithString:str];
    NSString *firstChar = [mstr substringWithRange:NSMakeRange(0, 1)];
    firstChar = [firstChar uppercaseString];
    [mstr replaceCharactersInRange:NSMakeRange(0, 1) withString:firstChar];
    return mstr;
}
/**
 * 更具子属性类型转换数组
 * @param Class
 * @return NSArray
 */
-(NSArray *) _convertArray:(NSArray *)array toEntity:(NSString *) propertyName{
    
    NSMutableArray *mArray = [[NSMutableArray alloc]init];
    /* 数组不为空 */
    if (array != nil && [array count] != 0) {
        /* 获取子属性类型 */
        NSString *className = [NSString stringWithFormat:@"SBA%@",[self _upperFirstChar:propertyName]];
        Class someClass = NSClassFromString(className);
         /* 子属性类不为空 */
        if (someClass != nil) {
            for (NSDictionary *dict in array){
                [mArray addObject:[dict dictionaryToEntity:someClass]];
            }
        }
    }
    return mArray;
}
@end
