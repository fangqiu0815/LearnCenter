//
//  HMEmoticonAttachment.h
//  Weibo11
//
//  Created by 刘凡 on 15/12/17.
//  Copyright © 2015年 joyios. All rights reserved.
//

#import <UIKit/UIKit.h>
@class HMEmoticon;

/// 自定义支持表情符号的文本附件
@interface HMEmoticonAttachment : NSTextAttachment

/// 表情模型
@property (nonatomic, strong) HMEmoticon *emoticon;

/// 使用表情模型实例化附件
+ (instancetype)attachmentWithEmoticon:(HMEmoticon *)emoticon;

/// 使用指定字体生成属性文本
- (NSAttributedString *)imageTextWithFont:(UIFont *)font;

@end
