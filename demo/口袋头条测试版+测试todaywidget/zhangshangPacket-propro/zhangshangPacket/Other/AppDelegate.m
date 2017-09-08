//
//  AppDelegate.m
//  zhangshangPacket
//
//  Created by apple on 2017/5/11.
//  Copyright © 2017年 apple-fangqiu. All rights reserved.
//

#import "AppDelegate.h"
#import <CoreLocation/CoreLocation.h>
#import "XWADVC.h"
#import <UMSocialCore/UMSocialCore.h>
#import "LoginModel.h"
#import "XWGuidePageVC.h"
#import "XWLoginVC.h"
//微信SDK头文件
#import "WXApi.h"
#import "XWWKWebTodayVC.h"
#import "XWIncomeDetailInfoModel.h"
#import "XWIncomeDetailListTool.h"
#import "XWHomeDetailVC.h"
#import "WKWebViewController.h"
#import "XWHomeViewController.h"
// 引入JPush功能所需头文件
#import "JPUSHService.h"
// iOS10注册APNs所需头文件
#ifdef NSFoundationVersionNumber_iOS_9_x_Max
#import <UserNotifications/UserNotifications.h>
#endif
// 如果需要使用idfa功能所需要引入的头文件（可选）
#import <AdSupport/AdSupport.h>
// 如果需要使用idfa功能所需要引入的头文件（可选）
#import <AdSupport/AdSupport.h>

//商户ID
#define WXDevelopmentMCHID @"1357131402"

//f653f408ab90781bfb2e23f902de8e3a ==== 友盟账号
#define USHARE_DEMO_APPKEY @"5941f2eacae7e713c5000fe8"

//极光账号
#define JPushID @"86ce9b680a809de3c984c1d0"

#pragma mark ================== 最新微信登录数据 ==================
/**
 AppID：wxb54923cd169dd6e0
 45729bb1e73892390754c0f4cbe1bd5b
 **/
#import "JPFPSStatus.h"


@interface AppDelegate ()<CLLocationManagerDelegate,UITabBarControllerDelegate,JPUSHRegisterDelegate>

{
    CLLocationManager *locationManager;
    NSString *currentCity;
    NSString *StrLatitude;
    NSString *StrLongitude;
    /**
     * 是否更新明细描述信息
     */
    BOOL isUpdateSysDetailConfig;
    /**
     * 是否更新系统任务
     */
    BOOL isUpdateSysTask;
    /**
     * 是否更新转盘数据
     */
    BOOL isUpdateSysWheelInfo;
    
}

@property (nonatomic, strong) NSMutableArray *infoArr;

@property (nonatomic, strong) XWTabBarVC *tabbarVC;
@property (nonatomic, strong) XWNavigationVC *mainNaviVC;
@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    //判断是否首次打开
    [self FirstOpen];

    //键盘  展示
    [self IQKeyBoard_info];
    //分享  信息
    [self shareInfo];
    //系统配置信息
    [self sysConfigInfo];
    
    //获取用户 经纬度
    [self loadUserJWDu];

    //开心转转乐
    [self sysHappyTurnDataInfo];
    
    //反馈问题类型数据
    [self feedMatterTypeInfo];
    
    
    //极光推送
    // Required
    // init Push
    // notice: 2.1.5版本的SDK新增的注册方法，改成可上报IDFA，如果没有使用IDFA直接传nil
    // 如需继续使用pushConfig.plist文件声明appKey等配置内容，请依旧使用[JPUSHService setupWithOption:launchOptions]方式初始化。
    //notice: 3.0.0及以后版本注册可以这样写，也可以继续用之前的注册方式
    JPUSHRegisterEntity * entity = [[JPUSHRegisterEntity alloc] init];
    entity.types = JPAuthorizationOptionAlert|JPAuthorizationOptionBadge|JPAuthorizationOptionSound;
    if ([[UIDevice currentDevice].systemVersion floatValue] >= 8.0) {
        // 可以添加自定义categories
        // NSSet<UNNotificationCategory *> *categories for iOS10 or later
        // NSSet<UIUserNotificationCategory *> *categories for iOS8 and iOS9
    }
    [JPUSHService registerForRemoteNotificationConfig:entity delegate:self];
    
    // Optional
    // 获取IDFA
    // 如需使用IDFA功能请添加此代码并在初始化方法的advertisingIdentifier参数中填写对应值
    NSString *advertisingId = [[[ASIdentifierManager sharedManager] advertisingIdentifier] UUIDString];
    
    // Required
    // init Push
    // notice: 2.1.5版本的SDK新增的注册方法，改成可上报IDFA，如果没有使用IDFA直接传nil
    // 如需继续使用pushConfig.plist文件声明appKey等配置内容，请依旧使用[JPUSHService setupWithOption:launchOptions]方式初始化。

    [JPUSHService setupWithOption:launchOptions appKey:JPushID
                          channel:@"App Store"
                 apsForProduction:YES
            advertisingIdentifier:advertisingId];

    
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
    
//    //首页内容刷新
//    UITabBarController *tabBarController = (UITabBarController *)self.window.rootViewController;
//    tabBarController.delegate = self;
    
    //延迟1.5s执行
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self sendNotification:launchOptions];
    });
    
#if defined(DEBUG)||defined(_DEBUG)
    [[JPFPSStatus sharedInstance] open];
#endif
    
    return YES;
}

- (void)sendNotification:(NSDictionary *)launchOptions
{
    if (launchOptions) {
        NSDictionary *remote = [launchOptions objectForKey:UIApplicationLaunchOptionsRemoteNotificationKey];
        if (remote) {
            [self pushToViewControllerWhenClickPushMessageWith:remote];
        } else {
            [[UIApplication sharedApplication] setApplicationIconBadgeNumber:0];
        }
    }

}


- (void)FirstOpen
{
    if(![[NSUserDefaults standardUserDefaults] boolForKey:@"firstLaunch"]){
        JLLog(@"第一次");
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"firstLaunch"];
        [[NSUserDefaults standardUserDefaults] setObject:@"1" forKey:@"IsFirestOpen"];
    }else{
        //不是第一次启动了
        JLLog(@"不是第一次");
        [[NSUserDefaults standardUserDefaults] setObject:@"0" forKey:@"IsFirestOpen"];
        
    }

}


#pragma mark - UITabBarControllerDelegate

- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController
{
    [[NSNotificationCenter defaultCenter] postNotificationName:@"TabRefresh" object:nil userInfo:nil];
}

- (void)windowInfo
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]] ;
    self.window.backgroundColor = MainBGColor;
//    if (STUserDefaults.ischeck == 1) {
//        self.window.rootViewController = [XWTabBarVC new];
//
//    } else {
        self.window.rootViewController = [XWADVC new];

//    }
    
    [self.window makeKeyAndVisible];

}


- (void)loadPaomaData
{
    [STRequest SysPersonConverDataWithDataBlock:^(id ServersData, BOOL isSuccess) {
        JLLog(@"ServersData---%@",ServersData);
        if (isSuccess) {
            if ([ServersData isKindOfClass:[NSDictionary class]]) {
                NSString *cStr = [NSString stringWithFormat:@"%@",ServersData[@"c"]];
                
                if ([cStr isEqualToString:@"1"]) {
                    
                    NSDictionary *dicttemp = [NSDictionary dictionaryWithDictionary:ServersData[@"d"]];
                    if ([dicttemp[@"taskinfo"] count] == 0) {
                        JLLog(@"无当前提现公告信息");
                    } else {
                        if ([dicttemp[@"taskinfo"] count] == 0) {
                            JLLog(@"系统提现信息为空");

                        } else {
                            STUserDefaults.adArr = dicttemp[@"taskinfo"];

                        }
                        

                    }
                } else {
                    [SVProgressHUD showErrorWithStatus:ServersData[@"m"]];
                    
                }
            } else {
                [SVProgressHUD showErrorWithStatus:@"服务器错误"];
            }
        } else {
            [SVProgressHUD showErrorWithStatus:@"网络错误！"];
            
        }
    }];
    
}


#pragma mark ================== 键盘信息 ==================
- (void)IQKeyBoard_info
{
    IQKeyboardManager *manager = [IQKeyboardManager sharedManager];
    manager.enable = YES;
    manager.shouldResignOnTouchOutside = YES;
    manager.shouldToolbarUsesTextFieldTintColor = YES;
    manager.enableAutoToolbar = NO;
}

#pragma mark ================== 分享信息 ==================
- (void)shareInfo
{
    /* 打开调试日志 */
    [[UMSocialManager defaultManager] openLog:YES];
    
    /* 设置友盟appkey */
    [[UMSocialManager defaultManager] setUmSocialAppkey:USHARE_DEMO_APPKEY];
    
    [self configUSharePlatforms];
    
    [self confitUShareSettings];
}

//- (void)getPersonInfoData
//{
//    [[NSNotificationCenter defaultCenter] postNotificationName:@"getPersonData" object:nil];
//}


- (void)confitUShareSettings
{
    /*
     * 打开图片水印
     */
    //[UMSocialGlobal shareInstance].isUsingWaterMark = YES;
    
    /*
     * 关闭强制验证https，可允许http图片分享，但需要在info.plist设置安全域名
     <key>NSAppTransportSecurity</key>
     <dict>
     <key>NSAllowsArbitraryLoads</key>
     <true/>
     </dict>
     */
    //[UMSocialGlobal shareInstance].isUsingHttpsWhenShareContent = NO;
    
}

- (void)configUSharePlatforms
{
    /* 设置微信的appKey和appSecret */
    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_WechatSession appKey:WXDevelopmentAppKey appSecret:WXDevelopmentAppSecret redirectURL:nil];
    /*
     * 移除相应平台的分享，如微信收藏
     */
    //[[UMSocialManager defaultManager] removePlatformProviderWithPlatformTypes:@[@(UMSocialPlatformType_WechatFavorite)]];
    
    
}


#pragma mark ================== 登录信息  ==================

//- (void)login
//{
//    XWLoginVC *loginVC = [[XWLoginVC alloc]init];
//    self.window.rootViewController = loginVC;
//    [SVProgressHUD showWithStatus:@"正在获取用户信息，请稍后" maskType:SVProgressHUDMaskTypeClear];
//    [ShareSDK getUserInfo:SSDKPlatformTypeWechat
//           onStateChanged:^(SSDKResponseState state, SSDKUser *user, NSError *error)
//     {
//         
//         if (state == SSDKResponseStateSuccess)
//         {
//             NSString *unionid = [user.rawData objectForKey:@"unionid"];
//             NSString *nickname = user.nickname;
//             NSString *userImage = user.icon;
//             NSString *openid = [user.rawData objectForKey:@"openid"];
//             NSString *osversion = DeviceInfo_shared->getOSVersion();
//             NSString *devicetype = DeviceInfo_shared->getDeviceType();
//             NSString *yueyu = DeviceInfo_shared->getYueYuState();
//             NSString *phonecard = DeviceInfo_shared->getCardState();
//             //用户APP渠道  iOS 为 120
//             NSInteger channel = 121;
//             
//             NSDictionary *param = @{@"unionid":unionid,
//                                     @"img":userImage,
//                                     @"nickname":nickname,
//                                     @"openid":openid,
//                                     @"yueyu":yueyu,
//                                     @"phonecard":phonecard,
//                                     @"osversion":osversion,
//                                     @"devicetype":devicetype,
//                                     @"channel":@(channel)
//                                     };
//             NSLog(@"%@---%@---%ld",unionid,openid,(long)channel);
//             
//             [STRequest LoginWithParams:param WithDataBlock:^(id ServersData, BOOL isSuccess) {
//                 LoginModel *dataModel = [LoginModel mj_objectWithKeyValues:ServersData];
//                 NSLog(@"%@",ServersData);
//                 if (dataModel.c == 1)
//                 {
//                     STUserDefaults.isLogin = YES;
//                     STUserDefaults.uid = dataModel.d.user.uid;
//                     STUserDefaults.img = dataModel.d.user.img;
//                     STUserDefaults.token = dataModel.d.user.token;
//                     STUserDefaults.name = dataModel.d.user.name;
//                     STUserDefaults.signstate = dataModel.d.user.signstate;
//                     dataModel.d.user.channel = 120;
//                     STUserDefaults.channel = [NSString stringWithFormat:@"%ld",(long)dataModel.d.user.channel];
//                     
//                     if ([self isBlankString:dataModel.d.user.phonenum]) {
//                         //注册
//                         [self createPhoneNumData];
//                     }
//                     else
//                     {
//                         STUserDefaults.phonenum = dataModel.d.user.phonenum;
//                     }
//                     
//                     [[NSNotificationCenter defaultCenter] postNotificationName:@"reloadMessage" object:nil];
//                     
//                     
//                     [SVProgressHUD showSuccessWithStatus:@"登录成功"];
//                 }else
//                 {
//                     [SVProgressHUD showErrorWithStatus:dataModel.m];
//                 }
//             }];
//             
//         }
//         
//         else
//         {
//             [SVProgressHUD showErrorWithStatus:@"取消登录"];
//             
//             MyLog(@"%@",error.description);
//         }
//         
//     }];
//
//}

#pragma mark ================== 得到用户信息 ==================
- (void)getInfo
{
    NSString *osversion = DeviceInfo_shared->getOSVersion();
    NSString *devicetype = DeviceInfo_shared->getDeviceType();
    NSString *yueyu = DeviceInfo_shared->getYueYuState();
    NSString *phonecard = DeviceInfo_shared->getCardState();
    
    NSDictionary *param = @{
                            @"yueyu":yueyu,
                            @"phonecard":phonecard,
                            @"osversion":osversion,
                            @"devicetype":devicetype
                            };
    
    JLLog(@"yueyu---%@\nphonecard---%@\nosversion---%@\ndevicetype---%@",yueyu,phonecard,osversion,devicetype);
    
    [STRequest downLoadUserDataTwoWithDict:param WithBlock:^(id ServersData, BOOL isSuccess) {
        STUserDefaults.isLogin = YES;
        if (isSuccess){
            JLLog(@"getinfo----%@",ServersData);
            if ([ServersData isKindOfClass:[NSDictionary class]]) {
                if ([ServersData[@"c"] intValue] == 1) {
                    NSDictionary *dictemp = [NSDictionary dictionaryWithDictionary:ServersData[@"d"]];
                    NSString *uid = [NSString stringWithFormat:@"%@",dictemp[@"uid"]];
                    // NSString *userName=[NSString stringWithFormat:@"%@",dictemp[@"name"]];
//                    NSString *usericon = [NSString stringWithFormat:@"%@",dictemp[@"img"]];
//                    NSString *username = [NSString stringWithFormat:@"%@",dictemp[@"name"]];
                    /*
                     
                     cash = 30;
                     cashconver = 0;
                     cashtoday = 0;
                     cashtotal = 30;
                     cashyes = 130;
                     disciple = 0;
                     disciplefee = 0;
                     ingot = 120;
                     isreward = 0;
                     isshare = 0;
                     issign = 1;
                     phonenum = 18559626098;
                     tasknum = 0;
                     token = 1e2cb207d1b227a44481d876b166a0ff;
                     uid = 91;
                     */
                    
                    NSString *userName = [NSString stringWithFormat:@"%@",dictemp[@"name"]];
                    NSString *userImg = [NSString stringWithFormat:@"%@",dictemp[@"img"]];
                    
                    NSString *phoneNum = [NSString stringWithFormat:@"%@",dictemp[@"phonenum"]];
                    NSString *token = [NSString stringWithFormat:@"%@",dictemp[@"token"]];
                    NSString *cash = [NSString stringWithFormat:@"%@",dictemp[@"cash"]];
                    NSString *cashyes = [NSString stringWithFormat:@"%@",dictemp[@"cashyes"]];
                    NSString *cashtoday = [NSString stringWithFormat:@"%@",dictemp[@"cashtoday"]];
                    NSString *cashconver = [NSString stringWithFormat:@"%@",dictemp[@"cashconver"]];
                    NSString *cashtotal = [NSString stringWithFormat:@"%@",dictemp[@"cashtotal"]];
                    NSString *ingot = [NSString stringWithFormat:@"%@",dictemp[@"ingot"]];
                    NSString *isshare = [NSString stringWithFormat:@"%@",dictemp[@"isshare"]];
                    NSString *tasknum = [NSString stringWithFormat:@"%@",dictemp[@"tasknum"]];
                    NSString *isreward = [NSString stringWithFormat:@"%@",dictemp[@"isreward"]];
                    NSString *disciple = [NSString stringWithFormat:@"%@",dictemp[@"disciple"]];
                    NSString *disciplefee = [NSString stringWithFormat:@"%@",dictemp[@"disciplefee"]];
                    NSString *issign = [NSString stringWithFormat:@"%@",dictemp[@"issign"]];
                    NSInteger empudid = [dictemp[@"empudid"] integerValue];
                    BOOL boundwx = [dictemp[@"boundwx"] integerValue];
                    NSString *shebeiid = [NSString stringWithFormat:@"%@",dictemp[@"udid"]];
                    
                    if ([phoneNum isEqualToString:@""]) {
                        JLLog(@"无手机号");
                        STUserDefaults.phonenum = phoneNum;

                    } else {
                        JLLog(@"有手机号---%@",phoneNum);
                        STUserDefaults.phonenum = phoneNum;
                    }
                    
                    STUserDefaults.isLogin = YES;
                    STUserDefaults.uid = uid;
                    STUserDefaults.name = userName;
                    STUserDefaults.img = userImg;
                    if ([STUserDefaults.token isEqualToString:token]) {
                        
                    } else {
                        STUserDefaults.token = token;
                    }
                    
                    JLLog(@"442----st.token---%@\ntoken--%@",STUserDefaults.token,token);
                    
                    STUserDefaults.cash = [NSString stringWithFormat:@"%.2f",[cash floatValue]/100.0];
                    STUserDefaults.cashtotal = [NSString stringWithFormat:@"%.2f",[cashtotal floatValue]/100.0];
                    STUserDefaults.cashyes = [NSString stringWithFormat:@"%.2f",[cashyes floatValue]/100.0];
                    STUserDefaults.cashtoday = [NSString stringWithFormat:@"%.2f",[cashtoday floatValue]/100.0];
                    STUserDefaults.cashconver = [NSString stringWithFormat:@"%.2f",[cashconver floatValue]/100.0];
                    
                    JLLog(@"%@---%@---%@",STUserDefaults.cashtotal,STUserDefaults.cashconver,STUserDefaults.cashtoday);
                    
                    STUserDefaults.ingot = [ingot intValue];
                    STUserDefaults.isshare = [isshare boolValue];
                    STUserDefaults.tasknum = [tasknum integerValue];
                    STUserDefaults.isreward = [isreward boolValue];
                    STUserDefaults.disciple = [disciple integerValue];
                    STUserDefaults.disciplefee = [disciplefee integerValue];
                    STUserDefaults.issign = [issign boolValue];
                    STUserDefaults.empudid = empudid;
//                    STUserDefaults.inviteCode = [NSString stringWithFormat:@"%@%@",uid,[self getCurrentTime]];
                    STUserDefaults.boundwx = boundwx;
                    if (![self isBlankString:shebeiid]) {
                        JLLog(@"shebeiid");
                        STUserDefaults.shebeiID = shebeiid;

                    }
                    // 系统提现信息
                    [self loadPaomaData];
                    
                    //window 展示
                    [self windowInfo];
                }
                else
                {
                    NSLog(@"获取用户信息：%@",ServersData[@"m"]);
                    if ([self isBlankString:STUserDefaults.token]) {
                        STUserDefaults.isLogin = NO;
                    }
                    else
                    {
                        STUserDefaults.isLogin = NO;
                        [SVProgressHUD showErrorWithStatus:@"登录已过期，请到个人中心进行登录"];
                        XWLoginVC *VC = [[XWLoginVC alloc] init];
                        [self.window.rootViewController presentViewController:VC animated:YES completion:nil];
                        // [ShareSDK cancelAuthorize:SSDKPlatformTypeWechat];
                        STUserDefaults.uid = 0;
                        STUserDefaults.img = NULL;
                        STUserDefaults.token = @"";
                        
                        STUserDefaults.cash = 0;
                        STUserDefaults.cashtotal = 0;
                        STUserDefaults.cashyes = 0;
                        STUserDefaults.cashtoday = 0;
                        STUserDefaults.cashconver = 0;
                        STUserDefaults.ingot = 0;
                        STUserDefaults.isshare = NO;
                        STUserDefaults.tasknum = 0;
                        STUserDefaults.isreward = NO;
                        STUserDefaults.disciple = 0;
                        STUserDefaults.disciplefee = 0;
                        
                    }
                }
                
            }
            else
            {
                [SVProgressHUD showErrorWithStatus:@"服务端数据出错"];
            }
            
        }
        else
        {
            JLLog(@"getinfo--网络错误，请重试");
//            [SVProgressHUD showErrorWithStatus:@"getinfo--网络错误，请重试"];
        }
        
    }];
    
}

#pragma mark ====================== 配置信息接口 =======================
- (void)sysConfigInfo
{
    [STRequest SysInfoDataWithDataBlock:^(id ServersData, BOOL isSuccess) {
        JLLog(@"sysinfo---%@",ServersData);
        if (isSuccess) {
            if ([ServersData isKindOfClass:[NSDictionary class]]) {
                if ([ServersData[@"c"] intValue] == 1) {
                    
                    //    mainfuns
                    NSString *mainfunsStr = ServersData[@"d"][@"mainfuncs"];
                    NSArray *mainfunsArr = [mainfunsStr componentsSeparatedByString:@"|"];
                    NSMutableArray *arr = [NSMutableArray arrayWithArray:mainfunsArr];
                    NSMutableArray *array1 = [NSMutableArray array];
                    NSMutableArray *arrayOther1 = [NSMutableArray array];
                    
                    for (int i = 0; i<arr.count; i++) {
                        if (i%2 == 0) {
                            [array1 addObject:arr[i]];
                        }else{
                            [arrayOther1 addObject:arr[i]];
                        }
                    }
                    STUserDefaults.mainfuncsID = array1;
                    JLLog(@"array1---%@,arrayOther1----%@,mainfuncsID---%@",array1,arrayOther1,STUserDefaults.mainfuncsID);
                    
                    for (NSObject *j in array1) {
                        [arr removeObject:j];
                    }
                    STUserDefaults.mainfuncs = arr;
                    JLLog(@"STUserDefaults.mainfuncs----%@",arr);
                    
                    //    bottomfunc
                    NSString *bottomfunsStr = ServersData[@"d"][@"bottomfunc"];
                    NSArray *bottomfunsArr = [bottomfunsStr componentsSeparatedByString:@"|"];
                    NSMutableArray *bottomarr = [NSMutableArray arrayWithArray:bottomfunsArr];
                    
                    NSMutableArray *array2 = [NSMutableArray array];
                    NSMutableArray *arrayOther2 = [NSMutableArray array];
                    
                    for (int i = 0; i<bottomarr.count; i++) {
                        if (i%2 == 0) {
                            [array2 addObject:bottomarr[i]];
                        }else{
                            [arrayOther2 addObject:bottomarr[i]];
                        }
                    }
                    JLLog(@"array2---%@,arrayOther2----%@,bottomfuncID---%@",array2,arrayOther2,STUserDefaults.bottomfuncID);

                    STUserDefaults.bottomfuncID = array2;
                    
                    STUserDefaults.bottomfunc = arrayOther2;
                    JLLog(@"STUserDefaults.bottomfunc----%@",arrayOther2);
                    
                    //    treasurefuncs
                    NSString *treasurefuncs = ServersData[@"d"][@"treasurefuncs"];
                    NSArray *treArr = [treasurefuncs componentsSeparatedByString:@"|"];
                    NSMutableArray *treArray  = [NSMutableArray arrayWithArray:treArr];
                    NSMutableArray *array3 = [NSMutableArray array];
                    for (int i = 0; i<treArray.count; i++) {
                        if (i%2 == 0) {
                            [array3 addObject:treArray[i]];
                        }
                    }
                    for (NSObject *j in array3) {
                        [treArray removeObject:j];
                    }
                    STUserDefaults.treasurefuncs = treArray;
                    JLLog(@"STUserDefaults.treasurefuncs----%@",treArray);
                    
                    //配置系统信息接口
#pragma mark =====================  取审核版和非审核版的标识 ===================
                    STUserDefaults.ischeck = [ServersData[@"d"][@"ischeck"] integerValue];
                    STUserDefaults.sysversion = ServersData[@"d"][@"sysversion"];
                    
                    JLLog(@"taskversion----%@",STUserDefaults.taskversion);
                    //判断 根据任务版本号 是否读取数据库内容
                    if (STUserDefaults.taskversion == ServersData[@"d"][@"taskversion"]) {
                        NSArray *taskInfoArray = [NSArray arrayWithContentsOfFile:XWPACKET_TASKINFO_CACHE_PATH];
                        JLLog(@"first---taskinfo----%@",taskInfoArray);
                        if (taskInfoArray.count == 0) {
                            // 当用户可以去删除任务信息缓存记录的时候 下次登录可以判断 任务信息缓存是否删除 如果删除则重新下载接口中的任务配置信息 如果没有则读取任务配置信息的数据
                            // 任务类型描述配置信息
                            [self getSysTaskInfo];
                        } else {
                            JLLog(@"second---taskinfo----%@",taskInfoArray);

                        }
                        
                    } else {
                        STUserDefaults.taskversion = ServersData[@"d"][@"taskversion"];
                        JLLog(@"taskversion---%@",STUserDefaults.taskversion);
                        // 任务类型描述配置信息
                        [self getSysTaskInfo];
                    }
                    
                    //判断 根据转盘数据版本号 是否读取转盘数据
                    if (STUserDefaults.wheeldrawversion == ServersData[@"d"][@"wheeldrawversion"]) {
                        isUpdateSysWheelInfo = NO;
                        
                    } else {
                        isUpdateSysWheelInfo = YES;
                        STUserDefaults.wheeldrawversion = ServersData[@"d"][@"wheeldrawversion"];
                        JLLog(@"STUserDefaults.wheeldrawversion---%@",STUserDefaults.wheeldrawversion);
                    }
                    
                    STUserDefaults.imgurlpre = ServersData[@"d"][@"imgurlpre"];
                    STUserDefaults.htmlurl = ServersData[@"d"][@"htmlurl"];
                    STUserDefaults.costingot = [ServersData[@"d"][@"costingot"] intValue];
                    STUserDefaults.shareurl = ServersData[@"d"][@"shareurl"];
                    STUserDefaults.slotrmb = ServersData[@"d"][@"slotrmb"];
                    STUserDefaults.slotcnfversion = ServersData[@"d"][@"slotcnfversion"];
                    STUserDefaults.converlist = ServersData[@"d"][@"converlist"];
                    //版本描述信息
                    STUserDefaults.versiondesc = ServersData[@"d"][@"versiondesc"];
                    //红包点击跳转地址
                    STUserDefaults.eventurl = ServersData[@"d"][@"eventurl"];
                    
                    //提现按钮
                    STUserDefaults.converlist = ServersData[@"d"][@"converlist"];
                    
                    //获取客服QQ
                    STUserDefaults.serviceqq = ServersData[@"d"][@"serviceqq"];
                    
                    //二维码分析地址
                    STUserDefaults.codeShareUrl = ServersData[@"d"][@"codeshare"];
                    
                    //判断 根据明细类型数据版本号 是否读取明细数据
                    if (STUserDefaults.typedescversion == ServersData[@"d"][@"typedescversion"]) {
                        NSMutableArray *infoarr = [XWIncomeDetailListTool topics];
//                        NSArray *IncomeDetailInfoArray = [NSArray arrayWithContentsOfFile:XWMINE_MONEYDETAIL_CACHE_PATH];
                        JLLog(@"first---taskinfo----%@",infoarr);
                        
                        JLLog(@"first--infoarr----%@",infoarr);
                        if (infoarr.count == 0) {
                            // 明细类型描述配置信息 // 当用户可以去删除明细信息缓存记录的时候 下次登录可以判断 明细类型描述配置信息缓存是否删除 如果删除则重新下载接口中的明细类型数据信息 如果没有则读取明细类型数据
                            [self sysDetailTypeConfigInfo];
                        } else {
                            JLLog(@"second--infoarr----%@",infoarr);

                        }
                    } else {
                        STUserDefaults.typedescversion = ServersData[@"d"][@"typedescversion"];
                        JLLog(@"typedescversion---%@",STUserDefaults.typedescversion);
                        
                        // 明细类型描述配置信息
                        [self sysDetailTypeConfigInfo];
                    }
                    
                    // 获取个人信息
                    [self getInfo];
                    
                }else{
                    NSLog(@"获取用户信息：%@",ServersData[@"m"]);
                    if ([self isBlankString:STUserDefaults.token]) {
                        STUserDefaults.isLogin = NO;
                        
                    }
                    else
                    {
                        STUserDefaults.isLogin=NO;
                        [SVProgressHUD showErrorWithStatus:@"登录已过期，请到个人中心进行登录"];
                    }
                    
                }
                
            }else{
                [SVProgressHUD showErrorWithStatus:@"服务端数据出错"];
            }
        }else{
            
//            [SVProgressHUD showErrorWithStatus:@"sysconfig---网络错误，请重试"];
            JLLog(@"sysconfig---网络错误，请重试");

        }
    }];
    
}

#pragma mark ================== 系统任务信息  ==================

- (void)getSysTaskInfo{
    
    [STRequest SysTaskInfoDataWithDataBlock:^(id ServersData, BOOL isSuccess) {
        if (isSuccess) {
            if ([ServersData isKindOfClass:[NSDictionary class]]) {
                if ([ServersData[@"c"] intValue] == 1) {
                    NSDictionary *dictemp = [NSDictionary dictionaryWithDictionary:ServersData[@"d"]];
                    NSArray *arrtemp = [NSArray arrayWithArray:dictemp[@"taskinfo"]];
                    
                    JLLog(@"arrtemp---%@",arrtemp);
                    
                    [arrtemp writeToFile:XWPACKET_TASKINFO_CACHE_PATH atomically:YES];
                    
                    
                }else{
                    NSLog(@"获取用户信息：%@",ServersData[@"m"]);
                    if ([self isBlankString:STUserDefaults.token]) {
                        STUserDefaults.isLogin = NO;
                    }
                    else
                    {
                        STUserDefaults.isLogin = NO;
                        [SVProgressHUD showErrorWithStatus:@"登录已过期，请到个人中心进行登录"];
                    }
                }
            }else{
                [SVProgressHUD showErrorWithStatus:@"服务端数据出错"];
            }
        }else{
            
//            [SVProgressHUD showErrorWithStatus:@"systaskinfo---网络错误，请重试"];
            JLLog(@"systaskinfo---网络错误，请重试");

        }
    }];
    
}


#pragma mark ================== 明细类型描述配置信息 ==================
- (void)sysDetailTypeConfigInfo
{
    
    [XWIncomeDetailListTool deleteAllDataFromSql];
    
    [STRequest SysConfigDetainesDataWithDataBlock:^(id ServersData, BOOL isSuccess) {
        if (isSuccess) {
            if ([ServersData isKindOfClass:[NSDictionary class]]) {
                if ([ServersData[@"c"] intValue] == 1) {
                    JLLog(@"SysConfigDetainesDataWithDataBlock----%@",ServersData);
                    NSDictionary *dictemp = [NSDictionary dictionaryWithDictionary:ServersData[@"d"]];
                    NSMutableArray *arrtemp = [NSMutableArray arrayWithArray:dictemp[@"typedesc"]];
                    
                    for (int j = 0; j < arrtemp.count; j++) {
                        NSString *astr = [arrtemp[j] substringToIndex:1];
                        NSString *bstr = [arrtemp[j] substringFromIndex:1];
                        XWIncomeDetailInfoModel *model = [[XWIncomeDetailInfoModel alloc]init];
                        model.type = astr;
                        model.typedesc = bstr;
                        JLLog(@"model----%@",model);
                        //保存到数据库
                        [XWIncomeDetailListTool saveTopic:model];
                    }
                    
//                    [arrtemp writeToFile:XWMINE_MONEYDETAIL_CACHE_PATH atomically:YES];
                    
                    JLLog(@"---%@---",[XWIncomeDetailListTool topics]);
                }else{
                    NSLog(@"获取用户信息：%@",ServersData[@"m"]);
                    if ([self isBlankString:STUserDefaults.token]) {
                        STUserDefaults.isLogin = NO;
                    }
                    else
                    {
                        STUserDefaults.isLogin = NO;
                        [SVProgressHUD showErrorWithStatus:@"登录已过期，请到个人中心进行登录"];
                    }
                    
                }
                
            }else{
//                [SVProgressHUD showErrorWithStatus:@"服务端数据出错"];
                JLLog(@"detail---服务端数据出错");

            }
        }else{
            
            JLLog(@"detail---网络错误，请重试");
        }
    }];
    
}

#pragma mark ================== 开心转转乐配置信息 ==================
- (void)sysHappyTurnDataInfo
{
    JLLog(@"待定");
}

#pragma mark ================== 反馈问题类型信息 ==================
- (void)feedMatterTypeInfo
{
    JLLog(@"待定");
}

-(BOOL)isBlankString:(NSString *)string {
    if (string == nil || string == NULL) {
        return YES;
    }
    if ([string isKindOfClass:[NSNull class]]) {
        return YES;
    }
    if ([[string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] length]==0) {
        return YES;
    }
    if ([string isEqualToString:@"(null)"]) {
        return YES;
    }
    if ([string isEqualToString:@"<null>"]) {
        return YES;
    }
    return NO;
}

#pragma mark =================== 友盟分享处理url地址的调用方法含支付sdk方法回调 ==============
// 支持所有iOS系统
- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
{
    //6.3的新的API调用，是为了兼容国外平台(例如:新版facebookSDK,VK等)的调用[如果用6.2的api调用会没有回调],对国内平台没有影响
    BOOL result = [[UMSocialManager defaultManager] handleOpenURL:url sourceApplication:sourceApplication annotation:annotation];
    if (!result) {
        // 其他如支付等SDK的回调
    }
    
    NSLog(@"%@",url);
    NSLog(@"%@",sourceApplication);
    NSLog(@"%@",annotation);
    NSLog(@"%@",[url absoluteString]);
    
    NSString* prefix = @"kdtoutiao://action=";
    if ([[url absoluteString] rangeOfString:prefix].location != NSNotFound) {
        NSString* action = [[url absoluteString] substringFromIndex:prefix.length];
        if ([action isEqualToString:@"openAPP"]) {
            //打开APP
        }
        else if([action containsString:@"openNewsUrl="]) {
            NSString *IDString = [action substringFromIndex:@"openNewsUrl=".length];
            //            BasicHomeViewController *vc = (BasicHomeViewController*)self.window.rootViewController;
            //            [vc.tabbar selectAtIndex:2];
            
            
            WKWebViewController *newsCtrl = [[WKWebViewController alloc]init];
            [newsCtrl loadWebURLSring:IDString];
            UINavigationController *NAV = (UINavigationController*)self.window.rootViewController;
            [NAV pushViewController:newsCtrl animated:YES];
        }
    }
    
    return result;
}

- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url
{
    BOOL result = [[UMSocialManager defaultManager] handleOpenURL:url];
    if (!result) {
        // 其他如支付等SDK的回调
    }
    return result;
}

#pragma mark =================== 极光推送处理 =====================
- (void)applicationWillResignActive:(UIApplication *)application {
    
    [JPUSHService setBadge:0]; //设置角标为0
    [application setApplicationIconBadgeNumber:0];
    [application cancelAllLocalNotifications];
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    [JPUSHService setBadge:0]; //设置角标为0
    [application setApplicationIconBadgeNumber:0];
    [application cancelAllLocalNotifications];
}


- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken
{
    /// Required - 注册 DeviceToken
    [JPUSHService registerDeviceToken:deviceToken];
}

- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error {
    //Optional
    JLLog(@"did Fail To Register For Remote Notifications With Error: %@", error);
}

- (void)jpushNotificationCenter:(UNUserNotificationCenter *)center willPresentNotification:(UNNotification *)notification withCompletionHandler:(void (^)(NSInteger))completionHandler {
    // Required
    NSDictionary *userInfo = notification.request.content.userInfo;
    UNNotificationRequest *request = notification.request; // 收到推送的请求
    UNNotificationContent *content = request.content; // 收到推送的消息内容
    NSNumber *badge = content.badge;  // 推送消息的角标
    NSString *body = content.body;    // 推送消息体
    UNNotificationSound *sound = content.sound;  // 推送消息的声音
    NSString *subtitle = content.subtitle;  // 推送消息的副标题
    NSString *title = content.title;  // 推送消息的标题
    JLLog(@"=========%@",userInfo);

    if([notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
        [JPUSHService handleRemoteNotification:userInfo];
        /// 前台收到推送的时候转成本地通知 ===========================
        if ([UIApplication sharedApplication].applicationState == UIApplicationStateActive) {
            //程序运行时收到通知，先弹出消息框
            NSLog(@"程序在前台");
            [self popAlert:userInfo];
        }else{
            //跳转到指定页面
            [self pushToViewControllerWhenClickPushMessageWith:userInfo];
            
        }
        // 判断为本地通知
        JLLog(@"iOS10 前台收到本地通知:{\nbody:%@，\ntitle:%@,\nsubtitle:%@,\nbadge：%@，\nsound：%@，\nuserInfo：%@\n}",body,title,subtitle,badge,sound,userInfo);
    }else {
        // 判断为本地通知
        JLLog(@"iOS10 前台收到本地通知:{\nbody:%@，\ntitle:%@,\nsubtitle:%@,\nbadge：%@，\nsound：%@，\nuserInfo：%@\n}",body,title,subtitle,badge,sound,userInfo);
    }
    completionHandler(UNNotificationPresentationOptionAlert|UNNotificationPresentationOptionSound|UNNotificationPresentationOptionBadge);
    // 需要执行这个方法，选择是否提醒用户，有Badge、Sound、Alert三种类型可以选择设置
}

// iOS 10 Support
- (void)jpushNotificationCenter:(UNUserNotificationCenter *)center didReceiveNotificationResponse:(UNNotificationResponse *)response withCompletionHandler:(void (^)())completionHandler {
    // Required
    NSDictionary * userInfo = response.notification.request.content.userInfo;
    UNNotificationRequest *request = response.notification.request; // 收到推送的请求
    UNNotificationContent *content = request.content; // 收到推送的消息内容
    NSNumber *badge = content.badge;  // 推送消息的角标
    NSString *body = content.body;    // 推送消息体
    UNNotificationSound *sound = content.sound;  // 推送消息的声音
    NSString *subtitle = content.subtitle;  // 推送消息的副标题
    NSString *title = content.title;  // 推送消息的标题
    JLLog(@"=========%@",userInfo);

    if([response.notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
        [JPUSHService handleRemoteNotification:userInfo];
        if ([UIApplication sharedApplication].applicationState == UIApplicationStateActive) {
            //程序运行时收到通知，先弹出消息框
            [self popAlert:userInfo];
            
        }else{
            [self pushToViewControllerWhenClickPushMessageWith:userInfo];
            
        }
        // 判断为本地通知
        JLLog(@"iOS10 前台收到本地通知:{\nbody:%@，\ntitle:%@,\nsubtitle:%@,\nbadge：%@，\nsound：%@，\nuserInfo：%@\n}",body,title,subtitle,badge,sound,userInfo);
    }else {
        // 判断为本地通知
        JLLog(@"iOS10 收到本地通知:{\nbody:%@，\ntitle:%@,\nsubtitle:%@,\nbadge：%@，\nsound：%@，\nuserInfo：%@\n}",body,title,subtitle,badge,sound,userInfo);

    }
    completionHandler();  // 系统要求执行这个方法
}

//#pragma mark -- 程序跳转方法
-(void)pushToViewControllerWhenClickPushMessageWith:(NSDictionary*)msgDic{
    
        NSDictionary *dict = @{
                               @"url":[msgDic objectForKey:@"url"],
                               @"alert":[[msgDic objectForKey:@"aps"]objectForKey:@"alert"],
                               @"content":[msgDic objectForKey:@"content"]
                               };
        [[NSNotificationCenter defaultCenter]postNotificationName:@"NotificationPushWkWebview" object:nil userInfo:dict];

}
//
//在前台的时候 我这里就直接弹出提示框
-(void)popAlert:(NSDictionary *)pushMessageDic{
    NSLog(@"%@",pushMessageDic);
    UIAlertController *alertController =
    [UIAlertController alertControllerWithTitle:[[pushMessageDic objectForKey:@"aps"]objectForKey:@"alert"]  message:nil
                                 preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *confirmAction =
    [UIAlertAction actionWithTitle:@"查看" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        [self pushToViewControllerWhenClickPushMessageWith:pushMessageDic];
    }];
    
    UIAlertAction *cancelAction =
    [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    
    [alertController addAction:confirmAction];
    [alertController addAction:cancelAction];
    [self.window.rootViewController presentViewController:alertController animated:YES completion:nil];

}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler {
    
    // Required, iOS 7 Support
    [JPUSHService handleRemoteNotification:userInfo];
    completionHandler(UIBackgroundFetchResultNewData);
    
    NSDictionary *aps = [userInfo valueForKey:@"aps"];
    
    //    NSString *content = [aps valueForKey:@"alert"]; //推送显示的内容
    
    //    NSInteger badge = [[aps valueForKey:@"badge"] integerValue];
    
    //    NSString *sound = [aps valueForKey:@"sound"]; //播放的声音
    
    // 取得自定义字段内容，userInfo就是后台返回的JSON数据，是一个字典
    
    application.applicationIconBadgeNumber = 0;
    
    if (application.applicationState == UIApplicationStateActive) {
        //程序运行时收到通知，先弹出消息框
        NSLog(@"程序在前台");
        [self popAlert:userInfo];
    }else{
        //程序已经关闭或者在后台运行
        [self pushToViewControllerWhenClickPushMessageWith:userInfo];
        
    }
    
    [application setApplicationIconBadgeNumber:0];
    
    [self pushToViewControllerWhenClickPushMessageWith:userInfo];
    
    JLLog(@"=========%@",userInfo);
    
}

//注册远程通知

- (void)application:(UIApplication *)application didRegisterUserNotificationSettings:(UIUserNotificationSettings *)notificationSettings{
    
    [application registerForRemoteNotifications];
    
}



- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.

    
}

//UIWindowDidBecomeVisibleNotification这个通知会有问题，点击网页上面的任何按钮，都会调用这个通知。
//目前已经找到解决方法了，在AppDelegate.m中，加入这个方法就可以了。
- (UIInterfaceOrientationMask)application:(UIApplication *)application supportedInterfaceOrientationsForWindow:(UIWindow *)window {
    
    if ([NSStringFromClass([[[window subviews]lastObject] class]) isEqualToString:@"UITransitionView"]) {
        return UIInterfaceOrientationMaskAll;
    }
    return UIInterfaceOrientationMaskPortrait;
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

#pragma mark ================== 载入用户位置的经纬度  ===================
- (void)loadUserJWDu
{
    //判断定位功能是否打开
    if ([CLLocationManager locationServicesEnabled]) {
        locationManager = [[CLLocationManager alloc] init];
        locationManager.delegate = self;
        currentCity = [[NSString alloc]init];
        [locationManager requestWhenInUseAuthorization];
        //设置寻址经度
        locationManager.desiredAccuracy = kCLLocationAccuracyBest;
        locationManager.distanceFilter = 5.0;
        [locationManager startUpdatingLocation];
        
    }
    
}

#pragma mark - 定位失败
- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
    //设置提示提醒用户打开定位服务
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"允许此APP访问你的位置" message:@"请在设置中打开定位" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *ok = [UIAlertAction actionWithTitle:@"" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        NSURL *settingUrl = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
        [[UIApplication sharedApplication] openURL:settingUrl];
    }];
    
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    
    [alert addAction:cancel];
    [alert addAction:ok];
    
   // [self presentViewController:alert animated:YES completion:nil];
    
}

#pragma mark  - 成功
- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations
{
    [locationManager stopUpdatingLocation];
    //旧值
    CLLocation *currtLocation = [locations lastObject];
    CLGeocoder *geocoder = [[CLGeocoder alloc]init];
    
    STUserDefaults.longitude = [NSString stringWithFormat:@"%f",currtLocation.coordinate.longitude];
    STUserDefaults.latitude = [NSString stringWithFormat:@"%f",currtLocation.coordinate.latitude];
    
    [geocoder reverseGeocodeLocation:currtLocation completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
        if (placemarks.count > 0) {
            CLPlacemark *placemark = placemarks[0];
            currentCity = placemark.locality;
            if (!currentCity) {
                currentCity = @"无法定位到当前城市";
            }
            
//            JLLog(@"placeMark.country --- %@",placemark.country);
//            JLLog(@"currtcity --- %@",currentCity);
//            JLLog(@"placemark.subLocality --- %@",placemark.subLocality);
//            JLLog(@"placemark.thoroughfare --- %@",placemark.thoroughfare);
//            JLLog(@"placemark.name --- %@",placemark.name);
            
            
        }else if (error == nil && placemarks.count == 0  ){
            
            JLLog(@"no location and error return");
        }else if (error){
            
            JLLog(@"location error %@",error);
        }
        
    }];
    
    
}


//获取当地时间
- (NSString *)getCurrentTime {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyyMMdd"];
    NSString *dateTime = [formatter stringFromDate:[NSDate date]];
    return dateTime;
}

@end
