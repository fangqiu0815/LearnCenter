//
//  NSArray+RandomSort.h
//  zhangshangPacket
//
//  Created by apple on 2017/5/25.
//  Copyright © 2017年 apple-fangqiu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSArray (RandomSort)

- (NSArray *)randomObjects;


- (NSArray *)splitArray: (NSArray *)array withSubSize : (int)subSize;

/**
 按照索引安全返回数组元素
 
 @param index 索引index
 @return self
 */
- (instancetype)hs_objectWithIndex:(NSUInteger)index;

@end
