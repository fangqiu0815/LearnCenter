//
//  SBJson.h
//  SmartBus
//
//  Created by 飞瞳凡想 on 14-5-6.
//  Copyright (c) 2014年 飞瞳凡想. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SBABusOperator.h"
#import "SBABasicOperator.h"

@interface SBAJson : NSObject <SBABusOperatorDelegate,SBABasicOperatorDelegate>
/**
 * 根据bus_id搜索bus信息
 * @param bus_id
 * @return dictionary
 */
-(NSDictionary *) getBusData:(NSString *)busId;
/**
 * 搜索line_id线路,stop_id站台最近的bus信息
 * @param stop_id
 * @param line_id
 * @return dictionary
 */
-(NSDictionary *) getTrackBusNearStop:(NSString *)stopId inLine:(NSString *)lineId;
/**
 * 搜索stop_id站在最近的buses信息
 * @param stop_id
 * @return dictionary
 */
-(NSDictionary *) getTrackBusesNearStop:(NSString *)stopId;
/**
 * 获取更新
 * @param version
 * @return dictionary
 */
-(NSDictionary *) update:(NSString *)version;

@end
