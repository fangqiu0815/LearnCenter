//
//  XWDisFastestDetailVC.m
//  zhangshangPacket
//
//  Created by apple on 2017/8/4.
//  Copyright © 2017年 apple-fangqiu. All rights reserved.
//

#import "XWDisFastestDetailVC.h"
#import "XWDisFastRecommendModel.h"
#import "XWDisFastDetailHeadView.h"
#import "XWDisFastRecommendModel.h"
#import "XWDisAblumCell.h"
#import "XWDisTitleCell.h"

@interface XWDisFastestDetailVC ()<DZNEmptyDataSetDelegate,
DZNEmptyDataSetSource>
{
    UIImageView *navBarHairlineImageView;
    NSString *_iconImageView;
    NSString *_wechatName;
    NSString *_wechatID;
    NSString *_typeStr;
    NSString *_countStr;
    NSString *_contentStr;

}
@property (nonatomic, strong) NSArray *titleData;
@property (nonatomic, strong) NSMutableArray *infoArr;

@end

@implementation XWDisFastestDetailVC

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

-(void)viewWillAppear:(BOOL)animated{
    [self preferredStatusBarStyle];
    [self setStatusBarBackgroundColor:MainRedColor];
    self.navigationController.navigationBar.translucent = NO;
    self.navigationController.navigationBar.dk_barTintColorPicker = DKColorPickerWithColors(MainRedColor,NightMainNaviColor,MainRedColor);

}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = WhiteColor;
    [self loadData];
    navBarHairlineImageView = [self findHairlineImageViewUnder:self.navigationController.navigationBar];
    
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
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.showsVerticalScrollIndicator = NO;
    self.tableView.showsHorizontalScrollIndicator = NO;
    self.tableView.emptyDataSetDelegate = self;
    self.tableView.emptyDataSetSource = self;
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.top.mas_equalTo(0);
        make.bottom.mas_equalTo(0);
    }];
    [self setupHeaderView];

}

- (void)setupHeaderView
{
    
    XWDisFastDetailHeadView *headView = [[XWDisFastDetailHeadView alloc]initWithFrame:CGRectMake(0, 0, ScreenW, 350*AdaptiveScale_W)];
    headView.dk_backgroundColorPicker = DKColorPickerWithColors(WhiteColor,NightMainBGColor,MainRedColor);
    UIImage *image1 = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:_iconImageView]]];
    CGImageRef imageRef = image1.CGImage;
    CGRect rect = CGRectMake(170, 170, 91, 91);
    CGImageRef image2 = CGImageCreateWithImageInRect(imageRef,rect);
    UIImage *newImage = [[UIImage alloc] initWithCGImage:image2];
    headView.iconImageView.image = newImage;
    
    headView.wechatName.text = _wechatName;
    if (STUserDefaults.ischeck == 1) {
        headView.wechatID.text = [NSString stringWithFormat:@"ID:%@",_wechatID];

    } else {
        headView.wechatID.text = [NSString stringWithFormat:@"微信号:%@",_wechatID];

    }
    headView.typeAndAccount.text = [NSString stringWithFormat:@"%@|%@人订阅",_typeStr,_countStr];
    headView.contentLab.text = _contentStr;
    [headView.gotoWechat addTarget:self action:@selector(gotoWechatClick:) forControlEvents:UIControlEventTouchUpInside];
    JLLog(@"wechatName---%@\ncontent---%@",_wechatName,_contentStr);
    
    self.tableView.tableHeaderView = headView;
    
}

- (void)gotoWechatClick:(id)sender
{
    UIPasteboard *pab = [UIPasteboard generalPasteboard];
    NSString *string = _wechatID;
    [pab setString:string];
    if (pab == nil) {
        JLLog(@"复制失败");
    }else
    {
        JLLog(@"复制成功%@",string);
        if (STUserDefaults.ischeck == 1) {
            [SVProgressHUD showSuccessWithStatus:@"复制ID成功,快去搜索吧"];
        }
    }
    
    if (STUserDefaults.ischeck == 1) {
        
    } else {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"温馨提示" message:@"是否前往微信关注该公众号？(该微信号已复制成功)" preferredStyle:UIAlertControllerStyleAlert];
        [alert addAction:[UIAlertAction actionWithTitle:@"是" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            NSURL * url = [NSURL URLWithString:@"weixin://"];
            BOOL canOpen = [[UIApplication sharedApplication] canOpenURL:url];
            //先判断是否能打开该url
            if (canOpen)
            {   //打开微信
                [[UIApplication sharedApplication] openURL:url];
            }else {
                [SVProgressHUD showErrorWithStatus:@"您需要先安装微信"];
            }
            
        }]];
        
        [alert addAction:[UIAlertAction actionWithTitle:@"否" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
        }]];
        
        [self presentViewController:alert animated:YES completion:nil];
        
    }
    
}

#pragma mark askForData
-(void)loadData
{
    [SVProgressHUD showWithMaskType:SVProgressHUDMaskTypeBlack];
    [STRequest DiscoverGetRecommendDetailItem:[_artid intValue] andDataBlock:^(id ServersData, BOOL isSuccess) {
        if (isSuccess) {
            JLLog(@"ServersData---%@",ServersData);
            if ([ServersData isKindOfClass:[NSDictionary class]]) {
                if (ServersData[@"c"]) {
                    [SVProgressHUD dismiss];

                    NSDictionary *dictemp = [NSDictionary dictionaryWithDictionary:ServersData[@"d"]];
                    NSMutableArray *arrtemp = [DisFastRecommendModel mj_objectArrayWithKeyValuesArray:dictemp[@"artlist"]];
                    if (arrtemp.count == 0) {
                        [SVProgressHUD showErrorWithStatus:@"更多推荐敬请期待"];
                    } else {
                        for (int i = 0; i<arrtemp.count; i++) {
                            [self.infoArr addObject:arrtemp[i]];
                        }
                        [self.tableView reloadData];
                        
                    }
                    _wechatName = dictemp[@"title"];
                    _wechatID = dictemp[@"wechatid"];
                    _typeStr = dictemp[@"source"];
                    _countStr = dictemp[@"orderread"];
                    _iconImageView = dictemp[@"pic"];
                    _contentStr = dictemp[@"content"];
                    JLLog(@"wechatName---%@\ncontent---%@",_wechatName,_contentStr);
                    [self setupTableView];

                }
                else
                {
                    
                    [SVProgressHUD showErrorWithStatus:ServersData[@"m"]];
                    [self.tableView.mj_header endRefreshing];
                    [self.tableView.mj_footer endRefreshing];
                }
                
            }else
            {
                [SVProgressHUD showErrorWithStatus:@"网络故障"];
                [self.tableView.mj_header endRefreshing];
                [self.tableView.mj_footer endRefreshing];
                
            }
            
        }
        else
        {
            [SVProgressHUD showErrorWithStatus:@"无网络"];
            [self.tableView.mj_header endRefreshing];
            [self.tableView.mj_footer endRefreshing];
            
        }
    }];
    

    
}

#pragma mark Empty_Data
- (UIImage *)imageForEmptyDataSet:(UIScrollView *)scrollView
{
    return MyImage(@"wushuju_");
}

#pragma mark - UITableViewDelegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    //    if(section == 0 ){
    //        return 1;
    //    }else{
    return self.infoArr.count;
    //    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identity = @"XWDisTitleCell";
    DisFastRecommendModel *model = self.infoArr[indexPath.row];
    XWDisTitleCell *cell = [tableView dequeueReusableCellWithIdentifier:identity];
    cell.dk_backgroundColorPicker = DKColorPickerWithColors(WhiteColor,NightMainBGColor,MainRedColor);
    if (cell == nil)
    {
        cell = [[XWDisTitleCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identity];
    }
    cell.titleLab.text = model.arttitle;
    cell.titleLab.dk_textColorPicker = DKColorPickerWithColors(BlackColor,WhiteColor,MainRedColor);
    cell.titleLab.font = [UIFont systemFontOfSize:RemindFont(14, 15, 16)];
    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // 取消选中状态
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    DisFastRecommendModel *model = self.infoArr[indexPath.row];
    WKWebViewController *wkVC = [[WKWebViewController alloc]init];
    [wkVC loadWebURLSring:model.arturl];
    [self.navigationController pushViewController:wkVC animated:YES];
    [wkVC setHidesBottomBarWhenPushed:YES];
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
   
    return 60*AdaptiveScale_W;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    
    return 45;
    
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc]init];
    view.dk_backgroundColorPicker  = DKColorPickerWithColors(WhiteColor,NightMainBGColor,MainRedColor);
    UIView *topView = [[UIView alloc]init];
    topView.dk_backgroundColorPicker = DKColorPickerWithColors(MainBGColor,NightBolangBGColor,MainRedColor);
    [view addSubview:topView];
    [topView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.mas_equalTo(0);
        make.height.mas_equalTo(5);
    }];
    
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(ScreenW*0.25, 8, ScreenW*0.5, 30)];
    label.text = [NSString stringWithFormat:@"文章(%ld)",(unsigned long)self.infoArr.count];
    label.font = [UIFont systemFontOfSize:RemindFont(16, 17, 18)];
    label.textAlignment = NSTextAlignmentCenter;
    label.dk_textColorPicker = DKColorPickerWithColors(BlackColor,WhiteColor,MainRedColor);
    [view addSubview:label];
    
    UIView *bottom = [[UIView alloc]init];
    bottom.dk_backgroundColorPicker = DKColorPickerWithColors(MainBGColor,NightMainLineColor,MainRedColor);
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
