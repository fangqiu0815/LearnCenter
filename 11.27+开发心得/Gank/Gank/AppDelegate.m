//
//  AppDelegate.m
//  Gank
//
//  Created by 谢培艺 on 2017/2/27.
//  Copyright © 2017年 CoderKo1o. All rights reserved.
//

#import "AppDelegate.h"
#import "PYHomeViewController.h"
#import <SDWebImage/SDImageCache.h>
#import <SDWebImage/SDWebImageManager.h>
#import "YQSlideMenuController.h"
#import "UIColor+PYExtension.h"
#import <UMSocialCore/UMSocialCore.h>
#import <AFNetworking/AFHTTPSessionManager.h>
#import "PYMenuViewController.h"
#import "PYLaunchVideoController.h"
#import <MediaPlayer/MPMoviePlayerController.h>

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    if (self.window == nil) {
        self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    }
    
    // 设置状态栏颜色为白色
    [application setStatusBarStyle:UIStatusBarStyleLightContent];
    
    // 播放视频
    PYLaunchVideoController *videoVC = [[PYLaunchVideoController alloc] init];
    self.window.rootViewController = videoVC;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(moviePlaybackComplete) name:MPMoviePlayerPlaybackDidFinishNotification object:nil];
    
    [self.window makeKeyAndVisible];
    
    // 设置友盟分享
    [self setupUMShare];
    
    return YES;
}

- (void)moviePlaybackComplete
{
    // 设置主要控制器
    PYHomeViewController *contentViewController = [[PYHomeViewController alloc] init];
    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:contentViewController];
    UIViewController *leftMenuViewController = [[PYMenuViewController alloc] init];
    YQSlideMenuController *sideMenuController = [[YQSlideMenuController alloc] initWithContentViewController:navigationController leftMenuViewController:leftMenuViewController];
    contentViewController.sideMenuController = sideMenuController;
    sideMenuController.delegate = contentViewController;
    self.window.rootViewController = sideMenuController;
}

- (void)setupUMShare
{
    
    //设置友盟appkey
    [[UMSocialManager defaultManager] setUmSocialAppkey:@"58b6858182b6357f460006dd"];
    
    //设置微信的appKey和appSecret
    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_WechatSession appKey:@"wx6679eb2079ee1984" appSecret:nil redirectURL:@"http://gank.io/"];
    
    //设置分享到QQ互联的appKey和appSecret
    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_QQ appKey:@"1105940735"  appSecret:nil redirectURL:@"http://gank.io/"];
    
    //设置新浪的appKey和appSecret
    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_Sina appKey:@"2335598832"  appSecret:@"7b86a3b25db004efc57097d6ab397e42" redirectURL:@"http://gank.io/"];
}

- (void)applicationDidReceiveMemoryWarning:(UIApplication *)application
{
    [[SDImageCache sharedImageCache] clearMemory];
    [[SDWebImageManager sharedManager] cancelAll];
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
