//
//  PosterView.h
//  HWMovie
//
//  Created by hyrMac on 15/7/24.
//  Copyright (c) 2015年 hyrMac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PosterUICollectionView.h"
#import "IndexUICollectionView.h"

@interface PosterView : UIView
{
    UIView *_headerView;
    PosterUICollectionView *_posterCollectionView;
    UILabel *_bottomTitleLabel;
    UIControl *_coverView;
    IndexUICollectionView *_indexCollectionView;
    UIImageView *_img1;
    UIImageView *_img2;
}

@property (nonatomic, retain) NSArray *movieModalArray;
@end
