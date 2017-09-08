//
//  ViewController.m
//  WKWebVCTest
//
//  Created by apple on 2017/8/8.
//  Copyright © 2017年 apple-fangqiu. All rights reserved.
//

#import "ViewController.h"
#import "WKWebVC.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (IBAction)Click:(UIButton *)sender {
    WKWebVC *web = [[WKWebVC alloc] init];
    [web loadWebURLSring:@"http://czb.fjweicheng.com/"];
    [self.navigationController pushViewController:web animated:YES];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
