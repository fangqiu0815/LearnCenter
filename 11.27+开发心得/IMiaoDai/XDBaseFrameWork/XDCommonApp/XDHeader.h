//
//  XDHeader.h
//  XDCommonApp
//
//  Created by XD-XY on 2/12/14.
//  Copyright (c) 2014 XD-XY. All rights reserved.
//

#ifndef XDCommonApp_XDHeader_h
#define XDCommonApp_XDHeader_h



//===========================================控制参数=====================================================
/*引导页数量
  当引导页为0时，表示没有引导页
 */
#define GUIDECOUNT 0

/*底部菜单栏中TabBar的个数
  本框架中提供三种数量3，4，5
 */
#define TABBARCOUNT 3

/****
 tabbar是否是需要登录才能进入(0表示不需要，1表示需要)
 ****/
#define NEEDACCOUNTFORLOGIN @[@"0",@"1",@"0",@"0"]
//程序进去默认选择第几个tabar
#define DEFAULTSELECTINDEX 0

//statusBar 背景图片
#define STATUSBARBG @"statusBar_bg"
//显示隐藏statusBar
#define SETSTATUSBARHIDDEN(isHidden)\
if (isHidden){\
[[UIApplication sharedApplication] setStatusBarHidden:YES];\
}else{\
[[UIApplication sharedApplication] setStatusBarHidden:NO];\
}

/*设置statusBar的字体
 UIStatusBarStyleDefault:黑体白字
 UIStatusBarStyleLightContent:黑体黑字
 */
#define SETSTATUSBARTEXTBLACKCOLORE(isBlack)\
if (isBlack){\
[[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];\
}else{\
[[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];\
}

//颜色值
#define BGCOLOR [UIColor colorWithRed:245.0/255.0 green:245.0/255.0 blue:245.0/255.0 alpha:1];


//用户信息
#define kMY_USER_NAME               @"myUserName"
#define kMY_USER_ID                 @"myUserId"
#define kMY_USER_PASSWORD           @"myUserPassword"
#define kMY_USER_TOKEN              @"myUserToken"
#define kMYCOOKIES                  @"myCookies"
#define kMMyUserInfo                @"myUserInfo"

#define kWBTOKEN                    @"wbtoken"
#define kWBINFO                     @"wbinfo"
#define kWBEXPIRETIME               @"wbexpiretime"
#define kWBUID                      @"wbuid"

//一级页面的导航栏标题
#define FIRSTVIEWTITLETEXT  @"首页"
#define SECONDVIEWTITLETEXT @"订单"
#define THIRDVIEWTITLETEXT  @"更多"
#define FOURTHVIEWTITLETEXT @"更多"
#define FIFTHVIEWTITLETEXT  @"FIVE"

/******
 导航栏
 ******/
#define NAVIGATIONBGIMAGEIOS7 @"nav_bg_ios7"
#define NAVIGATIONBGIMAGE @"nav_bg"
#define NAVIGATIONTITLEFONT [UIFont systemFontOfSize:20.0f]
#define NAVIGATIONTITLECOLORE [UIColor whiteColor]

//=======================================友盟分享==================================================
#define UMAPPKEY @"53f838f8fd98c585e6024668"
#define WEIXINAPPID @"wxdbae923bd72627f4"

#define SHARETITLE @"请输入您要分享的文字"
#define DOWNLOADRUL @"http://www.google.com.hk/"

#define QQAPPKEY @"kMUZpqgUTEEKAUgT"
#define QQAPPID  @"10021591"

//走马灯图片数量
#define PAGESCROLLVIEWNUMBER 4
//走马灯固定的图片(若无图片用 nil表示)
#define PAGESCROLLVIEWIMAGE1 @"tab_button1_notOn"
#define PAGESCROLLVIEWIMAGE2 @"tab_button2_notOn"
#define PAGESCROLLVIEWIMAGE3 @"tab_button3_notOn"
#define PAGESCROLLVIEWIMAGE4 @"tab_button4_notOn"
//走马灯的图片来源是否是网络请求来的(YES表示是，NO表示不是)
#define ISREQUSETIMAGE YES
//默认背景图片
#define PAGEDEFAULTIAMGE [UIImage imageNamed:@"normalPageScrollviewImage"]
//每张图片是否有点击事件(YES 表示有， NO 表示没有)
#define ISHAVEGESTURECLICK YES



//=======================================通用坐标=====================================================
#define UI_NAVIGATION_BAR_HEIGHT        44
#define UI_TOOL_BAR_HEIGHT              44
#define UI_TAB_BAR_HEIGHT               49
#define UI_STATUS_BAR_HEIGHT            20
#define UI_SCREEN_WIDTH                 ([[UIScreen mainScreen] bounds].size.width)
#define UI_SCREEN_HEIGHT                ([[UIScreen mainScreen] bounds].size.height)
#define UI_MAINSCREEN_HEIGHT            (UI_SCREEN_HEIGHT - UI_STATUS_BAR_HEIGHT)
#define UI_MAINSCREEN_HEIGHT_ROTATE     (UI_SCREEN_WIDTH - UI_STATUS_BAR_HEIGHT)
#define UI_WHOLE_SCREEN_FRAME           CGRectMake(0, 0, UI_SCREEN_WIDTH, UI_SCREEN_HEIGHT)
#define UI_WHOLE_SCREEN_FRAME_ROTATE    CGRectMake(0, 0, UI_SCREEN_HEIGHT, UI_SCREEN_WIDTH)
#define UI_MAIN_VIEW_FRAME              CGRectMake(0, UI_STATUS_BAR_HEIGHT, UI_SCREEN_WIDTH, UI_MAINSCREEN_HEIGHT)
#define UI_MAIN_VIEW_FRAME_ROTATE       CGRectMake(0, UI_STATUS_BAR_HEIGHT, UI_SCREEN_HEIGHT, UI_MAINSCREEN_HEIGHT_ROTATE)
#define UI_NONAVBAR_VIEW_FRAME          CGRectMake(0, 0, UI_SCREEN_WIDTH, UI_MAINSCREEN_HEIGHT - UI_NAVIGATION_BAR_HEIGHT)
#define UI_APPLICTION_VIEW_FRAME        CGRectMake(0, 0, UI_SCREEN_WIDTH, UI_MAINSCREEN_HEIGHT)


#define     VIEW_POINT_MAX_Y(view)         CGRectGetMaxY(view.frame)+3
#define     VIEW_POINT_MAX_X(view)         CGRectGetMaxX(view.frame)+3
#define     VIEW_POINT_MIN_X(view)         CGRectGetMinX(view.frame)+3
#define     VIEW_POINT_MIN_Y(view)         CGRectGetMinY(view.frame)+3
#define     UILABEL_TAG                    1000
#define     UIBUTTON_TAG                   2000
#define     UIIMAGEVIEW_TAG                3000
#define     UIVIEW_TAG                     5000


//首次启动
#define ISFIRSTSTART  @"isfirststart"

#define ISFIRST @"isFirst"

#define ISUPLOADPHONEBOOK @"isUploadPhoneBook"

#define MYUUID @"myUUID"

//判断是否是ios7系统
#define IOS7                           [[[UIDevice currentDevice] systemVersion] floatValue] >= 7.f
//判断是否是iphone5的设备
#define iPhone5 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size) : NO)

//算 宽加X坐标的和
#define width_x(view)  view.frame.size.width + view.frame.origin.x
//算 高加Y坐标的和
#define height_y(view)  view.frame.size.height + view.frame.origin.y

//判断是否登录
#define ISLOGING  [(NSDictionary *)[[NSUserDefaults standardUserDefaults] objectForKey:kMMyUserInfo] count]

//打印输出
#ifdef DEBUG

#define DDLOG(...) NSLog(__VA_ARGS__)
#define DDLOG_CURRENT_METHOD NSLog(@"%@-%@", NSStringFromClass([self class]), NSStringFromSelector(_cmd))

#else

#define DDLOG(...) ;
#define DDLOG_CURRENT_METHOD ;

#endif

/*********
 宏作用:单例生成宏
 使用方法:http://blog.csdn.net/totogo2010/article/details/8373642
 **********/
#define DEFINE_SINGLETON_FOR_HEADER(className) \
\
+ (className *)shared##className;

#define DEFINE_SINGLETON_FOR_CLASS(className) \
\
+ (className *)shared##className { \
static className *shared##className = nil; \
static dispatch_once_t onceToken; \
dispatch_once(&onceToken, ^{ \
shared##className = [[self alloc] init]; \
}); \
return shared##className; \
}

//RGB color macro
#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 \
green:((float)((rgbValue & 0xFF00) >> 8))/255.0 \
blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]
//RGB color macro with alpha
#define UIColorFromRGBWithAlpha(rgbValue,a) [UIColor \
colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 \
green:((float)((rgbValue & 0xFF00) >> 8))/255.0 \
blue:((float)(rgbValue & 0xFF))/255.0 alpha:a]
//RBG color
#define RGBA(r,g,b,a) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:a]

//字符串不为空
#define IS_NOT_EMPTY(string) (string !=nil && [string isKindOfClass:[NSString class]] && ![string isEqualToString:@""])

//数组不为空
#define ARRAY_IS_NOT_EMPTY(array) (array && [array isKindOfClass:[NSArray class]] && [array count])

//是否为汉字
#define IS_CH_SYMBOL(chr) ((int)(chr)>127)

#pragma mark - Api macro

#define HOST_URL @"http://118.244.192.197/fs"

//#define HOST_URL                          @"http://124.193.184.92:8082/fs"//@"http://192.168.23.27:8080/fs"//@"http://192.168.21.20:8080/fs"//@"http://192.168.23.27:8080/fs"//@"http://192.168.23.30:8080/fs"
#define API_GetInfoList                       @"getInfo.asp"

#define brokenNetwork                     @"网络未连接,请检查您的网络设置"

#define mKeyWindow   [UIApplication sharedApplication].keyWindow

//////////////////////////////////接口定义


#define API_QQLOGIN                     @"http://bbs.chinapet.com/plugin.php?id=leepet_thread:api"//QQ登录 须换掉改链接
#define API_QQBANGDING                  @"http://bbs.chinapet.com/plugin.php?id=leepet_thread:api"//QQ绑定   须换掉改链接

#define API_HOMEPAGE                    @"/app/main/home.json"   //首页

#define API_REGISTER                    @"/app/user/register.json"   //注册

#define API_LOGIN                       @"/app/user/login.json"   //登录

#define API_GETCODE                     @"/app/user/getcode.json"   //获取验证码

#define API_CHANGECODE                  @"/app/user/modpwd.json"   //修改密码

#define API_CHANGEHEADIMAGE             @"/app/user/modpic.json"   //修改头像

#define API_UPDATEUSERBANKINFO          @"/app/user/modotherinfo.json"   //更新用户银行卡信息

#define API_UPDATEUSERBASEINFO          @"/app/user/modbaseinfo.json"   //更新用户基本信息

#define API_UPDATEUSERPIC               @"/app/user/modpicinfo.json"   //更新证件照片

#define API_GETFENGKONGINFO             @"/app/user/getuserinfo.json"   //获取用户风控资料

#define API_GETORDERLIST                @"/app/user/orderlist.json"   //获取用户订单列表

#define API_GETDETAILINFO               @"/app/product/detail.json"   //获取商品详情

#define API_GOODSBUYERS                 @"/app/product/buylist.json"   //商品购买详情

#define API_PUSHORDER                   @"/app/order/submit.json"   //提交订单

#define API_PUSHPHONEBOOK               @"/app/user/submitphonelist.json"   //提交通讯录

#define API_GETBACKPW                   @"/app/user/resetpwd.json"   //重置密码

#define API_UPDATEVERSION               @"/app/main/update.json"   //版本更新

#define API_USERBILLS                   @"/app/user/bill.json"   //用户账单信息

#define API_BILLMONTH                   @"/app/user/billmonth.json"   //每月还款记录

#define API_ORDERBILL                   @"/app/user/orderbill.json"   //获取单笔订单的账单明细

#define API_ORDERSIGN                   @"/app/user/ordersign.json"   //确认收货

#define API_CANCLEORDER                 @"/app/order/cancel.json"     //取消订单

#define API_PAY                         @"/app/user/repayment.json"   //还款接口


#define API_LOGOUT                      @""   //退出登录

#define API_REGISTERTONE                @""   //手机注册第一步

#define API_REGISTERTTWO                @""   //手机注册第二步

#define API_EMAILREGISTER                @""   //邮箱注册

#define API_FORGETCODE                  @""    //忘记密码

#define API_FEEDBACK                    @"/app/user/feedback.json"    //意见反馈

#define API_GRADE                       @""     //给我们打分

#define API_UPDATEVERSION               @""     //

//xy
#define API_GETVIESION                @"/app/main/update.json"
#define AboutURLSTRING                  @"/static/app/h5/about.htm"
#define API_GETVIESION                   @"/app/main/update.json"
#define AboutURLSTRING                   @"/static/app/h5/about.htm"

#define KefuURLSTRING                    @"/static/app/h5/customer.htm"
#define JieDaiXieYiURLSTRING             @"/static/app/h5/agreement.htm"
#define ZhuCeXieYiURLSTRING              @"/static/app/h5/register.htm"


#endif
