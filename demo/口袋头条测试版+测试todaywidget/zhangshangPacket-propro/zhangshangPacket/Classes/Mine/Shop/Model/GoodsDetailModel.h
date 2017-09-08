//
//  GoodsDetailModel.h
//  CrazyPacket
//
//  Created by WuYanZu on 17/3/8.
//  Copyright © 2017年 WuYanZu. All rights reserved.
//

#import <Foundation/Foundation.h>

@class GoodsDetain;
@interface GoodsDetailModel : NSObject

@property (nonatomic, strong) GoodsDetain *d;

@property (nonatomic, assign) NSInteger st;

@property (nonatomic, assign) NSInteger c;

@property (nonatomic, copy) NSString *m;

@end
//@interface GoodsDetailData : NSObject
//
//@property (nonatomic, strong) GoodsDetain *detain;
//
//@end

@interface GoodsDetain : NSObject

@property (nonatomic, copy) NSString *goodsid;

@property (nonatomic, copy) NSString *desc_;

@property (nonatomic, copy) NSString *num;

@end

