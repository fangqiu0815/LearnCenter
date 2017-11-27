//
//  HMUser.h
//  Weibo11
//
//  Created by 刘凡 on 15/12/9.
//  Copyright © 2015年 itheima. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HMUser : NSObject
/// 用户UID
@property (nonatomic, assign) UInt64 id;
/// 用户昵称
@property (nonatomic, copy) NSString *screen_name;
/// 用户头像地址（中图），50×50像素
@property (nonatomic, copy) NSString *profile_image_url;
/// 认证类型
@property (nonatomic, assign) NSInteger verified_type;
/// 会员等级
@property (nonatomic, assign) NSInteger mbrank;

+ (instancetype)userWithDict:(NSDictionary *)dict;

@end
