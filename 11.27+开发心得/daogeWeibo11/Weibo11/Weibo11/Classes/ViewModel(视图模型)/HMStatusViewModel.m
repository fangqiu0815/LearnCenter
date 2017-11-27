//
//  HMStatusViewModel.m
//  Weibo11
//
//  Created by 刘凡 on 15/12/9.
//  Copyright © 2015年 itheima. All rights reserved.
//

#import "HMStatusViewModel.h"

@implementation HMStatusViewModel

+ (instancetype)viewModelWithStatus:(HMStatus *)status {
    HMStatusViewModel *obj = [[self alloc] init];
    
    obj.status = status;
    
    return obj;
}

- (NSString *)description {
    return self.status.description;
}

#pragma mark - 用户相关计算型属性
- (NSURL *)userAvatarURL {
    return [NSURL URLWithString:self.status.user.profile_image_url];
}

- (UIImage *)memberImage {
    if (self.status.user.mbrank > 0 && self.status.user.mbrank < 7) {
        NSString *imageName = [NSString stringWithFormat:@"common_icon_membership_level%zd", self.status.user.mbrank];
        
        return [UIImage imageNamed:imageName];
    }
    return nil;
}

- (UIImage *)verifiedImage {

    switch (self.status.user.verified_type) {
        case 0:
            return [UIImage imageNamed:@"avatar_vip"];
        case 2:
        case 3:
        case 5:
            return [UIImage imageNamed:@"avatar_enterprise_vip"];
        case 220:
            return [UIImage imageNamed:@"avatar_grassroot"];
        default:
            return nil;
    }
}

#pragma mark - 转发/评论/点赞计数字符串
- (NSString *)repostsCountStr {
    NSString *result = [self countString:self.status.reposts_count];
    
    return result == nil ? @" 转发" : result;
}

- (NSString *)commentsCountStr {
    NSString *result = [self countString:self.status.comments_count];
    
    return result == nil ? @" 评论" : result;
}

- (NSString *)attitudesCountStr {
    NSString *result = [self countString:self.status.attitudes_count];
    
    return result == nil ? @" 赞" : result;
}

- (NSString *)countString:(NSInteger)count {

    if (count <= 0) {
        return nil;
    } else if (count < 10000) {
        return [NSString stringWithFormat:@" %zd", count];
    } else {
        float num = (float)(count / 1000) / 10;
        
        if ((count / 1000) % 10 == 0) {
            return [NSString stringWithFormat:@" %.0f 万", num];
        } else {
            return [NSString stringWithFormat:@" %.1f 万", num];
        }
    }
}

#pragma mark - 转发微博相关
- (BOOL)hasRetweeted {
    return self.status.retweeted_status != nil;
}

- (NSString *)retweetedText {
    
    if (![self hasRetweeted]) {
        return nil;
    }
    
    return [NSString stringWithFormat:@"@%@:%@", self.status.retweeted_status.user.screen_name, self.status.retweeted_status.text];
}

@end
