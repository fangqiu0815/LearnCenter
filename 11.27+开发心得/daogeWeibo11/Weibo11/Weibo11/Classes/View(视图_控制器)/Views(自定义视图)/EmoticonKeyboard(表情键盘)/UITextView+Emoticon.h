//
//  UITextView+Emoticon.h
//  Weibo11
//
//  Created by 刘凡 on 15/12/17.
//  Copyright © 2015年 joyios. All rights reserved.
//

#import <UIKit/UIKit.h>
@class HMEmoticon;

/// 针对表情键盘的 UITextView 分类
@interface UITextView (Emoticon)

/// emoticon 对应的纯文本字符串，便于网络传输
@property (nonatomic, strong, readonly) NSString *emoticonText;

/// 在文本视图中插入 emoticon 表情中的图片或者 / emoji
///
/// @param emoticon 表情模型
/// @param isDelete 是否删除键
- (void)inputEmoticon:(HMEmoticon *)emoticon isDelete:(BOOL)isDelete;

@end
