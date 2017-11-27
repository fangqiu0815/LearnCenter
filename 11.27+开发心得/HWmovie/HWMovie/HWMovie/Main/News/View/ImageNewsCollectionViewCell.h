//
//  ImageNewsCollectionViewCell.h
//  HWMovie
//
//  Created by hyrMac on 15/7/22.
//  Copyright (c) 2015年 hyrMac. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ImageNewsModal;

@interface ImageNewsCollectionViewCell : UICollectionViewCell
@property (nonatomic, strong) UIImageView *iconImageView;
@property (nonatomic, retain) ImageNewsModal *imageModal;

@end
