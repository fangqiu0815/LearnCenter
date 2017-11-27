//
//  HMPicturePickerView.m
//  Weibo11
//
//  Created by 刘凡 on 15/12/14.
//  Copyright © 2015年 itheima. All rights reserved.
//

#import "HMPicturePickerView.h"
#import "HMPicturePickerCell.h"

#pragma mark - 自定义照片选择视图布局
@interface HMPicturePickerLayout : UICollectionViewFlowLayout

@end

@implementation HMPicturePickerLayout

- (void)prepareLayout {
    [super prepareLayout];
    
    CGFloat margin = 5;
    CGFloat w = (self.collectionView.bounds.size.width - 2 * margin) / 3;
    
    self.itemSize = CGSizeMake(w, w);
    self.minimumInteritemSpacing = margin;
    self.minimumLineSpacing = margin;
}

@end

#pragma mark - 照片选择视图

/// 可重用标识符
#define kPicturePickerCellID @"kPicturePickerCellID"
#define kMaxPictureCount 9

@interface HMPicturePickerView() <UICollectionViewDataSource, UICollectionViewDelegate, HMPicturePickerCellDelegate>
/// 添加照片回调
@property (nonatomic, copy) void (^addImageCallBack)();
@end

@implementation HMPicturePickerView

- (void)reloadData {
    [super reloadData];
    
    self.hidden = self.pictures.count == 0;
}

/// 添加一张照片
- (void)addImage:(UIImage *)image {
    if (image == nil) {
        return;
    }
    
    [self.pictures addObject:image];
    [self reloadData];
}

#pragma mark - 构造函数
- (instancetype)initWithAddImageCallBack:(void (^)())addImageCallBack {
    
    HMPicturePickerLayout *layout = [[HMPicturePickerLayout alloc] init];
    
    self = [super initWithFrame:CGRectZero collectionViewLayout:layout];
    if (self) {
        // 实例化 pictures 数组
        _pictures = [NSMutableArray array];
        // 记录回调
        _addImageCallBack = addImageCallBack;
        
        // 注册可重用cell
        [self registerClass:[HMPicturePickerCell class] forCellWithReuseIdentifier:kPicturePickerCellID];
        
        self.dataSource = self;
        self.delegate = self;
        
        // 初始隐藏
        self.hidden = YES;
    }
    return self;
}

#pragma mark - HMPicturePickerCellDelegate
- (void)picturePickerCellDidClickDeleteButton:(HMPicturePickerCell *)cell {
    
    NSIndexPath *indexPath = [self indexPathForCell:cell];
    
    [self.pictures removeObjectAtIndex:indexPath.item];
    
    [self reloadData];
}

#pragma mark - UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    // 如果是0张图片或者 9 张图片,就返回 images.count
    // 否则返回 images.count + 1
    NSInteger count = self.pictures.count;
    return (count == 0 || count == kMaxPictureCount) ? count : count + 1;
    
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    HMPicturePickerCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kPicturePickerCellID forIndexPath:indexPath];
    
    cell.image = (indexPath.item == self.pictures.count) ? nil : self.pictures[indexPath.item];
    cell.delegate = self;
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    // 判断是否点中末尾的加号按钮
    if (indexPath.item == self.pictures.count && self.addImageCallBack != nil) {
        self.addImageCallBack();
    }
}

@end
