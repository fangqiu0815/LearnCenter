//
//  MovieModal.m
//  HWMovie
//
//  Created by hyrMac on 15/7/20.
//  Copyright (c) 2015年 hyrMac. All rights reserved.
//

#import "MovieModal.h"

@implementation MovieModal
- (NSString *)description {
    return [NSString stringWithFormat:@"title:%@,year:%@",_title,_year];
}
@end
