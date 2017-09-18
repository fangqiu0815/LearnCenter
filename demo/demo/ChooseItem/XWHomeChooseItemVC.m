//
//  XWHomeChooseItemVC.m
//  zhangshangPacket
//
//  Created by apple-gaofangqiu on 2017/8/30.
//  Copyright © 2017年 apple-fangqiu. All rights reserved.
//

#import "XWHomeChooseItemVC.h"
#import "XWHobbyItemManager.h"
#import "XWHobbyChannelView.h"

@interface XWHomeChooseItemVC ()

{
    UIImageView *navBarHairlineImageView;
}
@property (nonatomic, strong) NSMutableArray *infoArr;

@property(nonatomic,strong) UICollectionView *collectionView;
@property(nonatomic,strong) NSMutableArray *dataSourceArr;
@property(nonatomic,strong) NSMutableArray *meTitleArrs;
@property(nonatomic,strong) NSMutableArray *otherTitleArrs;

@property (nonatomic, weak) XWHobbyItemManager *manager;

@property (nonatomic, strong) XWHobbyChannelView *managerView;

@property (nonatomic, strong) NSMutableArray *top;

@property (nonatomic, strong) NSMutableArray *bottom;

@end

@implementation XWHomeChooseItemVC

- (void)viewDidLoad {
    [super viewDidLoad];

    [self setUpHeader];
    
    
    [self setupUI];
    

}

- (void)setUpHeader
{
    UIView *headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenW, 64)];
    headerView.backgroundColor = [UIColor redColor];
    [self.view addSubview:headerView];
    
    UIView *littleView = [[UIView alloc]initWithFrame:CGRectMake(0, 20, ScreenW, 44)];
    littleView.backgroundColor = [UIColor redColor];
    [headerView addSubview:littleView];
    
    UILabel *titleLab = [[UILabel alloc]init];
    titleLab.backgroundColor = [UIColor whiteColor];
    titleLab.text = @"选择频道";
    titleLab.font = [UIFont systemFontOfSize:RemindFont(18, 19, 20)];
    titleLab.textAlignment = NSTextAlignmentCenter;
    [littleView addSubview:titleLab];
    [titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(littleView);
        make.centerY.mas_equalTo(littleView);
        make.width.mas_equalTo(120*AdaptiveScale_W);
        make.height.mas_equalTo(44);
    }];
    
    UIButton *closeBtn = [[UIButton alloc]init];
    [closeBtn setTitle:@"关闭" forState:0];
    [closeBtn setTitleColor:[UIColor whiteColor] forState:0];
    closeBtn.titleLabel.font = [UIFont systemFontOfSize:RemindFont(16, 17, 18)];
    closeBtn.titleLabel.textAlignment = NSTextAlignmentRight;
    [closeBtn addTarget:self action:@selector(closeAction:) forControlEvents:UIControlEventTouchUpInside];
    [littleView addSubview:closeBtn];
    [closeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(littleView.mas_right).offset(-15*AdaptiveScale_W);
        make.centerY.mas_equalTo(littleView);
        make.width.mas_equalTo(60*AdaptiveScale_W);
        make.height.mas_equalTo(44);
    }];
    
}

- (void)setupUI{
    
    self.tableView.backgroundColor = [UIColor whiteColor];
    self.tableView.separatorColor = [UIColor grayColor];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.showsVerticalScrollIndicator = NO;
    self.tableView.showsHorizontalScrollIndicator = NO;
    
    
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.top.mas_equalTo(64);
        make.bottom.mas_equalTo(0);
    }];
    
    /** 建议设置一下,不然当isShowBackCover属性为YES时,scrollView的内容会在导航栏上面 */
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    /**
     *  总体的频道管理器
     *  @param top              顶部频道数组
     *  @param bottom           底部频道数组
     *  @param initialIndex     当前选中的index
     *  @param style            当前的样式
     */
    self.manager = [XWHobbyItemManager updateWithTopArr:self.top BottomArr:self.bottom InitialIndex:arc4random()%20 newStyle:self.channelstyle];

    self.tableView.tableHeaderView = self.managerView;
    self.managerView.backgroundColor = [UIColor whiteColor];

    
}


- (void)closeAction:(id)sender{
    
    /**
     *  注意务必在频道管理器消失前调用此方法进行回调频道信息
     */
    [XWHobbyItemManager setUpdateIfNeeds];
    
    NSLog(@"%@---%@---%ld",self.manager.topChannelArr,self.manager.bottomChannelArr,(long)self.manager.initialIndex);
    NSMutableArray *managerArr = [NSMutableArray new];
    for (int i = 0; i<self.manager.topChannelArr.count; i++) {
        [managerArr addObject:self.manager.topChannelArr[i].channel_name];
        NSLog(@"%@",self.manager.topChannelArr[i].channel_name);
    }
    
    NSDictionary *dict = @{
                           @"topChannelArr":self.manager.topChannelArr,
                           @"bottomChannelArr":self.manager.bottomChannelArr
                           };
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"ChangeUserChannelsItem" object:nil userInfo:dict];
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
    self.topArray = [NSArray arrayWithArray:self.manager.topChannelArr];
    self.bottomArray = [NSArray arrayWithArray:self.manager.bottomChannelArr];
    
    NSLog(@"self.topArray---%@\nself.bottomArray--%@",self.topArray,self.bottomArray);
    
}

#pragma mark - lazy

- (XWHobbyChannelView *)managerView{
    if (!_managerView) {
        
        XWHobbyChannelView *channelView = [XWHobbyChannelView channelViewWithFrame:CGRectMake(0, 0, ScreenW, ScreenH) Manager:self.manager];
        _managerView = channelView;
        
        [channelView chooseChannelCallBack:^{
            [self dismissViewControllerAnimated:YES completion:nil];
        }];
        
    }
    return _managerView;
}


-(NSMutableArray *)top{
    if (!_top) {
        //virtual data
        NSMutableArray *top = [NSMutableArray new];
        for (int i = 0; i < STUserDefaults.mainfuncs.count; i++) {
            XWHobbyItemModel *model = [[XWHobbyItemModel alloc] init];
            model.channel_name = STUserDefaults.mainfuncs[i];
            model.isTop = YES;
            if (i < 2) {
                model.isEnable = YES;
            }else{
                model.isEnable = NO;
            }
            if (i == 0 || i == 1) {
                model.isHot = YES;
            }else{
                model.isHot = NO;
            }
            [top addObject:model];
        }
        _top = top;
    }
    return _top;
}

-(NSMutableArray *)bottom{
    if (!_bottom) {
        NSMutableArray *bottom = [NSMutableArray new];
        //virtual data
        for (int i = 0; i < STUserDefaults.mainfuncs.count; i++) {
            XWHobbyItemModel *model = [[XWHobbyItemModel alloc] init];
            model.channel_name = STUserDefaults.mainfuncs[i];
            model.isTop = NO;
            
            [bottom addObject:model];
        }
        _bottom = bottom;
    }
    return _bottom;
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
    [super viewWillAppear:animated];

    navBarHairlineImageView.hidden = YES;
    [self preferredStatusBarStyle];
    self.tabBarController.tabBar.hidden = YES;

    
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
