//
//  HMEmoticonButton.h
//  Weibo11
//
//  Created by 刘凡 on 15/12/16.
//  Copyright © 2015年 itheima. All rights reserved.
//

#import <UIKit/UIKit.h>
@class HMEmoticon;

/// 表情按钮
@interface HMEmoticonButton : UIButton
/// 表情包模型
@property (nonatomic, strong) HMEmoticon *emoticon;
/// 是否删除按钮
@property (nonatomic, assign) BOOL isDeleteButton;
@end
