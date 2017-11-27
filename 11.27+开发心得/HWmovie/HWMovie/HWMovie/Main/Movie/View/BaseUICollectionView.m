//
//  BaseUICollectionView.m
//  HWMovie
//
//  Created by hyrMac on 15/7/25.
//  Copyright (c) 2015年 hyrMac. All rights reserved.
//

#import "BaseUICollectionView.h"
#import "MovieModal.h"
#import "UIViewExt.h"
#import "common.h"

@implementation BaseUICollectionView

- (instancetype)initWithFrame:(CGRect)frame collectionViewLayout:(UICollectionViewLayout *)layout {
    self = [super initWithFrame:frame collectionViewLayout:layout];
    if (self) {
        self.delegate = self;
        self.dataSource = self;
        //        self.pagingEnabled = YES;
//        [self registerClass:[PosterCollectionViewCell class] forCellWithReuseIdentifier:@"posterCell"];
    }
    return self;
}

- (void)setMovieModalArray:(NSArray *)movieModalArray {
    _movieModalArray = movieModalArray;
    [self reloadData];
}

#pragma mark - collectionViewDataSourse

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    //    NSLog(@"%ld",_movieModalArray.count);
    return _movieModalArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    return nil;
}

#pragma mark - UICollectionViewDelegateFlowLayout

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake(self.itemWidth*0.75, self.height);
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(0, (kWidth-self.itemWidth*0.75)/2, 0, (kWidth-self.itemWidth*0.75)/2);
}

#pragma mark - UICollectionViewDelegate

//- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
//    if (indexPath.row == self.currentIndex) {
//        PosterCollectionViewCell *cell = (PosterCollectionViewCell *)[collectionView cellForItemAtIndexPath:indexPath];
//        [cell filpCell];
//    } else {
//        [collectionView scrollToItemAtIndexPath:indexPath atScrollPosition: UICollectionViewScrollPositionCenteredHorizontally animated:YES];
//        self.currentIndex = indexPath.row;
//    }
//    
//}

#pragma mark - scrollViewDelegate

- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset{
    /*
     velocity:速度
     targetContentOffset:目标偏移量
     */
    NSInteger index = (targetContentOffset->x)/(self.itemWidth*0.75);
    if (index < 0) {
        index = 0;
    } else if (index >= _movieModalArray.count) {
        index = _movieModalArray.count -1;
    }
    targetContentOffset->x = index*self.itemWidth*0.75;
    self.currentIndex = index;
}

@end
