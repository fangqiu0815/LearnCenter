//
//  UserInfo.m
//  XDCommonApp
//
//  Created by XD-XY on 2/13/14.
//  Copyright (c) 2014 XD-XY. All rights reserved.
//

#import "UserInfo.h"

@implementation UserInfo
DEFINE_SINGLETON_FOR_CLASS(UserInfo)

-(void)value:(NSString *)value key:(NSString *)key
{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setObject:value forKey:key];
    [userDefaults synchronize];
}

@end
