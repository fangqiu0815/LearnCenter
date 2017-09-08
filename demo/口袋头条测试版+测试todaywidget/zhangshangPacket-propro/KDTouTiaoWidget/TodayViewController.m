//
//  TodayViewController.m
//  KDTouTiaoWidget
//
//  Created by apple on 2017/8/8.
//  Copyright © 2017年 apple-fangqiu. All rights reserved.
//

#import "TodayViewController.h"
#import <NotificationCenter/NotificationCenter.h>
#import "AFNetworking.h"
#import "XWTWNewsCell.h"
#import "XWTWNewsModel.h"
#import "Masonry.h"
#import "STRequest.h"
#import "MJExtension.h"

#define cellHeight 85

@interface TodayViewController () <NCWidgetProviding,UITableViewDataSource,UITableViewDelegate>
{
    NSInteger _cellType;
    NSInteger isFirstGet;
    NSInteger isreading;
    NSString *readingID;
}

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, assign) NSInteger artidFirst;
@property (nonatomic, assign) NSInteger artidLast;
@property (nonatomic, assign) NSInteger artidFirstData;
@property (nonatomic, strong) NSMutableArray *muarray;
@property (nonatomic, strong) NSMutableArray *infoArr;
@property (nonatomic, strong) NSMutableArray *newsArr;
@property (nonatomic, strong) XWTWNewsModel *dataModel;
@property (nonatomic, assign) NSInteger artidMaxid;
@property (nonatomic, assign) NSInteger artidMinid;

@end

@implementation TodayViewController{
    XWTWNewsCell *dynamicCell;
    NSMutableArray *modelArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    
    [self loadData];
    
    UIButton *footBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [footBtn setTitle:@"查看更多" forState:UIControlStateNormal];
    [footBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [footBtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateHighlighted];
    footBtn.layer.cornerRadius = 5;
    [footBtn setBackgroundColor:[UIColor colorWithWhite:1 alpha:.3]];
    [self.view addSubview:footBtn];
    [footBtn addTarget:self action:@selector(moreAction) forControlEvents:UIControlEventTouchUpInside];
    
    [footBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left).offset(20);
        make.bottom.equalTo(self.view.mas_bottom).offset(-12.5);
        make.right.equalTo(self.view.mas_right).offset(-20);
        make.height.equalTo(@25);
    }];
    
    
    [self setPreferredContentSize:CGSizeMake(self.view.frame.size.width, cellHeight*4+ 50)];

}

- (void)loadData
{
    NSInteger direDown = 1;
    [self.muarray removeAllObjects];
    [STRequest NewsInfoNewDataParam:0 andDireParam:direDown andDataBlock:^(id ServersData, BOOL isSuccess) {
        NSLog(@"ServersData----%@",ServersData);
        
        self.dataModel = [XWTWNewsModel mj_objectWithKeyValues:ServersData];
        if (isSuccess) {
            if ([ServersData[@"c"] intValue] == 1) {
                
                NSDictionary *dictemp = [NSDictionary dictionaryWithDictionary:ServersData[@"d"]];
                NSMutableArray *arrtemp = [NSMutableArray arrayWithArray:dictemp[@"newslist"]];
                
                if (arrtemp.count == 0) {
                    NSLog(@"暂无更多数据");
                } else {
                    
                    self.newsArr = [TWNewsModel mj_objectArrayWithKeyValuesArray:arrtemp];
                    for (int i = arrtemp.count - 1 ; i >= 0; i--) {
                        
                        [self.infoArr insertObject:self.newsArr[i] atIndex:0];
                        
                    }
                    
                    _artidMaxid = [dictemp[@"maxid"] integerValue];
                    _artidMinid = [dictemp[@"minid"] integerValue];
                    if (_artidMaxid > 0) {
                        _artidFirstData = [dictemp[@"minid"] integerValue];
                        _artidLast = _artidMaxid;
                        
                    } else {
                        _artidFirstData = _artidMinid;
                        _artidLast = _artidMaxid;
                        
                    }
                    
                    dispatch_async(dispatch_get_main_queue(), ^{
                        [self.tableView reloadData];
                    });
                }
            }else
            {
                NSLog(@"%@",ServersData[@"m"]);
            }
            
        }else{
            NSLog(@"网络错误，请重试");
        }
    }];

}

- (void)creatTableView {
    
    _tableView  = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
    _tableView.dataSource  = self;
    _tableView.delegate = self;
    _tableView.tableFooterView = [[UIView alloc] init];
    [self.view addSubview:_tableView];
    
    [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left);
        make.top.equalTo(self.view.mas_top);
        make.right.equalTo(self.view.mas_right);
        make.bottom.equalTo(self.view.mas_bottom).offset(-50);
    }];
    
}


#pragma mark - UITableViewDataSource,UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return modelArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identifier = @"XWTWNewsCell";
    dynamicCell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (dynamicCell == nil) {
        
        dynamicCell = [[XWTWNewsCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    
    dynamicCell.model = modelArray[indexPath.row];
    
    return dynamicCell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 85;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView  deselectRowAtIndexPath:indexPath animated:YES];
    
    TWNewsModel *model = [modelArray objectAtIndex:indexPath.row];
    NSString *string = [NSString stringWithFormat:@"kdtoutiao://action=openNewsUrl=%@",model.url];
    
    [self.extensionContext openURL:[NSURL URLWithString:string] completionHandler:nil];
}

- (void)moreAction {
    [self.extensionContext openURL:[NSURL URLWithString:@"kdtoutiao://action=openAPP"] completionHandler:nil];
}

- (void)widgetPerformUpdateWithCompletionHandler:(void (^)(NCUpdateResult))completionHandler {
    
    completionHandler(NCUpdateResultNewData);
}
- (UIEdgeInsets)widgetMarginInsetsForProposedMarginInsets:(UIEdgeInsets)defaultMarginInsets
{
    return  UIEdgeInsetsMake(0, 0, 0, 0);
}

- (NSMutableArray *)infoArr
{
    if (!_infoArr) {
        _infoArr = [NSMutableArray array];
    }
    return _infoArr;
}

- (NSMutableArray *)muarray
{
    if (!_muarray) {
        _muarray = [NSMutableArray array];
    }
    return _muarray;
}
- (NSMutableArray *)newsArr
{
    if (!_newsArr) {
        _newsArr = [NSMutableArray array];
    }
    return _newsArr;
}

@end
