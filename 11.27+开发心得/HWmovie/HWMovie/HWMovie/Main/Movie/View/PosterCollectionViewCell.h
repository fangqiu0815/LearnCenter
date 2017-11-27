//
//  PosterCollectionViewCell.h
//  HWMovie
//
//  Created by hyrMac on 15/7/24.
//  Copyright (c) 2015年 hyrMac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PosterDetailView.h"
#import "MovieModal.h"

@interface PosterCollectionViewCell : UICollectionViewCell
{
    UIImageView *_bigPoster;
    PosterDetailView *_detailView;
}

@property (nonatomic, assign) BOOL isBack;
@property (nonatomic, retain) MovieModal *movieModal;

- (void)filpCell;
@end
