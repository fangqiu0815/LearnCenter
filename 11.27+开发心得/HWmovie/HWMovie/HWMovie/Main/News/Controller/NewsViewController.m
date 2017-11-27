//
//  NewsViewController.m
//  HWMovie
//
//  Created by hyrMac on 15/7/17.
//  Copyright (c) 2015年 hyrMac. All rights reserved.
//

#import "NewsViewController.h"
#import "NewsModal.h"
#import "NewsTableViewCell.h"
#import "DataService.h"
#import "UIViewExt.h"
#import "common.h"
#import "UIImageView+WebCache.h"
#import "ImageNewsViewController.h"
#import "NewsWebViewController.h"

@interface NewsViewController ()
{
    UIImageView *_headerImageView;
    UILabel *_headerLabel;
}

@end

@implementation NewsViewController

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = @"新闻";
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self _createTableView];
    [self _createHeader];
    [self _loadData];
}

#pragma mark - loadData
- (void)_loadData {
    NSArray *array = [DataService getJsonDataFromFile:@"news_list.json"];
    _newsMessageArray = [NSMutableArray array];
    for (NSInteger i = 0; i < array.count; i++) {
        NSDictionary *dict = array[i];
        NewsModal *modal = [[NewsModal alloc] init];
        
        [modal setValuesForKeysWithDictionary:dict];
//        modal.image = dict[@"image"];
//        modal.summary = dict[@"summary"];
//        modal.title = dict[@"title"];
//        modal.type = [dict[@"type"] integerValue];
        
        [_newsMessageArray addObject:modal];
    }
//    NSLog(@"%@",_newsMessageArray);
    // 自定义表头上的图片数据加载
    NewsModal *modal = _newsMessageArray[0];
    NSString *str = modal.image;
    NSURL *url = [NSURL URLWithString:str];
    [_headerImageView sd_setImageWithURL:url];
    
    _headerLabel.text = modal.title;
    
    [_newsMessageArray removeObjectAtIndex:0];
}

#pragma mark - createSubviews
- (void)_createTableView {
    _newsTableView = [[UITableView alloc] initWithFrame:self.view.bounds];
    _newsTableView.delegate = self;
    _newsTableView.dataSource = self;
    _newsTableView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"bg_main"]];
    [self.view addSubview:_newsTableView];
    
    // 表头视图
    UIView *headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 200)];
    headView.backgroundColor = [UIColor clearColor];
    _newsTableView.tableHeaderView = headView;
    
    // 注册单元格
    UINib *nib = [UINib nibWithNibName:@"NewsTableViewCell" bundle:[NSBundle mainBundle]];
    [_newsTableView registerNib:nib forCellReuseIdentifier:@"newsCell1"];
}

- (void)_createHeader {
    // 图片
    _headerImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 64,kWidth , 200)];
//     NSArray *array = [DataService getJsonDataFromFile:@"news_list.json"];
//     NSDictionary *dict = array[0];
//     NSString *str = dict[@"image"];
//     NSURL *url = [NSURL URLWithString:str];
//     [_headerImageView sd_setImageWithURL:url];
    [self.view addSubview:_headerImageView];
    
    // 文字
    _headerLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, kWidth, 30)];
    _headerLabel.bottom = _headerImageView.bottom;
    _headerLabel.backgroundColor = [UIColor blackColor];
    _headerLabel.alpha = 0.65;
    _headerLabel.textColor = [UIColor whiteColor];
    _headerLabel.font = [UIFont boldSystemFontOfSize:18];
    [self.view addSubview:_headerLabel];
}

#pragma mark - tableViewDataSourse
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _newsMessageArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NewsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"newsCell1" forIndexPath:indexPath];
    cell.newsMessage = _newsMessageArray[indexPath.row];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    return cell;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

#pragma mark - tableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 80;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NewsTableViewCell *cell1 = (NewsTableViewCell *)[tableView cellForRowAtIndexPath:indexPath];
    // 加载网页内容
    if (cell1.newsMessage.type == 0) {
        NewsWebViewController *web1 = [[NewsWebViewController alloc] init];
        [self.navigationController pushViewController:web1 animated:YES];
        self.navigationController.tabBarController.tabBar.hidden = YES;
    }
    
    // 图片新闻才转入
    if (cell1.newsMessage.type == 1) {
        ImageNewsViewController *imgNewsVc = [[ImageNewsViewController alloc] init];
        [self.navigationController pushViewController:imgNewsVc animated:YES];
        self.navigationController.tabBarController.tabBar.hidden = YES;
    }
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat offY = scrollView.contentOffset.y;
//    NSLog(@"%f",offY);
    if (offY > -64) {
        // 整体向上走了    self.frame.origin.y
        _headerImageView.top = -offY;
    } else {
        CGFloat newHeight = -64-offY+200;
        CGFloat newWidth = newHeight/200*kWidth;
        _headerImageView.frame = CGRectMake((kWidth-newWidth)/2, 64, newWidth, newHeight);
    }
    _headerLabel.bottom = _headerImageView.bottom;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated {
    self.navigationController.tabBarController.tabBar.hidden = NO;
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
