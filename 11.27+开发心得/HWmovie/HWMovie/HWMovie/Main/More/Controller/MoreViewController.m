//
//  MoreViewController.m
//  HWMovie
//
//  Created by hyrMac on 15/7/17.
//  Copyright (c) 2015年 hyrMac. All rights reserved.
//

#import "MoreViewController.h"
#import "MoreTableViewCell.h"
#import "moreModal.h"
#import "common.h"
#import "UIImageView+WebCache.h"

@interface MoreViewController ()

@end

@implementation MoreViewController

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = @"更多";
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self _createMoreTable];
    [self _loadData];
}

- (void)_loadData {
    _messageArray = [NSMutableArray array];
    NSArray *array = [NSArray arrayWithObjects:@"清除缓存",@"给个评价",@"检查新版本",@"商务合作",@"欢迎页",@"关于", nil];
    NSArray *array1 = [NSArray arrayWithObjects:@"moreClear@2x",@"moreScore@2x",@"moreVersion@2x",@"moreBusiness@2x",@"moreWelcome@2x",@"moreAbout@2x", nil];
    for (NSInteger i = 0; i < array.count; i++) {
        moreModal *modal = [[moreModal alloc] init];
        modal.title = array[i];
        modal.icon = array1[i];
        [_messageArray addObject:modal];
    }    
}

- (void)_createMoreTable {
    _moreTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kWidth, kHeight) style:UITableViewStyleGrouped ];
    _moreTableView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"bg_main"]];
    _moreTableView.dataSource = self;
    _moreTableView.delegate = self;
    // 注册
    UINib *nib = [UINib nibWithNibName:@"MoreTableViewCell" bundle:[NSBundle mainBundle]];
    [_moreTableView registerNib:nib forCellReuseIdentifier:@"moreCell"];
    [self.view addSubview:_moreTableView];
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _messageArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MoreTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"moreCell" forIndexPath:indexPath];
    cell.modal = _messageArray[indexPath.row];
    cell.selectionStyle =  UITableViewCellSelectionStyleNone;
    
    // 沙盒
//    NSString *homePath = NSHomeDirectory();
//    NSLog(@"%@",homePath);
    return cell;
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        UIAlertView *view1 = [[UIAlertView alloc] initWithTitle:@"提示" message:@"确定清除所有缓存？" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:@"取消", nil];
        [view1 show];
    }
}

#pragma mark - UIAlertViewDelegate

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex == 0) {
        SDImageCache *cache = [SDImageCache sharedImageCache];
        [cache clearDisk];
        [_moreTableView reloadData];
    }
}


- (void)viewWillAppear:(BOOL)animated {
    [_moreTableView reloadData];
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
