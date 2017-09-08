//
//  XWMineHelpVC.m
//  zhangshangPacket
//
//  Created by apple on 2017/5/12.
//  Copyright © 2017年 apple-fangqiu. All rights reserved.
//

#import "XWMineHelpVC.h"


@interface XWMineHelpVC ()<UIWebViewDelegate>
{
    UIWebView *personWebView;
}


@end

@implementation XWMineHelpVC


//设置字体颜色
- (UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;//bai色
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
    [self preferredStatusBarStyle];
    [self setStatusBarBackgroundColor:MainRedColor];
    self.navigationController.navigationBar.translucent = NO;
    self.navigationController.navigationBar.dk_barTintColorPicker = DKColorPickerWithColors(MainRedColor,NightMainNaviColor,MainRedColor);
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 设置导航栏标题变大
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(ScreenW/2, self.view.yj_centerX, 80, 40)];
    label.textColor = [UIColor whiteColor];
    label.text = @"帮助中心";
    label.font = [UIFont systemFontOfSize:18];
    self.navigationItem.titleView = label;
    [self addView];
    
}

- (void)addView
{
    JLLog(@"stuser.htmlurl = %@",STUserDefaults.htmlurl);
    NSString *url = [NSString stringWithFormat:@"%@%@",STUserDefaults.htmlurl,@"html/appGuide.html"];
    NSLog(@"帮助中心URL：%@",url);
    personWebView = [[UIWebView alloc]initWithFrame:self.view.frame];
    [personWebView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:url] cachePolicy:NSURLRequestReloadIgnoringLocalCacheData timeoutInterval:60.0]];
    personWebView.delegate = self;
    [self.view addSubview:personWebView];

   
}

- (void)viewWillDisappear:(BOOL)animated
{
    //清除请求
    [[NSURLCache sharedURLCache] removeAllCachedResponses];
    //清除cookies
    NSHTTPCookie *cookie;
    NSHTTPCookieStorage *storage = [NSHTTPCookieStorage sharedHTTPCookieStorage];
    for (cookie in [storage cookies]) {
        [storage deleteCookie:cookie];
    }
}

-(void)webViewDidStartLoad:(UIWebView *)webView
{
    [SVProgressHUD showWithStatus:@"加载数据中" maskType:SVProgressHUDMaskTypeBlack];
    
}
-(void)webViewDidFinishLoad:(UIWebView *)webView
{
    
    [SVProgressHUD dismiss];
    
}
-(void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    [SVProgressHUD dismiss];
    NSString *errorStr=[NSString stringWithFormat:@"%@",error];
    [SVProgressHUD showErrorWithStatus:errorStr];
    
}

@end
