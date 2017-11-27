//
//  FourthViewController.m
//  XDCommonApp
//
//  Created by XD-XY on 2/12/14.
//  Copyright (c) 2014 XD-XY. All rights reserved.
//

#import "FourthViewController.h"
#import "XDHeader.h"
#import "LoginViewController.h"
#import "RegisterViewController.h"
#import "ChangeCodeViewController.h"
#import "UIImageView+WebCache.h"


#import "NotificationViewController.h"
@interface FourthViewController ()

@end

@implementation FourthViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.dataArrary = [NSMutableArray arrayWithObjects:@"登录",@"注册",@"修改密码", nil];
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

	// Do any additional setup after loading the view.
    self.leftBtn.hidden =YES;
    self.titleLabel.text = FOURTHVIEWTITLETEXT;
    
    [self initPersonalViews];

}

-(void)initPersonalViews{
    UIImageView *popView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 207)];
    popView.image = [UIImage imageNamed:@"pop_bg"];
    
    popView.userInteractionEnabled = YES;
    [self.view addSubview:popView];
    
    UIButton *leftB = creatXRButton(CGRectMake(15, 33, 18,18), nil, [UIImage imageNamed:@"notification_bt"], [UIImage imageNamed:@"notification_bt"]);
    
    [popView addSubview:leftB];
    
    
    UIButton *lbtn = [UIButton buttonWithType:UIButtonTypeCustom];
    lbtn.frame = CGRectMake(0, 13, 48, 58);
    
    [lbtn addTarget:self action:@selector(goToNotification:) forControlEvents:UIControlEventTouchUpInside];
    [popView addSubview:lbtn];
    
    
    
    UIButton *settingBtn = creatXRButton(CGRectMake(UI_SCREEN_WIDTH-15-18, 33, 18,18), nil, [UIImage imageNamed:@"set_btn"], [UIImage imageNamed:@"set_btn"]);
    
    [popView addSubview:settingBtn];
    
    
    UIButton *rbtn = [UIButton buttonWithType:UIButtonTypeCustom];
    rbtn.frame = CGRectMake(settingBtn.frame.origin.x-10, 13, 48, 58);
    
    [rbtn addTarget:self action:@selector(goToSettings:) forControlEvents:UIControlEventTouchUpInside];
    [popView addSubview:rbtn];
    
    
    
    
    headerView = creatXRImageView(CGRectMake(125, 45, 70, 70), [UIImage imageNamed:@"moren_header"]);
    
    [popView addSubview:headerView];
    
    UILabel *nameLabel = creatXRLable(@"龙神", CGRectMake(headerView.frame.origin.x,headerView.frame.origin.y+headerView.frame.size.height+10,70,18));
    nameLabel.font = [UIFont systemFontOfSize:18.0];
    nameLabel.textColor = [UIColor whiteColor];
    nameLabel.backgroundColor = [UIColor clearColor];
    
    [popView addSubview:nameLabel];
    
    
    UIButton *detailBtn = creatXRButton(CGRectMake(116, nameLabel.frame.origin.y+nameLabel.frame.size.height+10, 87, 25), nil, [UIImage imageNamed:@"detail_btn"], [UIImage imageNamed:@"detail_btn"]);
    [detailBtn addTarget:self action:@selector(goToDetail:) forControlEvents:UIControlEventTouchUpInside];
    
    [popView addSubview:detailBtn];
                                      
    
    
    
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 143, self.contentView.frame.size.width, self.contentView.frame.size.height-80) style:UITableViewStylePlain];
    _tableView.delegate  = self;
    _tableView.dataSource = self;
    
    [self.contentView addSubview:_tableView];
    
    
    sheet = [[UIActionSheet alloc] initWithTitle:@"注册" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"普通注册",@"手机注册",@"邮箱注册", nil];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [_dataArrary count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *cellIdentifer = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifer];
    
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifer];
    }
    cell.textLabel.text = [_dataArrary objectAtIndex:indexPath.row];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    switch (indexPath.row) {
        case 0:
        {
            LoginViewController *loginVC = [[LoginViewController alloc] init];
            [self.navigationController pushViewController:loginVC animated:YES];
        }
            break;
        case 1:
        {
            
            [sheet showInView:self.view];
            
            
        }
            break;
        case 2:
        {
            ChangeCodeViewController *registVC = [[ChangeCodeViewController alloc] init];
            [self.navigationController pushViewController:registVC animated:YES];
        }
            break;
        case 3:
        {
            
        }
            break;
        case 4:
        {
            
        }
            break;
            
        default:
            break;
    }
}

//去往通知中心
-(void)goToNotification:(UIButton *)btn {
    NotificationViewController *notVC = [[NotificationViewController alloc] init];
    
    [self.navigationController pushViewController:notVC animated:YES];
}

//去设置
-(void)goToSettings:(UIButton *)btn{

}


-(void)goToDetail:(UIButton *)btn {
    
}


- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    switch (buttonIndex) {
        case 0:
        {
            RegisterViewController *registVC = [[RegisterViewController alloc] init];
            [self.navigationController pushViewController:registVC animated:YES];
        }
            break;
        case 1:
        {

        }
            break;
        case 2:
        {

        }
            break;
        case 3:
        {
            
        }
            break;
            
        default:
            break;
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
