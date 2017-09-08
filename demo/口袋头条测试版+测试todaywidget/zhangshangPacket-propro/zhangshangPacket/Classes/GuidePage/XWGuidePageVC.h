//
//  XWGuidePageVC.h
//  zhangshangPacket
//
//  Created by apple on 2017/5/11.
//  Copyright © 2017年 apple-fangqiu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XWNavigationVC.h"
#import "XWTabBarVC.h"
#import "XWLoginVC.h"
@interface XWGuidePageVC : UINavigationController

@property(nonatomic, strong)XWNavigationVC *navigationC;

@property(nonatomic, strong)XWTabBarVC *tabBarVC;
//获取根视图
-(UIViewController *)getTheRootController;

@property (nonatomic, strong) XWLoginVC *loginVC;

@end
