//
//  GuideViewController.h
//  HWMovie
//
//  Created by hyrMac on 15/7/27.
//  Copyright (c) 2015年 hyrMac. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GuideViewController : UIViewController <UIScrollViewDelegate>
@property (weak, nonatomic) IBOutlet UIScrollView *guideScrollView;
@property (weak, nonatomic) IBOutlet UIButton *enterButton;

- (IBAction)btnAction:(id)sender;

@end
