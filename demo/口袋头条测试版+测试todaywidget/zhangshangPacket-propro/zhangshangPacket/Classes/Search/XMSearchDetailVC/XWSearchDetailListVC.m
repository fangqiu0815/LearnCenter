//
//  XWSearchDetailListVC.m
//  zhangshangPacket
//
//  Created by apple on 2017/8/4.
//  Copyright © 2017年 apple-fangqiu. All rights reserved.
//

#import "XWSearchDetailListVC.h"
#import "XWSearchListCell.h"
#import "XWSearchPostModel.h"

@interface XWSearchDetailListVC ()<DZNEmptyDataSetDelegate,
DZNEmptyDataSetSource>
{
    UIImageView *navBarHairlineImageView;
}
@property (nonatomic, strong) NSMutableArray *infoArr;
@end

@implementation XWSearchDetailListVC

//设置字体颜色
- (UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;//黑色
}

//设置状态栏颜色
- (void)setStatusBarBackgroundColor:(UIColor *)color {
    
    //    UIView *statusBar = [[[UIApplication sharedApplication] valueForKey:@"statusBarWindow"] valueForKey:@"statusBar"];
    //    if ([statusBar respondsToSelector:@selector(setBackgroundColor:)]) {
    //        statusBar.backgroundColor = color;
    //    }
}
//！！！重点在viewWillAppear方法里调用下面两个方法
-(void)viewWillAppear:(BOOL)animated{
    [self preferredStatusBarStyle];
    [self setStatusBarBackgroundColor:MainRedColor];
    self.navigationController.navigationBar.translucent = NO;
    self.navigationController.navigationBar.dk_barTintColorPicker = DKColorPickerWithColors(MainRedColor,NightMainNaviColor,MainRedColor);
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 设置导航栏标题变大
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(self.view.yj_centerY-20, self.view.yj_centerX, 80, 40)];
    label.textAlignment = NSTextAlignmentCenter;
    label.textColor = [UIColor whiteColor];
    label.text = @"搜索结果";
    label.font = [UIFont systemFontOfSize:18];
    self.navigationItem.titleView = label;
    navBarHairlineImageView = [self findHairlineImageViewUnder:self.navigationController.navigationBar];
    
    [self setupTableView];
    
}

- (UIImageView*)findHairlineImageViewUnder:(UIView*)view {
    if([view isKindOfClass:UIImageView.class] && view.bounds.size.height<=1.0) {
        return(UIImageView*)view;
    }
    for(UIView *subview in view.subviews) {
        UIImageView *imageView = [self findHairlineImageViewUnder:subview];
        if(imageView) {
            return imageView;
        }
    }
    return nil;
}

- (void)setupTableView
{
    self.tableView.dk_backgroundColorPicker = DKColorPickerWithColors(MainBGColor,NightMainColor,MainRedColor);
    self.tableView.dk_separatorColorPicker = DKColorPickerWithColors(MainBGColor,NightMainLineColor,MainRedColor);
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.emptyDataSetDelegate = self;
    self.tableView.emptyDataSetSource = self;
    self.tableView.showsVerticalScrollIndicator = NO;
    self.tableView.showsHorizontalScrollIndicator = NO;
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.top.mas_equalTo(0);
        make.bottom.mas_equalTo(0);
    }];

    [self postSearchHistory];
    
}

- (void)postSearchHistory
{
    [self.infoArr removeAllObjects];
    [SVProgressHUD showWithStatus:@"正在加载数据" maskType:SVProgressHUDMaskTypeBlack];
    [STRequest HotSearchWordData:self.titleStr andDataBlock:^(id ServersData, BOOL isSuccess) {
        if (isSuccess) {
            if ([ServersData isKindOfClass:[NSDictionary class]]) {
                if ([ServersData[@"c"] intValue] == 1) {
                    JLLog(@"成功----sera--%@",ServersData);
                    [SVProgressHUD dismiss];
                    NSDictionary *dictemp = [NSDictionary dictionaryWithDictionary:ServersData[@"d"]];
                    NSMutableArray *tempArray = [SearchPostListModel mj_objectArrayWithKeyValuesArray:dictemp[@"searchlist"]];
                    
                    if (tempArray.count == 0) {
                        [SVProgressHUD showSuccessWithStatus:@"没有更多搜索记录了"];
                    } else {
                        for (int i = 0; i<tempArray.count; i++) {
                            
                            [self.infoArr addObject:tempArray[i]];
                            [self.tableView reloadData];
                        }
                    }
                }else
                {
                    JLLog(@"错误：%@",ServersData[@"m"]);
                }
                
            } else {
                [SVProgressHUD showErrorWithStatus:@"服务端数据出错"];
                
            }
        } else {
            
            [SVProgressHUD showErrorWithStatus:@"网络错误，请重试"];
        }
    }];
    
}


#pragma mark Empty_Data
- (UIImage *)imageForEmptyDataSet:(UIScrollView *)scrollView
{
    return MyImage(@"bg_default_mission");
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.infoArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    SearchPostListModel *model = self.infoArr[indexPath.row];
    JLLog(@"model---%@",model);
    XWSearchListCell *cell = [tableView dequeueReusableCellWithIdentifier:@"XWSearchListCell"];
    if (cell == nil)
    {
        cell = [[XWSearchListCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"XWSearchListCell"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    cell.dataModel = model;
    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    SearchPostListModel *model = self.infoArr[indexPath.row];
    WKWebViewController *wkwebview = [[WKWebViewController alloc]init];
    [wkwebview loadWebURLSring:model.weburl];
    [self.navigationController pushViewController:wkwebview animated:YES];
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


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 110*AdaptiveScale_W;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    
    return 40;
    
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc]init];
    view.dk_backgroundColorPicker  = DKColorPickerWithColors(WhiteColor,NightMainBGColor,MainRedColor);
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(15*AdaptiveScale_W, 5, ScreenW*0.4, 30)];
    label.text = @"搜索结果";
    label.font = [UIFont systemFontOfSize:RemindFont(16, 17, 18)];
    label.dk_textColorPicker = DKColorPickerWithColors(BlackColor,WhiteColor,MainRedColor);
    [view addSubview:label];
    
    UIView *bottom = [[UIView alloc]init];
    bottom.dk_backgroundColorPicker = DKColorPickerWithColors(MainBGColor,NightMainBGColor,MainRedColor);
    [view addSubview:bottom];
    [bottom mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.mas_equalTo(0);
        make.height.mas_equalTo(1);
    }];
    
    return view;
}


- (NSMutableArray *)infoArr
{
    if (!_infoArr) {
        _infoArr = [NSMutableArray new];
    }
    return _infoArr;
}



- (void)dealloc
{
    JLLog(@"---dealloc----");
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
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
