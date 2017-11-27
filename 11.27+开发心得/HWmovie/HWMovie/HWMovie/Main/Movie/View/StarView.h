//
//  StarView.h
//  HWMovie
//
//  Created by hyrMac on 15/7/21.
//  Copyright (c) 2015年 hyrMac. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface StarView : UIView
{
    UIView *_grayView;
    UIView *_yellowView;
}

@property (nonatomic,assign) float average;
@end
