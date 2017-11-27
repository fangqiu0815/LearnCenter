//
//  XDTabBarViewController.h
//  XDCommonApp
//
//  Created by XD-XY on 2/13/14.
//  Copyright (c) 2014 XD-XY. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XDHeader.h"
@interface XDTabBarViewController : UITabBarController<UITabBarControllerDelegate>

@property (nonatomic,strong)UIView * bgView;
@property (nonatomic,assign)NSInteger beforeIndex;
@property (nonatomic,assign)NSInteger presentIndex;
@property (nonatomic,strong)UIImageView * reminder_IV;

-(void)confirmSelectTabBar:(NSInteger)seder;

DEFINE_SINGLETON_FOR_HEADER(XDTabBarViewController);

@end
