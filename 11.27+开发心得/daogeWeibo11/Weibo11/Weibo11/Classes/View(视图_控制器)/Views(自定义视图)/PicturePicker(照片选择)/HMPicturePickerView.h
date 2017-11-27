//
//  HMPicturePickerView.h
//  Weibo11
//
//  Created by 刘凡 on 15/12/14.
//  Copyright © 2015年 itheima. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HMPicturePickerView : UICollectionView

/// 照片数组
@property (nonatomic, strong) NSMutableArray *pictures;

/// 实例化视图，并指定添加照片回调
///
/// @param addImageCallBack 添加照片回调
- (instancetype)initWithAddImageCallBack:(void (^)())addImageCallBack;

/// 添加一张照片
- (void)addImage:(UIImage *)image;

@end
