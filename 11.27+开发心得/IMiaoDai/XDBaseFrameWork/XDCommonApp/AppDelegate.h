//
//  AppDelegate.h
//  XDCommonApp
//
//  Created by XD-XY on 2/12/14.
//  Copyright (c) 2014 XD-XY. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XDTabBarViewController.h"

#define kAppKey         @"542501033"

@interface AppDelegate : UIResponder <UIApplicationDelegate,UIAlertViewDelegate>
{
    NSDictionary * dictVision;
}
@property (strong, nonatomic) UIWindow *window;
@property (nonatomic,strong)XDTabBarViewController * tabBarController;
@property (nonatomic,strong)UINavigationController * rootNav;
-(void)reSetRootView;
@end
