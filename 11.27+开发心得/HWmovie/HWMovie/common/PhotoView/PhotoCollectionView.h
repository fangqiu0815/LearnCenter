//
//  PhotoCollectionView.h
//  HWMovie
//
//  Created by hyrMac on 15/7/23.
//  Copyright (c) 2015年 hyrMac. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PhotoCollectionView : UICollectionView <UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@property (nonatomic, retain) NSArray *imageUrlArray;
@end
