//
//  cinemaModal.h
//  HWMovie
//
//  Created by hyrMac on 15/7/22.
//  Copyright (c) 2015年 hyrMac. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface cinemaModal : NSObject
// 影城名字
@property (nonatomic, copy) NSString *name;
// 评分
@property (nonatomic, copy) NSString *grade;
// 地址
@property (nonatomic, copy) NSString *address;
// 票价
@property (nonatomic, copy) NSString *lowPrice;
// 座票
@property (nonatomic, copy) NSString *isSeatSupport;
// 优惠券
@property (nonatomic, copy) NSString *isCouponSupport;

@property (nonatomic, copy) NSString *districtId;
@end
