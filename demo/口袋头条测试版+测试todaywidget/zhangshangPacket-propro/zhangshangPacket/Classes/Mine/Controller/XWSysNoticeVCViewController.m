//
//  XWSysNoticeVCViewController.m
//  zhangshangPacket
//
//  Created by apple on 2017/6/13.
//  Copyright © 2017年 apple-fangqiu. All rights reserved.
//

#import "XWSysNoticeVCViewController.h"
#import "XWMineNoticeCell.h"
#import "XWNoticeModel.h"
#import "XWWKWebTodayVC.h"

@interface XWSysNoticeVCViewController ()
{
    NSString *_urlStr;
}

@property (nonatomic, strong) NSMutableArray *infoArr;

@property (nonatomic, strong) XWNotice *noticeModel;
@end

@implementation XWSysNoticeVCViewController

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
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(ScreenW/2, self.view.yj_centerX, 80, 40)];
    label.textColor = [UIColor whiteColor];
    label.text = @"系统公告";
    label.font = [UIFont systemFontOfSize:18];
    self.navigationItem.titleView = label;
    [self addView];
    
}

- (void)addView
{
    self.tableView.dk_backgroundColorPicker = DKColorPickerWithColors(MainBGColor,NightMainColor,MainRedColor);
    self.tableView.dk_separatorColorPicker = DKColorPickerWithColors(MainBGColor,NightMainLineColor,MainRedColor);
    
    self.tableView.showsVerticalScrollIndicator = NO;
    self.tableView.showsHorizontalScrollIndicator = NO;
    //    self.tableView.emptyDataSetDelegate = self;
    //    self.tableView.emptyDataSetSource = self;
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.top.mas_equalTo(0);
        make.bottom.mas_equalTo(0);
    }];
    
    [self loadData];
    
//        if (STUserDefaults.isLogin){
//    
//            [self loadData];
//    
//        }
//        else
//        {
//            [SVProgressHUD showErrorWithStatus:@"请先登录"];
//    
//        }
    
    
    
}


- (void)loadData
{
    [SVProgressHUD showWithMaskType:SVProgressHUDMaskTypeBlack];
    
    [STRequest SysNoticeDataWithDataBlock:^(id ServersData, BOOL isSuccess) {
        XWNoticeModel *dataModel = [XWNoticeModel mj_objectWithKeyValues:ServersData];
        if (isSuccess) {
            if ([ServersData isKindOfClass:[NSDictionary class]]) {
                if (ServersData[@"c"]) {
                    JLLog(@"%@",ServersData);
                    NSDictionary *dictemp = [NSDictionary dictionaryWithDictionary:ServersData[@"d"]];
                    NSArray *arrtemp = [NSArray arrayWithArray:dictemp[@"notice"]];
                    
                    if (arrtemp.count == 0) {
                        JLLog(@"无更多数据");
                    } else {
                        for (int i = 0; i<arrtemp.count; i++) {
                            //                            self.infoArr = [XWNoticeModel mj_objectArrayWithKeyValuesArray:arrtemp];
                            [self.infoArr addObject:arrtemp[i]];
                            JLLog(@"self.info----%@---",self.infoArr);
                        }
                        
                        [self.tableView reloadData];
                        _urlStr = dictemp[@"noticeurl"] ;
                    }
                    [SVProgressHUD dismiss];
                    [self.tableView.mj_header endRefreshing];
                    [self.tableView.mj_footer endRefreshing];
                    
                }
                else
                {
                    [SVProgressHUD showErrorWithStatus:ServersData[@"m"]];
                    
                }
                
                
            }else{
                [SVProgressHUD showErrorWithStatus:@"网络故障"];
                
            }
            
        }
        else
        {
            [SVProgressHUD showErrorWithStatus:@"无网络"];
            
        }
    }];
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.infoArr.count;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identity = @"XWMineNoticeCell";
    
    XWMineNoticeCell *cell = [tableView dequeueReusableCellWithIdentifier:identity];
    if (cell == nil)
    {
        cell = [[XWMineNoticeCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identity];
    }
    
    [cell setCell:self.infoArr[indexPath.row]];
    
    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary *dict = self.infoArr[indexPath.row];
    NSString *canjumpStr = dict[@"noticeurl"];
    JLLog(@"canjumpStr---%@",canjumpStr);
    if ([self isBlankString:canjumpStr]) {
        [tableView deselectRowAtIndexPath:indexPath animated:YES];
        JLLog(@"1---%@",canjumpStr);

    } else {
        XWWKWebTodayVC *h5vc = [[XWWKWebTodayVC alloc]init];
        [h5vc loadWebURLSring:canjumpStr];
        h5vc.hidesBottomBarWhenPushed = YES;
        //h5vc.navigationItem.title = self.infoArr[indexPath.row][@"title"];
        [self.navigationController pushViewController:h5vc animated:YES];
        JLLog(@"2---%@",canjumpStr);

    }
    
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 130*AdaptiveScale_W;
}


- (NSMutableArray *)infoArr
{
    if (!_infoArr) {
        _infoArr = [NSMutableArray new] ;
    }
    return _infoArr;
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
