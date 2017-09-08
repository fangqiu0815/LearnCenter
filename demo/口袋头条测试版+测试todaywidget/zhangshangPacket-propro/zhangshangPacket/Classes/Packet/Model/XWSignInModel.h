//
//  XWSignInModel.h
//  zhangshangPacket
//
//  Created by apple on 2017/6/3.
//  Copyright © 2017年 apple-fangqiu. All rights reserved.
//

#import <Foundation/Foundation.h>
@class SignInList,SignInData;
@interface XWSignInModel : NSObject

@property (nonatomic, strong) SignInList *d;

@property (nonatomic, assign) NSInteger st;

@property (nonatomic, assign) NSInteger c;

@property (nonatomic, copy) NSString *m;

@end

@interface SignInList : NSObject

@property (nonatomic, strong) NSArray<SignInList *> *sign;

@end

@interface SignInData : NSObject

@property (nonatomic, assign) NSInteger signstate;

@property (nonatomic, assign) NSInteger serialsign;


@end
