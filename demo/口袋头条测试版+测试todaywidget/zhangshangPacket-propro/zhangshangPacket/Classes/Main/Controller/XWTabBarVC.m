//
//  XWTabBarVC.m
//  zhangshangnews
//
//  Created by apple on 2017/5/8.
//  Copyright © 2017年 apple-fangqiu. All rights reserved.
//

#import "XWTabBarVC.h"
#import "XWPacketVC.h"
#import "XWTaskListVC.h"
#import "XWMineVC.h"
#import "XWNavigationVC.h"
#import "XWController.h"
#import "XWHomeViewController.h"
#import "XWVideoVC.h"
#import "XWDiscoveryVC.h"

@interface XWTabBarVC ()
@property (nonatomic, strong) NSMutableArray *controllers;

@end

@implementation XWTabBarVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupChildControllers];
}
- (void)setupChildControllers {
    
    NSArray *VCArray = @[
                       @"XWHomeViewController",@"XWVideoVC",
                       @"XWDiscoveryVC",@"XWSearchVC",
                       @"XWPacketVC",@"XWMineVC"
                       ];
    NSArray *tabbarImgArr = @[
                              @"icon_home",@"icon_mov",@"icon_discovery",
                              @"icon_search",@"icon_missions",@"icon_user",
                              
                              ];
    
    NSArray *tabbarImgSelectArr = @[
                                    @"icon_home_fill",@"icon_mov_fill",
                                    @"icon_discovery_fill",@"icon_search_fill",
                                    @"icon_missions_fill",@"icon_user_fill",
                                    ];
    
    
    
//    [self.controllers addObject:[XWController initWithName:@"XWHomeViewController" title:@"首页" navigationTitle:@"" tabbarImage:@"icon_home" tabbarImageSelect:@"icon_home_fill"]];
//    [self.controllers addObject:[XWController initWithName:@"XWVideoVC" title:@"视频" navigationTitle:@"热门视频" tabbarImage:@"icon_mov" tabbarImageSelect:@"icon_mov_fill"]];
//    
//    [self.controllers addObject:[XWController initWithName:@"XWDiscoveryVC" title:@"发现" navigationTitle:@"发现" tabbarImage:@"icon_discovery" tabbarImageSelect:@"icon_discovery_fill"]];
//    
//    [self.controllers addObject:[XWController initWithName:@"XWSearchVC" title:@"热搜" navigationTitle:@"热门搜索" tabbarImage:@"icon_search" tabbarImageSelect:@"icon_search_fill"]];
//    
//    [self.controllers addObject:[XWController initWithName:@"XWPacketVC" title:@"任务" navigationTitle:@"任务" tabbarImage:@"icon_missions" tabbarImageSelect:@"icon_missions_fill"]];
//    
//    [self.controllers addObject:[XWController initWithName:@"XWMineVC" title:@"我的" navigationTitle:@"我的" tabbarImage:@"icon_user" tabbarImageSelect:@"icon_user_fill"]];
//    
    
    NSArray *bottomArr = STUserDefaults.bottomfuncID;
    
    JLLog(@"%@",STUserDefaults.bottomfunc);
    
    for (int i = 0; i< bottomArr.count; i++) {
        
        int j = [STUserDefaults.bottomfuncID[i] intValue] - 1;
        JLLog(@"i = %d\nj = %d",i,j);
        //12356
        id sender = [XWController initWithName:VCArray[j] title:STUserDefaults.bottomfunc[i] navigationTitle:STUserDefaults.bottomfunc[i] tabbarImage:tabbarImgArr[j] tabbarImageSelect:tabbarImgSelectArr[j]];
        [self.controllers addObject:sender];
        
//        [self.controllers addObject:[XWController initWithName:VCArray[i] title:STUserDefaults.bottomfunc[i] navigationTitle:STUserDefaults.bottomfunc[i] tabbarImage:tabbarImgArr[i] tabbarImageSelect:tabbarImgSelectArr[i]]];
    }
//        switch ([STUserDefaults.bottomfuncID[i] intValue]) {
//            case 1:
//                
//                [self.controllers addObject:[XWController initWithName:@"XWHomeViewController" title:@"首页" navigationTitle:@"" tabbarImage:@"icon_home" tabbarImageSelect:@"icon_home_fill"]];
//                
//                break;
//            case 2:
//                
//                [self.controllers addObject:[XWController initWithName:@"XWVideoVC" title:@"视频" navigationTitle:@"热门视频" tabbarImage:@"icon_mov" tabbarImageSelect:@"icon_mov_fill"]];
//                
//                break;
//            case 3:
//                
//                [self.controllers addObject:[XWController initWithName:@"XWDiscoveryVC" title:@"发现" navigationTitle:@"发现" tabbarImage:@"icon_discovery" tabbarImageSelect:@"icon_discovery_fill"]];
//                
//                break;
//            case 4:
//                
//                 [self.controllers addObject:[XWController initWithName:@"XWSearchVC" title:@"热搜" navigationTitle:@"热门搜索" tabbarImage:@"icon_search" tabbarImageSelect:@"icon_search_fill"]];
//                
//                break;
//            case 5:
//                
//                [self.controllers addObject:[XWController initWithName:@"XWPacketVC" title:@"任务" navigationTitle:@"任务" tabbarImage:@"icon_missions" tabbarImageSelect:@"icon_missions_fill"]];
//                
//                break;
//            case 6:
//                
//                [self.controllers addObject:[XWController initWithName:@"XWMineVC" title:@"我的" navigationTitle:@"我的" tabbarImage:@"icon_user" tabbarImageSelect:@"icon_user_fill"]];
//                
//                break;
//            default:
//                
//                break;
//        }
    
//    }
    
    [self.controllers enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [self setupChildControllerWithModel:(XWController *)obj];
    }];
    
    self.selectedIndex = 0;
    
    self.tabBar.dk_backgroundColorPicker = DKColorPickerWithColors(WhiteColor,BlackColor,MainRedColor);
    self.tabBar.dk_tintColorPicker = DKColorPickerWithColors(MainRedColor,MainRedColor,MainRedColor);
    self.tabBar.dk_barTintColorPicker = DKColorPickerWithColors(WhiteColor,WhiteColor,MainRedColor);
    
    [self.tabBar setBackgroundImage:[XWCommonFunction createImageWithColor:WhiteColor]];
    [self.tabBar setShadowImage:[XWCommonFunction createImageWithColor:WhiteColor]];
    
    CGRect rect = CGRectMake(0, 0, ScreenW, ScreenH);
    
    UIGraphicsBeginImageContext(rect.size);
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [[UIColor clearColor] CGColor]);
    
    CGContextFillRect(context, rect);
    
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    [self.tabBar setBackgroundImage:img];
    
    [self.tabBar setShadowImage:img];
    
    
    
}

- (void)setupChildControllerWithModel:(XWController *)mcontroller {
    
    UIViewController *controller = [[NSClassFromString(mcontroller.className) alloc] init];
    
    controller.title = mcontroller.classTitle;
    controller.navigationItem.title = mcontroller.navigationTitle;
    controller.tabBarItem.image = [UIImage imageNamedWithRenderOriginal:mcontroller.tabbarImage];
    controller.tabBarItem.selectedImage = [[UIImage imageNamed:mcontroller.tabbarImageSelect] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    XWNavigationVC *naV = [[XWNavigationVC alloc] initWithRootViewController:controller];
    [self addChildViewController:naV];
    
}
#pragma mark get
- (NSMutableArray *)controllers {
    if (!_controllers) {
        _controllers = [[NSMutableArray alloc] initWithCapacity:0];
    }
    return _controllers;
}

/**
 *  更改状态栏颜色
 */
- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

- (void)dealloc
{
    JLLog(@"dealloc");
}

@end
