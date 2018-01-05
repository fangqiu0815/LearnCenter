//
//  ViewController.m
//  XBYTableView
//
//  Created by xiebangyao on 2017/12/25.
//  Copyright © 2017年 xby. All rights reserved.
//

#import "ViewController.h"
#import <AFNetworking.h>
#import "XBYTableView.h"
#import "DataModel.h"

#define KEY @"" //https://www.juhe.cn/docs/api/id/95 示例使用了聚合数据笑话大全的key，需自己申请

@interface ViewController ()<UITableViewDelegate, UITableViewDataSource, XBYTableViewDelegate>

@property (nonatomic, strong) XBYTableView *tableView;

@property (nonatomic, strong) NSMutableArray *dataArray;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.dataArray = @[].mutableCopy;
    [self.view addSubview:self.tableView];
    [self loadDataNeedRestData:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Private Method
//获取当前时间戳
- (NSString *)currentTimeStr{
    NSDate* date = [NSDate dateWithTimeIntervalSinceNow:0];//获取当前时间0秒后的时间
    NSTimeInterval time=[date timeIntervalSince1970];// *1000 是精确到毫秒，不乘就是精确到秒
    NSString *timeString = [NSString stringWithFormat:@"%.0f", time];
    return timeString;
}

- (void)loadDataNeedRestData:(BOOL)reset {
    if (reset) {
        [self.dataArray removeAllObjects];
        [self.tableView reloadData];
    }
    NSString *time = [self currentTimeStr];
    
#warning KEY值不能为空
    NSAssert(KEY.length>0, @"KEY值不能为空");
    
    NSString *url = [NSString stringWithFormat:@"http://japi.juhe.cn/joke/content/list.from?key=%@&page=%ld&pagesize=%ld&sort=desc&time=%@",KEY,self.tableView.page,self.tableView.pageSize,time];
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    [manager GET:url parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        //解析数据可以用MJExtension
        NSArray *dataArray = responseObject[@"result"][@"data"];
        for (NSDictionary *dic in dataArray) {
            DataModel *model = [DataModel new];
            model.content = [dic valueForKey:@"content"];
            model.hashId = [dic valueForKey:@"hashId"];
            model.unixtime = [dic valueForKey:@"unixtime"];
            model.updatetime = [dic valueForKey:@"updatetime"];
            [self.dataArray addObject:model];
        }
        [self.tableView reloadData];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull   error) {
        [self.tableView pageDecreaseOne];   //设置了自动加一，失败了要手动减一
    }];
}

#pragma mark - XBYTableViewDelegate
- (void)refreshTableView:(XBYTableView *)tableView loadNewDataWithPage:(NSInteger)page {
    [self loadDataNeedRestData:YES];
}

- (void)refreshTableView:(XBYTableView *)tableView loadMoreDataWithPage:(NSInteger)page {
    [self loadDataNeedRestData:NO];
}

#pragma mark - UITableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.dataArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    //不考虑复用之类的，简单示例
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    DataModel *model = self.dataArray[indexPath.section];
    cell.textLabel.text = model.content;
    return cell;
}

#pragma mark - Getter
- (XBYTableView *)tableView {
    if (!_tableView) {
        _tableView = [[XBYTableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
        _tableView.refreshDelegate = self;
        _tableView.delegate = self;
        _tableView.dataSource = self;
        
        _tableView.from = 1;    //设置起始页为1
        _tableView.pageSize = 15;   //设置每一页数据为15条
        _tableView.pageAddOne = YES;    //页数自动加一
    }
    
    return _tableView;
}

@end
