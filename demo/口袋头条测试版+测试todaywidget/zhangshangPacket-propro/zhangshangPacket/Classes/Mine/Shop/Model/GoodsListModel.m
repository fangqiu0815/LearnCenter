
//
//  GoodsListModel.m
//  CrazyPacket
//
//  Created by WuYanZu on 17/3/8.
//  Copyright © 2017年 WuYanZu. All rights reserved.
//

#import "GoodsListModel.h"

@implementation GoodsListModel

@end
@implementation GoodsListData

+ (NSDictionary *)objectClassInArray{
    return @{@"goods" : [ItemDetail class]};
}

@end


//@implementation GoodsItem
//
//+ (NSDictionary *)objectClassInArray{
//    return @{@"gs" : [ItemDetail class]};
//}
//
//@end


@implementation ItemDetail

@end


