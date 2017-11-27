//
//  BaseUICollectionView.h
//  HWMovie
//
//  Created by hyrMac on 15/7/25.
//  Copyright (c) 2015年 hyrMac. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaseUICollectionView : UICollectionView  <UICollectionViewDelegateFlowLayout,UICollectionViewDataSource>
@property (nonatomic, retain) NSArray *movieModalArray;
@property (nonatomic, assign) NSInteger currentIndex;
@property (nonatomic, assign) CGFloat itemWidth;

@end
