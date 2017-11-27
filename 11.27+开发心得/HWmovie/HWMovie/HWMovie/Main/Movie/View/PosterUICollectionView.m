//
//  PosterUICollectionView.m
//  HWMovie
//
//  Created by hyrMac on 15/7/24.
//  Copyright (c) 2015年 hyrMac. All rights reserved.
//

#import "PosterUICollectionView.h"
#import "PosterCollectionViewCell.h"
#import "MovieModal.h"
#import "UIViewExt.h"
#import "common.h"

@implementation PosterUICollectionView

- (instancetype)initWithFrame:(CGRect)frame collectionViewLayout:(UICollectionViewLayout *)layout {
    self = [super initWithFrame:frame collectionViewLayout:layout];
    if (self) {
        self.delegate = self;
        self.dataSource = self;
//        self.pagingEnabled = YES;
        [self registerClass:[PosterCollectionViewCell class] forCellWithReuseIdentifier:@"posterCell"];
    }
    return self;
}

//- (void)setMovieModalArray:(NSArray *)movieModalArray {
//    _movieModalArray = movieModalArray;
//    [self reloadData];
//}

#pragma mark - collectionViewDataSourse

//- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
////    NSLog(@"%ld",_movieModalArray.count);
//    return _movieModalArray.count;
//}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    PosterCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"posterCell" forIndexPath:indexPath];
    MovieModal *modal = self.movieModalArray[indexPath.row];
    cell.movieModal = modal;
    cell.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"bg_main"]];
    return cell;
}

//#pragma mark - UICollectionViewDelegateFlowLayout

//- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
////    return CGSizeMake((self.width)*0.75, self.height);
//    return CGSizeMake(self.itemWidth*0.75, self.height);
//}
//
//- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
////    return UIEdgeInsetsMake(0, kWidth/8, 0, kWidth/8);
//    return UIEdgeInsetsMake(0,self.itemWidth/8, 0, self.itemWidth/8);
//}

#pragma mark - UICollectionViewDelegate

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == self.currentIndex) {
        PosterCollectionViewCell *cell = (PosterCollectionViewCell *)[collectionView cellForItemAtIndexPath:indexPath];
        [cell filpCell];
    } else {
        [collectionView scrollToItemAtIndexPath:indexPath atScrollPosition: UICollectionViewScrollPositionCenteredHorizontally animated:YES];
        self.currentIndex = indexPath.row;
    }
   
}

//- (void)collectionView:(UICollectionView *)collectionView didEndDisplayingCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath {
//    CGFloat co =  self.contentOffset.x;

////    self.contentOffset = CGPointMake(cell.center.x, 0);
//}

//#pragma mark - scrollViewDelegate
//
//- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset{
//    /*
//     velocity:速度
//     targetContentOffset:目标偏移量
//     */
//    
//    NSInteger index = (targetContentOffset->x)/(kWidth*0.75);
//    targetContentOffset->x = index*kWidth*0.75;
//    self.currentIndex = index;
//}

//- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
//    NSLog(@"实施：%lf", scrollView .contentOffset.x);
//}

@end



