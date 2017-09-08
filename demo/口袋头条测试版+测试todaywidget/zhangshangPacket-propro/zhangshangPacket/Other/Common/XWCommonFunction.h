//
//  XWCommonFunction.h
//  zhangshangnews
//
//  Created by apple on 2017/5/10.
//  Copyright © 2017年 apple-fangqiu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

// 标准系统状态栏高度
#define SYS_STATUSBAR_HEIGHT                          20
// 热点栏高度
#define HOTSPOT_STATUSBAR_HEIGHT                      20
// 导航栏（UINavigationController.UINavigationBar）高度
#define NAVIGATION_HEIGHT                             44
// 导航栏+状态栏
#define ALL_NAVIGATION_HEIGHT                         0
// 工具栏（UINavigationController.UIToolbar）高度
#define TOOLBAR_HEIGHT                                44
// 标签栏（UITabBarController.UITabBar）高度
#define TABBAR_HEIGHT                                 49

//设备宽
#define IPHONE_W [UIScreen mainScreen].bounds.size.width
//设备高
#define IPHONE_H [UIScreen mainScreen].bounds.size.height
/** 屏幕尺寸size */
#define IPHONE_SIZE  [[UIScreen mainScreen] bounds].size
/** 屏幕尺寸frame */
#define IPHONE_FRAME [[UIScreen mainScreen] bounds]
/** 图片赋值 */
#define MyImage(imageName) [UIImage imageNamed:imageName]

/** 自定义颜色 */
#define CUSTOMCOLOR(r,g,b)  [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:1.0]
/** 带透明度的自定义颜色 */
#define CUSTOMCOLORA(r,g,b,a)  [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:a]



/**
 * 随机颜色
 */
#define RandomColor [UIColor colorWithRed:(arc4random_uniform(256)/255.0) green:(arc4random_uniform(256)/255.0) blue:(arc4random_uniform(256)/255.0) alpha:1.0]
/** 获取Window */
#define MainWindow [UIApplication sharedApplication].keyWindow
/** 状态栏高度 */
#define STATUS_BAR (([[[UIDevice currentDevice]systemVersion]floatValue] >= 7.0) ? 20 : 0)

//系统版本号
#define SystemVersion       ([[UIDevice currentDevice] systemVersion].floatValue)
//获取AppDelegate
#define appDelegate ((AppDelegate *)[UIApplication sharedApplication].delegate)
/** 创建位置Fram */
#define  Frame(x,y,w,h)         CGRectMake((x), (y), (w), (h))
/** 创建点Point */
#define  Point(x,y)             CGPointMake((x), (y))
/** 创建尺寸size */
#define  Size(w,h)              CGSizeMake((w), (h))
/** 字体大小font */
#define  Font(font)             [UIFont systemFontOfSize:(font)]
/** 设备唯一标识 */
#define Reg_ID                  [[[UIDevice currentDevice] identifierForVendor] UUIDString]
/** 白色 */
#define WhiteColor [UIColor whiteColor]
#define BlackColor [UIColor blackColor]

//主色调
#define MainColor [UIColor whiteColor]

#define LineColor                   CUSTOMCOLOR(229, 229, 229)
#define MainLabColor ([UIColor colorWithRed:0.902 green:0.216 blue:0.216 alpha:1.000])
#define MainTextColor ([UIColor colorWithRed:0.45 green:0.45 blue:0.45 alpha:1.00])
#define MainBGColor                 CUSTOMCOLOR(230, 230, 230)

#define MainYellowColor             CUSTOMCOLOR(255, 175, 0)
#define MainRedColor                CUSTOMCOLOR(244, 75, 80)  //244, 75, 80 主色f44b50
#define MainGrayTextColor           CUSTOMCOLOR(150, 150, 150)
#define MainMidLineColor            CUSTOMCOLOR(200, 200, 200)
#define MainYingHuangColor          CUSTOMCOLOR(0, 229, 0)
#define MainQRCodeColor             CUSTOMCOLOR(101, 101, 101)
#define MainTextInformColor         CUSTOMCOLOR(74, 74, 74) // #4a4a4a

//夜晚色调
#define NightMainColor              CUSTOMCOLOR(20, 20, 20)
#define NightHeaderMainColor        CUSTOMCOLOR(16, 16, 16)
#define NightMainBGColor            CUSTOMCOLOR(32, 32, 32)
#define NightBolangBGColor          CUSTOMCOLOR(60, 60, 60)
#define NightMainBlueColor          CUSTOMCOLOR(70,164,255)
#define NightMainNaviColor          CUSTOMCOLOR(15, 16, 16)
#define NightMainCellColor          CUSTOMCOLOR(24, 25, 26)
#define NightMainTextColor          CUSTOMCOLOR(117, 118, 119)
#define NightMainLineColor          CUSTOMCOLOR(30, 31, 32)



/** 适配字体大小 */
#define RemindFont(x,y,z) (IPHONE_W == 320?(x):IPHONE_W == 375? (y):(z))

/** 弱引用 */
#define WeakType(type) __weak typeof(type) weak##type = type;

/** 适配比例 */
#define AdaptiveScale_W (IPHONE_W/375.0)
#define AdaptiveScale_H (IPHONE_H/667.0)
/**  适配比例   iPhonese 为标准  等比例缩放宽高 */
#define kScale_W(w) (w*(kScreen_H == 480 ? 270:kScreen_W)/375.0)
#define kScale_H(h) (h*kScreen_H/667.0)

#define kScale_Frame(x,y,w,h)  CGRectMake((x*(kScreen_H == 480 ? 270:kScreen_W)/375.0+(kScreen_H == 480 ? 25:0)), (y*kScreen_H/667.0), (w*(kScreen_H == 480 ? 270:kScreen_W)/375.0), (h*kScreen_H/667.0))

#define iPhone5 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size) : NO)

#define iPhone6 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(750, 1334), [[UIScreen mainScreen] currentMode].size) : NO)

#define iPhone6plus ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1242, 2208), [[UIScreen mainScreen] currentMode].size) : NO)

//宏定义国际化字符
#define INTERNATIONAL
#ifdef INTERNATIONAL
#define INTERSTR(a)   (NSLocalizedString(a, nil))
#else
#define INTERSTR(a)   (a)
#endif
//用于控制是否输出调试信息
#ifdef DEBUG

#define PRINT//PRINT为手动控制宏关键字
#ifdef PRINT
#define LOG(...) NSLog(__VA_ARGS__);
#define LOG_METHOD NSLog(@"%s", __func__);
#else
#define LOG(...)    {};
#define LOG_METHOD  {};
#endif

#else
#define LOG(...)    {};
#define LOG_METHOD  {};
#endif

#ifdef DEBUG
#define MyLog(format, ...) printf("\n[%s] %s [第%d行] %s\n", __TIME__, __FUNCTION__, __LINE__, [[NSString stringWithFormat:format, ## __VA_ARGS__] UTF8String]);
#else
#define MyLog(format, ...)
#endif


@interface XWCommonFunction : NSObject


/**
 *  通过颜色创建图片
 */
+ (UIImage *)createImageWithColor:(UIColor *)color;
/**
 *  验证电话号
 */
+ (BOOL)isValidateMobileNumber:(NSString *)mobileNum;
/**
 *  判断星座
 */
+ (NSString *)constellationWithDate:(NSDate *)date;
/**
 *  验证邮箱
 */
+ (BOOL)validateEmail:(NSString *)email;
/**
 *  验证是否纯数字
 */
+ (BOOL)validatePureInt:(NSString*)string;
/**
 *  获取设备UUID
 */
+(NSString *)getDeviceUUid;
/**
 *  获取设备当前系统
 */
+(NSString *)getDeviceSystemVersion;
/**
 *  获取当前wifi账号
 */
+ (NSString *)getWifiAccount;

/**
 @brief  识别成功震动提醒
 */
+ (void)systemVibrate;
/**
 @brief  扫码成功声音提醒
 */
+ (void)systemSound;
/**
 @brief  越级返回
 */
+ (void)backFromController:(UIViewController *)nowController toController:(Class)toController;
/**
 @brief  标准时间戳转换
 */
+(NSString *)normalDataChangeToStr:(NSDate *)date;
-(NSString *)timeStampToString:(CGFloat)timeStamp;

+(NSString *)normalDataStrChangeToStr:(long long)date;
/**
 @brief  longlong转换时间格式
 */
+(NSString *)stringChangeToNormal:(long long)time;
/**
 @brief  获取当前时间
 */
+(NSString *)getCurrentDataAndTime;
/**
 @brief  获取当前时间戳
 */
+(NSString*)getCurrentTimestamp;
/**
 @brief  设置单边圆角
 */
+ (CAShapeLayer*)setButtoncornerRadius:(UIRectCorner)corners
                                   Btn:(UIButton*)btn
                          cornerRadius:(float)cornerRadius;
/**
 @brief  转码
 */
+(NSString *)changeToUtf8:(NSString *)normalStr;

-(BOOL)isBlankString:(NSString *)string ;

@end
