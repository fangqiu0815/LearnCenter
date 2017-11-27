//
//  PYWebController.m
//  youzhu
//
//  Created by 谢培艺 on 16/1/27.
//  Copyright © 2016年 iphone5solo. All rights reserved.
//

#import "PYWebController.h"
#import "YJWebProgressLayer.h"
#import <UMSocialCore/UMSocialCore.h>
#import <UMengUShare/UShareUI/UMSocialUIManager.h>
#import "PYResource.h"
#import "UIBarButtonItem+PYExtension.h"
#import "PYHUD.h"
#import <WebKit/WebKit.h>

@interface PYWebController () <WKNavigationDelegate>
/** 加载进度条 */
@property (nonatomic, strong) YJWebProgressLayer *webProgressLayer;
/** 加载网页 */
@property (nonatomic, strong) WKWebView *webView;
/** 网络加载失败提示 */
@property (nonatomic, strong) PYHUD *loadFailView;
/** 当前请求 */
@property (nonatomic, strong) NSURLRequest *request;

@end

@implementation PYWebController

- (PYHUD *)loadFailView
{
    if (!_loadFailView) {
        PYHUD *loadFailView = [[PYHUD alloc]initWithFrame:self.view.bounds];
        loadFailView.indicatorBackGroundColor = [UIColor clearColor];
        loadFailView.messageLabel.text = @"网络迷路了...\n快点我刷新下";
        loadFailView.backgroundColor = [UIColor whiteColor];
        loadFailView.customImage = [UIImage imageNamed:@"networkError"];
        __weak typeof(self) weakSelf = self;
        [loadFailView refreshWhenNwrworkError:^(PYHUD *hud) {
            [weakSelf.webView loadRequest:self.request];
        }];
        _loadFailView = loadFailView;
    }
    return _loadFailView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 设置UI
    [self setupUI];
}

- (void)setupUI {
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.view.frame = CGRectMake(0, 64, self.view.bounds.size.width, self.view.bounds.size.height - 64);
    _webView = [[WKWebView alloc] initWithFrame:self.view.frame];
    _webView.navigationDelegate = self;
    _webView.backgroundColor = [UIColor whiteColor];
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:self.url]];
    self.request = request;
    [_webView loadRequest:request];
    _webProgressLayer = [[YJWebProgressLayer alloc] init];
    _webProgressLayer.frame = CGRectMake(0, 42, self.view.frame.size.width, 2);
    _webProgressLayer.strokeColor = self.progressColor.CGColor;
    [self.navigationController.navigationBar.layer addSublayer:_webProgressLayer];
    [self.view addSubview:_webView];
    
    // 设置导航栏
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem py_itemWithViewController:self action:@selector(back) image:@"back_normal" highlightImage:nil];
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem py_itemWithViewController:self action:@selector(share) image:@"share_normal" highlightImage:nil];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.title = self.webTitle.length > 0 ? self.webTitle : self.resource.type;
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
}

- (void)share
{
    // 分享
    //显示分享面板
    [UMSocialUIManager showShareMenuViewInWindowWithPlatformSelectionBlock:^(UMSocialPlatformType platformType, NSDictionary *userInfo) {
        //Do Something
        [self shareWebPageToPlatformType:platformType];
    }];
}

- (void)shareWebPageToPlatformType:(UMSocialPlatformType)platformType
{
    //创建分享消息对象
    UMSocialMessageObject *messageObject = [UMSocialMessageObject messageObject];
    NSArray *types = @[@"Android", @"iOS", @"前端", @"瞎推荐", @"拓展资源", @"App", @"休息视频"];
    NSArray *imageNames = @[@"android", @"ios", @"front", @"recommend", @"expand", @"app", @"video"];
    // 取出分类
    NSString *type = self.resource.type;
    NSString *imageName = imageNames[[types indexOfObject:type]];
    //创建网页内容对象
    UMShareWebpageObject *shareObject = [UMShareWebpageObject shareObjectWithTitle:@"干货集中营" descr:self.resource.desc thumImage:[UIImage imageNamed:imageName]];
    //设置网页地址
    shareObject.webpageUrl = self.url;
    
    //分享消息对象设置分享内容对象
    messageObject.shareObject = shareObject;
    
    //调用分享接口
    [[UMSocialManager defaultManager] shareToPlatform:platformType messageObject:messageObject currentViewController:self completion:^(id data, NSError *error) {
        if (error) {
            NSLog(@"************Share fail with error %@*********",error);
        } else {
            NSLog(@"response data is %@",data);
        }
    }];
}

- (void)back
{
    if ([self.navigationController childViewControllers].count > 1) {
        [self.navigationController popViewControllerAnimated:YES];
    } else {
        [self.navigationController dismissViewControllerAnimated:YES completion:nil];
    }
    
    // 移除进度条
    [self.webProgressLayer removeFromSuperlayer];
    
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
}

#pragma mark - UIWebViewDelegate
- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation {
    [self.loadFailView hide];
    [_webProgressLayer startLoad];
}

- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation {
    [_webProgressLayer finishedLoadWithError:nil];
}

- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(WKNavigation *)navigation withError:(NSError *)error {
    [_webProgressLayer finishedLoadWithError:error];
    // 网络加载异常
    [self.loadFailView showAtView:self.webView hudType:JHUDLoadingTypeCustomAnimations];
}

- (void)dealloc {
    [_webProgressLayer closeTimer];
    [_webProgressLayer removeFromSuperlayer];
    _webProgressLayer = nil;
}

@end
