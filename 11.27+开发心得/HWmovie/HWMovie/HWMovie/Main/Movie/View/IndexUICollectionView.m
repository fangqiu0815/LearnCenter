//
//  IndexUICollectionView.m
//  HWMovie
//
//  Created by hyrMac on 15/7/25.
//  Copyright (c) 2015年 hyrMac. All rights reserved.
//

#import "IndexUICollectionView.h"
#import "IndexCollectionViewCell.h"
#import "MovieModal.h"

@implementation IndexUICollectionView

- (instancetype)initWithFrame:(CGRect)frame collectionViewLayout:(UICollectionViewLayout *)layout {
    self = [super initWithFrame:frame collectionViewLayout:layout];
    if (self) {
        self.delegate = self;
        self.dataSource = self;
        //        self.pagingEnabled = YES;
        [self registerClass:[IndexCollectionViewCell class] forCellWithReuseIdentifier:@"indexCell"];
    }
    return self;
}

#pragma mark - collectionViewDataSourse

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    IndexCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"indexCell" forIndexPath:indexPath];
    MovieModal *modal = self.movieModalArray[indexPath.row];
    cell.movieModal = modal;
    cell.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"bg_main"]];
    return cell;
}

#pragma mark - UICollectionViewDelegate

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row != self.currentIndex) {
        
        [collectionView scrollToItemAtIndexPath:indexPath atScrollPosition: UICollectionViewScrollPositionCenteredHorizontally animated:YES];
        self.currentIndex = indexPath.row;
    }

}

@end
