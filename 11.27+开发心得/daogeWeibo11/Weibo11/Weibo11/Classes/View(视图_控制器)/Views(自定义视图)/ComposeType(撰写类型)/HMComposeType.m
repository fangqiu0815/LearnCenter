//
//  HMComposeType.m
//  Weibo11
//
//  Created by 刘凡 on 15/12/14.
//  Copyright © 2015年 itheima. All rights reserved.
//

#import "HMComposeType.h"

@implementation HMComposeType

+ (instancetype)composeTypeWithDict:(NSDictionary *)dict {
    id obj = [[self alloc] init];
    
    [obj setValuesForKeysWithDictionary:dict];
    
    return obj;
}

+ (NSArray *)composeTypeList {
    NSArray *array = @[@{@"icon": @"tabbar_compose_idea", @"title": @"文字", @"controllerName": @"HMComposeViewController"},
                       @{@"icon": @"tabbar_compose_photo", @"title": @"照片/视频"},
                       @{@"icon": @"tabbar_compose_weibo", @"title": @"长微博"},
                       @{@"icon": @"tabbar_compose_lbs", @"title": @"签到"},
                       @{@"icon": @"tabbar_compose_review", @"title": @"点评"},
                       @{@"icon": @"tabbar_compose_more", @"title": @"更多", @"actionName": @"clickMoreButton"},
                       @{@"icon": @"tabbar_compose_friend", @"title": @"好友圈"},
                       @{@"icon": @"tabbar_compose_wbcamera", @"title": @"微博相机"},
                       @{@"icon": @"tabbar_compose_music", @"title": @"音乐"},
                       @{@"icon": @"tabbar_compose_shooting", @"title": @"拍摄"}];
    
    NSMutableArray *arrayM = [NSMutableArray array];
    
    for (NSDictionary *dict in array) {
        [arrayM addObject:[HMComposeType composeTypeWithDict:dict]];
    }
    
    return arrayM.copy;
}

@end
