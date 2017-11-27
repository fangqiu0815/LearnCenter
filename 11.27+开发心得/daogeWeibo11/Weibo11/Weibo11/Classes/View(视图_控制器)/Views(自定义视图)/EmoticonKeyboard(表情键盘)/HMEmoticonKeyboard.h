//
//  HMEmoticonKeyboard.h
//  Weibo11
//
//  Created by 刘凡 on 15/12/15.
//  Copyright © 2015年 itheima. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HMEmoticonManager.h"

/// 表情键盘
@interface HMEmoticonKeyboard : UIView

/**
 实例化表情键盘
 
 @param textView 由表情键盘负责的 textView
 @return 表情键盘实例
 
 @code
 
 // 在私有扩展中增加以下代码，定义表情键盘属性
 @property (nonatomic, strong) HMEmoticonKeyboard *emoticonKeyboard;
 
 ...
 
 
 // 在 viewDidLoad 中增加以下代码，实例化表情键盘，并传入接收的 textView
 _emoticonKeyboard = [[HMEmoticonKeyboard alloc] initWithTextView:self.textView];
 
 @endcode
 */
- (instancetype)initWithTextView:(UITextView *)textView;

@end
