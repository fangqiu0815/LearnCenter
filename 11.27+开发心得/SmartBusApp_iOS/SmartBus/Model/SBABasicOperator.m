//
//  SBBasicOperator.m
//  SmartBus
//
//  Created by 飞瞳凡想 on 14-5-6.
//  Copyright (c) 2014年 飞瞳凡想. All rights reserved.
//

#import "SBABasicOperator.h"
#import "SBAJson.h"

#pragma mark -SBLineGather
/** 线路信息集合 */
@interface SBLineGather : NSObject
/** 线路id */
@property(nonatomic,strong) NSString *lineId;
/** 线路位置 */
@property(nonatomic,strong) NSArray *road;
/** 站台位置 */
@property(nonatomic,strong) NSArray *stops;

@end

@implementation SBLineGather

@synthesize lineId;
@synthesize road;
@synthesize stops;

@end

#pragma mark -SBABasicOperator
@interface SBABasicOperator ()
/** 线路集合数组 */
@property(nonatomic,strong) NSArray *lines;
/** 网络通信模块 */
@property(nonatomic,strong) SBAJson *json;
@end

@implementation SBABasicOperator

@synthesize delegate;

- (SBABasicOperator *) init{
    self = [super init];
    _json = [[SBAJson alloc]init];
    self.delegate = _json;
    return self;
}

- (BOOL) analysisJsonData:(NSDictionary *)json{
    return NO;
}

- (NSArray *) getArray:(DataType)type{
    return nil;
}

- (BOOL) requestUpdate:(NSString *)version{
    return [super analysisJsonData:[delegate update:version]];
}

-(NSArray *) getPositions{
    return [super getArray:SBAPositionType];
}
-(NSArray *) getLines{
    return [super getArray:SBALineType];
}
-(NSArray *) getStops{
    return [super getArray:SBAStopType];
}
@end
