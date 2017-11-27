//
//  chooseCityModel.h
//  XDCommonApp
//
//  Created by XD-XY on 8/29/14.
//  Copyright (c) 2014 XD-XY. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface chooseCityModel : NSObject

@property(nonatomic,strong)NSString * cityName;
@property(nonatomic,strong)NSString * cityId;
@property(nonatomic,strong)NSString * defaultStatus;

-(id)initWithDic:(NSDictionary *)dic;
@end
