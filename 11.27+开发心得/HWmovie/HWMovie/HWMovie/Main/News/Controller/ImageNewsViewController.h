//
//  ImageNewsViewController.h
//  HWMovie
//
//  Created by hyrMac on 15/7/22.
//  Copyright (c) 2015年 hyrMac. All rights reserved.
//

#import "BaseViewController.h"

@interface ImageNewsViewController : BaseViewController <UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
{
    UICollectionView *_imageCollectionView;
    NSMutableArray *_imageModalArray;
}

@end
