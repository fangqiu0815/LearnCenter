//
//  HMEmoticonToolbar.h
//  Weibo11
//
//  Created by 刘凡 on 15/12/15.
//  Copyright © 2015年 itheima. All rights reserved.
//

#import <UIKit/UIKit.h>

/// 表情工具栏按钮类型
typedef enum : NSUInteger {
    EmoticonToolbarRecent,
    EmoticonToolbarNormal,
    EmoticonToolbarEmoji,
    EmoticonToolbarLangXiaohua,
} HMEmoticonToolbarType;

@protocol HMEmoticonToolbarDelegate <NSObject>

/// 工具栏选中表情类型
///
/// @param type 表情类型
- (void)emoticonToolbarDidSelectEmoticonType:(HMEmoticonToolbarType)type;

@end

/// 表情键盘工具条
@interface HMEmoticonToolbar : UIView

/// 代理
@property (nonatomic, weak) id<HMEmoticonToolbarDelegate> delegate;

/// 使用 section 设置选中按钮
- (void)setSelectedButtonWithSection:(NSInteger)section;

@end
