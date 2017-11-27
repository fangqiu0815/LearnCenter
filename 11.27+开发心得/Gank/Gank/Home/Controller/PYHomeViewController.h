//
//  PYHomeViewController.h
//  Gank
//
//  Created by 谢培艺 on 2017/2/27.
//  Copyright © 2017年 CoderKo1o. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YQSlideMenuController.h"

@interface PYHomeViewController : UIViewController <YQContentViewControllerDelegate>


@property (nonatomic, weak) YQSlideMenuController *sideMenuController;

@end
