//
//  LoginModel.h
//  zhangshangPacket
//
//  Created by apple on 2017/5/20.
//  Copyright © 2017年 apple-fangqiu. All rights reserved.
//

#import <Foundation/Foundation.h>

@class LoginData;

@interface LoginModel : NSObject

@property (nonatomic, strong) LoginData *d;

@property (nonatomic, assign) NSInteger st;

@property (nonatomic, assign) NSInteger c;

@property (nonatomic, copy) NSString *m;



@end



@interface LoginData : NSObject

@property (nonatomic, copy) NSString *uid;

@property (nonatomic, copy) NSString *phonenum;

@property (nonatomic, copy) NSString *token;

@property (nonatomic, copy) NSString *cash;

@property (nonatomic, copy) NSString *cashyes;

@property (nonatomic, copy) NSString *cashtoday;

@property (nonatomic, copy) NSString *cashtotal;

@property (nonatomic, copy) NSString *cashconver;

@property (nonatomic, assign) NSInteger ingot;

@property (nonatomic, assign) BOOL isshare;

@property (nonatomic, assign) NSInteger tasknum;

@property (nonatomic, assign) BOOL isreward;

@property (nonatomic, assign) BOOL issign;

@property (nonatomic, assign) NSInteger disciple;

@property (nonatomic, assign) NSInteger disciplefee;

@property (nonatomic, copy) NSString *img;

@property (nonatomic, assign) NSInteger channel;

@property (nonatomic, copy) NSString *name;

@property (nonatomic, assign) NSInteger signstate;

@property (nonatomic, assign) NSInteger logtime;


@end





