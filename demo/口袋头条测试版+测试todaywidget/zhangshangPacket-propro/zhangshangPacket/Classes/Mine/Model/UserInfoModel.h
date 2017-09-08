//
//  UserInfoModel.h
//  zhangshangPacket
//
//  Created by apple on 2017/5/20.
//  Copyright © 2017年 apple-fangqiu. All rights reserved.
//

#import <Foundation/Foundation.h>


@class UserData,UserDataList;

@interface UserInfoModel : NSObject


@property (nonatomic, strong) UserData *d;

@property (nonatomic, assign) NSInteger st;

@property (nonatomic, assign) NSInteger c;

@property (nonatomic, copy) NSString *m;



@end

@interface UserData : NSObject

@property (nonatomic, strong) UserDataList *user;


@end

@interface UserDataList : NSObject



@property (nonatomic, copy) NSString *uid;

@property (nonatomic, copy) NSString *phonenum;

@property (nonatomic, copy) NSString *token;

@property (nonatomic, assign) NSInteger cash;

@property (nonatomic, assign) NSInteger cashyes;

@property (nonatomic, assign) NSInteger cashtoday;

@property (nonatomic, assign) NSInteger cashconver;

@property (nonatomic, assign) NSInteger ingot;

@property (nonatomic, assign) BOOL isshare;

@property (nonatomic, assign) NSInteger tasknum;

@property (nonatomic, assign) BOOL isreward;

@property (nonatomic, assign) NSInteger disciple;

@property (nonatomic, assign) NSInteger disciplefee;

@property (nonatomic, assign) BOOL issign;




@end
