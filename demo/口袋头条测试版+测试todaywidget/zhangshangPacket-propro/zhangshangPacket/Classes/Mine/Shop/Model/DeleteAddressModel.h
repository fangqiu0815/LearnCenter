//
//  DeleteAddressModel.h
//  CrazyPacket
//
//  Created by WuYanZu on 17/3/7.
//  Copyright © 2017年 WuYanZu. All rights reserved.
//

#import <Foundation/Foundation.h>

@class DeletaData;
@interface DeleteAddressModel : NSObject

@property (nonatomic, strong) DeletaData *d;

@property (nonatomic, assign) NSInteger st;

@property (nonatomic, assign) NSInteger c;

@property (nonatomic, copy) NSString *m;

@end
@interface DeletaData : NSObject

@property (nonatomic, assign) NSInteger del;

@end

