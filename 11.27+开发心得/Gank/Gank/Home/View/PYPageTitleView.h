//
//  PYPageTitleView.h
//  PopTest
//
//  Created by 谢培艺 on 2017/2/27.
//  Copyright © 2017年 CoderKo1o. All rights reserved.
//

#import <UIKit/UIKit.h>

#define PYPageTitleCount 7

@interface PYPageTitleView : UIView

@property (nonatomic, weak) UIImageView *pageTitleImageView;
- (void)touchEnd:(NSInteger)index;

@end
