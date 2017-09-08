//
//  XWMineInCashVC.m
//  zhangshangPacket
//
//  Created by apple on 2017/5/22.
//  Copyright © 2017年 apple-fangqiu. All rights reserved.
//

#import "XWMineInCashVC.h"
#import "XWChooseMoneyView.h"
@interface XWMineInCashVC ()

@property (nonatomic, strong) UIView *headView;

@property (nonatomic, strong) UIImageView *weixinImg;

/** 微信账号 */
@property (nonatomic, strong) UITextField *wechatTextField;

/** 姓名 */
@property (nonatomic, strong) UITextField *nameTextField;

@property (nonatomic, strong) UILabel *noticeLab;

@property (nonatomic, strong) XWChooseMoneyView *chooseView;

@property (nonatomic, strong) UIButton *duihuanBtn;

@end

@implementation XWMineInCashVC

//设置字体颜色
- (UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;//黑色
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
    self.view.backgroundColor = MainBGColor;
    
    // 设置导航栏标题变大
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(ScreenW/2, self.view.yj_centerX, 80, 40)];
    label.textColor = [UIColor whiteColor];
    label.text = @"提现";
    label.font = [UIFont systemFontOfSize:18];
    self.navigationItem.titleView = label;

    [self setupUI];
    
}

- (void)setupUI
{
    UIView *headView = [[UIView alloc]init];
    self.headView = headView;
    headView.backgroundColor = WhiteColor;
    [self.view addSubview:headView];
    [headView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(0);
        make.left.right.mas_equalTo(0);
        make.height.mas_equalTo(0.45*ScreenH);
        
    }];
    
    
    UIImageView *weixinImage = [[UIImageView alloc]init];
    self.weixinImg = weixinImage;
    weixinImage.image = MyImage(@"icon_treasury_weixin");
    [headView addSubview:weixinImage];
    [weixinImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(headView);
        make.top.mas_equalTo(headView.mas_top).offset(40);
        make.width.height.mas_equalTo(60);
    }];

    UITextField *wechatTextField = [[UITextField alloc]init];
    self.wechatTextField = wechatTextField;
    //wechatTextField.placeholder = @"  请输入微信账号";
    wechatTextField.placeholder = STUserDefaults.phonenum;
    wechatTextField.userInteractionEnabled = NO;
    wechatTextField.font = [UIFont systemFontOfSize:RemindFont(16, 17, 18)];
    wechatTextField.layer.borderColor= MainMidLineColor.CGColor;
    wechatTextField.layer.borderWidth= 1.0f;
    wechatTextField.layer.cornerRadius = 5.0f;

    [headView addSubview:wechatTextField];
    [wechatTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(weixinImage.mas_bottom).offset(10);
        make.height.mas_equalTo(45);
        make.left.mas_equalTo(20);
        make.right.mas_equalTo(-20);
    }];
    
    UITextField *nameTextField = [[UITextField alloc]init];
    self.nameTextField = nameTextField;
    nameTextField.placeholder = @"  请输入微信实名";
    nameTextField.layer.borderColor= MainMidLineColor.CGColor;
    nameTextField.layer.borderWidth= 1.0f;
    nameTextField.layer.cornerRadius = 5.0f;
    nameTextField.font = [UIFont systemFontOfSize:RemindFont(16, 17, 18)];
    [headView addSubview:nameTextField];
    [nameTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(wechatTextField.mas_bottom).offset(10);
        make.height.mas_equalTo(45);
        make.left.mas_equalTo(20);
        make.right.mas_equalTo(-20);
    }];
    
    UIButton *duihuanBtn = [[UIButton alloc]init];
    [duihuanBtn setBackgroundColor:MainRedColor];
    [duihuanBtn setTitle:@"提现" forState:0];
    duihuanBtn.titleLabel.font = [UIFont systemFontOfSize:RemindFont(16, 17, 18)];
    [duihuanBtn setTitleColor:WhiteColor forState:0];
    self.duihuanBtn = duihuanBtn;
    [duihuanBtn addTarget:self action:@selector(chooseTagClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:duihuanBtn];
    [duihuanBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.height.mas_equalTo(50);
        make.bottom.mas_equalTo(self.view.mas_bottom).offset(0);
    }];
    
    XWChooseMoneyView *moneyView = [[XWChooseMoneyView alloc]init];
    self.chooseView = moneyView;
    moneyView.backgroundColor = WhiteColor;
    [self.view addSubview:moneyView];
    [moneyView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.top.mas_equalTo(headView.mas_bottom).offset(10);
        make.bottom.mas_equalTo(self.duihuanBtn.mas_top).offset(0);
    }];
    
    
    
}

- (void)chooseTagClick:(id)sender
{
    

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
