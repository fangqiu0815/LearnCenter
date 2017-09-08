//
//  XWPacketCashVC.m
//  zhangshangPacket
//
//  Created by apple on 2017/6/2.
//  Copyright © 2017年 apple-fangqiu. All rights reserved.
//

#import "XWPacketCashVC.h"
#import "XWGetCoinCell.h"
#import "XWMineListCell.h"
#import "XWMineMidCell.h"
#import "XWMiddleCashCell.h"
#import "XWCountInfoVC.h"
#import "XWJinBiVC.h"
#import "XWXianJinVC.h"
#import "XWCoinRuleVC.h"
#import "XWMineInCashVC.h"
#import "XWMidHistoryCashCell.h"
#import "XWGetCashView.h"
#import "XWMineInCashAlipayVC.h"
#import "XWAliTixianVC.h"
#import "XWMineVC.h"
#import "XWMinePacketTiXianVC.h"
#import "XWMinePubView.h"

@interface XWPacketCashVC ()<XWGetCashViewDelegate,XWMinePubViewDelegate>
{
    UIImageView *navBarHairlineImageView;
    
    NSString *_str;
    NSInteger sendToMineIngot;

}

@property (nonatomic, strong) XWMineMidCell *midCell;

@end

@implementation XWPacketCashVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
    // 设置导航栏标题变大
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(ScreenW/2, self.view.yj_centerX, 80, 40)];
    label.textColor = [UIColor whiteColor];
    label.text = @"我的钱包";
    label.font = [UIFont systemFontOfSize:18];
    
    self.navigationItem.titleView = label;
    //设置头视图
    [self setupHeaderUI];
    //设置钱包下的视图
    [self setupUI];
    navBarHairlineImageView = [self findHairlineImageViewUnder:self.navigationController.navigationBar];

    
}



- (UIImageView*)findHairlineImageViewUnder:(UIView*)view {
    if([view isKindOfClass:UIImageView.class] && view.bounds.size.height<=1.0) {
        return(UIImageView*)view;
    }
    for(UIView *subview in view.subviews) {
        UIImageView *imageView = [self findHairlineImageViewUnder:subview];
        if(imageView) {
            return imageView;
        }
    }
    return nil;
}

- (void)setupHeaderUI
{
    XWMineMidCell *midCell = [[XWMineMidCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"XWMineMidCell"];
    self.midCell = midCell;
    self.midCell.canGetLab.text = [NSString stringWithFormat:@"%ld",(long)_todayIngot];
    self.midCell.yesIncomeLab.text = [NSString stringWithFormat:@"%@",STUserDefaults.cashyes];
    midCell.frame = CGRectMake(0, 0, ScreenW, 80);
    midCell.dk_backgroundColorPicker = DKColorPickerWithColors(MainRedColor,NightMainBGColor,MainRedColor);

    
    [self.view addSubview:midCell];
    
    XWGetCoinCell *getCoinCell = [[XWGetCoinCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"XWGetCoinCell"];
    getCoinCell.cashLab.text = STUserDefaults.cash;
    [getCoinCell.tixianBtn addTarget:self action:@selector(tixianclick) forControlEvents:UIControlEventTouchUpInside];
    getCoinCell.dk_backgroundColorPicker = DKColorPickerWithColors(WhiteColor,NightMainBGColor,MainRedColor);
    getCoinCell.frame = CGRectMake(0, 80, ScreenW, 50);
    
    [self.view addSubview:getCoinCell];
    
}

- (void)tixianclick
{
    if (![STUserDefaults.phonenum isEqualToString:@""]) {
        JLLog(@"empudid---%ld",STUserDefaults.empudid);
        if (STUserDefaults.empudid == 1) {
            [[NSNotificationCenter defaultCenter] postNotificationName:@"XWJIAGUGETUDIDCLICK" object:nil];
//            [self jiaguClick];
        } else {
            
            if (STUserDefaults.isJiagu == 1) {
                //提现
                XWGetCashView *cashView = [[XWGetCashView alloc]initWithFrame:[UIScreen mainScreen].bounds];
                cashView.delegate = self;
                [cashView  show];
            } else {
                [[NSNotificationCenter defaultCenter] postNotificationName:@"XWJIAGUGETUDIDCLICK" object:nil];
//                [self jiaguClick];

            }
        }
        
    } else {
        XWMinePubView *cashPubView = [[XWMinePubView alloc]initWithFrame:[UIScreen mainScreen].bounds];
        cashPubView.delegate = self;
        [cashPubView show];
    }
    
}

#pragma mark ============== 请求加固的方法 ================
- (void)jiaguClick
{
    JLLog(@"jiaguClick----请求加固的方法");
    [STRequest ProjectAddIDDataBlock:^(id ServersData, BOOL isSuccess) {
        JLLog(@"加固--serverdata---%@",ServersData);
        if (isSuccess) {
            if ([ServersData isKindOfClass:[NSDictionary class]]) {
                if ([ServersData[@"c"] integerValue] == 1) {
                    
                    NSDictionary *dictemp = [NSDictionary dictionaryWithDictionary:ServersData[@"d"]];
                    if ([dictemp count] == 0) {
                        JLLog(@"d下面没值");
                    } else {
                        NSInteger status = [dictemp[@"status"] integerValue];
                        NSString *url = dictemp[@"url"];
                        
                        if (status == 1) {
                            JLLog(@"需要加固");
                            if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:url]]) {
                                [[UIApplication sharedApplication] openURL:[NSURL URLWithString:url]];
                            }
                        } else {
                            JLLog(@"不需要加固");
                            STUserDefaults.isJiagu = 1;
                        }
                    }
                    
                } else {
                    JLLog(@"%@",ServersData[@"m"]);
                }
                
            }else{
                JLLog(@"请求到json格式不对不是字典类型");
            }
        } else {
            
            JLLog(@"请求接口不成功");
        }
        
    }];
    
    
}


- (void)didSelectBtnWithBtnTag:(NSInteger)tag
{
    if (tag == 1) {
        //微信
//        XWMineInCashVC *mineCashVC = [[XWMineInCashVC alloc]init];
//        [self.navigationController pushViewController:mineCashVC animated:YES];
        [SVProgressHUD showSuccessWithStatus:@"该功能还在开发中"];
        
    } else if(tag == 2){
        
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
            
            [[NSNotificationCenter defaultCenter] postNotificationName:@"AlwaysWechatLogin" object:nil];
            
        }

    }

}

- (void)setupUI
{
    self.tableView.dk_backgroundColorPicker = DKColorPickerWithColors(MainBGColor,NightMainColor,MainRedColor);
    self.tableView.dk_separatorColorPicker = DKColorPickerWithColors(MainBGColor,NightMainLineColor,MainRedColor);
    // self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.top.mas_equalTo(80+50);
        make.bottom.mas_equalTo(0);
    }];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if (section == 0) {
        return 2;
    } else {
        return 2;
    }
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0) {
        XWMidHistoryCashCell *cashCell = [[XWMidHistoryCashCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"XWMidHistoryCashCell"];
        cashCell.selectionStyle = UITableViewCellSelectionStyleNone;
        if (indexPath.row == 0) {
            JLLog(@"cashtotal---%@---cashconver---%@",STUserDefaults.cashtotal,STUserDefaults.cashconver);
            [cashCell setCellDataWithTitle:@"历史收入(元)" andRightTitle:STUserDefaults.cashtotal];
            return cashCell;
        }else{
            
            [cashCell setCellDataWithTitle:@"历史提现(元)" andRightTitle:STUserDefaults.cashconver];
            return cashCell;
        }
    }else{
        UITableViewCell *listCell = [[UITableViewCell alloc]init];
        listCell.selectionStyle = UITableViewCellSelectionStyleNone;
        listCell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        listCell.textLabel.font = [UIFont systemFontOfSize:RemindFont(14, 15, 16)];
        listCell.dk_backgroundColorPicker = DKColorPickerWithColors(WhiteColor,NightMainBGColor,MainRedColor);
        listCell.textLabel.dk_textColorPicker = DKColorPickerWithColors(BlackColor,WhiteColor,MainRedColor);
        if (indexPath.row == 0) {
            listCell.textLabel.yj_x = 15;
            listCell.textLabel.text = @"收支明细";
            return listCell;
        
        }else{
            listCell.textLabel.yj_x = 15;
            listCell.textLabel.text = @"元宝规则";
            return listCell;
        }
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            JLLog(@"历史收入");
        } else {
            JLLog(@"历史提现");
        }
    }else{
        if (indexPath.row == 0) {
            XWCountInfoVC *infoVC = [[XWCountInfoVC alloc]initWithViewControllerClasses:@[[XWJinBiVC class], [XWXianJinVC class]] andTheirTitles:@[@"元宝", @"现金"] ];
            infoVC.menuHeight = 44;
            infoVC.menuViewStyle = WMMenuViewStyleLine;
            infoVC.bounces = NO;
            infoVC.progressViewIsNaughty = YES;
            infoVC.titleColorNormal = NightMainTextColor;
            infoVC.titleColorSelected = MainRedColor;
            infoVC.menuView.lineColor = MainRedColor;
            [self.navigationController pushViewController:infoVC animated:YES];

        } else {
            XWCoinRuleVC *ruleVC = [[XWCoinRuleVC alloc]init];
            [self.navigationController pushViewController:ruleVC animated:YES];
        }
    }

}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 10;
}

- (void)dealloc
{
    JLLog(@"dealloc");
    
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

-(void)viewWillAppear:(BOOL)animated{
    [self preferredStatusBarStyle];
    [self setStatusBarBackgroundColor:MainRedColor];
    navBarHairlineImageView.hidden = YES;

    self.navigationController.navigationBar.translucent = NO;
    self.navigationController.navigationBar.dk_barTintColorPicker = DKColorPickerWithColors(MainRedColor,NightMainNaviColor,MainRedColor);

}




@end
