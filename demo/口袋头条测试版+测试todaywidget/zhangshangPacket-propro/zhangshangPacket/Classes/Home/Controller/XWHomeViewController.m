//
//  XWHomeViewController.m
//  zhangshangPacket
//
//  Created by apple on 2017/5/25.
//  Copyright © 2017年 apple-fangqiu. All rights reserved.
//

#import "XWHomeViewController.h"
#import "XWHomeDetailVC.h"
#import "XWHomeJokeVC.h"
#import "XWHeadView.h"
#import "XWTitleImageView.h"
#import "XWLoginVC.h"
#import "XWHomeTodayVC.h"
#import "XWHomeTecoVC.h"
#import "XWHomeFinanceVC.h"
#import "XWHomeInportVC.h"
#import "XWRegisterVC.h"
#import "XWPublishInformView.h"
#import "XWWKWebTodayVC.h"
#import "XWTabBarVC.h"
#import "WKWebViewController.h"

@interface XWHomeViewController ()<XFPublishViewDelegate>
{
    UIButton *_button;
    UIWindow *_window;

}
//@property (nonatomic, strong) WMPageController *pageController;

@property (nonatomic, strong) NSArray *titleData;
@property (nonatomic, strong) NSArray *IDData;
@property (nonatomic, strong) XWTabBarVC *tabbar;
@end

@implementation XWHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [[NSNotificationCenter defaultCenter ]addObserver:self selector:@selector(jiaguClick) name:@"XWJIAGUGETUDIDCLICK" object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(randomClick) name:@"XWPUBLISHMOREINFOVIEW" object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(pushClick:) name:@"NotificationPushWkWebview" object:nil];
   
}

//设置字体颜色
- (UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;//白色
}

//设置状态栏颜色
- (void)setStatusBarBackgroundColor:(UIColor *)color {
    
//    UIView *statusBar = [[[UIApplication sharedApplication] valueForKey:@"statusBarWindow"] valueForKey:@"statusBar"];
//    if ([statusBar respondsToSelector:@selector(setBackgroundColor:)]) {
//        statusBar.backgroundColor = color;
//    }
    
}

//！！！重点在viewWillAppear方法里调用下面两个方法
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self preferredStatusBarStyle];
    [self setStatusBarBackgroundColor:MainRedColor];
    self.navigationController.navigationBar.translucent = NO;
    self.navigationItem.titleView = [[UIImageView alloc]initWithImage:MyImage(@"icon_logo")];
    self.navigationController.navigationBar.dk_barTintColorPicker = DKColorPickerWithColors(MainRedColor,NightMainNaviColor,MainRedColor);
    self.menuView.dk_backgroundColorPicker = DKColorPickerWithColors(WhiteColor,NightMainNaviColor,MainRedColor);
    
    self.titleColorNormal = NightMainTextColor;
    self.titleColorSelected = MainRedColor;
    self.menuView.lineColor = MainRedColor;

    self.hidesBottomBarWhenPushed = NO;
    if (STUserDefaults.ischeck == 1) {
        
    } else {
        
        [self createSuspendButton];

    }
    
}

#pragma mark - 创建悬浮的按钮
- (void)createSuspendButton
{
    _button = [UIButton buttonWithType:UIButtonTypeCustom];
//    [_button setTitle:@"按钮" forState:UIControlStateNormal];
    [_button setImage:MyImage(@"icon_hongbao_mission") forState:0];
    [_button setImage:MyImage(@"icon_hongbao_mission_fill") forState:UIControlStateHighlighted];
//    [_button setTitleColor:WhiteColor forState:0];
    [_button addTarget:self action:@selector(clickWindow) forControlEvents:UIControlEventTouchUpInside];
    [_button sizeToFit];
    JLLog(@"%f---%f",_button.yj_width,_button.yj_height);
    _button.yj_x = ScreenW - _button.yj_width - 30*AdaptiveScale_W;
    _button.yj_y = ScreenH - _button.yj_height - 150*AdaptiveScale_W;
    JLLog(@"");
//    _window = [[UIWindow alloc]initWithFrame:CGRectMake(ScreenW - 70*AdaptiveScale_W, ScreenH - 160*AdaptiveScale_W, 45*AdaptiveScale_W, 65*AdaptiveScale_W)];
//    _window.windowLevel = UIWindowLevelNormal;
////    _window.backgroundColor = CUSTOMCOLORA(244, 75, 80, 0.6);
////    _window.layer.cornerRadius = 30;
////    _window.layer.masksToBounds = YES;
//    [_window addSubview:_button];
//    [_window makeKeyAndVisible];//关键语句,显示window
    _button.layer.zPosition = 100000;
    [self.view addSubview:_button];
//    [_button mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.right.mas_equalTo(40*AdaptiveScale_W);
//        make.bottom.mas_equalTo(100*AdaptiveScale_W);
//        make.height.mas_equalTo(65*AdaptiveScale_W);
//        make.width.mas_equalTo(45*AdaptiveScale_W);
//    }];
    
    
}

//红包点击跳转地址
- (void)clickWindow
{
    JLLog(@"clickWindow");
    
    if ([STUserDefaults.eventurl isEqualToString:@""]) {
        //跳转任务界面
        self.tabBarController.selectedIndex = 2;
        
    } else {
        //跳转内部浏览器
        XWWKWebTodayVC *webVC = [[XWWKWebTodayVC alloc] init];
        [webVC loadWebURLSring:STUserDefaults.eventurl];
        
        // 设置导航栏标题变大
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(ScreenW/2 - 20, self.view.yj_centerX, 80, 40)];
        label.textColor = [UIColor whiteColor];
        label.font = [UIFont systemFontOfSize:18];
        label.text = @"红包";
        webVC.navigationItem.titleView = label;
        
        [self setHidesBottomBarWhenPushed:YES];//隐藏tabbar
        [self.navigationController pushViewController:webVC animated:YES];
        
    }
    
//    XWWKWebTodayVC *webVC = [[XWWKWebTodayVC alloc] init];
//    [webVC loadWebURLSring:STUserDefaults.eventurl];
//    [webVC setHidesBottomBarWhenPushed:YES];
//    
//    XWTabBarVC *tabBarVc = (XWTabBarVC *)[UIApplication sharedApplication].keyWindow.rootViewController;
//    //取出当前选中的导航控制器
//    XWNavigationVC *Nav = tabBarVc.viewControllers[tabBarVc.selectedIndex];
//    [Nav pushViewController:webVC animated:YES];
    
}

- (void)pushClick:(NSNotification *)noti
{
    
    WKWebViewController *wkwebview = [[WKWebViewController alloc]init];
    [wkwebview loadWebURLSring:noti.userInfo[@"url"]];
    wkwebview.titleStr = noti.userInfo[@"alert"];
    wkwebview.contentStr = noti.userInfo[@"content"];
    JLLog(@"url---%@\ntitle---%@\ncontent---%@",noti.userInfo[@"url"],wkwebview.titleStr,wkwebview.contentStr);
    [self.navigationController pushViewController:wkwebview animated:YES];
    
}

#pragma mark 标题数组
- (NSArray *)titleData {
    if (!_titleData) {
        _titleData = STUserDefaults.mainfuncs;
    }
    return _titleData;
    
}

- (NSArray *)IDData
{
    if (!_IDData) {
        _IDData = STUserDefaults.mainfuncsID;
    }
    return _IDData;
}

#pragma mark 初始化代码
- (instancetype)init {
    if (self = [super init]) {

        self.menuViewStyle = WMMenuViewStyleLine;
        self.titleSizeNormal = RemindFont(14, 15, 16);
        self.titleSizeSelected = RemindFont(16, 17, 18);
        JLLog(@"%d",STUserDefaults.isnight);
        self.menuView.lineColor = MainRedColor;
        self.titleColorNormal = NightMainTextColor;
        self.titleColorSelected = MainRedColor;
        if (self.titleData.count > 5) {
            self.menuItemWidth = 80;
        } else {
            self.menuItemWidth = (ScreenW) / self.titleData.count;
        }
        
        self.menuHeight = 44;
        self.showOnNavigationBar = NO;
        
    }
    return self;
}


#pragma mark 返回子页面的个数
- (NSInteger)numbersOfChildControllersInPageController:(WMPageController *)pageController {
    return self.titleData.count;
}

#pragma mark 返回某个index对应的页面
- (UIViewController *)pageController:(WMPageController *)pageController viewControllerAtIndex:(NSInteger)index {
    
    
    switch ([self.IDData[index] integerValue] - 1) {
        case 0:{
            //推荐
            XWHomeDetailVC   *vcClass = [[XWHomeDetailVC alloc] init];
            // vcClass.title = @"推荐";
            
            return vcClass;
        }
            break;
            
        case 1:{
            //热搜
            XWHomeDetailVC   *vcClass = [[XWHomeDetailVC alloc] init];
            // vcClass.title = @"推荐";
            
            return vcClass;
        }
            break;
            
        case 2:{
            //历史上的今天
            XWHomeTodayVC *vcClass = [[XWHomeTodayVC alloc]init];
            //   vcClass.title = @"历史上的今天";
            return vcClass;
            
        }
            break;
            
        case 3:{
            //笑话
            XWHomeJokeVC *vcClass = [[XWHomeJokeVC alloc]init];
            // vcClass.title = @"笑话";
            return vcClass;
        }
            break;
            
        case 4:{
            //自然
            XWHomeDetailVC   *vcClass = [[XWHomeDetailVC alloc] init];
            // vcClass.title = @"推荐";
            
            return vcClass;
        }
            break;
            
        case 5:{
            //人文
            XWHomeDetailVC   *vcClass = [[XWHomeDetailVC alloc] init];
            // vcClass.title = @"推荐";
            
            return vcClass;
        }
            break;
            
        case 6:{
            //旅游
            XWHomeDetailVC   *vcClass = [[XWHomeDetailVC alloc] init];
            // vcClass.title = @"推荐";
            
            return vcClass;
        }
            break;
            
        case 7:{
            //情感
            XWHomeDetailVC   *vcClass = [[XWHomeDetailVC alloc] init];
            // vcClass.title = @"推荐";
            
            return vcClass;
        }
            break;
            
        case 8:{
            //娱乐
            XWHomeInportVC *vcClass = [[XWHomeInportVC alloc]init];
            return vcClass;
            
        }
            break;
            
        case 9:{
            //科技
            XWHomeTecoVC *vcClass = [[XWHomeTecoVC alloc]init];
            return vcClass;
        }
            break;
            
        case 10:{
            //财经
            XWHomeFinanceVC *vcClass = [[XWHomeFinanceVC alloc]init];
            return vcClass;
        }
            break;
        case 11:{
            //本地
            XWHomeFinanceVC *vcClass = [[XWHomeFinanceVC alloc]init];
            return vcClass;
        }
            break;
            
        default:{
            //其他
            
            XWHomeJokeVC *vcClass = [[XWHomeJokeVC alloc]init];
            // vcClass.title = @"笑话";
            return vcClass;
            
        }
            break;
    }
    
}

#pragma mark 返回index对应的标题
- (NSString *)pageController:(WMPageController *)pageController titleAtIndex:(NSInteger)index {
    self.selectItemIndex = [self.titleData[index] integerValue ];
    return self.titleData[index];
}

- (void)randomClick
{
//    XWLoginVC *loginVc = [[XWLoginVC alloc]init];
//    [self presentViewController:loginVc animated:YES completion:nil];
//    
//    XWRegisterVC *loginVc = [[XWRegisterVC alloc]init];
//    [self.navigationController pushViewController:loginVc animated:YES];
    XWPublishInformView *publishView = [[XWPublishInformView alloc]initWithFrame:CGRectMake(0, 0, ScreenW, ScreenH)];
    publishView.layer.zPosition = 10000;
    publishView.layer.masksToBounds = YES;
    publishView.layer.cornerRadius = 5.0;
    publishView.delegate = self;
    [publishView  show];
    
}


#pragma mark ============== 请求加固的方法 ================
- (void)jiaguClick
{
    JLLog(@"jiaguClick----请求加固的方法");
    [STRequest ProjectAddIDDataBlock:^(id ServersData, BOOL isSuccess) {
        JLLog(@"加固--serverdata---%@",ServersData);
        if (isSuccess) {
            if ([ServersData isKindOfClass:[NSDictionary class]]) {
                if ([ServersData[@"c"] integerValue] == 1) {
                    
                    NSDictionary *dictemp = [NSDictionary dictionaryWithDictionary:ServersData[@"d"]];
                    if ([dictemp count] == 0) {
                        JLLog(@"d下面没值");
                    } else {
                        NSInteger status = [dictemp[@"status"] integerValue];
                        NSString *url = dictemp[@"url"];
                        
                        if (status == 1) {
                            JLLog(@"需要加固");
                            if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:url]]) {
                                [[UIApplication sharedApplication] openURL:[NSURL URLWithString:url]];
                            }
                        } else {
                            JLLog(@"不需要加固");
                            STUserDefaults.isJiagu = 1;
                        }
                    }
                    
                } else {
                    JLLog(@"%@",ServersData[@"m"]);
                }
                
            }else{
                JLLog(@"请求到json格式不对不是字典类型");
            }
        } else {
            
            JLLog(@"请求接口不成功");
        }
        
    }];
    

}


- (void)dealloc
{
    JLLog(@"dealloc");
//    [_button removeFromSuperview];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"XWJIAGUGETUDIDCLICK" object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"XWPUBLISHMOREINFOVIEW" object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"NotificationPushWkWebview" object:nil];

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






@end
