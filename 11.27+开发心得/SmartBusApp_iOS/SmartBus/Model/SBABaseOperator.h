//
//  SBBaseOperator.h
//  SmartBus
//
//  Created by 飞瞳凡想 on 14-5-6.
//  Copyright (c) 2014年 飞瞳凡想. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SBABaseData.h"
typedef NS_ENUM(NSInteger, DataType) {
    SBABusType,SBALineType,SBAStopType,SBAPositionType
};
typedef enum {
    line,bus,stop,road,position,flag,
    version,error
    
}DataKey;
/**
 * 信息操作基类
 * 请通过其子类SBBusInfo,SBBasicInfo类进行操作，不推荐实例化该类
 */
@interface SBABaseOperator : NSObject
/**
 * 构造函数
 * @return SBBaseInfo
 */
-(SBABaseOperator *) init;
/**
 * 解析json数据
 * @param jsonData
 * @return json != nil && json.flag == 1 ? YES : NO;
 */
-(BOOL) analysisJsonData:(NSDictionary *)json;

/**
 * 获取数组
 * @param type
 * @return array
 */
-(NSArray *) getArray:(DataType)type;


@end
