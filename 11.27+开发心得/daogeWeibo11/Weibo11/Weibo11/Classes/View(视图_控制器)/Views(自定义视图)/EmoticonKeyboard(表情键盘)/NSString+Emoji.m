//
//  NSString+Emoji.m
//  Weibo11
//
//  Created by 刘凡 on 15/12/16.
//  Copyright © 2015年 itheima. All rights reserved.
//

#import "NSString+Emoji.h"

#define EmojiCodeToSymbol(c) ((((0x808080F0 | (c & 0x3F000) >> 4) | (c & 0xFC0) << 10) | (c & 0x1C0000) << 18) | (c & 0x3F) << 24)

@implementation NSString (Emoji)

+ (NSString *)emojiWithIntCode:(unsigned int)intCode {
    unsigned int symbol = EmojiCodeToSymbol(intCode);
    NSString *string = [[NSString alloc] initWithBytes:&symbol length:sizeof(symbol) encoding:NSUTF8StringEncoding];
    
    // 新版Emoji
    if (string == nil) {
        string = [NSString stringWithFormat:@"%C", (unichar)intCode];
    }
    return string;
}

+ (NSString *)emojiWithStringCode:(NSString *)stringCode {
    
    NSScanner *scanner = [[NSScanner alloc] initWithString:stringCode];
    
    unsigned int intCode = 0;
    [scanner scanHexInt:&intCode];
    
    return [self emojiWithIntCode:intCode];
}

- (NSString *)emoji {
    return [NSString emojiWithStringCode:self];
}

@end
