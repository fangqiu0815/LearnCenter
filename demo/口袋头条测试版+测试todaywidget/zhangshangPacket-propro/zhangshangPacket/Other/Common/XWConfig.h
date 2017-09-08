//
//  XWConfig.h
//  zhangshangnews
//
//  Created by apple on 2017/5/10.
//  Copyright © 2017年 apple-fangqiu. All rights reserved.
//

#ifndef XWConfig_h
#define XWConfig_h

//3rd lib
#import "XWCommonFunction.h"
#import "UIView+Frame.h"
#import "UIImage+Original.h"
#import "UIImageView+WebCache.h"
#import <Masonry/Masonry.h>
#import <MJRefresh/MJRefresh.h>
#import "MJExtension.h"
#import "SVProgressHUD.h"
#import "AppDelegate.h"
#import "SDCycleScrollView.h"
#import <IQKeyboardManager/IQKeyboardManager.h>
#import <DZNEmptyDataSet/UIScrollView+EmptyDataSet.h>
#import "WMPageController.h"
#import <BlocksKit/BlocksKit.h>
#import <BlocksKit+UIKit.h>
#import <Block.h>
#import "WKWebViewController.h"
#import "CleanCacheToolClass.h"
#import "UITableView+FDTemplateLayoutCell.h"
#import "NSString+Ext.h"
#import "ZFPlayer.h"
#import <DKNightVersion/DKNightVersion.h>

#import "UIImage+YJCircleImage.h"
#import "UIImageView+YJImageExtension.h"
#import "NSString+CZNSStringExt.h"
#import "UIButton+FQButton.h"
#import "XWUserDefault+XWPropertity.h"
#import "UIColor+XWColor.h"
#import "NSString+CzbExtension.h"
#import "UITextField+CzbExtension.h"
#import "NSMutableArray+RandomSort.h"
#import "NSArray+RandomSort.h"
#import "NSString+CzbExtension.h"
#import "UIView+TYAlertView.h"
#import "TYAlertController.h"
#import "TYAlertController+BlurEffects.h"
#import "UIView+XWNightView.h"
#import "XWNightModeManager.h"
#import "XWMainCell.h"

//
#import "XWBaseVC.h"
#import "XWTabBarVC.h"
#import "XWNavigationVC.h"
#import "UIBarButtonItem+Item.h"
#import "UIButton+Badge.h"
#import "DeviceInfo.h"
#import "WXPaySign.h"
#import "ToolFontFit.h"
#import "XWCell.h"
#import "GCD_Timer.h"
#import "STRequest.h"
#import "UIImageView+YLNoImageModel.h"

/* 屏幕适配 */
#define iphone4 ScreenH == 480
#define iphoneSE ScreenH == 568
#define iphone7 ScreenH == 667
#define iphone7p ScreenH == 736

#define XWADDRESS_REAPID_CACHE_PATH [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"XWAddressReapid.plist"]

#define XWSEARCH_SEARCH_HISTORY_CACHE_PATH [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"XWSearchhistories.plist"]

#define XWPACKET_TASKINFO_CACHE_PATH [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"TaskInfoData.plist"]

#define XWMINE_MONEYDETAIL_CACHE_PATH [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"MineMoneyDetail.plist"]

#define CachePath NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES).lastObject
#define DocumentPath NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).lastObject


#define iOS9Later ([UIDevice currentDevice].systemVersion.floatValue >= 9.0f)

#ifdef DEBUG //开发状态
#define JLLog(FORMAT, ...) fprintf(stderr,"%s:第 %d 行\n%s\n",[[[NSString stringWithUTF8String:__FILE__] lastPathComponent] UTF8String], __LINE__, [[NSString stringWithFormat:FORMAT, ##__VA_ARGS__] UTF8String]);
#else  //发布状态
#define JLLog(...)
#endif



#endif /* XWConfig_h */
