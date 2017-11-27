//
//  SBBaseInfo.m
//  SmartBus
//
//  Created by 飞瞳凡想 on 14-5-6.
//  Copyright (c) 2014年 飞瞳凡想. All rights reserved.
//

#import "SBABaseData.h"
#import "NSDictionary+EntityHelper.h"

@implementation SBAData
@synthesize flag;
@synthesize bus;
@synthesize line;
@synthesize stop;
@synthesize position;
@synthesize error;
@synthesize version;

-(SBAData *) initWithDicationary:(NSDictionary *)dict{
    self = [dict dictionaryToEntity:[self class]];
    return self;
}
@end

#pragma mark -SBPosition

@implementation SBAPosition

@synthesize positionId;
@synthesize x;
@synthesize y;

@end

#pragma mark -SBABus
@implementation SBABus

@synthesize busId;
@synthesize speed;
@synthesize numberOfPeople;
@synthesize positionId;

@end

#pragma mark -SBAStop
@implementation SBAStop

@synthesize stopId;
@synthesize stopName;
@synthesize positionId;

@end

#pragma mark -SBALine
@implementation SBALine

@synthesize lineId;
@synthesize stops;
@synthesize positions;

-(void) specialConvert{
    if (self.stops && self.positions) {
        self.stops = [(NSString *)stops componentsSeparatedByString:@","];
        self.positions = [(NSString *)positions componentsSeparatedByString:@","];
    }
}
@end
