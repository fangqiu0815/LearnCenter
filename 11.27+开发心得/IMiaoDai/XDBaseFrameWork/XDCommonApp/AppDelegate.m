//
//  AppDelegate.m
//  XDCommonApp
//
//  Created by XD-XY on 2/12/14.
//  Copyright (c) 2014 XD-XY. All rights reserved.
//

#import "AppDelegate.h"
#import "XDHeader.h"
#import "XDTools.h"
#import "GuideViewController.h"
//#import "WBParams.h"
#import "MyOrdersViewController.h"
#import "MyBillsViewController.h"

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.

    if (![[[NSUserDefaults standardUserDefaults] objectForKey:ISFIRST] isEqualToString:@"YES"]) {
        NSString * uuid = [self uuid];
        NSUserDefaults * user = [NSUserDefaults standardUserDefaults];
        [user setObject:uuid forKey:MYUUID];
        [user setObject:@"YES" forKey:ISFIRST];
        [user synchronize];
    }
    
    if (GUIDECOUNT==0||[[NSUserDefaults standardUserDefaults] objectForKey:ISFIRSTSTART]){
        self.tabBarController = [XDTabBarViewController sharedXDTabBarViewController];
        self.rootNav = [[UINavigationController alloc] initWithRootViewController:_tabBarController];
        _rootNav.navigationBarHidden=YES;
    }
    
    if (GUIDECOUNT!=0){
        if (![[NSUserDefaults standardUserDefaults] objectForKey:ISFIRSTSTART]){
            SETSTATUSBARHIDDEN(YES);
            GuideViewController * guideView = [[GuideViewController alloc] init];
            self.window.rootViewController = guideView;
        }else{
            SETSTATUSBARHIDDEN(NO);
            self.window.rootViewController = _rootNav;
        }
    }else{
        SETSTATUSBARHIDDEN(NO);
        self.window.rootViewController = _rootNav;
    }
    
    //微博
//    [WeiboSDK enableDebugMode:YES];
//    [WeiboSDK registerApp:kAppKey];
    
    //设置友盟统计 start
    
    //设置友盟统计 end


    
//    //极光推送   uid
//    [APService registerForRemoteNotificationTypes:(UIRemoteNotificationTypeBadge|UIRemoteNotificationTypeSound|UIRemoteNotificationTypeAlert)];
//    [APService setupWithOption:launchOptions];
    if ([[NSUserDefaults standardUserDefaults] valueForKey:kMMyUserInfo]){
        //登录成功状态
        NSString * uid = [[[NSUserDefaults standardUserDefaults] objectForKey:kMMyUserInfo] objectForKey:@"uid"];
        NSString * overdue = [[[NSUserDefaults standardUserDefaults] objectForKey:kMMyUserInfo] objectForKey:@"overdue"];
        NSString * string = [NSString stringWithFormat:@"%@",uid];
//        [APService setTags:[NSSet setWithObject:[NSString stringWithFormat:@"%@",string]] callbackSelector:nil object:nil];
        if ([overdue isEqualToString:@"1"]){
            [XDTools setPushInfoType:@"2" andValue:@"1"];
        }
    }else{
//        //登录失败状态
//        [APService setTags:[NSSet setWithObject:@""] callbackSelector:nil object:nil];
    }

    [XDTools moveFileToDocument:@"area" andType:@"db"];
    
    
    if ((![XDTools getPushValueWithType:@"1"])&&
        (![XDTools getPushValueWithType:@"2"])&&
        (![XDTools getPushValueWithType:@"3"])&&
        (![XDTools getPushValueWithType:@"4"])){
        [XDTabBarViewController sharedXDTabBarViewController].reminder_IV.hidden = YES;
    }else{
        [XDTabBarViewController sharedXDTabBarViewController].reminder_IV.hidden = NO;

    }
    
    
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    return YES;
}

- (NSString *) uuid {

    CFUUIDRef puuid = CFUUIDCreate( kCFAllocatorSystemDefault );

    CFStringRef uuidString = CFUUIDCreateString(nil, puuid);

    NSString * result = (NSString *)CFBridgingRelease(CFStringCreateCopy(NULL, uuidString));

    CFRelease(puuid);

    CFRelease(uuidString);

    return result;
    
}



- (void)reSetRootView{
    SETSTATUSBARHIDDEN(NO);
    self.tabBarController = [XDTabBarViewController sharedXDTabBarViewController];
    self.rootNav = [[UINavigationController alloc] initWithRootViewController:_tabBarController];
    _rootNav.navigationBarHidden=YES;
    self.window.rootViewController = _rootNav;
}

-(void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken
{
    //jpush 2
//    [APService registerDeviceToken:deviceToken];
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo
{
//    [APService handleRemoteNotification:userInfo];
    if (application.applicationState ==UIApplicationStateInactive ){
        //用户从后台进入
        [XDTools setPushInfoType:[userInfo valueForKey:@"type"] andValue:@"0"];
        [self chooseDifferentVC:userInfo];
    }else if (application.applicationState ==UIApplicationStateActive){
        //用户一直活跃在前台
        
        if ([userInfo valueForKey:@"type"]){
            [XDTools setPushInfoType:[userInfo valueForKey:@"type"] andValue:@"1"];
            [XDTabBarViewController sharedXDTabBarViewController].reminder_IV.hidden = NO;
            NSNotificationCenter * center = [NSNotificationCenter defaultCenter];
            [center postNotificationName:@"pushNotificationName" object:nil userInfo:nil];
        }
        
        
    }
        
    
     [UIApplication sharedApplication].applicationIconBadgeNumber = 0;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
     [UIApplication sharedApplication].applicationIconBadgeNumber = 0;
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
     [UIApplication sharedApplication].applicationIconBadgeNumber = 0;
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
     [UIApplication sharedApplication].applicationIconBadgeNumber = 0;
    if ([[[NSUserDefaults standardUserDefaults] valueForKey:@"mustupdate"] intValue]==1){
        dictVision = [[NSDictionary alloc] initWithDictionary:[[NSUserDefaults standardUserDefaults] valueForKey:@"versioninfo"]];
        UIAlertView *al = [[UIAlertView alloc] initWithTitle:@"提示" message:[dictVision valueForKey:@"content"] delegate:self cancelButtonTitle:@"立即更新" otherButtonTitles:nil, nil];
        al.tag = 1000;
        [al show];
        
    }
    
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (alertView.tag == 1000){
        if (buttonIndex == 0) {
            NSURL *url = [NSURL URLWithString:[dictVision valueForKey:@"url"]];
            [[UIApplication sharedApplication] openURL:url];
            
        }
    }
    
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

#pragma mark
#pragma mark -进入前端跳转到不同页面
-(void)chooseDifferentVC:(NSDictionary *)userInfo
{
    if ([userInfo valueForKey:@"type"]){
        //特定推送
        int type = [[userInfo valueForKey:@"type"] intValue];
        switch (type) {
            case 1:             //还款提醒
            {   //跳转我的账单
                //“我的”tab显示红点，"我的账单"显示红点
        
                MyBillsViewController * billVC = [[MyBillsViewController alloc] init];
                [_rootNav.navigationController pushViewController:billVC animated:YES];
            }
                break;
            case 2:             //逾期提醒
            {
                //跳转我的账单 “我的账单”显示“逾期”红底文字 “我的账单”显示红点
                
                MyBillsViewController * billVC = [[MyBillsViewController alloc] init];
                [_rootNav.navigationController pushViewController:billVC animated:YES];
            }
                break;
            case 3:             //签收提醒
            {   //跳转我的订单 “我的订单”显示红点
                
                MyOrdersViewController * ordersVC = [[MyOrdersViewController alloc] init];
                [_rootNav.navigationController pushViewController:ordersVC animated:YES];
            }
                break;
            case 4:             //审核结果
            {   //跳转我的订单
                //进入“我的订单”页面，“我的”+1，“我的订单”显示红点
                
                MyOrdersViewController * ordersVC = [[MyOrdersViewController alloc] init];
                [_rootNav.navigationController pushViewController:ordersVC animated:YES];
            }
                break;
            default:
                break;
        }
    }else{
        //广播
    }
}


@end
