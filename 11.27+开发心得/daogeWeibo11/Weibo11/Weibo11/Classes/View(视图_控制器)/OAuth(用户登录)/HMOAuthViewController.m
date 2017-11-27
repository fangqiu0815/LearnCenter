//
//  HMOAuthViewController.m
//  Weibo11
//
//  Created by 刘凡 on 15/12/6.
//  Copyright © 2015年 itheima. All rights reserved.
//

#import "HMOAuthViewController.h"
#import <SVProgressHUD/SVProgressHUD.h>

@interface HMOAuthViewController () <UIWebViewDelegate>
@property (nonatomic, strong) UIWebView *webView;
@end

@implementation HMOAuthViewController

- (UIWebView *)webView {
    if (_webView == nil) {
        _webView = [[UIWebView alloc] init];
        _webView.delegate = self;
    }
    return _webView;
}

- (void)loadView {
    self.view = self.webView;
    
    self.title = @"登录新浪微博";
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem ff_barButtonWithTitle:@"取消" imageName:nil target:self action:@selector(clickCloseButton)];
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem ff_barButtonWithTitle:@"自动填充" imageName:nil target:self action:@selector(autoFill)];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.webView loadRequest:[NSURLRequest requestWithURL:[HMNetworkTools sharedTools].oauthURL]];
}

#pragma mark - 监听方法
/// 点击关闭按钮
- (void)clickCloseButton {
    [self dismissWithCompletion:nil];
}

/// 关闭当前控制器
- (void)dismissWithCompletion:(void (^)())completion {
    [SVProgressHUD dismiss];
    
    [self.view endEditing:YES];
    [self dismissViewControllerAnimated:(completion == nil) completion:completion];
}

/// 自动填充
- (void)autoFill {
    NSString *js = @"document.getElementById('userId').value = 'daoge10000@sina.cn';" \
    "document.getElementById('passwd').value = 'qqq123';";
    
    [self.webView stringByEvaluatingJavaScriptFromString:js];
}

#pragma mark - UIWebViewDelegate
/// WebView 开始加载代理方法
- (void)webViewDidStartLoad:(UIWebView *)webView {
    [SVProgressHUD show];
}

/// WebView 完成加载代理方法
- (void)webViewDidFinishLoad:(UIWebView *)webView {
    [SVProgressHUD dismiss];
}

/// WebView 将要开始加载请求
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {

    // 判断加载的 URL 是否是回调地址，如果不是就加载
    if (![request.URL.absoluteString hasPrefix:WB_REDIRECT_URL]) {
        return YES;
    }
    
    // 提取 URL 中的 query 字符串
    NSString *query = request.URL.query;
    if ([query hasPrefix:@"code="]) {
        NSString *code = [query substringFromIndex:@"code=".length];
        
        DDLogInfo(@"授权码是 %@", code);
        [[HMUserAccountViewModel sharedUserAccount] accessTokenWithCode:code completed:^(BOOL isSuccessed) {
           
            if (!isSuccessed) {
                [SVProgressHUD showInfoWithStatus:@"网络访问错误"];
                
                return;
            }
            
            DDLogInfo(@"用户登录成功 %@", [HMUserAccountViewModel sharedUserAccount].userAccount);
            [self dismissWithCompletion:^{
                [[NSNotificationCenter defaultCenter] postNotificationName:HMSwitchRootViewControllerNotification object:self];
            }];
        }];
    } else {
        DDLogInfo(@"取消授权");
        
        [self dismissWithCompletion:nil];
    }
    
    return NO;
}

@end
