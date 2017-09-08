//
//  AddressModel.m
//  CrazyPacket
//
//  Created by WuYanZu on 17/3/7.
//  Copyright © 2017年 WuYanZu. All rights reserved.
//

#import "AddressModel.h"

@implementation AddressModel

@end
@implementation AddressData

+ (NSDictionary *)objectClassInArray{
    return @{@"reapAddress" : [AddressList class]};
}

@end


@implementation AddressList

@end


