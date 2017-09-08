//
//  AddAddressModel.h
//  CrazyPacket
//
//  Created by WuYanZu on 17/3/7.
//  Copyright © 2017年 WuYanZu. All rights reserved.
//

#import <Foundation/Foundation.h>

@class AddData,Addinfo;
@interface AddAddressModel : NSObject

@property (nonatomic, strong) AddData *d;

@property (nonatomic, assign) NSInteger st;

@property (nonatomic, assign) NSInteger c;

@property (nonatomic, copy) NSString *m;

@end
@interface AddData : NSObject

@property (nonatomic, strong) Addinfo *addressinfo;

@end

@interface Addinfo : NSObject

@property (nonatomic, copy) NSString *mobilephone;

@property (nonatomic, copy) NSString *name;

@property (nonatomic, copy) NSString *detainaddress;

@property (nonatomic, copy) NSString *addressid;

@end

