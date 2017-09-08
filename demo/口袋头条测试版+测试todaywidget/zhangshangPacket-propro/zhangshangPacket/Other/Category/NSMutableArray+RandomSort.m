//
//  NSMutableArray+RandomSort.m
//  zhangshangPacket
//
//  Created by apple on 2017/5/25.
//  Copyright © 2017年 apple-fangqiu. All rights reserved.
//

#import "NSMutableArray+RandomSort.h"

@implementation NSMutableArray (RandomSort)

- (void)randomObjects
{
    [self sortUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
        int32_t randomResult = (int32_t)arc4random() % 3 - 1; // arc4random() 返回值为 u_int32_t，不能为负数，先转为 int32_t
        return randomResult;
    }];
}

- (void)arrayWithEven:(NSMutableArray *)array
{
    NSMutableArray *arrayTwo = [NSMutableArray array];
    for (int i = 0; i<array.count; i++) {
        if (i%2 == 0) {
            [arrayTwo addObject:array[i]];
        }
    }
    for (NSObject *j in arrayTwo) {
        [array removeObject:j];
    }
    

}


@end
