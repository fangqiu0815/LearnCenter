//
//  PhotoCollectionViewCell.h
//  HWMovie
//
//  Created by hyrMac on 15/7/23.
//  Copyright (c) 2015年 hyrMac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PhotoScrollView.h"

@interface PhotoCollectionViewCell : UICollectionViewCell
{
    PhotoScrollView *_scrollView;
}

@property (nonatomic, retain) NSString *imageUrlStr;
@end
