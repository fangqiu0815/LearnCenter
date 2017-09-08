//
//  XWRecommendVideoVC.m
//  zhangshangPacket
//
//  Created by apple on 2017/8/3.
//  Copyright © 2017年 apple-fangqiu. All rights reserved.
//

#import "XWRecommendVideoVC.h"
#import "XWVideoModel.h"
#import "AFNetWorkTool.h"
#import "MJExtension.h"
#import "XWVideoCell.h"
#import "MJRefresh.h"
#import "ZFPlayer.h"
#import "SVProgressHUD.h"

@interface XWRecommendVideoVC ()<ZFPlayerDelegate>

@property (nonatomic,strong)NSUserDefaults *userinfo;
@property (nonatomic,strong)NSMutableArray *videoArr;
@property (nonatomic,strong) ZFPlayerView *playerView;
@property (nonatomic,strong) ZFPlayerControlView *controlView;
/**最后一条时间戳*/
@property (nonatomic,strong)NSString *lastTimestamp;
@end

@implementation XWRecommendVideoVC
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



- (void)viewDidLoad {
    [super viewDidLoad];

//    self.navigationController.navigationBar.dk_barTintColorPicker=DKColorPickerWithColors(navBarColor,CELLBG,RedColor);
//    self.tableView.dk_backgroundColorPicker=DKColorPickerWithColors(lineColor,CELLBG,RedColor);
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
    
    [AFNetWorkTool getBaoZouVideoTimestamp:_lastTimestamp moreData:^(id responseObject) {
        JLLog(@"responsObject---%@",responseObject);
        self.lastTimestamp=responseObject[@"timestamp"];
        NSArray *datas=responseObject[@"data"];
        NSArray *moreArr=[XWVideoModel mj_objectArrayWithKeyValuesArray:datas];
        
        [self.videoArr addObjectsFromArray:moreArr];
        [self.tableView reloadData];
        
        [self.tableView.mj_footer endRefreshing];
        //刷新栏显示的刷新条数
        
        [self.tableView.mj_header endRefreshingWithCompletionBlock:^{
            [self showNewStatusesCount:datas.count];
        }];
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        [self.tableView.mj_footer endRefreshing];
    }];
    
    
}
-(void)loadVideoData{
    
    UIButton *refreshBtn=nil;
    if(self.pulldownRefreh){
        refreshBtn=self.pulldownRefreh();
    }
    
    
    [AFNetWorkTool getBaoZouVideoData:^(id responseObject) {

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
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    __block XWVideoModel *model = self.videoArr[indexPath.row];
    //------------
    cell.getVideoID = ^id{
        return model;
    };
    cell.model = model;
    
    __block NSIndexPath *weakIndexPath = indexPath;
    __block XWVideoCell *weakCell = cell;
    WeakType(self);
    
    //点击开始播放视频
    cell.readlyPlayVideo=^(UIButton *btn){
        JLLog(@"点击了播放视频");
        
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


//-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
//    historyY = scrollView.contentOffset.y;
//}

//-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
//    //向上
//    if (scrollView.contentOffset.y<historyY) {
//        if(scrollView.contentOffset.y<0&&self.topViewTransform){
//            self.topViewTransform(scrollView.contentOffset.y);
//        }
//    }else{
//        self.topViewTransform(0);
//    }
//}



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
