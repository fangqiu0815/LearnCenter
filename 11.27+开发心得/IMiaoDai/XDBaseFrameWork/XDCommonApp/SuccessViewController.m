//
//  SuccessViewController.m
//  XDCommonApp
//
//  Created by xindao on 14-8-6.
//  Copyright (c) 2014年 XD-XY. All rights reserved.
//

#import "SuccessViewController.h"
#import "MyOrdersViewController.h"
@implementation SuccessViewController
- (void)viewDidLoad{
    [super viewDidLoad];
    self.titleLabel.text = @"订单提交";

    float h = 0;
    if (IOS7) {
        h = 20;
    }
    UIButton * backBtn = [XDTools getAButtonWithFrame:CGRectMake(0, h+7, 50, 30) nomalTitle:@"首页" hlTitle:@"首页" titleColor:[UIColor whiteColor] bgColor:UIColorFromRGB(0xf18d00) nbgImage:nil hbgImage:nil action:@selector(backToRoot) target:self buttonTpye:UIButtonTypeCustom];
    [self.navigationBarView addSubview:backBtn];

    self.leftBtn.hidden = YES;
//    [self.leftBtn setTitle:@"首页" forState:UIControlStateNormal];
//    [self.leftBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];

    UIImageView * IV = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, 300, 43/2.0f)];
    IV.image = [UIImage imageNamed:@"jdt03"];
    [self.contentView addSubview:IV];

    UIView * bg = [[UIView alloc] initWithFrame:CGRectMake(0, 40, UI_SCREEN_WIDTH, 160)];
    bg.backgroundColor = [UIColor whiteColor];
    [self.contentView addSubview:bg];

    for (int i = 0; i < 2; i++) {
        UIImageView * line = [[UIImageView alloc] initWithFrame:CGRectMake(0, i*159.5f, UI_SCREEN_WIDTH, .5f)];
        line.image = [UIImage imageNamed:@"line"];
        [bg addSubview:line];
    }

    UILabel * label1 = [XDTools addAlabelForAView:bg withText:@"喵~订单提交成功" frame:CGRectMake(0,12,UI_SCREEN_WIDTH,25) font:[UIFont systemFontOfSize:17] textColor:UIColorFromRGB(0x4ea96c)];
    label1.textAlignment = NSTextAlignmentCenter;
    UILabel * label2 = [XDTools addAlabelForAView:bg withText:@"订单已进入审核中，喵小贷会在1个工作日内完成审核" frame:CGRectMake(0,height_y(label1)+10,UI_SCREEN_WIDTH,15) font:[UIFont systemFontOfSize:13] textColor:UIColorFromRGB(0x6a6a6a)];
    label2.textAlignment = NSTextAlignmentCenter;
    UILabel * label3 = [XDTools addAlabelForAView:bg withText:@"审核结果请到我的订单页面查看。\n表捉急哦！" frame:CGRectMake(0,height_y(label2),UI_SCREEN_WIDTH,40) font:[UIFont systemFontOfSize:13] textColor:UIColorFromRGB(0x6a6a6a)];
    label3.numberOfLines = 0;
//    label3.backgroundColor = [UIColor orangeColor];
    label3.textAlignment = NSTextAlignmentCenter;


    UIButton * btn = [XDTools getAButtonWithFrame:CGRectMake(85, height_y(label3)+10, 150, 40) nomalTitle:@"查看订单状态" hlTitle:@"查看订单状态" titleColor:[UIColor whiteColor] bgColor:UIColorFromRGB(0xf18d00) nbgImage:nil hbgImage:nil action:@selector(gotoOrder) target:self buttonTpye:UIButtonTypeCustom];
    [bg addSubview:btn];


}

- (void)backToRoot{
    UIAlertView * alert = [[UIAlertView alloc] initWithTitle:nil message:@"真的要返回首页吗？" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    alert.delegate = self;
    [alert show];
}


#pragma mark - AlertView Delegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex) {
        [self.navigationController popToRootViewControllerAnimated:YES];
    }
}

- (void)alertViewCancel:(UIAlertView *)alertView{
    [alertView dismissWithClickedButtonIndex:0 animated:YES];
}


- (void)gotoOrder{
    MyOrdersViewController * orders = [[MyOrdersViewController alloc] init];
    [self.navigationController pushViewController:orders animated:YES];
}
@end
