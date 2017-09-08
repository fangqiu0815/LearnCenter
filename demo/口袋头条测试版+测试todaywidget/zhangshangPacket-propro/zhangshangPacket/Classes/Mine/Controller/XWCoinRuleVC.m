//
//  XWCoinRuleVC.m
//  zhangshangPacket
//
//  Created by apple on 2017/6/2.
//  Copyright © 2017年 apple-fangqiu. All rights reserved.
//

#import "XWCoinRuleVC.h"

@interface XWCoinRuleVC ()
<UIWebViewDelegate>
{
    UIWebView *personWebView;
}
@end

@implementation XWCoinRuleVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 设置导航栏标题变大
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(ScreenW/2, self.view.yj_centerX, 80, 40)];
    label.textColor = [UIColor whiteColor];
    label.text = @"元宝规则";
    label.font = [UIFont systemFontOfSize:18];
    self.navigationItem.titleView = label;
    
    self.view.backgroundColor = MainBGColor;
    [self addView];
}

- (void)addView
{
    JLLog(@"stuser.htmlurl = %@",STUserDefaults.htmlurl);
    NSString *url = [NSString stringWithFormat:@"%@%@",STUserDefaults.htmlurl,@"html/aboutIngot.html"];
    NSLog(@"元宝规则URL：%@",url);
    personWebView = [[UIWebView alloc]initWithFrame:self.view.frame];
    [personWebView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:url] cachePolicy:NSURLRequestReloadIgnoringLocalCacheData timeoutInterval:60.0]];
    personWebView.delegate = self;
    [self.view addSubview:personWebView];
    
    
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

- (void)dealloc
{
    JLLog(@"dealloc");
    
}

//设置字体颜色
- (UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
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

    self.navigationController.navigationBarHidden = NO;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
