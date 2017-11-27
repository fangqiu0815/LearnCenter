//
//  AppDelegate.m
//  Weibo11
//
//  Created by 刘凡 on 15/12/5.
//  Copyright © 2015年 itheima. All rights reserved.
//

#import "AppDelegate.h"
#import <AFNetworkActivityIndicatorManager.h>
#import "HMMainViewController.h"
#import "HMNewFeatureViewController.h"
#import "HMWelcomeViewController.h"
#import "HMOAuthViewController.h"
#import "HMUserAccount.h"

#import "HMEmoticonManager.h"

/// 切换控制器通知
NSString *const HMSwitchRootViewControllerNotification = @"HMSwitchRootViewControllerNotification";

@interface AppDelegate ()
/// 通知监听对象
@property (nonatomic, strong) id observer;
@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    [self setupDDLog];
    [self setupAFNetworking];
    
    NSLog(@"test tracking");
    
    [HMEmoticonManager sharedManager];
    
    // 加载保存的用户账户
    DDLogVerbose(@"%@", [HMUserAccountViewModel sharedUserAccount].userAccount);
    
    // 设置根视图控制器
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = [UIColor whiteColor];
    
    self.window.rootViewController = [self defaultRootViewController];
    
    [self.window makeKeyAndVisible];
    
    // 监听控制器监听通知
    /**
     参数 1: 监听的通知字符串
     参数 2: 监听发送通知的对象
     参数 3: 表示执行任务所在的线程
            如果为 nil，会在发送通知所在的线程执行 block 方法
     参数 4: 接收到通知后要执行的 block
     
     注意：如果 block 中有 self，会产生循环引用
     */
    __weak typeof(self) weakSelf = self;
    self.observer = [[NSNotificationCenter defaultCenter] addObserverForName:HMSwitchRootViewControllerNotification object:nil queue:nil usingBlock:^(NSNotification * _Nonnull note) {
        
        DDLogInfo(@"切换控制器 %@", note.object);
        // 如果通知的 object 不为空，加载欢迎界面
        // 否在加载主页面
        NSString *clsName = ([note.object isKindOfClass:[HMOAuthViewController class]]) ? @"HMWelcomeViewController" : @"HMMainViewController";
        Class cls = NSClassFromString(clsName);
        
        weakSelf.window.rootViewController = [[cls alloc] init];
    }];
    return YES;
}

- (void)dealloc {
    // 注销通知
    [[NSNotificationCenter defaultCenter] removeObserver:self.observer];
}

/// 默认根控制器
///
/// @return 系统启动的默认根控制器
- (UIViewController *)defaultRootViewController {
    
    // 判断用户是否登录
    if ([HMUserAccountViewModel sharedUserAccount].isLogon) {
        
        // 判断是否有新版本
        if ([self isNewVersion]) {
            return [[HMNewFeatureViewController alloc] init];
        } else {
            return [[HMWelcomeViewController alloc] init];
        }
    }
    
    // 如果没有登录，直接进入 MainViewController 登录
    return [[HMMainViewController alloc] init];
}

/// 检查新版本
- (BOOL)isNewVersion {

    // 1. 取出当前版本
    NSString *currentVersion = [NSBundle mainBundle].infoDictionary[@"CFBundleShortVersionString"];
    
    // 2. 取出沙盒版本
    NSString *sandboxVersionKey = @"HM_SandboxVersionKey";
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    NSString *sandboxVersion = [defaults stringForKey:sandboxVersionKey];
    
    // 3. 将当前版本保存至用户偏好
    [defaults setObject:currentVersion forKey:sandboxVersionKey];
    
    return [currentVersion compare:sandboxVersion] == NSOrderedDescending;
}

/// 设置 DDLog
- (void)setupDDLog {
    // 设置 DDLog
    setenv("XcodeColors", "YES", 0);
    
    // 添加 Logger
    [DDLog addLogger:[DDTTYLogger sharedInstance]];
    
    // 设置颜色
    [[DDTTYLogger sharedInstance] setColorsEnabled:YES];
    [[DDTTYLogger sharedInstance] setForegroundColor:[UIColor blueColor] backgroundColor:nil forFlag:DDLogFlagInfo];
    [[DDTTYLogger sharedInstance] setForegroundColor:[UIColor darkGrayColor] backgroundColor:nil forFlag:DDLogFlagVerbose];
}

/// 设置 AFNetworking
- (void)setupAFNetworking {

    // 启用状态栏指示器
    [AFNetworkActivityIndicatorManager sharedManager].enabled = YES;
    
    // 设置缓存
    [NSURLCache setSharedURLCache:[[NSURLCache alloc] initWithMemoryCapacity:4 * 1024 * 1024 diskCapacity:20 * 1024 * 1024 diskPath:nil]];
}

@end
