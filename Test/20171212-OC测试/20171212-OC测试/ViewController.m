//
//  ViewController.m
//  20171212-OC测试
//
//  Created by apple-gaofangqiu on 2017/12/12.
//  Copyright © 2017年 apple-fangqiu. All rights reserved.
//

#import "ViewController.h"
#import "UIDevice+DeviceIDByKeychainThisDeviceOnly.h"

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    NSArray *_sectionTitleArray;
    NSArray *_taskListArray;
}
@property (nonatomic, strong) UITableView *tableView;


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    _sectionTitleArray = @[@"",@"我的等级",@"我的特权",@"成长任务"];
//    _taskListArray = @[@"消费获取积分",@"邀请好友"];
//    [self setupUI];
    
    NSString* test = [UIDevice identifierByKeychain];
    NSLog(@"%@", test);
}

- (void)setupUI{
    
    UITableView *tableview = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStylePlain];
    tableview.backgroundColor = [UIColor whiteColor];
    tableview.delegate = self;
    tableview.dataSource = self;
    tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    tableview.estimatedRowHeight = 0;
    tableview.estimatedSectionHeaderHeight = 0;
    tableview.estimatedSectionFooterHeight = 0;
    tableview.tableFooterView = [[UITableView alloc] init];
    [self.view addSubview:tableview];
    
    
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"taskListCell"];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"taskListCell"];
    }
    cell.textLabel.text = _taskListArray[indexPath.row];
    cell.detailTextLabel.text = @"去完成";
    cell.detailTextLabel.textColor = [UIColor blackColor];
    cell.detailTextLabel.backgroundColor = [UIColor redColor];
    cell.detailTextLabel.layer.masksToBounds = YES;
    cell.detailTextLabel.layer.cornerRadius = 5;
    return cell;
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
