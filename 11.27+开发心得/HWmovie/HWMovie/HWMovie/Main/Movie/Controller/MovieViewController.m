//
//  MovieViewController.m
//  HWMovie
//
//  Created by hyrMac on 15/7/17.
//  Copyright (c) 2015年 hyrMac. All rights reserved.
//

#import "MovieViewController.h"
#import "MovieModal.h"
#import "MovieTableViewCell.h"
#import "common.h"
#import "DataService.h"
#import "HttpDataService.h"

@interface MovieViewController ()

@end

@implementation MovieViewController

#pragma mark - MainViewController

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = @"电影";
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self _createNav];
    // tableView是第一个被加载到view的子视图
    [self _creteMovieTableView];
    [self _createPosterView];
//    [self _loadData];
//    self.edgesForExtendedLayout = UIRectEdgeNone;
    [self _loadDataHttp];
}

#pragma mark - LoadData

//  从Json中加载本地数据,丢弃,改用网络数据
- (void)_loadData {
//    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"us_box" ofType:@"json"];
//    NSData *data = [NSData dataWithContentsOfFile:filePath];
//    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers  error:nil];
    NSDictionary *dic = [DataService getJsonDataFromFile:@"us_box.json"];
//    NSLog(@"%@",dic);
    
    // 可变数组  ->  字典
    _movieModalArray = [NSMutableArray array];
   
    // subjects array  11项
    NSArray *subjects = dic[@"subjects"];
    for (NSDictionary *dict in subjects) {
        MovieModal *mDict = [[MovieModal alloc] init];
        NSDictionary *subject = dict[@"subject"];
        mDict.title = subject[@"title"];  // title
        mDict.year = subject[@"year"];    // year
        mDict.images = subject[@"images"];    // images
        
        NSDictionary *rating = subject[@"rating"];
        mDict.average = [rating[@"average"] floatValue];   // average
        
//        NSLog(@"%@",mDict);
        [_movieModalArray addObject:mDict];
    }
    
    _posterView.movieModalArray = _movieModalArray;
}

- (void)_loadDataHttp {
    
    [HttpDataService requestAFUrl:US_BOX httpMethod:@"GET" params:nil data:nil block:^(id result) {
        NSDictionary *dic = result;
        __block MovieViewController *this = self;
        // 可变数组  ->  字典
        this->_movieModalArray = [NSMutableArray array];
        
        // subjects array  11项
        NSArray *subjects = dic[@"subjects"];
        for (NSDictionary *dict in subjects) {
            MovieModal *mDict = [[MovieModal alloc] init];
            NSDictionary *subject = dict[@"subject"];
            mDict.title = subject[@"title"];  // title
            mDict.year = subject[@"year"];    // year
            mDict.images = subject[@"images"];    // images
            
            NSDictionary *rating = subject[@"rating"];
            mDict.average = [rating[@"average"] floatValue];   // average
            
            //        NSLog(@"%@",mDict);
            [this->_movieModalArray addObject:mDict];
        }
        
        this->_posterView.movieModalArray = this->_movieModalArray;
    }] ;
    
    
    
}

#pragma mark - CreateSubviews

// 切换_movieTableView和_posterView的按钮
- (void)_createNav {
    UIView *btnView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 50, 30)];
    
    UIButton *button1 = [UIButton buttonWithType:UIButtonTypeCustom ];
    [button1 setImage:[UIImage imageNamed:@"list_home"] forState:UIControlStateNormal ];
    [button1 setBackgroundImage:[UIImage imageNamed:@"exchange_bg_home@2x"] forState:UIControlStateNormal];
    [button1 sizeToFit];
    button1.tag = 1;
    [button1 addTarget:self action:@selector(buttonAction:) forControlEvents: UIControlEventTouchUpInside ];
    [btnView addSubview:button1];
    
    UIButton *button2 = [UIButton buttonWithType:UIButtonTypeCustom ];
    [button2 setImage:[UIImage imageNamed:@"poster_home"] forState:UIControlStateNormal ];
    [button2 setBackgroundImage:[UIImage imageNamed:@"exchange_bg_home@2x"] forState:UIControlStateNormal];
    [button2 sizeToFit];
    button2.tag = 2;
    [button2 addTarget:self action:@selector(buttonAction:) forControlEvents: UIControlEventTouchUpInside ];
    [btnView addSubview:button2];
    button2.hidden = YES;

    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:btnView];
}

// 电影列表视图
- (void)_creteMovieTableView {
    _movieTableView = [[UITableView alloc] initWithFrame:self.view.bounds];
    _movieTableView.delegate = self;
    _movieTableView.dataSource = self;
    [self.view addSubview:_movieTableView];
    
    // 注册cell
    UINib *nib = [UINib nibWithNibName:@"MovieTableViewCell" bundle:[NSBundle mainBundle]];
    [_movieTableView registerNib:nib forCellReuseIdentifier:@"cell1"];
    _movieTableView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"bg_main"]];
    _movieTableView.hidden = YES;
}

// 海报视图
- (void)_createPosterView {
    _posterView = [[PosterView alloc] initWithFrame:self.view.bounds];
    _posterView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"bg_main"]];
    [self.view addSubview:_posterView];
}

#pragma mark - Actions

- (void)buttonAction:(UIButton *)button {
    UIView *filpView = self.navigationItem.rightBarButtonItem.customView;
    
    UIButton *btn1 = (UIButton *)[filpView viewWithTag:1];
    UIButton *btn2 = (UIButton *)[filpView viewWithTag:2];
    btn1.hidden = !btn1.hidden;
    btn2.hidden = !btn2.hidden;
    _movieTableView.hidden = !_movieTableView.hidden;
    _posterView.hidden = !_posterView.hidden;
    
    BOOL isLeft = btn1.hidden;
    [self filpAction:filpView isLeft:isLeft];
    [self filpAction:self.view isLeft:isLeft];
    
    isLeft = !isLeft;
}

#pragma mark - Tools

// 视图切换动画效果设置
- (void)filpAction:(UIView *)view isLeft:(BOOL)isLeft {
    UIViewAnimationOptions option = isLeft ? UIViewAnimationOptionTransitionFlipFromLeft :UIViewAnimationOptionTransitionFlipFromRight;
    [UIView transitionWithView:view duration:0.5 options:option animations:nil completion:nil];
}

#pragma mark - TableViewDataSourse

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _movieModalArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MovieTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell1" forIndexPath:indexPath];

    cell.movieMessage = _movieModalArray[indexPath.row];
    return cell;
}

#pragma mark - TableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 90;
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
