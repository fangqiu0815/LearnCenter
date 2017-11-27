//
//  IndexCollectionViewCell.h
//  HWMovie
//
//  Created by hyrMac on 15/7/25.
//  Copyright (c) 2015年 hyrMac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MovieModal.h"

@interface IndexCollectionViewCell : UICollectionViewCell
{
    UIImageView *_smallPoster;
}

@property (nonatomic, assign) BOOL isBack;
@property (nonatomic, retain) MovieModal *movieModal;

@end
