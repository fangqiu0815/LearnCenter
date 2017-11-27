//
//  HMEmoticonCell.h
//  Weibo11
//
//  Created by 刘凡 on 15/12/15.
//  Copyright © 2015年 itheima. All rights reserved.
//

#import <UIKit/UIKit.h>
@class HMEmoticon;

@protocol HMEmoticonCellDelegate <NSObject>

/// 表情cell选中表情
///
/// @param emoticon  选中的表情
/// @param isDeleted 是否删除键，如果是，emoticon == nil
- (void)emoticonCellDidSelectedEmoticon:(HMEmoticon *)emoticon isDeleted:(BOOL)isDeleted;

@end

/// 表情 Cell
@interface HMEmoticonCell : UICollectionViewCell

/// 代理
@property (nonatomic, weak) id<HMEmoticonCellDelegate> delegate;

/// 当前 cell 所在 indexPath
@property (nonatomic) NSIndexPath *indexPath;

/// 当前页面的表情模型数组
@property (nonatomic) NSArray *emoticons;
@end
