//
//  PhotoViewController.h
//  HWMovie
//
//  Created by hyrMac on 15/7/23.
//  Copyright (c) 2015年 hyrMac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PhotoCollectionView.h"

@interface PhotoViewController : UIViewController
{
    PhotoCollectionView *_collectionView;
}

@property (nonatomic, retain) NSArray *imageUrlArray;
@property (nonatomic, assign) NSInteger currentIndex;  // 当前要显示图片的index
@end
