//
//  XWIncomeDetailListTool.m
//  zhangshangPacket
//
//  Created by apple on 2017/6/8.
//  Copyright © 2017年 apple-fangqiu. All rights reserved.
//

#import "XWIncomeDetailListTool.h"
#import <FMDB/FMDB.h>

static FMDatabase *db;

@interface XWIncomeDetailListTool ()

@property (nonatomic,strong) FMDatabaseQueue *dbQueue;


@end

@implementation XWIncomeDetailListTool

+ (void)initialize{
    [self adddbIncomeDetail:@"incomeDetailSql.sqlite"];
}
+(void)adddbIncomeDetail:(NSString *)dbIncomeDetail{
    NSString *filename = [DocumentPath stringByAppendingPathComponent:dbIncomeDetail];
    // 打开数据库
    db = [FMDatabase databaseWithPath:filename];
    if ([db open]) {
        JLLog(@"打开数据库成功");
        // 创建帖子表
        NSString *sql = @"create table if not exists t_collect(id INTEGER PRIMARY KEY AUTOINCREMENT,type TEXT,typedesc TEXT);";
        if([db executeUpdate:sql]){
            JLLog(@"创建表成功");
        }
        [db close];

    }
}

// 保存模型对象到数据库
+ (void)saveTopic:(XWIncomeDetailInfoModel *)model{
    [db open];
    NSString *sql = [NSString stringWithFormat:@"insert into t_collect(type,typedesc) values (?,?);"];
    BOOL success = [db executeUpdate:sql,model.type,model.typedesc];
    if (success) {
        JLLog(@"保存明细到数据库成功");
       // [SVProgressHUD showSuccessWithStatus:@"收藏成功"];
    }else{
        JLLog(@"保存明细到数据库失败");
       // [SVProgressHUD showSuccessWithStatus:@"收藏失败"];

    }
    [db close];
}

+(void)deleteDataFromSql:(NSString *)idstr{
    [db open];
    NSString *del=[NSString stringWithFormat:@"Delete From t_collect Where id = %@;",idstr];
    BOOL success = [db executeUpdate:del];
    if (success) {
        JLLog(@"删除成功");
      //  [SVProgressHUD showSuccessWithStatus:@"取消收藏"];
    }else{
        JLLog(@"删除失败");
      //  [SVProgressHUD showSuccessWithStatus:@"取消收藏失败"];
        
    }
    [db close];
}
// 获取数据库里的所有模型
+ (NSMutableArray *)topics{
    [db open];
    NSString *sql = @"select * from t_collect;";
    NSMutableArray *datas = [self topicsWithSql:sql];
    [db close];
    return datas;
}

// 根据sql语句获取模型
+ (NSMutableArray *)topicsWithSql:(NSString *)sql{
    [db open];
    NSMutableArray *topics = [NSMutableArray array];
    
    if ([db open]) {
        FMResultSet *result = [db executeQuery:sql];
        while ([result next]) {
            XWIncomeDetailInfoModel *model = [[XWIncomeDetailInfoModel alloc] init];
            model.type = [result stringForColumn:@"type"];
            model.typedesc = [result stringForColumn:@"typedesc"];
            [topics addObject:model];
        }
        [db close];
    }
    
    return topics;
}

/** 根据任务版本号进行数据库全删 **/
+(void)deleteAllDataFromSql
{
    [db open];
    NSString *del = [NSString stringWithFormat:@"Delete From t_collect"];
    BOOL success = [db executeUpdate:del];
    if (success) {
        JLLog(@"清空成功");
    }else{
        JLLog(@"清空失败");
    }
    [db close];
}



@end
