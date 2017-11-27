//
//  HMPicturePickerCell.h
//  Weibo11
//
//  Created by 刘凡 on 15/12/14.
//  Copyright © 2015年 itheima. All rights reserved.
//

#import <UIKit/UIKit.h>
@class HMPicturePickerCell;

@protocol HMPicturePickerCellDelegate <NSObject>

- (void)picturePickerCellDidClickDeleteButton:(HMPicturePickerCell *)cell;

@end

@interface HMPicturePickerCell : UICollectionViewCell

/// 照片图像
@property (nonatomic, strong) UIImage *image;
/// 代理
@property (nonatomic, weak) id<HMPicturePickerCellDelegate> delegate;

@end
