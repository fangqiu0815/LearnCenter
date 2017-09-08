//
//  CleanCacheToolClass.m
//
//  Created by selfos on 16/10/6.
//  Copyright © 2016年 selfos. All rights reserved.
//

#import "CleanCacheToolClass.h"

@implementation CleanCacheToolClass

+ (void)getCacheSizeWithPath:(NSString *)path complete:(void(^)(CGFloat))block;
{   

    NSFileManager *fileMgr = [NSFileManager defaultManager];

    BOOL isDirectory;
    BOOL isExists = [fileMgr fileExistsAtPath:path isDirectory:&isDirectory];
    if (!isDirectory || !isExists) {
 
        NSException *exce = [NSException exceptionWithName:@"参数错误" reason:@"必须传一个文件夹路径" userInfo:nil];
  
        [exce raise];
        return;
    }
    

    __block CGFloat totalSize = 0;

    dispatch_async(dispatch_get_global_queue(0, 0), ^{
   
        NSArray *subfileArr = [fileMgr subpathsAtPath:path];
        for (NSString *subPath in subfileArr) {
         
            NSString *subFilePaht = [path stringByAppendingPathComponent:subPath];
  
            NSDictionary *attributeDict = [fileMgr attributesOfItemAtPath:subFilePaht error:nil];
      
            CGFloat fileSize = [attributeDict[NSFileSize] floatValue];
            totalSize += fileSize;
        }
        
        dispatch_sync(dispatch_get_main_queue(), ^{
            if (block) {
                block(totalSize);
            }
        });
    });
}


#pragma mark - 处理缓存大小
+ (NSString *)stringWithTotalSize:(CGFloat)totalSize
{
    NSString *sizeStr = [NSString stringWithFormat:@"%.1fB",totalSize];
    if (totalSize > 1000 * 1000 * 1000) { // GB
       
        sizeStr = [NSString stringWithFormat:@"%.1fGB",totalSize / (1000 * 1000 * 1000)];
        sizeStr = [sizeStr stringByReplacingOccurrencesOfString:@".0" withString:@""];
    }else if(totalSize > 1000 * 1000){ // MB
    
        sizeStr = [NSString stringWithFormat:@"%.1fMB",totalSize / (1000 * 1000)];
        sizeStr = [sizeStr stringByReplacingOccurrencesOfString:@".0" withString:@""];
    }else if(totalSize > 1000){ // KB
   
        sizeStr = [NSString stringWithFormat:@"%.1fKB",totalSize / 1000];
        sizeStr = [sizeStr stringByReplacingOccurrencesOfString:@".0" withString:@""];
    }
    return sizeStr;
}

+ (void)cleanCacheWithPath:(NSString *)path complete:(void(^)())block
{
    NSFileManager *fileMgr = [NSFileManager defaultManager];

    BOOL isDirectory;
    BOOL isExists = [fileMgr fileExistsAtPath:path isDirectory:&isDirectory];
    if (!isDirectory || !isExists) {
     
        NSException *exce = [NSException exceptionWithName:@"参数有误" reason:@"必须传一个文件夹路径" userInfo:nil];
    
        [exce raise];
        return;
    }
    
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        NSArray *subPathArr = [fileMgr subpathsAtPath:path];
      
        for (NSString *subPath in subPathArr) {
         
            NSString *subFilePath = [path stringByAppendingPathComponent:subPath];
            BOOL isDirectory;
            BOOL isExists = [fileMgr fileExistsAtPath:subFilePath isDirectory:&isDirectory];
            if (!isDirectory && isExists) {
        
                [fileMgr removeItemAtPath:subFilePath error:nil];
            }
        }
        dispatch_sync(dispatch_get_main_queue(), ^{
            if (block) {
                block();
            }
        });
        
    });
    
}

@end
