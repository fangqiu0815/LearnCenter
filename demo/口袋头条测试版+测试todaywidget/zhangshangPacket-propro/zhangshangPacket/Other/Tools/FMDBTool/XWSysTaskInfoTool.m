//
//  XWSysTaskInfoTool.m
//  zhangshangPacket
//
//  Created by apple on 2017/6/9.
//  Copyright © 2017年 apple-fangqiu. All rights reserved.
//

#import "XWSysTaskInfoTool.h"
#import <FMDB/FMDB.h>
// 数据库中常见的几种类型
#define SQL_TEXT     @"TEXT" //文本
#define SQL_INTEGER  @"INTEGER" //int long integer ...
#define SQL_REAL     @"REAL" //浮点
#define SQL_BLOB     @"BLOB" //data

static FMDatabase *dbbase;

@implementation XWSysTaskInfoTool

+ (void)initialize{
    [self adddbIncomeDetail:@"SysTaskDataDB.sqlite"];
}


+(void)adddbIncomeDetail:(NSString *)dbIncomeDetail{
    NSString *filename = [CachePath stringByAppendingPathComponent:dbIncomeDetail];
    // 打开数据库
    [dbbase open];
    dbbase = [FMDatabase databaseWithPath:filename];
    if ([dbbase open]) {
        JLLog(@"打开数据库成功");
        // 创建帖子表
        NSString *sql = @"create table if not exists t_taskinfo (pkid INTEGER PRIMARY KEY AUTOINCREMENT,id TEXT,type TEXT,desc TEXT,conval TEXT,objval TEXT,reward TEXT,stype TEXT);";
        if([dbbase executeUpdate:sql]){
            JLLog(@"创建表成功");
        }
        [dbbase close];

    }

}

// 保存帖子模型对象到数据库
+ (void)saveTopic:(XWTaskDetailInfoModel *)model{
    [dbbase open];

    NSString *sql = [NSString stringWithFormat:@"insert into t_taskinfo(id,type,desc,conval,objval,reward,stype) values (?,?,?,?,?,?,?);"];
    BOOL success = [dbbase executeUpdate:sql,model.ID,model.type,model.desc,model.conval,model.objval,model.reward,model.stype];
    if (success) {
        JLLog(@"保存任务信息到数据库成功");
        JLLog(@"sql--%@",sql);
        
    }else{
        JLLog(@"保存任务信息到数据库失败");
        JLLog(@"sql--%@",sql);

    }
    [dbbase close];

}

+(void)deleteDataFromSql:(NSString *)idstr{
    [dbbase open];

    NSString *del = [NSString stringWithFormat:@"Delete From t_taskinfo Where pkid = %@;",idstr];
    BOOL success = [dbbase executeUpdate:del];
    if (success) {
        JLLog(@"删除成功");
        //  [SVProgressHUD showSuccessWithStatus:@"取消收藏"];
    }else{
        JLLog(@"删除失败");
        //  [SVProgressHUD showSuccessWithStatus:@"取消收藏失败"];
        
    }
    [dbbase close];

}

/** 根据任务版本号进行数据库清空 **/
+(void)deleteAllDataFromSql
{
    [dbbase open];

    NSString *del = [NSString stringWithFormat:@"delete from t_taskinfo"];
    BOOL success = [dbbase executeUpdate:del];
    if (success) {
        JLLog(@"清空成功");
    }else{
        JLLog(@"清空失败");
    }
    [dbbase close];

}

// 获取数据库里的所有帖子模型
+ (NSMutableArray *)topics{
    [dbbase open];

    NSString *sql = @"select * from t_taskinfo;";
    NSMutableArray *datas = [self topicsWithSql:sql];
    [dbbase close];

    return datas;
}

// 根据sql语句获取帖子模型
+ (NSMutableArray *)topicsWithSql:(NSString *)sql{
    [dbbase open];

    NSMutableArray *topics = [NSMutableArray array];
    FMResultSet *result = [dbbase executeQuery:sql];
    while ([result next]) {
        XWTaskDetailInfoModel *model = [[XWTaskDetailInfoModel alloc] init];
        model.ID = [result intForColumn:@"id"];
        model.type = [result intForColumn:@"type"];
        model.desc = [result stringForColumn:@"desc"];
        model.conval = [result intForColumn:@"conval"];
        model.objval = [result intForColumn:@"objval"];
        model.reward = [result intForColumn:@"reward"];
        model.stype = [result intForColumn:@"stype"];

        [topics addObject:model];
    }
    [dbbase close];

    return topics;
}





@end

