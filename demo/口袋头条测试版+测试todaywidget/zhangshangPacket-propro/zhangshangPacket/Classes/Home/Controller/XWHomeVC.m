//
//  XWHomeVC.m
//
//  Created by apple on 2017/5/8.
//  Copyright © 2017年 apple-fangqiu. All rights reserved.
//

#import "XWHomeVC.h"

#import "XWTitleImageView.h"
#import "XWSysInfoModel.h"
#import "XWHomeMenuVC.h"


@interface XWHomeVC ()
{
    NSString *_titleStr;
    NSString *_packetStr;
    NSArray *_temArr;
}


@property (nonatomic,strong) NSArray *viewControllers;
@property (nonatomic,strong) NSArray *tagTitles;



@end

@implementation XWHomeVC

- (void)viewDidLoad {
    [super viewDidLoad];

    self.title = @"资讯";
    //创建消息和闹钟 navigationBar
    [self setupNavigationBar];
//创建菜单栏
    [self setupMenuView];
    
    STUserDefaults.uid = @"24";
    STUserDefaults.version = @"0.0.1";
    STUserDefaults.token = @"8e33784eef6cf542bb8c178ca34d6398";
    [STRequest SysInfoDataWithDataBlock:^(id ServersData, BOOL isSuccess) {
        
        if (isSuccess) {
            
            NSLog(@"ServersData ----%@",ServersData);
            NSDictionary *tempDic = ServersData[@"d"];
            _titleStr = tempDic[@"mainfuncs"];
            NSLog(@"titleStr----%@",_titleStr);
            
            _packetStr = tempDic[@"treasurefuncs"];
            NSLog(@"_packetStr----%@",_packetStr);
            
            NSString *string = _titleStr;
            
            NSArray *array = [string componentsSeparatedByString:@"|"];
            
            _temArr = array;
            NSLog(@"array == %@", array);
            
        }else{
            
            [SVProgressHUD showErrorWithStatus:@"网络故障，请重试!"];
        }
        
    }];
    
    
}

- (void)setupMenuView
{
    XWHomeMenuVC *menuVC = [[XWHomeMenuVC alloc]initWithMneuViewStyle:MenuViewStyleLine];
    [menuVC loadVC:[[XWHomeVC class] ] AndTitle:_temArr];

}





//创建消息和闹钟 navigationBar
- (void)setupNavigationBar
{
    // 设置导航条的内容
    // 设置导航条左边的按钮
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem createItemWithImage:[UIImage imageNamed:@"message"] highImage:[UIImage imageNamed:@"message"] addTarget:self action:@selector(messageClick)];
    // 设置导航条右边的按钮
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem createItemWithImage:[UIImage imageNamed:@"other"] highImage:[UIImage imageNamed:@"other1"] addTarget:self action:@selector(randomClick)];
    
}

- (void)messageClick
{

    
    
}

- (void)randomClick
{
    
    
    
}




- (void)dealloc
{
    JLLog(@"dealloc");

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];



}



@end
