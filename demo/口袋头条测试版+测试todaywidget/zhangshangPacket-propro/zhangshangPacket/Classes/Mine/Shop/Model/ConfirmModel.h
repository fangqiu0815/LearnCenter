//
//  ConfirmModel.h
//  CrazyPacket
//
//  Created by WuYanZu on 17/3/9.
//  Copyright © 2017年 WuYanZu. All rights reserved.
//

#import <Foundation/Foundation.h>

@class GoodSexch;
@interface ConfirmModel : NSObject

@property (nonatomic, strong) GoodSexch *d;

@property (nonatomic, assign) NSInteger st;

@property (nonatomic, assign) NSInteger c;

@property (nonatomic, copy) NSString *m;

@end
//@interface ConfirmOrderData : NSObject
//
//@property (nonatomic, strong) GoodSexch *goodsexch;
//
//@end

@interface GoodSexch : NSObject

@property (nonatomic, copy) NSString *cash;

//@property (nonatomic, assign) NSInteger cgnum;
//
//@property (nonatomic, copy) NSString *gnum;
//
//@property (nonatomic, assign) NSInteger cscore;
//
//@property (nonatomic, assign) CGFloat score;

@end

