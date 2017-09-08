//
//  XWHomeDataTool.m
//  zhangshangPacket
//
//  Created by apple on 2017/7/21.
//  Copyright © 2017年 apple-fangqiu. All rights reserved.
//

#import "XWHomeDataTool.h"
#import <FMDB/FMDB.h>

static FMDatabase *db;
@implementation XWHomeDataTool

/*
 
 @property (nonatomic, copy) NSString *id;
 
 @property (nonatomic, copy) NSString *type;
 
 @property (nonatomic, copy) NSString *hasReward;
 
 @property (nonatomic, copy) NSString *showType;
 
 @property (nonatomic, copy) NSMutableDictionary *imgsUrl;
 
 @property (nonatomic, copy) NSString *title;
 
 @property (nonatomic, copy) NSString *resource;
 
 @property (nonatomic, copy) NSString *content;
 
 @property (nonatomic, copy) NSString *url;
 
 @property (nonatomic, copy) NSString *ingot;
 
 @property (nonatomic, copy) NSString *arttime;
 
 @property (nonatomic, copy) NSString *author;
 
 @property (nonatomic, copy) NSString *tag;
 
 @property (nonatomic, copy) NSString *showurl;
 
 */

+ (void)initialize{
    [self adddbIncomeDetail:@"XWHomeDataSQL.sqlite"];
}

+(void)adddbIncomeDetail:(NSString *)dbIncomeDetail{
    NSString *filename = [CachePath stringByAppendingPathComponent:dbIncomeDetail];
    // 打开数据库
    db = [FMDatabase databaseWithPath:filename];
    if ([db open]) {
        JLLog(@"打开数据库成功");
        // 创建帖子表
        NSString *sql = @"create table if not exists t_collect(id text,type text,hasReward text,showType text,imgsUrl text,title text,resource text,content text,url text,ingot text,arttime text,author text,tag text,showurl text);";
        if([db executeUpdate:sql]){
            JLLog(@"创建表成功");
        }
    }
}

// 保存帖子模型对象到数据库
+ (void)saveTopic:(NewsListDataModel *)model{

    NSString *sql = [NSString stringWithFormat:@"insert into t_collect(id,type,hasReward,showType,imgsUrl,title,resource,content,url,ingot,arttime,author,tag,showurl) values ('%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@');",model.id,model.type,model.hasReward,model.showType,model.imgsUrl[@"imgsUrl1"],model.title,model.resource,model.content,model.url,model.ingot,model.arttime,model.author,model.tag,model.showurl];

    BOOL success = [db executeUpdate:sql];
    if (success) {
        JLLog(@"保存阅读信息到数据库成功");
        JLLog(@"%@",sql);
        // [SVProgressHUD showSuccessWithStatus:@"收藏成功"];
    }else{
        JLLog(@"保存阅读信息到数据库失败");
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
    JLLog(@"%@",result);
    while ([result next]) {
        NewsListDataModel *model = [[NewsListDataModel alloc] init];
        model.id = [result stringForColumn:@"id"];
        model.type = [result stringForColumn:@"type"];
        model.hasReward = [result stringForColumn:@"hasReward"];
        model.showType = [result stringForColumn:@"showType"];
        model.imgsUrl = [result stringForColumn:@"imgsUrl"];
        model.title = [result stringForColumn:@"title"];
        model.resource = [result stringForColumn:@"resource"];
        model.content = [result stringForColumn:@"content"];
        model.url = [result stringForColumn:@"url"];
        model.ingot = [result stringForColumn:@"ingot"];
        model.arttime = [result stringForColumn:@"arttime"];
        model.author = [result stringForColumn:@"author"];
        model.tag = [result stringForColumn:@"tag"];
        model.showurl = [result stringForColumn:@"showurl"];
        
        [topics addObject:model];
    }
    return topics;
}



@end
