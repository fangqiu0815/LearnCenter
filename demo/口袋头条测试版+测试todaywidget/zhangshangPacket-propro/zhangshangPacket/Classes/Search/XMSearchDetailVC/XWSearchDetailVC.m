//
//  XWSearchDetailVC.m
//  zhangshangPacket
//
//  Created by apple on 2017/5/27.
//  Copyright © 2017年 apple-fangqiu. All rights reserved.
//

#import "XWSearchDetailVC.h"
@interface XWSearchDetailVC ()<WKNavigationDelegate,WKUIDelegate,UINavigationBarDelegate>
{
    NSInteger isFinishWeb;
}
@property (assign, nonatomic) NSUInteger loadCount;
@property (strong, nonatomic) UIProgressView *progressView;
@property (strong, nonatomic) WKWebView *wkWebView;



@end

@implementation XWSearchDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configUI];
    
//    //添加右边分享按钮
//    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamedWithRenderOriginal:@"icon_share"] style:UIBarButtonItemStyleDone target:self action:@selector(shareClick:)];
    
}

//- (void)shareClick:(id)sender
//{
//    XWPublishView *publishView = [[XWPublishView alloc]initWithFrame:[UIScreen mainScreen].bounds];
//    publishView.delegate = self;
//    [publishView  show];
//    
//}

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


- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self preferredStatusBarStyle];
    [self setStatusBarBackgroundColor:MainRedColor];
    self.tabBarController.tabBar.hidden = YES;
    self.navigationController.navigationBar.translucent = NO;
    
    self.navigationController.navigationBar.dk_barTintColorPicker = DKColorPickerWithColors(MainRedColor,NightMainNaviColor,MainRedColor);

}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [SVProgressHUD dismiss];
}

-(void)leftButtonClick{
    if (self.wkWebView.canGoBack) {
        [self.wkWebView goBack];
    }else{
        [self.navigationController popViewControllerAnimated:YES];
    }
}

- (void)configUI{
    
    // 进度条
    UIProgressView *progressView = [[UIProgressView alloc] initWithFrame:CGRectMake(0, ALL_NAVIGATION_HEIGHT, IPHONE_W, 0)];
    progressView.tintColor = [UIColor orangeColor];
    progressView.trackTintColor = [UIColor whiteColor];
    [self.view addSubview:progressView];
    self.progressView = progressView;
    // 网页
    WKWebView *wkWebView = [[WKWebView alloc] initWithFrame:CGRectMake(0, ALL_NAVIGATION_HEIGHT, IPHONE_W, IPHONE_H-ALL_NAVIGATION_HEIGHT)];
    wkWebView.autoresizingMask = UIViewAutoresizingNone;
    wkWebView.contentMode = UIViewContentModeTop;
    
    [self.wkWebView xw_setDayMode:^(UIView *view) {
        WKWebView *bar = (WKWebView *)view;
        bar.backgroundColor = WhiteColor;
    } nightMode:^(UIView *view) {
        WKWebView *bar = (WKWebView *)view;
        bar.backgroundColor = NightMainBGColor;
    }];
    
    wkWebView.navigationDelegate = self;
    wkWebView.UIDelegate = self;
    //    [self.view insertSubview:wkWebView belowSubview:progressView];
    [self.view addSubview:wkWebView];
    [wkWebView addObserver:self forKeyPath:@"estimatedProgress" options:NSKeyValueObservingOptionNew context:nil];
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:self.url]];
    [wkWebView loadRequest:request];
    self.wkWebView = wkWebView;
}

// 计算wkWebView进度条
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    if (object == self.wkWebView && [keyPath isEqualToString:@"estimatedProgress"]) {
        CGFloat newprogress = [[change objectForKey:NSKeyValueChangeNewKey] doubleValue];
        if (newprogress == 1) {
            self.progressView.hidden = YES;
            [self.progressView setProgress:0 animated:NO];
        }else {
            self.progressView.hidden = NO;
            [self.progressView setProgress:newprogress animated:YES];
        }
    }
}

#pragma mark - webView代理

// 计算webView进度条
- (void)setLoadCount:(NSUInteger)loadCount {
    _loadCount = loadCount;
    if (loadCount == 0) {
        self.progressView.hidden = YES;
        [self.progressView setProgress:0 animated:NO];
    }else {
        self.progressView.hidden = NO;
        CGFloat oldP = self.progressView.progress;
        CGFloat newP = (1.0 - oldP) / (loadCount + 1) + oldP;
        if (newP > 0.95) {
            newP = 0.95;
        }
        [self.progressView setProgress:newP animated:YES];
    }
}

#pragma mark - WKUIDelegate
-(WKWebView *)webView:(WKWebView *)webView createWebViewWithConfiguration:(WKWebViewConfiguration *)configuration forNavigationAction:(WKNavigationAction *)navigationAction windowFeatures:(WKWindowFeatures *)windowFeatures
{
    if (!navigationAction.targetFrame.isMainFrame) {
        [webView loadRequest:navigationAction.request];
    }
    return nil;
}

-(void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation{
    self.loadCount ++;
    [SVProgressHUD show];
    
//    if (isFinishWeb == 1) {
//        [SVProgressHUD dismiss];
//    } else {
//        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(10.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//            [SVProgressHUD showErrorWithStatus:@"网络错误"];
//
//        });
//    }
}

-(void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation{
    self.loadCount --;
    isFinishWeb = 1;
    //self.title = webView.title;
    [SVProgressHUD dismiss];
    
}

- (void)webView:(WKWebView *)webView didFailNavigation:(WKNavigation *)navigation withError:(NSError *)error
{
    [SVProgressHUD showErrorWithStatus:@"网络出错"];
    JLLog(@"error---%@",error);
}

- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(WKNavigation *)navigation withError:(NSError *)error
{
    [SVProgressHUD showErrorWithStatus:@"网络出错"];
}


// 记得取消监听
- (void)dealloc {
    [self.wkWebView removeObserver:self forKeyPath:@"estimatedProgress"];
    [SVProgressHUD dismiss];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
