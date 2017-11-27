//
//  NewsWebViewController.m
//  HWMovie
//
//  Created by hyrMac on 15/7/27.
//  Copyright (c) 2015年 hyrMac. All rights reserved.
//

#import "NewsWebViewController.h"

@interface NewsWebViewController ()

@end

@implementation NewsWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    // webview
//    UIWebView *web1 = [[UIWebView alloc] initWithFrame:self.view.bounds];
//    
//    NSURLRequest *urlRequest = [NSURLRequest requestWithURL:[NSURL URLWithString:@"https://www.baidu.com"]];
//    [web1 loadRequest:urlRequest];
//    [self.view addSubview:web1];
    
    UIWebView *web2 = [[UIWebView alloc] initWithFrame:self.view.bounds];
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"news.html" ofType:nil];
    NSString *htmlStr = [NSString stringWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:nil];
    [web2 loadHTMLString:htmlStr baseURL:nil];
    [self.view addSubview:web2];
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
