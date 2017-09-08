//
//  XWTurnTableInfoTool.m
//  zhangshangPacket
//
//  Created by apple on 2017/6/9.
//  Copyright © 2017年 apple-fangqiu. All rights reserved.
//

#import "XWTurnTableInfoTool.h"

#import <FMDB/FMDB.h>

static FMDatabase *db;

@implementation XWTurnTableInfoTool
/*
 
 @property (nonatomic, copy) NSString *id;
 
 @property (nonatomic, copy) NSString *type;
 
 @property (nonatomic, copy) NSString *val;
 
 @property (nonatomic, copy) NSString *desc;

 
 */
+ (void)initialize{
    [self adddbIncomeDetail:@"SysTurnTableInfoSql.sqlite"];
}

+(void)adddbIncomeDetail:(NSString *)dbIncomeDetail{
    NSString *filename = [CachePath stringByAppendingPathComponent:dbIncomeDetail];
    // 打开数据库
    db = [FMDatabase databaseWithPath:filename];
    if ([db open]) {
        JLLog(@"打开数据库成功");
        // 创建帖子表
        NSString *sql = @"create table if not exists t_collect(id text,type text,desc text,val text);";
        if([db executeUpdate:sql]){
            JLLog(@"创建表成功");
        }
    }
}

// 保存帖子模型对象到数据库
+ (void)saveTopic:(XWTurnTableInfoModel *)model{
    NSString *sql = [NSString stringWithFormat:@"insert into t_collect(id,type,desc,val) values ('%@','%@','%@','%@');",model.ID,model.type,model.desc,model.val];
    BOOL success = [db executeUpdate:sql];
    if (success) {
        JLLog(@"保存任务信息到数据库成功");
        // [SVProgressHUD showSuccessWithStatus:@"收藏成功"];
    }else{
        JLLog(@"保存任务信息到数据库失败");
        // [SVProgressHUD showSuccessWithStatus:@"收藏失败"];
        
    }
}
+(void)deleteDataFromSql:(NSString *)idstr{
    NSString *del=[NSString stringWithFormat:@"Delete From t_collect Where id = %@;",idstr];
    BOOL success = [db executeUpdate:del];
    if (success) {
        JLLog(@"删除成功");
        //  [SVProgressHUD showSuccessWithStatus:@"取消收藏"];
    }else{
        JLLog(@"删除失败");
        //  [SVProgressHUD showSuccessWithStatus:@"取消收藏失败"];
        
    }
}

/** 根据任务版本号进行数据库全删 **/
+(void)deleteAllDataFromSql
{
    NSString *del = [NSString stringWithFormat:@"Delete From t_collect"];
    BOOL success = [db executeUpdate:del];
    if (success) {
        JLLog(@"删除成功");
    }else{
        JLLog(@"删除失败");
    }
    
}

// 获取数据库里的所有帖子模型
+ (NSMutableArray *)topics{
    NSString *sql = @"select * from t_collect;";
    NSMutableArray *datas = [self topicsWithSql:sql];
    return datas;
}

// 根据sql语句获取帖子模型
+ (NSMutableArray *)topicsWithSql:(NSString *)sql{
    NSMutableArray *topics = [NSMutableArray array];
    FMResultSet *result = [db executeQuery:sql];
    while ([result next]) {
        XWTurnTableInfoModel *model = [[XWTurnTableInfoModel alloc] init];
        model.ID = [result stringForColumn:@"id"];
        model.type = [result stringForColumn:@"type"];
        model.desc = [result stringForColumn:@"desc"];
        model.val = [result stringForColumn:@"conval"];
        
        [topics addObject:model];
    }
    return topics;
}



@end
