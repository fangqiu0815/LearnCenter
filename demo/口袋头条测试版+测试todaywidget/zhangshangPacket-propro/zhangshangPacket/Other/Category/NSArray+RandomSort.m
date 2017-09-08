//
//  NSArray+RandomSort.m
//  zhangshangPacket
//
//  Created by apple on 2017/5/25.
//  Copyright © 2017年 apple-fangqiu. All rights reserved.
//

#import "NSArray+RandomSort.h"

@implementation NSArray (RandomSort)

- (NSArray *)randomObjects
{
    return [self sortedArrayUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
        int32_t randomResult = (int32_t)arc4random() % 3 - 1; // arc4random() 返回值为 u_int32_t，不能为负数，先转为 int32_t
        return randomResult;
    }];
}

#pragma mark -- 将数组拆分成固定长度

/**
 *  将数组拆分成固定长度的子数组
 *
 *  @param array 需要拆分的数组
 *
 *  @param subSize 指定长度
 *
 */
- (NSArray *)splitArray: (NSArray *)array withSubSize : (int)subSize{
    //  数组将被拆分成指定长度数组的个数
    unsigned long count = array.count % subSize == 0 ? (array.count / subSize) : (array.count / subSize + 1);
    //  用来保存指定长度数组的可变数组对象
    NSMutableArray *arr = [[NSMutableArray alloc] init];
    
    //利用总个数进行循环，将指定长度的元素加入数组
    for (int i = 0; i < count; i ++) {
        //数组下标
        int index = i * subSize;
        //保存拆分的固定长度的数组元素的可变数组
        NSMutableArray *arr1 = [[NSMutableArray alloc] init];
        //移除子数组的所有元素
        [arr1 removeAllObjects];
        
        int j = index;
        //将数组下标乘以1、2、3，得到拆分时数组的最大下标值，但最大不能超过数组的总大小
        while (j < subSize*(i + 1) && j < array.count) {
            [arr1 addObject:[array objectAtIndex:j]];
            j += 1;
        }
        //将子数组添加到保存子数组的数组中
        [arr addObject:[arr1 copy]];  
    }  
    
    return [arr copy];  
}

- (instancetype)hs_objectWithIndex:(NSUInteger)index
{
    if (index < self.count) {
        return self[index];
    }else{
        return nil;
    }
}

@end
