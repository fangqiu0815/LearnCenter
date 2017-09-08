//
//  XWVideoVC.m
//  zhangshangPacket
//
//  Created by apple on 2017/8/1.
//  Copyright © 2017年 apple-fangqiu. All rights reserved.
//

#import "XWVideoVC.h"
#import "XWNewVideoVC.h"
#import "XWHotVideoVC.h"
#import "XWRecommendVideoVC.h"
#import "XWVideoModel.h"
#import "AFNetWorkTool.h"
#import "MJExtension.h"
#import "XWVideoCell.h"
#import "MJRefresh.h"
#import "ZFPlayer.h"
#import "SVProgressHUD.h"
#import <UMSocialCore/UMSocialCore.h>
#import "XWSearchVC.h"
#import "XWVideoCell.h"


@interface XWVideoVC ()<ZFPlayerDelegate,XWVideoPublishViewDelegate>
{
    NSString *shareUrl;
    NSString *titleStr;
    NSString *iconStr;

}
@property (nonatomic, strong) NSArray *titleData;
@property (nonatomic,strong)NSUserDefaults *userinfo;
@property (nonatomic,strong)NSMutableArray *videoArr;
@property (nonatomic,strong) ZFPlayerView *playerView;
@property (nonatomic,strong) ZFPlayerControlView *controlView;
/**最后一条时间戳*/
@property (nonatomic,strong) NSString *lastTimestamp;

@property (nonatomic, weak) XWVideoCell *cell;

@end

@implementation XWVideoVC

//设置字体颜色
- (UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;//白色
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
    [super viewWillAppear:animated];
    [self preferredStatusBarStyle];
    [self setStatusBarBackgroundColor:MainRedColor];
    self.navigationController.navigationBar.translucent = NO;
    self.navigationController.navigationBar.dk_barTintColorPicker = DKColorPickerWithColors(MainRedColor,NightMainNaviColor,MainRedColor);

    
    // 设置导航栏标题变大
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(ScreenW/2, self.view.yj_centerX, 80, 40)];
    label.textColor = WhiteColor;
    label.text = @"精选视频";
    label.font = [UIFont systemFontOfSize:18];
    self.navigationItem.titleView = label;
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamedWithRenderOriginal:@"icon_mov_magnifier"] style:UIBarButtonItemStylePlain target:self action:@selector(SearchClick:)];
    
    
    self.hidesBottomBarWhenPushed = NO;
    
}

static NSString *videoID = @"XWVideoCell";

-(NSUserDefaults *)userinfo{
    if(!_userinfo){
        _userinfo=[NSUserDefaults standardUserDefaults];
    }
    return _userinfo;
}
-(NSMutableArray *)videoArr{
    if(!_videoArr){
        _videoArr=[NSMutableArray array];
    }
    return _videoArr;
}

- (void)SearchClick:(id)sender
{
    XWSearchVC *searchVc = [[XWSearchVC alloc]init];
    [self.navigationController pushViewController:searchVc animated:YES];

}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.dk_backgroundColorPicker = DKColorPickerWithColors(MainBGColor,NightMainColor,MainRedColor);
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([XWVideoCell class]) bundle:nil] forCellReuseIdentifier:videoID];
    [self setupRefreshView];
    [self pullRefreshMoreData];
    self.tableView.rowHeight = 240;
    
}

#pragma mark - 下拉刷新数据
- (void)setupRefreshView{
    MJRefreshNormalHeader *mjheader = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadVideoData)];
    //    mjheader.stateLabel.dk_textColorPicker=DKColorPickerWithColors(MainCellColor,navBarColor,RedColor);
    //mjheader.lastUpdatedTimeLabel.hidden=YES;
    self.tableView.mj_header = mjheader;
    [self.tableView.mj_header beginRefreshing];
}
#pragma mark - 上拉加载更多
-(void)pullRefreshMoreData{
    MJRefreshAutoNormalFooter *footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreVideoData:)];
    [footer setTitle:@"加载更多" forState:MJRefreshStateRefreshing];
    self.tableView.mj_footer=footer;
}
-(void)loadMoreVideoData:(MJRefreshAutoNormalFooter *)footer{
    if(self.videoArr.count==0){
        [self.tableView.mj_footer endRefreshing];
        [footer setTitle:@"没有网络了哦" forState:MJRefreshStateIdle];
        [self.tableView.mj_header endRefreshing];
        return;
    }
    
    [SVProgressHUD showWithStatus:@"正在加载" maskType:SVProgressHUDMaskTypeBlack];
    
    [AFNetWorkTool getBaoZouVideoTimestamp:_lastTimestamp moreData:^(id responseObject) {
        JLLog(@"responsObject---%@",responseObject);
        self.lastTimestamp=responseObject[@"timestamp"];
        NSArray *datas=responseObject[@"data"];
        NSArray *moreArr=[XWVideoModel mj_objectArrayWithKeyValuesArray:datas];
        [SVProgressHUD dismiss];
        [self.videoArr addObjectsFromArray:moreArr];
        [self.tableView reloadData];
        
        [self.tableView.mj_footer endRefreshing];
        //刷新栏显示的刷新条数
        
        [self.tableView.mj_header endRefreshingWithCompletionBlock:^{
            [self showNewStatusesCount:datas.count];
        }];
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        [SVProgressHUD dismiss];
        [self.tableView.mj_footer endRefreshing];
    }];
    
}

-(void)loadVideoData{
    
    UIButton *refreshBtn=nil;
    if(self.pulldownRefreh){
        refreshBtn=self.pulldownRefreh();
    }
    [SVProgressHUD showWithStatus:@"正在加载" maskType:SVProgressHUDMaskTypeBlack];

    [AFNetWorkTool getBaoZouVideoData:^(id responseObject) {
        [SVProgressHUD dismiss];
        JLLog(@"responsObject---%@",responseObject);
        
        NSArray *datas=responseObject[@"data"];
        self.videoArr = [XWVideoModel mj_objectArrayWithKeyValuesArray:datas];
        self.lastTimestamp=responseObject[@"timestamp"];
        [self.tableView reloadData];
        [self.tableView.mj_header endRefreshing];
        //刷新栏显示的刷新条数
        [self.tableView.mj_header endRefreshingWithCompletionBlock:^{
            [self showNewStatusesCount:datas.count];
        }];
        //结束刷新按钮动画
        [self endRefreshBtn:refreshBtn];
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        [self.tableView.mj_header endRefreshing];
        //结束刷新按钮动画
        [self endRefreshBtn:refreshBtn];
        [SVProgressHUD showErrorWithStatus:@"请求超时"];
    }];
    
}

/**
 *  提示用户最新的资讯数量
 *
 *  @param count 最新资讯数量
 */
- (void)showNewStatusesCount:(NSInteger )count
{
    UILabel *label = [[UILabel alloc] init];
    if (count) {
        label.text = [NSString stringWithFormat:@"口袋头条为您推荐%ld条更新", count];
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

-(void)endRefreshBtn:(UIButton *)refreshBtn{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        //移除核心动画
        [refreshBtn.layer removeAllAnimations];
        refreshBtn.selected=NO;
    });
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.videoArr.count;
}

-(void)beginRefresh{
    [self.tableView.mj_header beginRefreshing];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    XWVideoCell *cell = [tableView dequeueReusableCellWithIdentifier:videoID];
    if (!cell) {
        cell = [[XWVideoCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:videoID];
    }
    cell.videoContent.hidden = NO;
    cell.playTime.hidden = NO;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    __block XWVideoModel *model = self.videoArr[indexPath.row];
    shareUrl = model.file_url;
    titleStr = model.title;
    iconStr = model.image;
    
    //------------
    cell.getVideoID = ^id{
        return model;
    };
    cell.model = model;
    [cell.shareClick addTarget:self action:@selector(shareVideoClick:) forControlEvents:UIControlEventTouchUpInside];
    __block NSIndexPath *weakIndexPath = indexPath;
    __block XWVideoCell *weakCell = cell;
    WeakType(self);
    
    //点击开始播放视频
    cell.readlyPlayVideo=^(UIButton *btn){
        JLLog(@"点击了播放视频");
        
        weakCell.videoContent.hidden = YES;
        weakCell.playTime.hidden = YES;
        // 分辨率字典（key:分辨率名称，value：分辨率url)
        //NSMutableDictionary *dic = [NSMutableDictionary dictionary];
        ZFPlayerModel *playerModel = [[ZFPlayerModel alloc] init];
        playerModel.title            = model.title;
        playerModel.videoURL         = [NSURL URLWithString:model.file_url];
        playerModel.placeholderImageURLString = model.image;
        playerModel.scrollView        = weakself.tableView;
        playerModel.indexPath        = weakIndexPath;
        // 赋值分辨率字典
        //playerModel.resolutionDic    = dic;
        // (需要设置imageView的tag值，此处设置的为101)
        playerModel.fatherViewTag = weakCell.videoImage.tag;
        // 设置播放控制层和model
        [weakself.playerView playerControlView:weakself.controlView playerModel:playerModel];
        [weakself.playerView addPlayerToFatherView:weakCell.videoImage];
        // 下载功能
        //weakSelf.playerView.hasDownload = YES;
        // 自动播放
        [weakself.playerView autoPlayTheVideo];
        
    };
    
    return cell;
}
- (ZFPlayerView *)playerView
{
    if (!_playerView) {
        _playerView = [ZFPlayerView sharedPlayerView];
        // 当cell划出屏幕的时候停止播放
        _playerView.stopPlayWhileCellNotVisable = YES;
        //（可选设置）可以设置视频的填充模式，默认为（等比例填充，直到一个维度到达区域边界）
        // _playerView.playerLayerGravity = ZFPlayerLayerGravityResizeAspect;
        _playerView.delegate = self;
        // 静音
        //_playerView.mute = YES;
    }
    return _playerView;
}

- (ZFPlayerControlView *)controlView
{
    if (!_controlView) {
        _controlView = [[ZFPlayerControlView alloc] init];
    }
    return _controlView;
}

// 页面消失时候重置player
- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.playerView resetPlayer];
    
}

- (void)shareVideoClick:(id)sender
{
    if (STUserDefaults.ischeck == 1) {
        
    } else {
        XWVideoPublishView *publishView = [[XWVideoPublishView alloc]initWithFrame:[UIScreen mainScreen].bounds];
        publishView.delegate = self;
        [publishView  show];
    }
    
}

#pragma mark ==================== 分享视频 ====================
-(void)didSelectBtnWithBtnTag:(NSInteger)tag
{
    
    //创建分享消息对象
    UMSocialMessageObject *messageObject = [UMSocialMessageObject messageObject];
    
    UMShareWebpageObject *shareObject = [UMShareWebpageObject shareObjectWithTitle:titleStr descr:titleStr thumImage:[UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:iconStr]]]];
    //设置网页地址
    shareObject.webpageUrl = shareUrl;
    
    //分享消息对象设置分享内容对象
    messageObject.shareObject = shareObject;
    
    if (tag == 1) {
        
        if (![STUserDefaults.phonenum isEqualToString:@""]){
            
            //调用分享接口
            [[UMSocialManager defaultManager] shareToPlatform:UMSocialPlatformType_WechatTimeLine messageObject:messageObject currentViewController:self completion:^(id data, NSError *error) {
                if (error) {
                    UMSocialLogInfo(@"************Share fail with error %@*********",error);
                    [SVProgressHUD showErrorWithStatus:@"分享失败"];
                }else{
                    if ([data isKindOfClass:[UMSocialShareResponse class]]) {
                        UMSocialShareResponse *resp = data;
                        //分享结果消息
                        UMSocialLogInfo(@"response message is %@",resp.message);
                        //第三方原始返回的数据
                        UMSocialLogInfo(@"response originalResponse data is %@",resp.originalResponse);
                        //分享普通新闻
                        [SVProgressHUD showSuccessWithStatus:@"分享成功"];
                        
                    }else{
                        UMSocialLogInfo(@"response data is %@",data);
                    }
                }
            }];
            
        }else{
            [self wechatLogin];
        }
    }else if (tag == 2){
        if (![STUserDefaults.phonenum isEqualToString:@""]){
            
            //调用分享接口
            [[UMSocialManager defaultManager] shareToPlatform:UMSocialPlatformType_WechatSession messageObject:messageObject currentViewController:self completion:^(id data, NSError *error) {
                if (error) {
                    UMSocialLogInfo(@"************Share fail with error %@*********",error);
                    [SVProgressHUD showErrorWithStatus:@"分享失败"];
                }else{
                    if ([data isKindOfClass:[UMSocialShareResponse class]]) {
                        UMSocialShareResponse *resp = data;
                        //分享结果消息
                        UMSocialLogInfo(@"response message is %@",resp.message);
                        //第三方原始返回的数据
                        UMSocialLogInfo(@"response originalResponse data is %@",resp.originalResponse);
                        //分享普通新闻
                        [SVProgressHUD showSuccessWithStatus:@"分享成功"];
                        
                    }else{
                        UMSocialLogInfo(@"response data is %@",data);
                    }
                }
            }];
            
        }else{
            [self wechatLogin];
        }

    }
}

- (void)wechatLogin
{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"是否前往微信登录?" preferredStyle:UIAlertControllerStyleAlert];
    [alert addAction:[UIAlertAction actionWithTitle:@"是" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [[NSNotificationCenter defaultCenter] postNotificationName:@"login" object:nil];
        XWLoginVC *loginVC = [[XWLoginVC alloc]init];
        [self presentViewController:loginVC animated:YES completion:nil];
        
    }]];
    
    [alert addAction:[UIAlertAction actionWithTitle:@"否" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
    }]];
    
    [self presentViewController:alert animated:YES completion:nil];
    
}





//
//#pragma mark 标题数组
//- (NSArray *)titleData {
//    if (!_titleData) {
//        _titleData = @[
//                       @"推荐",@"最新",@"最热"
//                       ];
//    }
//    return _titleData;
//    
//}
//
//#pragma mark 初始化代码
//- (instancetype)init {
//    if (self = [super init]) {
//        
//        self.menuBGColor = MainRedColor;
//        self.titleSizeNormal = 15;
//        self.titleSizeSelected = 16;
//        self.titleColorNormal = MainBGColor;
//        self.titleColorSelected = WhiteColor;
//        self.showOnNavigationBar = YES;
//        self.progressViewIsNaughty = YES;
//        self.menuViewStyle = WMMenuViewStyleLine;
//        self.menuHeight = 44;
//        
//        if (self.titleData.count > 5) {
//            self.menuItemWidth = 80;
//        } else if(self.titleData.count <= 3){
//            self.menuItemWidth = 60;
//        } else{
//            self.menuItemWidth = (ScreenW) / self.titleData.count;
//
//        }
//        
//    }
//    return self;
//}
//
//
//#pragma mark 返回子页面的个数
//- (NSInteger)numbersOfChildControllersInPageController:(WMPageController *)pageController {
//    return self.titleData.count;
//}
//
//#pragma mark 返回某个index对应的页面
//- (UIViewController *)pageController:(WMPageController *)pageController viewControllerAtIndex:(NSInteger)index {
//    
//    switch (index) {
//        case 0:{
//            //最新
//            XWRecommendVideoVC   *vcClass = [[XWRecommendVideoVC alloc] init];
//            // vcClass.title = @"推荐";
//            
//            return vcClass;
//        }
//            break;
//            
//        case 1:{
//            //最热
//            XWNewVideoVC   *vcClass = [[XWNewVideoVC alloc] init];
//            // vcClass.title = @"推荐";
//            
//            return vcClass;
//        }
//            break;
//            
//        case 2:{
//            //最热
//            XWHotVideoVC   *vcClass = [[XWHotVideoVC alloc] init];
//            // vcClass.title = @"推荐";
//            
//            return vcClass;
//        }
//            break;
//            
//        default:{
//            //其他
//            
//            XWHotVideoVC *vcClass = [[XWHotVideoVC alloc]init];
//            // vcClass.title = @"笑话";
//            return vcClass;
//            
//        }
//            break;
//    }
//    
//}
//
//#pragma mark 返回index对应的标题
//- (NSString *)pageController:(WMPageController *)pageController titleAtIndex:(NSInteger)index {
//    self.selectItemIndex = [self.titleData[index] integerValue ];
//    return self.titleData[index];
//}

- (void)dealloc
{
    JLLog(@"dealloc");
    
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
