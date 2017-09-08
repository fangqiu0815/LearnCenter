//
//  XWSysTaskInfoTool.h
//  zhangshangPacket
//
//  Created by apple on 2017/6/9.
//  Copyright © 2017年 apple-fangqiu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "XWTaskDetailInfoModel.h"
@interface XWSysTaskInfoTool : NSObject

/**保存模型到数据库*/
+ (void)saveTopic:(XWTaskDetailInfoModel *)model;

/**获取所有模型*/
+ (NSMutableArray *)topics;

/**获取模型*/
+ (NSMutableArray *)topicsWithSql:(NSString *)sql;

/**通过ID删除指定行*/
+(void)deleteDataFromSql:(NSString *)idstr;

/** 根据任务版本号进行数据库全清 **/
+(void)deleteAllDataFromSql;







@end
