//
//  SBBusOperator.h
//  SmartBus
//
//  Created by 飞瞳凡想 on 14-5-6.
//  Copyright (c) 2014年 飞瞳凡想. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SBABaseOperator.h"

#pragma mark -SBABusOperator Delegate
/**
 * delegate，提供与服务器通信方法
 */
@protocol SBABusOperatorDelegate <NSObject>
@required
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
@end

#pragma mark -SBABusOperator API
/**
 * 公交信息操作类
 */
@interface SBABusOperator : SBABaseOperator
/**
 * delegate对象，提供与服务器通信方法
 */
@property (nonatomic,assign) id<SBABusOperatorDelegate> delegate;
/**
 * 构造函数
 * @return SBBusOperator
 */
- (SBABusOperator *)init;
/**
 * 屏蔽父类方法,无意义
 * 不推荐使用
 * @param dictionary
 * @return NO
 */
- (BOOL) analysisJsonData:(NSDictionary *)json;
/**
 * 屏蔽父类方法,无意义
 * 不推荐使用
 * @param type
 * @return nil
 */
- (NSArray *) getArray:(DataType)type;
/**
 * 向服务器请求bus_id号bus信息,成功后数据通过getBus和getBuses方法获取
 * @param bus_id
 * @return YES ? success : fail
 */
-(BOOL) requestBusData:(NSString *)busId;
/**
 * 向服务器请求line_id线路,stop_id站台最近的bus信息，成功后数据通过getBus和getBuses方法获取
 * @param stop_id
 * @param line_id
 * @return YES ? success : fail
 */
-(BOOL) requestTrackBusNearStop:(NSString *)stopId inLine:(NSString *)lineId;
/**
 * 向服务器请求stop_id站在最近的buses信息，成功后数据通过getBus和getBuses方法获取
 * @param stop_id
 * @return YES ? success : fail
 */
-(BOOL) requestTrackBusesNearStop:(NSString *)stopId;
/**
 * 获取bus数组
 * 先通过request*方法从服务器获取数据，未获取数据或获取数据失败返回nil
 * @return array
 */
-(NSArray *) getBuses;
/**
 * 获取busId相应的bus对象
 * 先通过request*方法从服务器获取数据，未获取数据或获取数据失败返回nil
 * @param busId
 * @return bus
 */
-(SBABus *) getBusById:(NSString *) busId;
@end
