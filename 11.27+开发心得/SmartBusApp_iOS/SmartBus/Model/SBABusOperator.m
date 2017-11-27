//
//  SBBusOperator.m
//  SmartBus
//
//  Created by 飞瞳凡想 on 14-5-6.
//  Copyright (c) 2014年 飞瞳凡想. All rights reserved.
//

#import "SBABusOperator.h"
#import "SBAJson.h"

#pragma mark -SBABus

@interface SBABusOperator ()

/** 网络通信模块 */
@property(nonatomic,strong) SBAJson *json;

@end

@implementation SBABusOperator

@synthesize delegate;

/*构造函数*/
-(SBABusOperator *) init{
        self = [super init];
        _json = [[SBAJson alloc]init];
        self.delegate = _json;
        return self;
}
/*屏蔽父类解析json方法*/
- (BOOL) analysisJsonData:(NSDictionary *)json{
    return NO;
}
/*屏蔽父类获取type类型数组方法*/
- (NSArray *) getArray:(DataType)type{
    return nil;
}
/*向服务器请求bus_id号bus信息*/
- (BOOL) requestBusData:(NSString *)busId{
    if (delegate != nil && [delegate respondsToSelector:@selector(getBusData:)])
        return [super analysisJsonData:[delegate getBusData:busId]];
    return NO;
}
/*向服务器请求line_id线路,stop_id站台最近的bus信息*/
- (BOOL) requestTrackBusNearStop:(NSString *)stopId inLine:(NSString *)lineId{
    if (delegate != nil && [delegate respondsToSelector:@selector(getTrackBusNearStop:inLine:)])
        return [super analysisJsonData:[delegate getTrackBusNearStop:stopId inLine:lineId]];
    return NO;
}
/*向服务器请求stop_id站在最近的buses信息*/
- (BOOL) requestTrackBusesNearStop:(NSString *)stopId{
    if (delegate != nil && [delegate respondsToSelector:@selector(getTrackBusesNearStop:)])
        return [super analysisJsonData:[delegate getTrackBusesNearStop:stopId]];
    return NO;
}
/*获取bus数组*/
- (NSArray *) getBuses{
    return [super getArray:SBABusType];
}
/*获取busId相应的bus对象*/
- (SBABus *) getBusById:(NSString *)busId{
    NSArray *buses = [self getBuses];
    if (buses == nil) {
        return nil;
    }
    for (SBABus *bus in buses) {
        if ([bus.busId isEqualToString:busId]) {
            return bus;
        }
    }
    return nil;
}
@end
