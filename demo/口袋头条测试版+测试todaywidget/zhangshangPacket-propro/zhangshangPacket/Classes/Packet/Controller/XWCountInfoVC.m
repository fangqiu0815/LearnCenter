//
//  XWCountInfoVC.m
//  zhangshangPacket
//
//  Created by apple on 2017/5/16.
//  Copyright © 2017年 apple-fangqiu. All rights reserved.
//

#import "XWCountInfoVC.h"
#import "XWXianJinVC.h"
#import "XWJinBiVC.h"
#import "WMPageController.h"


@interface XWCountInfoVC ()

@property (nonatomic, strong) NSMutableArray *infoArr;

@end

@implementation XWCountInfoVC

- (void)viewDidLoad {
    [super viewDidLoad];

    // 设置导航栏标题变大
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(ScreenW/2, self.view.yj_centerX, 80, 40)];
    label.textColor = [UIColor whiteColor];
    label.text = @"收支明细";
    label.font = [UIFont systemFontOfSize:18];
    self.navigationItem.titleView = label;
    self.view.backgroundColor = MainBGColor;
    
    
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
    [super viewWillAppear:animated];

    [self preferredStatusBarStyle];
    [self setStatusBarBackgroundColor:MainRedColor];
    self.navigationController.navigationBar.translucent = NO;
    self.navigationController.navigationBar.dk_barTintColorPicker = DKColorPickerWithColors(MainRedColor,NightMainNaviColor,MainRedColor);
    self.menuView.dk_backgroundColorPicker = DKColorPickerWithColors(WhiteColor,NightMainNaviColor,MainRedColor);
    
    
    
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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
