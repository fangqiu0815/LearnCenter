//
//  SecondViewController.m
//  XDCommonApp
//
//  Created by XD-XY on 2/12/14.
//  Copyright (c) 2014 XD-XY. All rights reserved.
//

#import "SecondViewController.h"
#import "XDHeader.h"
#import "XDTools.h"
#import "UIImageView+WebCache.h"
#import "LoginViewController.h"
#import "RegisterViewController.h"
#import "MyInfoViewController.h"
#import "MyOrdersViewController.h"
#import "MyBillsViewController.h"
#import "MaterialsViewController.h"
#import "ConfirmOrderViewController.h"
@interface SecondViewController ()

@end

@implementation SecondViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reloadTableViewWithPushinfo:) name:@"pushNotificationName" object:nil];
    
    [myTableView reloadData];
    
    if ((![XDTools getPushValueWithType:@"1"])&&
        (![XDTools getPushValueWithType:@"2"])&&
        (![XDTools getPushValueWithType:@"3"])&&
        (![XDTools getPushValueWithType:@"4"])){
        [XDTabBarViewController sharedXDTabBarViewController].reminder_IV.hidden = YES;
    }else{
        [XDTabBarViewController sharedXDTabBarViewController].reminder_IV.hidden = NO;
    }
}


-(void)viewWillDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"pushNotificationName" object:nil];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    self.leftBtn.hidden =YES;
    self.titleLabel.text = @"我的";

    self.contentView.backgroundColor = UIColorFromRGB(0xececec);
    
    myTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0,UI_SCREEN_WIDTH, self.contentView.frame.size.height-UI_TAB_BAR_HEIGHT) style:UITableViewStylePlain];
    myTableView.delegate =self;
    myTableView.dataSource = self;
    myTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    myTableView.backgroundColor = [UIColor clearColor];
    [self.contentView addSubview:myTableView];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (!indexPath.section) {
        return 75;
    }else{
        return 40;
    }
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (!section) {
        return 1;
    }else{
        return 3;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 10;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView * headerBg = [[UIView alloc] initWithFrame:CGRectMake(0, 0, UI_SCREEN_WIDTH, 10)];
    headerBg.backgroundColor = [UIColor clearColor];
    return headerBg;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (!indexPath.section) {
        NSString * cellName = @"cell0";
        UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellName];
        if (cell == nil){
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellName];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;

            headerIV = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, 55, 55)];
            headerIV.layer.masksToBounds = YES;
            headerIV.layer.cornerRadius = headerIV.bounds.size.height/2;
            [cell.contentView addSubview:headerIV];

            loginBtn = [XDTools getAButtonWithFrame:CGRectMake(75,75/2.0f-25/2.0f, 56, 25) nomalTitle:@"登录" hlTitle:@"登录" titleColor:UIColorFromRGB(0xf18d00) bgColor:[UIColor clearColor] nbgImage:nil hbgImage:nil action:@selector(login) target:self buttonTpye:UIButtonTypeCustom];
            loginBtn.layer.borderColor = UIColorFromRGB(0xf18d00).CGColor;
            loginBtn.layer.borderWidth = .5f;
            [cell.contentView addSubview:loginBtn];

            registerBtn = [XDTools getAButtonWithFrame:CGRectMake(150,75/2.0f-25/2.0f, 56, 25) nomalTitle:@"注册" hlTitle:@"注册" titleColor:UIColorFromRGB(0xf18d00) bgColor:[UIColor clearColor] nbgImage:nil hbgImage:nil action:@selector(gotoRegister) target:self buttonTpye:UIButtonTypeCustom];
            registerBtn.layer.borderColor = UIColorFromRGB(0xf18d00).CGColor;
            registerBtn.layer.borderWidth = .5f;
            [cell.contentView addSubview:registerBtn];

            userinfoLB = [XDTools addAlabelForAView:cell.contentView withText:nil frame:CGRectMake(70,75/2.0f-30/2.0f, 156, 40) font:[UIFont systemFontOfSize:14] textColor:UIColorFromRGB(0x636363)];


            UIImageView * line = [[UIImageView alloc] initWithFrame:CGRectMake(0, 74.5f, UI_SCREEN_WIDTH, .5f)];
            line.image = [UIImage imageNamed:@"line"];
            [cell.contentView addSubview:line];

        }
        if (!ISLOGING) {
            headerIV.image = [UIImage imageNamed:@"miaodai_header"];
            loginBtn.hidden = NO;
            registerBtn.hidden = NO;
            userinfoLB.hidden = YES;
            cell.accessoryType = UITableViewCellAccessoryNone;
        }else{
            NSString * headImage = [[[NSUserDefaults standardUserDefaults] objectForKey:kMMyUserInfo] objectForKey:@"pic"];
            [headerIV setImageWithURL:[NSURL URLWithString:headImage] placeholderImage:[UIImage imageNamed:@"humanHeader"]];
//            headerIV.image = [UIImage imageNamed:@"Icon_ios7"];
            loginBtn.hidden = YES;
            registerBtn.hidden = YES;
            userinfoLB.hidden = NO;
            NSMutableString * str = [NSMutableString stringWithFormat:@"%@",[[[NSUserDefaults standardUserDefaults] objectForKey:kMMyUserInfo] objectForKey:@"userName"]];
            NSRange range = NSMakeRange(3, 4);
            [str replaceCharactersInRange:range withString:@"****"];
            NSString * name = [[[NSUserDefaults standardUserDefaults] objectForKey:kMMyUserInfo] objectForKey:@"name"];
            if (name.length) {
                userinfoLB.text = [NSString stringWithFormat:@"%@同学\n%@",name,str];
            }else{
                userinfoLB.text = [NSString stringWithFormat:@"喵~欢迎新同学\n%@",str];
            }
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;

        }

        return cell;
    }else{
        NSString * cellName = @"cell1";
        UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellName];
        if (cell == nil){
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellName];

            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.textLabel.frame = CGRectMake(VIEW_POINT_MAX_X(cell.imageView), 10, 150, 20);
            cell.textLabel.font = [UIFont systemFontOfSize:15];

            if (indexPath.section == 1) {
                if (!indexPath.row) {
                    cell.imageView.frame = CGRectMake(10, 12.5f, 29/2.0f, 30/2.0f);
                    cell.imageView.image = [UIImage imageNamed:@"dingdanIcon"];
                    cell.textLabel.text = @"我的订单";
                }else if (indexPath.row == 1) {
                    
                    cell.imageView.frame = CGRectMake(10, 12.5f, 29/2.0f, 30/2.0f);
                    cell.imageView.image = [UIImage imageNamed:@"zhangdanIcon"];
                    cell.textLabel.text = @"我的账单";

                }else{
                    cell.imageView.frame = CGRectMake(10, 12.5f, 29/2.0f, 30/2.0f);
                    cell.imageView.image = [UIImage imageNamed:@"ziliaoIcon"];
                    cell.textLabel.text = @"我的资料";
                }
            }
            
            UIImageView * line = [[UIImageView alloc] initWithFrame:CGRectMake(0, 39.5f, UI_SCREEN_WIDTH, .5f)];
            line.image = [UIImage imageNamed:@"line"];
            [cell.contentView addSubview:line];

            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;


            
        }

        
        if(!indexPath.row){
            if ([XDTools getPushValueWithType:@"4"]||[XDTools getPushValueWithType:@"3"]){
                order_reminder = nil;
                order_reminder = [[UIImageView alloc] initWithFrame:CGRectMake(280, 15, 10, 10)];
                order_reminder.backgroundColor = [UIColor redColor];
                order_reminder.layer.cornerRadius = 5;
                order_reminder.layer.masksToBounds = YES;
                order_reminder.tag = 1001;
                [cell.contentView addSubview:order_reminder];
            }else{
                for (UIView * view in cell.contentView.subviews){
                    if (view.tag == 1001){
                        [view removeFromSuperview];
                    }
                }
                [order_reminder removeFromSuperview];
                order_reminder = nil;
            }
        }else if (indexPath.row ==1){
            if ([XDTools getPushValueWithType:@"2"]||[XDTools getPushValueWithType:@"1"]){
                bill_remider = nil;
                bill_remider = [[UIImageView alloc] initWithFrame:CGRectMake(280, 15, 10, 10)];
                bill_remider.backgroundColor = [UIColor redColor];
                bill_remider.tag = 1002;
                bill_remider.layer.cornerRadius = 5;
                bill_remider.layer.masksToBounds = YES;
                [cell.contentView addSubview:bill_remider];
            }else{
                for (UIView * view in cell.contentView.subviews){
                    if (view.tag == 1002){
                        [view removeFromSuperview];
                    }
                }
                [bill_remider removeFromSuperview];
                bill_remider = nil;
            }
            
            if ([XDTools getPushValueWithType:@"2"]){
                yuqiBtn = [XDTools getAButtonWithFrame:CGRectMake(244, 8.5f, 45, 23) nomalTitle:@"逾期" hlTitle:@"逾期" titleColor:[UIColor whiteColor] bgColor:UIColorFromRGB(0xca0003) nbgImage:nil hbgImage:nil action:nil target:self buttonTpye:UIButtonTypeCustom];
                yuqiBtn.titleLabel.font = [UIFont systemFontOfSize:14];
                yuqiBtn.tag = 2147617;
                [cell.contentView addSubview:yuqiBtn];
            }else{
                for (UIView * view in cell.contentView.subviews){
                    if (view.tag == 2147617){
                        [view removeFromSuperview];
                    }
                }
                [yuqiBtn removeFromSuperview];
                yuqiBtn = nil;
            }
            
            if (yuqiBtn){
                for (UIView * view in cell.contentView.subviews){
                    if (view.tag == 1002){
                        [view removeFromSuperview];
                    }
                }
                [bill_remider removeFromSuperview];
                bill_remider = nil;
            }
        }
        
        NSDictionary * infoDic = [[NSUserDefaults standardUserDefaults] objectForKey:kMMyUserInfo];
        if ([infoDic[@"overdue"] intValue]) {
            UIButton * btn = (UIButton *)[self.view viewWithTag:2147617];
            btn.hidden = NO;
        }


        return cell;
    }

}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (!ISLOGING) {
        if (!indexPath.section) {
            return;
        }
        LoginViewController * login = [[LoginViewController alloc] init];
        [self.navigationController pushViewController:login animated:YES];
    }else{
        if (!indexPath.section) {
            if(ISLOGING){
                MyInfoViewController * change = [[MyInfoViewController alloc] init];
                [self.navigationController pushViewController:change animated:YES];
            }else{
                
                [self login];
            }
        }else if (indexPath.section == 1) {
            if (!indexPath.row) {
                MyOrdersViewController * orders = [[MyOrdersViewController alloc] init];
                [self.navigationController pushViewController:orders animated:YES];
            }else if (indexPath.row == 1) {
                MyBillsViewController * bills = [[MyBillsViewController alloc] init];
                [self.navigationController pushViewController:bills animated:YES];
            }else{
                MaterialsViewController * ziliao = [[MaterialsViewController alloc] init];
                ziliao.type = @"2";
                [self.navigationController pushViewController:ziliao animated:YES];
            }
        }
    }
}

- (void)login{
    LoginViewController * login = [[LoginViewController alloc] init];
    [self.navigationController pushViewController:login animated:YES];
}

- (void)gotoRegister{
    RegisterViewController * registerVC = [[RegisterViewController alloc] init];
    [self.navigationController pushViewController:registerVC animated:YES];
}

//推送通过注册消息更新
-(void)reloadTableViewWithPushinfo:(NSNotification *)info
{
    [myTableView reloadData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
