//
//  PhotoCollectionView.m
//  HWMovie
//
//  Created by hyrMac on 15/7/23.
//  Copyright (c) 2015年 hyrMac. All rights reserved.
//

#import "PhotoCollectionView.h"
#import "PhotoCollectionViewCell.h"

@implementation PhotoCollectionView

// 应与上层调用时完全相同，不然无法进入该方法－－－－>废话，却疏忽了
- (instancetype)initWithFrame:(CGRect)frame collectionViewLayout:(UICollectionViewLayout *)layout {
    self = [super initWithFrame:frame collectionViewLayout:layout];
    if (self) {
        self.dataSource = self;
        self.delegate = self;
        self.pagingEnabled = YES;  // 分页浏览效果
        [self registerClass:[PhotoCollectionViewCell class] forCellWithReuseIdentifier:@"cell"];  // 注册单元项
    }
    return self;
}

// 需要吗？
- (void)setImageUrlArray:(NSArray *)imageUrlArray {
    _imageUrlArray = imageUrlArray;
    [self reloadData];
}

#pragma mark - CollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
//    NSLog(@"%ld",self.imageUrlArray.count);
    return self.imageUrlArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    PhotoCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    cell.imageUrlStr = self.imageUrlArray[indexPath.row];
    return cell;
}

#pragma mark - UICollectionViewDelegate

- (void)collectionView:(UICollectionView *)collectionView didEndDisplayingCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath {
    PhotoCollectionViewCell *photoCell = (PhotoCollectionViewCell *)cell;
    
    PhotoScrollView *scrollView = (PhotoScrollView *)[photoCell.contentView viewWithTag:100];
    
    scrollView.zoomScale = 1.0;
}

@end
