//
//  TopheadModal.m
//  HWMovie
//
//  Created by hyrMac on 15/7/27.
//  Copyright (c) 2015年 hyrMac. All rights reserved.
//

#import "TopheadModal.h"

@implementation TopheadModal

- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
    if ([key isEqualToString:@"release"]) {
        self.releaseInfo = value;
    }
}
@end
