//
//  UserInfo.h
//  XDCommonApp
//
//  Created by XD-XY on 2/13/14.
//  Copyright (c) 2014 XD-XY. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "XDHeader.h"
@interface UserInfo : NSObject
DEFINE_SINGLETON_FOR_HEADER(UserInfo);
@property (nonatomic,assign)BOOL isLogin;
- (void)value:(NSString*)value key:(NSString*)key;

@end
