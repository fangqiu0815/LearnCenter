//
//  PYCardViewController.m
//  Gank
//
//  Created by 谢培艺 on 2017/2/27.
//  Copyright © 2017年 CoderKo1o. All rights reserved.
//
#import "PYCardViewController.h"
#import "CardLayout.h"
#import "CardSelectedLayout.h"
#import "CardCellCollectionViewCell.h"
#import <MJRefresh/MJRefresh.h>
#import "PYRefreshHeader.h"
#import <AFNetworking/AFHTTPSessionManager.h>
#import "PYResource.h"
#import <MJExtension/MJExtension.h>
#import "CardCellCollectionViewCell.h"
#import "UIView+PYExtension.h"
#import "PYRefreshHeader.h"
#import "PYImage.h"
#import "PYHUD.h"
#import <AFNetworkReachabilityManager.h>

#define RGBAColor(r,g,b,a)  [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:a]
#define RGBColor(r,g,b)     RGBAColor(r,g,b,1.0)
#define RGBColorC(c)        RGBColor((((int)c) >> 16),((((int)c) >> 8) & 0xff),(((int)c) & 0xff))


static CGFloat collectionHeight;

@interface PYCardViewController ()<UICollectionViewDelegate,UICollectionViewDataSource, UIGestureRecognizerDelegate>

@property(nonatomic, strong)UICollectionView* cardCollectionView;
@property(nonatomic, strong)UICollectionViewLayout* cardLayout;
@property(nonatomic, strong)UICollectionViewLayout* cardLayoutStyle1;
@property(nonatomic, strong)UICollectionViewLayout* cardLayoutStyle2;
@property(nonatomic, strong)UITapGestureRecognizer* tapGesCollectionView;
@property (nonatomic, weak) CardCellCollectionViewCell *selectedCell;

/** 数组资源数组 */
@property (nonatomic, strong) NSMutableArray<NSArray *> *rescouceGroups;
/** 原数组的所有资源 */
@property (nonatomic, strong) NSMutableArray<PYResource *> *resources;
/** 当前页数 */
@property (nonatomic, assign) NSInteger currentPage;
/** 每次加载个数 */
@property (nonatomic, assign) NSInteger earchCount;

/** 网络加载失败提示 */
@property (nonatomic, strong) PYHUD *loadFailView;
/** 网络加载提示 */
@property (nonatomic, strong) PYHUD *loadingView;
/** 记录当前网络状态 */
@property (nonatomic, assign) AFNetworkReachabilityStatus currentNetworkStatus;

@end

@implementation PYCardViewController

- (NSMutableArray<NSArray *> *)rescouceGroups
{
    if (!_rescouceGroups) {
        _rescouceGroups = [NSMutableArray array];
        // 加载数据
        [self loadData:YES];
    }
    return _rescouceGroups;
}

- (PYHUD *)loadFailView
{
    if (!_loadFailView) {
        PYHUD *loadFailView = [[PYHUD alloc]initWithFrame:CGRectMake(15, 5, self.view.bounds.size.width - 10, self.view.bounds.size.height)];
        loadFailView.indicatorBackGroundColor = [UIColor clearColor];
        loadFailView.indicatorForegroundColor = self.typeColor;
        loadFailView.messageLabel.text = @"网络迷路了...\n快点我刷新下";
        loadFailView.backgroundColor = [UIColor whiteColor];
        loadFailView.customImage = [UIImage imageNamed:@"networkError"];
        __weak typeof(self) weakSelf = self;
    
        [loadFailView refreshWhenNwrworkError:^(PYHUD *hud) {
            [weakSelf loadData:self.resources.count == 0];
        }];
        _loadFailView = loadFailView;
    }
    return _loadFailView;
}

- (PYHUD *)loadingView
{
    if (!_loadingView) {
        PYHUD *loadingView = [[PYHUD alloc]initWithFrame:CGRectMake(15, 5, self.view.bounds.size.width - 10, self.view.bounds.size.height)];
        loadingView.indicatorBackGroundColor = [UIColor clearColor];
        loadingView.indicatorForegroundColor = self.typeColor;
        loadingView.messageLabel.text = nil;
        loadingView.backgroundColor = [UIColor whiteColor];
        _loadingView = loadingView;
    }
    return _loadingView;
}

- (NSInteger)earchCount
{
    if (_earchCount == 0) {
        if ([self.resourceType isEqualToString:@"iOS"]) { // 加载25条数据
            _earchCount = 25;
        } else if ([self.resourceType isEqualToString:@"Android"]) { // 加载40条
            _earchCount = 40;
        } else { // 加载15条
            _earchCount = 15;
        }
    }
    return _earchCount;
}

/** 加载数据 */
- (void)loadData:(BOOL)refresh
{
    [self.loadingView showAtView:self.view hudType:JHUDLoadingTypeDot];
    self.currentPage = refresh ? 1 : self.currentPage + 1;
    // 请求数据
    AFHTTPSessionManager *HTTPManager = [AFHTTPSessionManager manager];
    NSString *urlStr = [NSString stringWithFormat:@"http://gank.io/api/data/%@/%zd/%zd", self.resourceType, self.earchCount, self.currentPage];
    NSString *encodedString = [urlStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    // 显示加载
    if (self.resources.count == 0) {
        self.resources = [NSMutableArray array];
    }
    [self.loadFailView hide];
    [HTTPManager GET:encodedString parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) { // 请求成功
        // 取出数组
        NSArray *results = responseObject[@"results"];
        if (results.count == 0) return;
        // 转化成模型
        NSArray *resources = [PYResource mj_objectArrayWithKeyValuesArray:results];
        [self.resources addObjectsFromArray:resources];
        NSInteger originalDays = self.rescouceGroups.count;
        self.rescouceGroups = [NSMutableArray arrayWithArray:[self resourceByDay:self.resources]];
        
        // 根据原图获取其他信息
        AFHTTPSessionManager *mgr = [AFHTTPSessionManager manager];
        __block NSInteger imageCount = 0;
        for (PYResource *resource in self.resources) {
            if (resource.images.count == 0) continue;
            imageCount++;
            NSMutableArray *tempM = [NSMutableArray array];
            for (NSString *imageUrl in resource.images) {
                PYImage *imageModel = [[PYImage alloc] init];
                [mgr GET:[NSString stringWithFormat:@"%@?imageInfo", imageUrl] parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                    imageCount--;
                    // 缩略图地址
                    imageModel.thumbUrl = [NSString stringWithFormat:@"%@?imageView2/0/w/400/format/png", imageUrl];
                    // 获取其他图片信息
                    imageModel.width = [responseObject[@"width"] floatValue];
                    imageModel.height = [responseObject[@"height"] floatValue];
                    imageModel.url = [NSString stringWithFormat:@"%@?imageView2/0/w/%d", imageUrl, (int)(PYScreenW * [[UIScreen mainScreen] scale] * 1.5)];
                    [tempM addObject:imageModel];
                    resource.imageModels = [tempM copy];
                    if (imageCount == 0) { // 所有图片加载完成
                        if (_rescouceGroups.count > 0) {
                            [self.loadingView hide];
                            [self.loadFailView hide];
                            [self.cardCollectionView reloadData];
                            CGFloat offsetY = refresh ? _rescouceGroups.count * 140 : ((_rescouceGroups.count - originalDays)) * 140;
                            [self.cardCollectionView setContentOffset:CGPointMake(0, offsetY)];
                        }
                    }
                } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                }];
            }
        }
        if (_rescouceGroups.count > 0 && imageCount == 0) { // 没有图片
            [self.loadFailView hide];
            [self.loadingView hide];
            [self.cardCollectionView reloadData];
            CGFloat offsetY = refresh ? _rescouceGroups.count * 140 : ((_rescouceGroups.count - originalDays)) * 140;
            [self.cardCollectionView setContentOffset:CGPointMake(0, offsetY)];
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        self.currentPage --;
        [self.loadingView hide];
        [self.loadFailView showAtView:self.view hudType:JHUDLoadingTypeCustomAnimations];
    }];
}

- (NSArray *)resourceByDay:(NSArray *)resourceArray
{
    //首先把原数组中数据的日期取出来放入timeArr
    NSMutableArray *timeArr = [NSMutableArray array];
    for (PYResource *resource in resourceArray) {
        [timeArr addObject:[resource.publishedAt substringToIndex:@"yyyy-MM-dd".length]];
    }
    //使用asset把timeArr的日期去重
    NSSet *set = [NSSet setWithArray:timeArr];
    NSArray *userArray = [set allObjects];
    NSSortDescriptor *sd1 = [NSSortDescriptor sortDescriptorWithKey:nil ascending:NO]; // yes升序排列，no,降序排列
    //按日期降序排列的日期数组
    NSArray *myary = [userArray sortedArrayUsingDescriptors:[NSArray arrayWithObjects:sd1, nil]];
    //此时得到的myary就是按照时间降序排列拍好的数组
    NSMutableArray *resultArray = [NSMutableArray array];
    int currentIndex = 0;
    for (int i = 0; i < myary.count; i++) {
        // 取出日期
        NSString *dateStr = myary[i];
        // 临时数组
        NSMutableArray *tempArr = [NSMutableArray array];
        for (int j = currentIndex; j < resourceArray.count; j++) {
            // 取出日期
            PYResource *resource = resourceArray[j];
            NSString *originalDateStr = resource.publishedAt;
            if ([originalDateStr containsString:dateStr]) { // 同一天
                [tempArr addObject:resource];
            } else { // 进到下一天
                currentIndex = j;
                break; // 跳出循环
            }
        }
        // 保存数组
        [resultArray addObject:[tempArr copy]];
    }
    // 遍历后的数组
    return resultArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    collectionHeight = self.view.bounds.size.height;
    self.cardLayoutStyle1 =  [[CardLayout alloc] initWithOffsetY:collectionHeight * 15];
    self.cardLayout = self.cardLayoutStyle1;
    [self.view addSubview:self.cardCollectionView];
    self.cardCollectionView.contentInset = UIEdgeInsetsMake(-350, 0, 0, 0);
}

#pragma mark - UICollectionViewDataSource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.rescouceGroups.count;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CardCellCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cardCell" forIndexPath:indexPath];
    cell.resouces = self.rescouceGroups[self.rescouceGroups.count - 1 - indexPath.row];
    // 设置背景色
    cell.bgColor = [self getGameColor:self.rescouceGroups.count - 1 - indexPath.row];
    return cell;
}

-(UIColor*)getGameColor:(NSInteger)index
{
    NSArray* colorList = @[RGBColorC(0xfb742a),RGBColorC(0xfcc42d),RGBColorC(0x29c26d),RGBColorC(0xfaa20a),RGBColorC(0x5e64d9),RGBColorC(0x6d7482),RGBColorC(0x54b1ff),RGBColorC(0xe2c179),RGBColorC(0x9973e5),RGBColorC(0x61d4ff)];
    UIColor* color = [colorList objectAtIndex:(index%10)];
    return color;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    CardCellCollectionViewCell *selectedCell = (CardCellCollectionViewCell *)[collectionView cellForItemAtIndexPath:indexPath];
    self.selectedCell = selectedCell;
    
    selectedCell.tableView.userInteractionEnabled = YES;
    CGFloat offsetY = self.cardCollectionView.contentOffset.y;
    if ([self.cardLayout isKindOfClass:[CardLayout class]]) {
        if (!self.cardLayoutStyle2) {
            self.cardLayoutStyle2 =  [[CardSelectedLayout alloc]initWithIndexPath:indexPath offsetY:offsetY ContentSizeHeight:((CardLayout*)self.cardLayout).contentSizeHeight];
            self.cardLayout = self.cardLayoutStyle2;
        }
        else
        {
            ((CardSelectedLayout*)self.cardLayoutStyle2).contentOffsetY = offsetY;
            ((CardSelectedLayout*)self.cardLayoutStyle2).contentSizeHeight = ((CardLayout*)self.cardLayout).contentSizeHeight;
            ((CardSelectedLayout*)self.cardLayoutStyle2).selectedIndexPath = indexPath;
            self.cardLayout = self.cardLayoutStyle2;
        }
        self.cardCollectionView.scrollEnabled = NO;
        [self showMaskView]; //显示背景浮层
    }
    else
    {
        if (!self.cardLayoutStyle1) {
            self.cardLayoutStyle1 =  [[CardLayout alloc]initWithOffsetY:offsetY];
            self.cardLayout = self.cardLayoutStyle1;
        }
        else
        {
            ((CardLayout*)self.cardLayoutStyle1).offsetY = offsetY;
            self.cardLayout = self.cardLayoutStyle1;
        }
        self.cardCollectionView.scrollEnabled = YES;
        [self hideMaskView];
    }
    [self.cardCollectionView setCollectionViewLayout:self.cardLayout animated:YES];
}

-(void)showMaskView
{
    self.cardCollectionView.backgroundColor = [UIColor whiteColor];
    [self.cardCollectionView addGestureRecognizer:self.tapGesCollectionView];
}

-(void)hideMaskView
{
    self.cardCollectionView.backgroundColor = [UIColor whiteColor];
    [self.cardCollectionView removeGestureRecognizer:self.tapGesCollectionView];
}

-(void)tapOnBackGround
{
    self.selectedCell.tableView.userInteractionEnabled = NO;
    self.selectedCell.tableView.contentOffset = CGPointZero;
    CGFloat offsetY = self.cardCollectionView.contentOffset.y;
    
    if ([self.cardLayout isKindOfClass:[CardLayout class]]) {
        
    } else {
        if (!self.cardLayoutStyle1) {
            self.cardLayoutStyle1 =  [[CardLayout alloc]initWithOffsetY:offsetY];
            self.cardLayout = self.cardLayoutStyle1;
        } else {
            ((CardLayout*)self.cardLayoutStyle1).offsetY = offsetY;
            self.cardLayout = self.cardLayoutStyle1;
        }
        self.cardCollectionView.scrollEnabled = YES;
        [self.cardCollectionView removeGestureRecognizer:self.tapGesCollectionView];
    }
    [self.cardCollectionView setCollectionViewLayout:self.cardLayout animated:YES];
}

-(UITapGestureRecognizer*)tapGesCollectionView
{
    if (!_tapGesCollectionView) {
        _tapGesCollectionView = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapOnBackGround)];
        _tapGesCollectionView.delegate = self;
    }
    return _tapGesCollectionView;
}

-(UICollectionView*)cardCollectionView
{
    if (!_cardCollectionView) {
        _cardCollectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(5, 0 , self.view.bounds.size.width - 10, self.view.bounds.size.height) collectionViewLayout:self.cardLayout];
        _cardCollectionView.autoresizingMask = UIViewAutoresizingFlexibleHeight;
        _cardCollectionView.layer.cornerRadius = 5;
        [_cardCollectionView registerClass:[CardCellCollectionViewCell class] forCellWithReuseIdentifier:@"cardCell"];
        _cardCollectionView.delegate = self;
        _cardCollectionView.dataSource = self;
        _cardCollectionView.backgroundColor = [UIColor whiteColor];
        _cardCollectionView.showsVerticalScrollIndicator = NO;
        _cardCollectionView.showsHorizontalScrollIndicator = NO;
    }
    return _cardCollectionView;
}

- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset
{
    if ((*targetContentOffset).y == -scrollView.contentInset.top && scrollView.contentOffset.y + 50 < (*targetContentOffset).y) { // 进入刷新状态
        [self loadData:self.resources.count == 0];
    }
}

#pragma mark - UIGestureRecognizerDelegate
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch{
    // 若为UITableViewCellContentView（即点击了tableViewCell），则不截获Touch事件
    if ([NSStringFromClass([touch.view class]) isEqualToString:@"UITableViewCellContentView"]) {
        return NO;
    }
    return YES;
}

@end
