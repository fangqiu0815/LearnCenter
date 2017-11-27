//
//  chooseCityModel.m
//  XDCommonApp
//
//  Created by XD-XY on 8/29/14.
//  Copyright (c) 2014 XD-XY. All rights reserved.
//

#import "chooseCityModel.h"

@implementation chooseCityModel
-(id)initWithDic:(NSDictionary *)dic{
    self = [super init];
    
    if (self) {
        self.cityName = [dic objectForKey:@"name"];
        self.cityId = [dic objectForKey:@"id"];
    }
    
    [self judgeIsNull:self.cityId];
    [self judgeIsNull:self.cityName];

    
    return self;
}

-(void)judgeIsNull:(NSString *)string{
    if ([string isKindOfClass:[NSNull class]]) {
        string = @"";
    }
}
@end
