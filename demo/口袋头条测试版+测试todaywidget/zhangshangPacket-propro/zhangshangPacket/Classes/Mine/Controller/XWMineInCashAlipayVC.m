//
//  XWMineInCashAlipayVC.m
//  zhangshangPacket
//
//  Created by apple on 2017/6/13.
//  Copyright © 2017年 apple-fangqiu. All rights reserved.
//

#import "XWMineInCashAlipayVC.h"
#import "XWChooseMoneyView.h"
#import "XWAliTixianVC.h"
@interface XWMineInCashAlipayVC ()
{
    NSString *_str;
}
@property (nonatomic, strong) UIView *headView;

@property (nonatomic, strong) UIImageView *aliImg;

/** 微信账号 */
@property (nonatomic, strong) UITextField *alipayTextField;

/** 姓名 */
@property (nonatomic, strong) UITextField *nameTextField;

@property (nonatomic, strong) UILabel *noticeLab;

@property (nonatomic, strong) XWChooseMoneyView *chooseView;

@property (nonatomic, strong) UIButton *duihuanBtn;
@end

@implementation XWMineInCashAlipayVC

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
    [super viewWillAppear:animated];
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
//    UIScrollView *scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, ScreenW, ScreenH)];
//    scrollView.contentSize = CGSizeMake(ScreenW, ScreenH);
//    scrollView.backgroundColor = MainBGColor;
//    [self.view addSubview:scrollView];
    
    UIView *headView = [[UIView alloc]init];
    self.headView = headView;
    headView.backgroundColor = WhiteColor;
    [self.view addSubview:headView];
    [headView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(0);
        make.left.right.mas_equalTo(0);
        make.height.mas_equalTo(0.45*ScreenH);
        
    }];
    
    UIImageView *aliImage = [[UIImageView alloc]init];
    self.aliImg = aliImage;
    aliImage.image = MyImage(@"icon_treasury_zfb");
    [headView addSubview:aliImage];
    [aliImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(headView);
        make.top.mas_equalTo(headView.mas_top).offset(40);
        make.width.height.mas_equalTo(60);
    }];
    
    UITextField *alipayTextF = [[UITextField alloc]init];
    self.alipayTextField = alipayTextF;
    alipayTextF.placeholder = @"  请输入支付宝账号";
    alipayTextF.font = [UIFont systemFontOfSize:RemindFont(16, 17, 18)];
    alipayTextF.layer.borderColor= MainMidLineColor.CGColor;
    alipayTextF.layer.cornerRadius = 5.0f;
    alipayTextF.layer.borderWidth = 1.0f;
    [headView addSubview:alipayTextF];
    [alipayTextF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(aliImage.mas_bottom).offset(10);
        make.height.mas_equalTo(45);
        make.left.mas_equalTo(20);
        make.right.mas_equalTo(-20);
    }];
    
    UITextField *nameTextField = [[UITextField alloc]init];
    self.nameTextField = nameTextField;
    nameTextField.placeholder = @"  请输入姓名";
    nameTextField.layer.borderColor= MainMidLineColor.CGColor;
    nameTextField.layer.borderWidth= 1.0f;
    nameTextField.layer.cornerRadius = 5.0f;
    nameTextField.font = [UIFont systemFontOfSize:RemindFont(16, 17, 18)];
    [headView addSubview:nameTextField];
    [nameTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(alipayTextF.mas_bottom).offset(10);
        make.height.mas_equalTo(45);
        make.left.mas_equalTo(20);
        make.right.mas_equalTo(-20);
    }];
    
    UILabel *noticeLab = [[UILabel alloc]init];
    NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:
                                      @"提示：兑换金额50.00元起"];
    [str addAttribute:NSForegroundColorAttributeName value:MainTextColor range:NSMakeRange(0,7)];
    [str addAttribute:NSForegroundColorAttributeName value:MainRedColor range:NSMakeRange(7,5)];
    [str addAttribute:NSForegroundColorAttributeName value:MainTextColor range:NSMakeRange(12,2)];
    noticeLab.attributedText = str;
    noticeLab.font = [UIFont systemFontOfSize:RemindFont(15, 16, 17)];
    [headView addSubview:noticeLab];
    [noticeLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(nameTextField.mas_bottom).offset(10);
        make.height.mas_equalTo(30);
        make.left.mas_equalTo(20);
        make.right.mas_equalTo(-20);
    }];
    
    UIButton *duihuanBtn = [[UIButton alloc]init];
    [duihuanBtn setBackgroundColor:MainRedColor];
    [duihuanBtn setTitle:@"兑换" forState:0];
    duihuanBtn.titleLabel.font = [UIFont systemFontOfSize:RemindFont(16, 17, 18)];
    [duihuanBtn setTitleColor:WhiteColor forState:0];
    self.duihuanBtn = duihuanBtn;
    [duihuanBtn addTarget:self action:@selector(chooseTagClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:duihuanBtn];
    [duihuanBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.bottom.mas_equalTo(self.view.mas_bottom).offset(0);
        make.height.mas_equalTo(50);
    }];
    
    XWChooseMoneyView *moneyView = [[XWChooseMoneyView alloc]init];
    self.chooseView = moneyView;
    moneyView.backgroundColor = WhiteColor;
    [self.view addSubview:moneyView];
    [moneyView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.top.mas_equalTo(headView.mas_bottom).offset(10);
        make.bottom.mas_equalTo(duihuanBtn.mas_top).offset(0);
    }];
    
    
}

- (void)chooseTagClick:(id)sender
{
    if (STUserDefaults.isLogin) {
        [STRequest AlipayGetMoneyWithDataBlock:^(id ServersData, BOOL isSuccess) {
            if (isSuccess) {
                if ([ServersData[@"c"] integerValue] == 1) {
                    _str = ServersData[@"d"][@"duibastore"];
                    JLLog(@"_str---%@",_str);
                    XWAliTixianVC *webVC = [XWAliTixianVC new];
                    webVC.h5Url = _str;
                    webVC.hidesBottomBarWhenPushed = YES;
                    [self.navigationController pushViewController:webVC animated:YES];
                } else {
                    [SVProgressHUD showErrorWithStatus:ServersData[@"m"]];
                }
                
            }else{
                
                [SVProgressHUD showErrorWithStatus:@"网络错误，请重试"];
                
            }
            
        }];
        
    } else {
        
        [SVProgressHUD showErrorWithStatus:@"请先登录"];
        
    }
    
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
