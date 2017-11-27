//
//  ViewController.m
//  STEncryptUtils
//
//  Created by yls on 14-1-15.
//  Copyright (c) 2014年 yls. All rights reserved.
//

#import "ViewController.h"
#import "STEncryptUtils.h"

// 秘钥
#define Key @"stlwtr"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    NSString *pwd = @"123456";
    // 加密
    NSString *enPwd = [pwd encryptWithKey:Key];
    
    NSLog(@"%@", enPwd);
    
    // 解密
    NSString *dePwd = [enPwd decryptWithKey:Key];
    
    NSLog(@"%@", dePwd);
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
