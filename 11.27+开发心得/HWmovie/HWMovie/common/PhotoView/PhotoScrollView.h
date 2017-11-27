//
//  PhotoScrollView.h
//  HWMovie
//
//  Created by hyrMac on 15/7/23.
//  Copyright (c) 2015年 hyrMac. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PhotoScrollView : UIScrollView <UIScrollViewDelegate>
{
    UIImageView *_imageView;
}

@property (nonatomic, retain) NSString *imageUrlStr;
@end
