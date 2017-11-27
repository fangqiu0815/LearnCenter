//
//  SBBasicOperator.h
//  SmartBus
//
//  Created by 飞瞳凡想 on 14-5-6.
//  Copyright (c) 2014年 飞瞳凡想. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SBABaseOperator.h"
#pragma  mark -SBABasicOperator Delegate
/**
 * delegate，提供与服务器通信方法
 */
@protocol SBABasicOperatorDelegate <NSObject>
@required
/**
 * 获取更新
 * @param version
 * @return dictionary
 */
-(NSDictionary *) update:(NSString *)version;
@end
/**
 * 基础信息操作类(line,stop,road,position)
 */
#pragma mark SBBasicOperator API
/**
 * 基础信息操作类
 * 基础信息包括（line,stop,road,position）
 */
@interface SBABasicOperator : SBABaseOperator
/**
 * delegate对象，提供与服务器通信方法
 */
@property (nonatomic,assign) id<SBABasicOperatorDelegate> delegate;

/**
 * 获取更新
 * @param version
 * @return YES ? have update : no update;
 */
-(BOOL) requestUpdate:(NSString *)version;
/**
 * 获取SBPosition数组
 * @return NSArray
 */
-(NSArray *) getPositions;
/**
 * 获取SBLine数组
 * @return NSArray
 */
-(NSArray *) getLines;
/**
 * 获取SBStop1数组
 * @return NSArray
 */
-(NSArray *) getStops;
@end
