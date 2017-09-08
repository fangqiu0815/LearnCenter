//
//  XWHomeJokeVC.m
//  zhangshangPacket
//
//  Created by apple on 2017/5/25.
//  Copyright © 2017年 apple-fangqiu. All rights reserved.
//

#import "XWHomeJokeVC.h"
#import "XWHomeJokeModel.h"
#import "XWJokeCell.h"
#import "XWJokeCommentCell.h"
#import "UITableView+FDTemplateLayoutCell.h"

static NSString *cellID = @"XWJokeCell";
static NSString *cellCommentID = @"XWJokeCommentCell";
@interface XWHomeJokeVC ()
{
    NSInteger _cellType;
}
@property (nonatomic, strong) NSMutableArray *infoArrFrames;
/** 上一次选中 tabBar 的索引*/
@property (nonatomic, strong) UIViewController *lastSelectedIndex;

@property (nonatomic, strong) NSMutableArray *jokeArr;

@end

@implementation XWHomeJokeVC

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    //通知方式去监测点击tabbar
//    // 监听 tabBar 点击的通知
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(tabBarSelected) name:@"TabRefresh" object:nil];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupUI];
}

//- (void)tabBarSelected{
//    
//    //如果是连点 2 次，并且 如果选中的是当前导航控制器，刷新
//    if (self.lastSelectedIndex != self.tabBarController.selectedViewController && self.view.isShowingOnKeyWindow) {
//        [self.tableView.mj_header beginRefreshing];
//        NSLog(@"%@--%@",self,self.parentViewController);
//    };
//    
//    self.lastSelectedIndex = self.tabBarController.selectedViewController;
//    
//}
//
//- (void)viewDidLayoutSubviews
//{
//    [super viewDidLayoutSubviews];
//    if (!self.lastSelectedIndex) {
//        self.lastSelectedIndex = self.tabBarController.selectedViewController;
//    }
//}

- (void)setupUI
{
    self.tableView.dk_backgroundColorPicker = DKColorPickerWithColors(MainBGColor,NightMainColor,MainRedColor);
    self.tableView.dk_separatorColorPicker = DKColorPickerWithColors(MainBGColor,NightMainLineColor,MainRedColor);
    // self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.top.mas_equalTo(0);
        make.bottom.mas_equalTo(0);
    }];
    
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        if (STUserDefaults.isLogin) {
            [_infoArrFrames removeAllObjects];
            [self loadData];
        
        }else{
        
            [self.tableView.mj_header endRefreshing];
            [SVProgressHUD showErrorWithStatus:@"请先登录"];
        
        }
        
    }];
    
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        if (STUserDefaults.isLogin){
            [self loadData];
        
        }
        else
        {
            [self.tableView.mj_footer endRefreshing];
            [SVProgressHUD showErrorWithStatus:@"请先登录"];
        
        }
        
    }];
    
    if (STUserDefaults.isLogin){
    
        [self loadData];
        
    }
    else
    {
        [SVProgressHUD showErrorWithStatus:@"请先登录"];
        
    }

    
    [self.tableView registerClass:[XWJokeCell class] forCellReuseIdentifier:cellID];
    [self.tableView registerClass:[XWJokeCommentCell class] forCellReuseIdentifier:cellCommentID];
    //self.tableView.fd_debugLogEnabled = YES;

    
}

- (void)loadData
{
    [STRequest JokesInfoDataWithBlock:^(id ServersData, BOOL isSuccess) {
        JLLog(@"serverdata---%@",ServersData);
        if (isSuccess) {
            if ([ServersData isKindOfClass:[NSDictionary class]]) {
                if ([ServersData[@"c"] intValue] == 1) {
                    
                    
                    
                    NSDictionary *dictemp = [NSDictionary dictionaryWithDictionary:ServersData[@"d"]];
                    NSMutableArray *arrtemp = [NSMutableArray arrayWithArray:dictemp[@"jokeslist"]];
                    
                    [self.tableView.mj_header endRefreshingWithCompletionBlock:^{
                        [self showNewStatusesCount:arrtemp.count];
                    }];
                    
                    [self.tableView.mj_footer endRefreshing];
                    
                    if (arrtemp.count == 0) {
                        JLLog(@"无更多数据");
                    } else {
                        self.jokeArr = [JokeData mj_objectArrayWithKeyValuesArray:arrtemp];
                        
                        for (int i = 0; i < arrtemp.count; i++) {
                            
                            [self.infoArrFrames addObject:self.jokeArr[i]];
                            
                        }
                        
                        [self.tableView reloadData];

                    }
                }else
                {
                    
                    [SVProgressHUD showErrorWithStatus:ServersData[@"m"]];
                    [self.tableView.mj_header endRefreshing];
                    [self.tableView.mj_footer endRefreshing];

                }
                
                
            }else{
                [SVProgressHUD showErrorWithStatus:@"服务端数据出错"];
                [self.tableView.mj_header endRefreshing];
                [self.tableView.mj_footer endRefreshing];

            }
        }else{
            
            [SVProgressHUD showErrorWithStatus:@"网络错误，请重试"];
            [self.tableView.mj_header endRefreshing];
            [self.tableView.mj_footer endRefreshing];

        }
        
    }];
    
    
}

/**
 *  提示用户最新的资讯数量
 *
 *  @param count 最新资讯数量
 */
- (void)showNewStatusesCount:(int)count
{
    UILabel *label = [[UILabel alloc] init];
    if (count) {
        label.text = [NSString stringWithFormat:@"口袋头条为您推荐%d条更新", count];
    } else {
        label.text = @"没有更多更新";
    }
    
    label.backgroundColor = CUSTOMCOLOR(255, 150, 150);
    label.textAlignment = NSTextAlignmentCenter;
    label.font = [UIFont systemFontOfSize:RemindFont(14, 15, 16)];
    label.textColor = WhiteColor;
    label.yj_width = self.view.yj_width;
    label.yj_height = 40;
    label.yj_x = 0;
    label.yj_y = 64 - label.yj_height;
    [self.navigationController.view insertSubview:label belowSubview:self.navigationController.navigationBar];
    CGFloat duration = 0.25;
    [UIView animateWithDuration:duration animations:^{
        label.transform = CGAffineTransformMakeTranslation(0, label.yj_height);
    } completion:^(BOOL finished) {
        CGFloat delay = 1.0;
        
        [UIView animateWithDuration:duration delay:delay options:UIViewAnimationOptionCurveEaseInOut animations:^{
            
            label.transform = CGAffineTransformIdentity;
        } completion:^(BOOL finished) {
            [label removeFromSuperview];
        }];
    }];
    
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.infoArrFrames.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    JokeData *dataModel = self.infoArrFrames[indexPath.row];
 //   if ([dataModel.pname length] == 0) {
        XWJokeCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        if (cell == nil) {
            cell = [[XWJokeCell alloc ]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        }
        
        [self configureCell:cell atIndexPath:indexPath];
        return cell;
//    } else {
//        
//        XWJokeCommentCell *commentcell = [tableView dequeueReusableCellWithIdentifier:cellCommentID];
//        if (commentcell == nil) {
//            commentcell = [[XWJokeCommentCell alloc ]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellCommentID];
//        }
//        
//        JLLog(@" dataModel.pname---%@ ",dataModel.pname);
//        
//        [self configureCommentCell:commentcell atIndexPath:indexPath];
//        return commentcell;
//    }

   
}

- (void)configureCell:(XWJokeCell *)cell atIndexPath:(NSIndexPath *)indexPath{
    
    cell.fd_enforceFrameLayout = YES; // Enable to use "-sizeThatFits:"
    cell.dataModel = self.infoArrFrames[indexPath.row];
}

- (void)configureCommentCell:(XWJokeCommentCell *)cell atIndexPath:(NSIndexPath *)indexPath{
    
    cell.fd_enforceFrameLayout = YES; // Enable to use "-sizeThatFits:"
    cell.dataModel = self.infoArrFrames[indexPath.row];
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    JokeData *dataModel = self.infoArrFrames[indexPath.row];

    return [self.tableView fd_heightForCellWithIdentifier:cellID configuration:^(XWJokeCell *cell) {
            [self configureCell:cell atIndexPath:indexPath];
            }] + 30;
    
}

- (NSMutableArray *)jokeArr
{
    if (!_jokeArr) {
        _jokeArr = [NSMutableArray array];
    }
    return _jokeArr;
}

- (NSMutableArray *)infoArrFrames
{
    if (!_infoArrFrames) {
        _infoArrFrames = [NSMutableArray array];
    }
    return _infoArrFrames;
}

-(BOOL)isBlankString:(NSString *)string {
    if (string == nil || string == NULL) {
        return YES;
    }
    if ([string isKindOfClass:[NSNull class]]) {
        return YES;
    }
    if ([[string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] length]==0) {
        return YES;
    }
    if ([string isEqualToString:@"(null)"]) {
        return YES;
    }
    if ([string isEqualToString:@"<null>"]) {
        return YES;
    }
    return NO;
}




- (void)dealloc
{
    JLLog(@"dealloc");

}

@end
