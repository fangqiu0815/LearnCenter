//
//  HWButton.h
//  HWMovie
//
//  Created by hyrMac on 15/7/17.
//  Copyright (c) 2015年 hyrMac. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HWButton : UIControl {
    UIImageView *_imgView;
    UILabel *_label;
}

- (instancetype)initWithFrame:(CGRect)frame withImgName:(NSString *)imgName withTitle:(NSString *)title;

@end
