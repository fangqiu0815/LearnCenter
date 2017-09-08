//
//  XWCollectVC.m
//  zhangshangPacket
//
//  Created by apple on 2017/7/21.
//  Copyright © 2017年 apple-fangqiu. All rights reserved.
//

#import "XWCollectVC.h"
#import "XWCetCell.h"
#import "XWHomeCheckCollectTool.h"
#import "XWHomeDetailNewsVC.h"
#import "XWWKWebTodayVC.h"
@interface XWCollectVC ()<DZNEmptyDataSetDelegate,
DZNEmptyDataSetSource>
{
    UIImageView *navBarHairlineImageView;
}
@property (nonatomic, strong) NSMutableArray *infoArr;
@property (nonatomic,strong) NSMutableArray *selectedModelList;

@end

@implementation XWCollectVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupUI];
    // 设置导航栏标题变大
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(self.view.yj_centerY-20, self.view.yj_centerX, 80, 40)];
    label.textAlignment = NSTextAlignmentCenter;
    label.textColor = [UIColor whiteColor];
    label.text = @"收藏记录";
    label.font = [UIFont systemFontOfSize:18];
    self.navigationItem.titleView = label;
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

- (void)setupUI{
    
    self.tableView.dk_backgroundColorPicker = DKColorPickerWithColors(MainBGColor,NightMainColor,MainRedColor);
    self.tableView.dk_separatorColorPicker = DKColorPickerWithColors(MainBGColor,NightMainLineColor,MainRedColor);
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
    
    [self topicAdd];
    
    UIBarButtonItem *barBtn = [self addSelectBtn:@"清空" action:@selector(selectClick)];
    self.navigationItem.rightBarButtonItems = @[barBtn];
    
}

- (void)topicAdd
{
    
    self.infoArr = [XWHomeCheckCollectTool topics];
    JLLog(@"%@",self.infoArr);
    [self.tableView reloadData];
}

-(void)selectClick{
    
    if (self.infoArr.count == 0) {
        [SVProgressHUD showSuccessWithStatus:@"当前无收藏记录"];
    } else {
        [self createAlertWithString];
        
    }
    
}

-(void)createAlertWithString
{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"确认删除所有收藏记录?删除后无法恢复" message:nil preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *action = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    
    UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [XWHomeCheckCollectTool deleteAllDataFromSql];
        [self.infoArr removeAllObjects];
        [self.tableView reloadData];
        
    }];
    
    [alert addAction:action];
    [alert addAction:action1];
    [self presentViewController:alert animated:YES completion:nil];
    
}


-(UIBarButtonItem *)addSelectBtn:(NSString *)btTitle action:(SEL)sel{
    UIBarButtonItem *barBtn = [[UIBarButtonItem alloc]initWithTitle:btTitle style:UIBarButtonItemStylePlain target:self action:sel];
    [barBtn setTintColor:WhiteColor];
    
    return barBtn;
}

//设置字体颜色
- (UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
}

//设置状态栏颜色
- (void)setStatusBarBackgroundColor:(UIColor *)color {
    
    //    UIView *statusBar = [[[UIApplication sharedApplication] valueForKey:@"statusBarWindow"] valueForKey:@"statusBar"];
    //    if ([statusBar respondsToSelector:@selector(setBackgroundColor:)]) {
    //        statusBar.backgroundColor = color;
    //    }
}

- (void)viewWillAppear:(BOOL)animated{
    navBarHairlineImageView.hidden = YES;
    [self preferredStatusBarStyle];
    [self setStatusBarBackgroundColor:MainRedColor];
    self.navigationController.navigationBar.translucent = NO;
    self.navigationController.navigationBar.dk_barTintColorPicker = DKColorPickerWithColors(MainRedColor,NightMainNaviColor,MainRedColor);

}


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
    
    XWCetCell *cell = [tableView dequeueReusableCellWithIdentifier:@"XWCetCell"];
    
    NewsListDataModel *model = self.infoArr[indexPath.row];
    if (cell == nil)
    {
        cell = [[XWCetCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"XWCetCell"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    cell.model = model;
    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSIndexPath *indexPathA = [NSIndexPath indexPathForRow:indexPath.row inSection:0];
    [tableView reloadRowsAtIndexPaths:[NSArray arrayWithObjects:indexPathA,nil] withRowAnimation:UITableViewRowAnimationNone];
    
    NewsListDataModel *model = self.infoArr[indexPath.row];
    
    XWWKWebTodayVC *detailsController = [[XWWKWebTodayVC alloc] init];
    JLLog(@"model.url---%@",model.url);
    [detailsController loadWebURLSring:model.url];
    // 设置导航栏标题变大
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(ScreenW/2, self.view.yj_centerX, 80, 40)];
    label.textColor = [UIColor whiteColor];
    label.font = [UIFont systemFontOfSize:18];
    label.text = model.title;
    detailsController.navigationItem.titleView = label;
    
    [self setHidesBottomBarWhenPushed:YES];//隐藏tabbar
    [self.navigationController pushViewController:detailsController animated:YES];
    
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
    //    if (indexPath.section == 0)
    //    {
    //        return 100*AdaptiveScale_W;
    //
    //    }else
    //    {
    return 100*AdaptiveScale_W;
    //    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    //    if (section == 0) {
    //        return 1;
    //    }else{
    return 1;
    //   }
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
