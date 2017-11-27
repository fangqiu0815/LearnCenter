//
//  UITextView+Emoticon.m
//  Weibo11
//
//  Created by 刘凡 on 15/12/17.
//  Copyright © 2015年 joyios. All rights reserved.
//

#import "UITextView+Emoticon.h"
#import "HMEmoticonAttachment.h"
#import "HMEmoticon.h"

@implementation UITextView (Emoticon)

- (void)inputEmoticon:(HMEmoticon *)emoticon isDelete:(BOOL)isDelete {
    
    // 1. 判断是否删除
    if (isDelete) {
        [self deleteBackward];
        return;
    }
    
    // 2. emoji
    if (emoticon.isEmoji) {
        [self replaceRange:self.selectedTextRange withText:emoticon.emoji];
        return;
    }
    
    // 3. 表情图片
    NSAttributedString *imageText = [[HMEmoticonAttachment attachmentWithEmoticon:emoticon] imageTextWithFont:self.font];
    
    NSMutableAttributedString *attributeTextM = [[NSMutableAttributedString alloc] initWithAttributedString:self.attributedText];
    
    [attributeTextM replaceCharactersInRange:self.selectedRange withAttributedString:imageText];
    
    NSRange range = self.selectedRange;
    self.attributedText = attributeTextM;
    self.selectedRange = NSMakeRange(range.location + 1, 0);
    
    // 4. 主动调用代理方法
    if ([self.delegate respondsToSelector:@selector(textViewDidChange:)]) {
        [self.delegate textViewDidChange:self];
    }
    // 发送文本变化通知 - 注意 object 是发布通知的对象
    [[NSNotificationCenter defaultCenter] postNotificationName:UITextViewTextDidChangeNotification object:self];
}

- (NSString *)emoticonText {
    
    NSAttributedString *attributeText = self.attributedText;
    
    NSMutableString *stringM = [NSMutableString string];
    [attributeText enumerateAttributesInRange:NSMakeRange(0, attributeText.length) options:0 usingBlock:^(NSDictionary<NSString *,id> * _Nonnull attrs, NSRange range, BOOL * _Nonnull stop) {
        
        if ([attrs[@"NSAttachment"] isKindOfClass:[HMEmoticonAttachment class]]) {
            [stringM appendString:[attrs[@"NSAttachment"] emoticon].chs];
        } else {
            [stringM appendString:[attributeText.string substringWithRange:range]];
        }
    }];
    
    return stringM.copy;
}

@end
