//
//  NSString+Emoji.h
//  Weibo11
//
//  Created by 刘凡 on 15/12/16.
//  Copyright © 2015年 itheima. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Emoji)

/// 将十六进制的编码转为emoji字符
+ (NSString *)emojiWithIntCode:(unsigned int)intCode;

/// 将十六进制的编码转为emoji字符
+ (NSString *)emojiWithStringCode:(NSString *)stringCode;
- (NSString *)emoji;

@end
