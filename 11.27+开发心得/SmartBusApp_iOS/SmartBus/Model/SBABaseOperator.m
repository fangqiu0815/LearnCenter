//
//  SBBase.m
//  SmartBus
//
//  Created by 飞瞳凡想 on 14-5-6.
//  Copyright (c) 2014年 飞瞳凡想. All rights reserved.
//

#import "SBABaseOperator.h"
#import "NSDictionary+EntityHelper.h"
#pragma mark -SBABaseInfo


@interface SBABaseOperator ()
/**
 * 数据
 */
@property (nonatomic,strong) SBAData *data;

@end

@implementation SBABaseOperator

-(SBABaseOperator *) init{
    self = [super init];
    if (self != nil) {
        _data = [[SBAData alloc]init];
    }
    return self;
}
/*解析json数据*/
-(BOOL) analysisJsonData:(NSDictionary *)json{
    if (json == nil) {
        return NO;
    }
    _data = [[SBAData alloc]initWithDicationary:json];
    if ([_data.flag isEqualToString:@"SUCCESS"]) {
        return YES;
    }else{
        return NO;
    }
}

/*获取对应类型数据数组*/
-(NSArray *) getArray:(DataType)type{
    switch (type) {
        case SBABusType:
            return _data.bus;
        case SBALineType:
            return _data.line;
        case SBAPositionType:
            return _data.position;
        case SBAStopType:
            return _data.stop;
        default:
            return nil;
    }
        
}
@end
