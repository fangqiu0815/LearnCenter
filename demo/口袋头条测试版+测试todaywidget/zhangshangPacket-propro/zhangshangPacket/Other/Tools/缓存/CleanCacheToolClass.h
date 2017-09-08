//
//  CleanCacheToolClass.h
//
//  Created by selfos on 16/10/6.
//  Copyright © 2016年 selfos. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CleanCacheToolClass : NSObject
/**
 *
 *  根据一个文件夹,获取文件夹大小
 *
 *  @param path  缓存路径
 *  @param block 完成时调用的block
 */
+ (void)getCacheSizeWithPath:(NSString *)path complete:(void(^)(CGFloat totalCache))block;

/**
 *  将缓存大小转换成字符串
 *
 *  @param totalSize 缓存大小
 *
 *  @return 转换成的字符串
 */
+ (NSString *)stringWithTotalSize:(CGFloat)totalSize;


/**
 *
 *  根据一个文件夹路径,清除缓存
 *
 *  @param path  缓存路径
 *  @param block 完成时调用的block
 */
+ (void)cleanCacheWithPath:(NSString *)path complete:(void(^)())block;
@end
