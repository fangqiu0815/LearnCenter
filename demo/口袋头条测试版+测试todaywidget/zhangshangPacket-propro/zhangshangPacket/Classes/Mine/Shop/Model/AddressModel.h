//
//  AddressModel.h
//  CrazyPacket
//
//  Created by WuYanZu on 17/3/7.
//  Copyright © 2017年 WuYanZu. All rights reserved.
//

#import <Foundation/Foundation.h>

@class AddressData,AddressList;
@interface AddressModel : NSObject

@property (nonatomic, strong) AddressData *d;

@property (nonatomic, assign) NSInteger st;

@property (nonatomic, assign) NSInteger c;

@property (nonatomic, copy) NSString *m;

@end
@interface AddressData : NSObject

@property (nonatomic, strong) NSArray<AddressList *> *reapAddress;

@end

@interface AddressList : NSObject

@property (nonatomic, copy) NSString *reapid;

@property (nonatomic, copy) NSString *name;

@property (nonatomic, copy) NSString *phone;

@property (nonatomic, copy) NSString *address;


@property(nonatomic, copy)NSString *addtime;

@property (nonatomic)BOOL isSlected;




@end

