//
//  XWSearchVC.m
//  zhangshangPacket
//
//  Created by apple on 2017/5/23.
//  Copyright © 2017年 apple-fangqiu. All rights reserved.
//

#import "XWSearchVC.h"
#import "XWSearchDetailVC.h"
#import "XWSearchModel.h"
#define TextColor CUSTOMCOLOR(113, 113, 113)
#import "XWSearchDetailListVC.h"


@interface XWSearchVC ()<UITableViewDelegate,UITableViewDataSource,UISearchBarDelegate>

{
    int _page;  //当前页
    int _totalpage;  // 总页数

}

@property (nonatomic, weak) UIView *headerView;

@property (nonatomic, weak) UIView *hotSearchView;

@property (nonatomic, weak) UIView *searchHistoryView;

@property (nonatomic, strong) NSMutableArray *searchHistories;

@property (nonatomic, assign) BOOL keyboardShowing;

@property (nonatomic, assign) CGFloat keyboardHeight;

@property (nonatomic, weak) UIView *hotSearchTagsContentView;

@property (nonatomic, weak) UIView *searchHistoryTagsContentView;

@property (nonatomic, strong) UITableView *baseSearchTableView;

@property (nonatomic, assign) UIDeviceOrientation currentOrientation;

@property (nonatomic, strong) NSMutableArray *infoArr;

@property (nonatomic, strong) NSMutableArray *titleArray;

@property (nonatomic, strong) NSMutableArray *urlArray;



@end

@implementation XWSearchVC

- (instancetype)init
{
    if (self = [super init]) {
        [self setup];
        _page = 1;
        [self getHotWordWithPage:_page];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(turnClick:) name:@"RefreshXWInfo" object:nil];
        
    }
    return self;
}

- (void)getHotWordWithPage:(int)page
{
    
    [SVProgressHUD showWithStatus:@"正在获取数据" maskType:SVProgressHUDMaskTypeBlack];
    
    [STRequest GetHotSearchWordWithPageNum:page withDataBlock:^(id ServersData, BOOL isSuccess) {
        XWSearchModel *model = [XWSearchModel mj_objectWithKeyValues:ServersData];
        if (isSuccess) {
            [SVProgressHUD dismiss];
            if (model.c == 1) {
                if (model.d.pagedata.count == 0) {
                    //                        [SVProgressHUD showErrorWithStatus:@"无更多数据"];
                } else {
                    for (SearchData *detailModel in model.d.pagedata) {
                        [self.infoArr addObject:detailModel];
                    }
                    
                    if (self.infoArr.count == 0) {
                        JLLog(@"无数据");
                        //                            [SVProgressHUD showErrorWithStatus:@"无更多数据"];
                    } else {
                        
                        for (int i = 0; i<self.infoArr.count; i++) {
                            
                            [self.titleArray addObject:self.infoArr[i][@"title"]];
                            [self.urlArray addObject:[NSString stringWithFormat:@"https://m.sogou.com/web/searchList.jsp?pid=sogou-wsse-51e6d6e679953c63&keyword=%@",self.titleArray[i]]];
                        }
                        
                        //                            https://m.sogou.com/web/searchList.jsp?pid=sogou-wsse-51e6d6e679953c63&keyword=好的
                        
                        self.hotSearches = self.titleArray;
                        self.hotSearchTags = self.urlArray;
                        
                        _page = model.d.pagenum ;
                        _totalpage = model.d.totalpage;
                        
                    }
                    
                }
                
            }else
            {
                [SVProgressHUD dismiss];
                [SVProgressHUD showErrorWithStatus:ServersData[@"m"]];
                
            }
            
        } else {
            [SVProgressHUD dismiss];
            [SVProgressHUD showErrorWithStatus:@"网络错误，请重试"];
        }
    }];
    
    
}

- (void)turnClick:(id)sender
{
    
    if (STUserDefaults.isLogin) {
        [_infoArr removeAllObjects];
        
        if (_page == _totalpage) {
            
            [SVProgressHUD showSuccessWithStatus:@"数据已完"];
            _page = 1;
            
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [self getHotWordWithPage:_page];
            });
            
        } else {
            
            [self.titleArray removeAllObjects];
            [self.urlArray removeAllObjects];
            _page++;
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [self getHotWordWithPage:_page];
            });
        }
        
    } else {
        
        [SVProgressHUD showErrorWithStatus:@"请先登录"];
        
    }

}

- (NSMutableArray *)infoArr
{
    if (!_infoArr) {
        _infoArr = [NSMutableArray array];
    }
    return _infoArr;
}

- (NSMutableArray *)titleArray
{
    if (!_titleArray) {
        _titleArray = [NSMutableArray array];
    }
    return _titleArray;
}

- (NSMutableArray *)urlArray
{
    if (!_urlArray) {
        _urlArray = [NSMutableArray array];
    }
    return _urlArray;
}

- (void)awakeFromNib
{
    [super awakeFromNib];
    
    [self setup];
}

- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    
    if (self.currentOrientation != [[UIDevice currentDevice] orientation]) {
        
        self.hotSearches = self.hotSearches;
        self.searchHistories = self.searchHistories;
        self.currentOrientation = [[UIDevice currentDevice] orientation];
    }
}

- (BOOL)prefersStatusBarHidden
{
    return NO;
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    //[self.searchBar becomeFirstResponder];
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

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self preferredStatusBarStyle];
    [self setStatusBarBackgroundColor:MainRedColor];
    self.navigationController.navigationBar.translucent = NO;
    self.navigationController.navigationBar.dk_barTintColorPicker = DKColorPickerWithColors(MainRedColor,NightMainNaviColor,MainRedColor);
    
    if (NO == self.navigationController.navigationBar.translucent) {
        self.baseSearchTableView.contentInset = UIEdgeInsetsMake(0, 0, self.view.yj_y, 0);
        if (!self.navigationController.navigationBar.barTintColor) {
            self.navigationController.navigationBar.dk_barTintColorPicker = DKColorPickerWithColors(MainRedColor,NightMainNaviColor,MainRedColor);
        }
    }
    
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    //[self.searchBar resignFirstResponder];
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark - Lazy
- (UITableView *)baseSearchTableView
{
    if (!_baseSearchTableView) {
        UITableView *baseSearchTableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
        baseSearchTableView.backgroundColor = [UIColor clearColor];
        baseSearchTableView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        if ([baseSearchTableView respondsToSelector:@selector(setCellLayoutMarginsFollowReadableWidth:)]) { // For the adapter iPad
            baseSearchTableView.cellLayoutMarginsFollowReadableWidth = NO;
        }
        baseSearchTableView.delegate = self;
        baseSearchTableView.dataSource = self;
        [self.view addSubview:baseSearchTableView];
        _baseSearchTableView = baseSearchTableView;
    }
    return _baseSearchTableView;
}

- (UIButton *)emptyButton
{
    if (!_emptyButton) {
        UIButton *emptyButton = [[UIButton alloc] init];
        emptyButton.titleLabel.font = self.searchHistoryHeader.font;
        [emptyButton setTitleColor:TextColor forState:UIControlStateNormal];
        [emptyButton setTitle:@"清空" forState:UIControlStateNormal];
        [emptyButton setImage:MyImage(@"empty") forState:UIControlStateNormal];
        [emptyButton addTarget:self action:@selector(emptySearchHistoryDidClick) forControlEvents:UIControlEventTouchUpInside];
        [emptyButton sizeToFit];
        emptyButton.yj_width += 10;
        emptyButton.yj_height += 10;
        emptyButton.yj_centerY = self.searchHistoryHeader.yj_centerY;
        emptyButton.yj_x = self.searchHistoryView.yj_width - emptyButton.yj_width;
        emptyButton.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin;
        [self.searchHistoryView addSubview:emptyButton];
        _emptyButton = emptyButton;

    }
    return _emptyButton;
}

- (UIView *)searchHistoryTagsContentView
{
    if (!_searchHistoryTagsContentView) {
        UIView *searchHistoryTagsContentView = [[UIView alloc] init];
        searchHistoryTagsContentView.yj_width = self.searchHistoryView.yj_width;
        searchHistoryTagsContentView.autoresizingMask = UIViewAutoresizingFlexibleWidth;
        searchHistoryTagsContentView.yj_y = ScreenH*0.5 ;
        [self.searchHistoryView addSubview:searchHistoryTagsContentView];
        _searchHistoryTagsContentView = searchHistoryTagsContentView;
    }
    return _searchHistoryTagsContentView;
}

- (UILabel *)searchHistoryHeader
{
    if (!_searchHistoryHeader) {
        UILabel *titleLabel = [self setupTitleLabel:@"搜索历史"];
        [self.searchHistoryView addSubview:titleLabel];
        _searchHistoryHeader = titleLabel;
    }
    return _searchHistoryHeader;
}

- (UILabel *)setupTitleLabel:(NSString *)title
{
    UILabel *titleLabel = [[UILabel alloc] init];
    titleLabel.text = title;
    titleLabel.font = [UIFont systemFontOfSize:RemindFont(15, 16, 17)];
    titleLabel.tag = 1;
    titleLabel.textColor = TextColor;
    [titleLabel sizeToFit];
    titleLabel.yj_x = 0;
    titleLabel.yj_y = 0;
    return titleLabel;
}

- (UIView *)searchHistoryView
{
    if (!_searchHistoryView) {
        UIView *searchHistoryView = [[UIView alloc] init];
        searchHistoryView.yj_x = self.hotSearchView.yj_x;
        searchHistoryView.yj_y = ScreenH*0.5;
        searchHistoryView.yj_width = self.headerView.yj_width - searchHistoryView.yj_x * 2;
        searchHistoryView.autoresizingMask = UIViewAutoresizingFlexibleWidth;
        [self.headerView addSubview:searchHistoryView];
        _searchHistoryView = searchHistoryView;
    }
    return _searchHistoryView;
}

- (NSMutableArray *)searchHistories
{
    if (!_searchHistories) {
        _searchHistories = [NSMutableArray arrayWithArray:[NSKeyedUnarchiver unarchiveObjectWithFile:self.searchHistoriesCachePath]];
        
    }
    return _searchHistories;
}

- (UIBarButtonItem *)selectButton
{
    return self.navigationItem.rightBarButtonItem;
}


- (void)setShowSearchHistory:(BOOL)showSearchHistory
{
    _showSearchHistory = showSearchHistory;
    
    [self setHotSearches:self.hotSearches];
}

- (void)setup
{
    self.view.dk_backgroundColorPicker = DKColorPickerWithColors(WhiteColor,NightMainBGColor,MainRedColor);
    self.baseSearchTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDidShowAll:) name:UIKeyboardDidShowNotification object:nil];

    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"搜索" style:UIBarButtonItemStyleDone target:self action:@selector(searchDidClick:)];
    self.navigationItem.rightBarButtonItem.tintColor = WhiteColor;
    self.searchHistoriesCachePath = XWSEARCH_SEARCH_HISTORY_CACHE_PATH;
    //搜索历史条数
    self.searchHistoriesCount = 20;
    self.showSearchHistory = YES;
    self.showHotSearch = YES;
    self.hotSearchStyle = XWHotSearchStyleDefault;
    self.searchHistoryStyle = XWSearchHistoryStyleNormalTag;
    self.searchResultShowMode = XWSearchResultShowModePush;
    //创建顶部搜索框和右侧按钮
    UIView *titleView = [[UIView alloc] init];
    titleView.yj_x = 10 * 0.5;
    titleView.yj_y = 7;
    titleView.yj_width = self.view.yj_width - 64 - titleView.yj_x * 2;
    titleView.yj_height = 30;
    UISearchBar *searchBar = [[UISearchBar alloc] initWithFrame:titleView.bounds];
    [titleView addSubview:searchBar];
    searchBar.barTintColor = MainRedColor;
    titleView.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    self.navigationItem.titleView = titleView;
    
    searchBar.translatesAutoresizingMaskIntoConstraints = NO;
    NSLayoutConstraint *widthCons = [NSLayoutConstraint constraintWithItem:searchBar attribute:NSLayoutAttributeWidth  relatedBy:NSLayoutRelationEqual toItem:titleView attribute:NSLayoutAttributeWidth multiplier:1.0 constant:0];
    NSLayoutConstraint *heightCons = [NSLayoutConstraint constraintWithItem:searchBar attribute:NSLayoutAttributeHeight  relatedBy:NSLayoutRelationEqual toItem:titleView attribute:NSLayoutAttributeHeight multiplier:1.0 constant:0];
    NSLayoutConstraint *xCons = [NSLayoutConstraint constraintWithItem:searchBar attribute:NSLayoutAttributeTop  relatedBy:NSLayoutRelationEqual toItem:titleView attribute:NSLayoutAttributeTop multiplier:1.0 constant:0];
    NSLayoutConstraint *yCons = [NSLayoutConstraint constraintWithItem:searchBar attribute:NSLayoutAttributeLeft  relatedBy:NSLayoutRelationEqual toItem:titleView attribute:NSLayoutAttributeLeft multiplier:1.0 constant:0];
    [titleView addConstraint:widthCons];
    [titleView addConstraint:heightCons];
    [titleView addConstraint:xCons];
    [titleView addConstraint:yCons];
    #pragma mark - 搜索框中 占位字符
    searchBar.placeholder = @"热门搜索";
    searchBar.backgroundImage = MyImage(@"clearImage");
    searchBar.delegate = self;
    self.searchBar = searchBar;
 
    //创建热门搜索 view
    UIView *headerView = [[UIView alloc] init];
    headerView.yj_width = ScreenW;
    UIView *hotSearchView = [[UIView alloc] init];
    hotSearchView.yj_x = 10 * 1.5;
    hotSearchView.yj_width = headerView.yj_width - hotSearchView.yj_x * 2;
    
    hotSearchView.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    #pragma  mark-----  热门搜索  ---- 字样
    UILabel *titleLabel = [self setupTitleLabel:@"热门搜索"];
    self.hotSearchHeader = titleLabel;
    [hotSearchView addSubview:titleLabel];
    #pragma mark---------- 换一批 --------------
    UIButton *turnButton = [[UIButton alloc] init];
    self.turnButton = turnButton;
    turnButton.titleLabel.font = self.hotSearchHeader.font;
    [turnButton setTitleColor:TextColor forState:0];
    [turnButton setTitle:@"换一批" forState:UIControlStateNormal];
    [turnButton addTarget:self action:@selector(turnClick:) forControlEvents:UIControlEventTouchUpInside];
    [turnButton setImage:MyImage(@"icon_search_update") forState:0];
    [turnButton sizeToFit];
    turnButton.titleLabel.textAlignment = NSTextAlignmentLeft;
    turnButton.yj_width = 100*AdaptiveScale_W;
    turnButton.yj_height = 40*AdaptiveScale_W;
    turnButton.yj_centerX = ScreenW*0.8;
    turnButton.yj_centerY = self.hotSearchHeader.yj_centerY;
    [hotSearchView addSubview:turnButton];
    
    UIView *hotSearchTagsContentView = [[UIView alloc] init];
    hotSearchTagsContentView.yj_width = hotSearchView.yj_width;
    hotSearchTagsContentView.yj_y = CGRectGetMaxY(titleLabel.frame) + 10;
    hotSearchTagsContentView.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    [hotSearchView addSubview:hotSearchTagsContentView];
    [headerView addSubview:hotSearchView];
    self.hotSearchTagsContentView = hotSearchTagsContentView;
    self.hotSearchView = hotSearchView;
    self.headerView = headerView;
    self.baseSearchTableView.tableHeaderView = headerView;
    
    UIView *footerView = [[UIView alloc] init];
    footerView.yj_width = ScreenW;
    UILabel *emptySearchHistoryLabel = [[UILabel alloc] init];
    emptySearchHistoryLabel.textColor = [UIColor darkGrayColor];
    emptySearchHistoryLabel.font = [UIFont systemFontOfSize:13];
    emptySearchHistoryLabel.userInteractionEnabled = YES;
#pragma mark ---- 清空历史记录 ----
    emptySearchHistoryLabel.text = @"清空";
    emptySearchHistoryLabel.textAlignment = NSTextAlignmentCenter;
    emptySearchHistoryLabel.yj_height = 49;
    [emptySearchHistoryLabel addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(emptySearchHistoryDidClick)]];
    emptySearchHistoryLabel.yj_width = footerView.yj_width;
    emptySearchHistoryLabel.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    self.emptySearchHistoryLabel = emptySearchHistoryLabel;
    [footerView addSubview:emptySearchHistoryLabel];
    footerView.yj_height = emptySearchHistoryLabel.yj_height;
    self.baseSearchTableView.tableFooterView = footerView;
    
}

- (void)setupHotSearchNormalTags
{
    self.hotSearchTags = [self addAndLayoutTagsWithTagsContentView:self.hotSearchTagsContentView tagTexts:self.hotSearches];
    
    [self setHotSearchStyle:self.hotSearchStyle];
}

- (void)setupSearchHistoryTags
{
    self.baseSearchTableView.tableFooterView = nil;
    self.searchHistoryTagsContentView.yj_y = 10;
    self.emptyButton.yj_y = self.searchHistoryHeader.yj_y - 10 * 0.5;
    self.searchHistoryTagsContentView.yj_y = CGRectGetMaxY(self.emptyButton.frame) + 10;
    self.searchHistoryTags = [self addAndLayoutTagsWithTagsContentView:self.searchHistoryTagsContentView tagTexts:[self.searchHistories copy]];
}

- (NSArray *)addAndLayoutTagsWithTagsContentView:(UIView *)contentView tagTexts:(NSArray<NSString *> *)tagTexts;
{
    [contentView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    NSMutableArray *tagsM = [NSMutableArray array];

    for (int i = 0; i < tagTexts.count; i++) {
        
        UILabel *label = [[UILabel alloc] init];
        label.userInteractionEnabled = YES;
        label.font = [UIFont systemFontOfSize:12];
        label.text = tagTexts[i];
        label.backgroundColor = MainBGColor;
        label.layer.cornerRadius = 3;
        label.clipsToBounds = YES;
        label.textAlignment = NSTextAlignmentCenter;
        [label sizeToFit];
        label.yj_width += 20;
        label.yj_height += 14;
        
        [label addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tagDidCLick:)]];
        [contentView addSubview:label];
        [tagsM addObject:label];
    }
    
    CGFloat currentX = 0;
    CGFloat currentY = 0;
    CGFloat countRow = 0;
    CGFloat countCol = 0;
    
    for (int i = 0; i < contentView.subviews.count; i++) {
        UILabel *subView = contentView.subviews[i];
        if (subView.yj_width > contentView.yj_width) subView.yj_width = contentView.yj_width;
        if (currentX + subView.yj_width + 10 * countRow > contentView.yj_width) {
            subView.yj_x = 0;
            subView.yj_y = (currentY += subView.yj_height) + 10 * ++countCol;
            currentX = subView.yj_width;
            countRow = 1;
        } else {
            subView.yj_x = (currentX += subView.yj_width) - subView.yj_width + 10 * countRow;
            subView.yj_y = currentY + 10 * countCol;
            countRow ++;
        }
    }
    
    contentView.yj_height = CGRectGetMaxY(contentView.subviews.lastObject.frame);
    if (self.hotSearchTagsContentView == contentView) { // popular search tag
        self.hotSearchView.yj_height = CGRectGetMaxY(contentView.frame) + 10 * 2;
    } else if (self.searchHistoryTagsContentView == contentView) { // search history tag
        self.searchHistoryView.yj_height = CGRectGetMaxY(contentView.frame) + 10 * 2;
    }
    
    [self layoutForDemand];
    self.baseSearchTableView.tableHeaderView.yj_height = self.headerView.yj_height = MAX(CGRectGetMaxY(self.hotSearchView.frame), CGRectGetMaxY(self.searchHistoryView.frame));
    self.baseSearchTableView.tableHeaderView.hidden = NO;
    
    [self.baseSearchTableView setTableHeaderView:self.baseSearchTableView.tableHeaderView];
    return [tagsM copy];
}

- (void)layoutForDemand {
    if (NO == self.swapHotSeachWithSearchHistory) {
        self.hotSearchView.yj_y = 10 * 2;
        self.searchHistoryView.yj_y = self.hotSearches.count > 0 && self.showHotSearch ? CGRectGetMaxY(self.hotSearchView.frame) : ScreenW*0.5+200*AdaptiveScale_W;
    } else { // swap popular search whith search history
        self.hotSearchView.yj_y = self.searchHistories.count > 0 && self.showSearchHistory ? CGRectGetMaxY(self.searchHistoryView.frame) : 10 * 2;
    }
}

#pragma mark - setter
- (void)setSwapHotSeachWithSearchHistory:(BOOL)swapHotSeachWithSearchHistory
{
    _swapHotSeachWithSearchHistory = swapHotSeachWithSearchHistory;
    
    self.hotSearches = self.hotSearches;
    self.searchHistories = self.searchHistories;
}

- (void)setHotSearchTitle:(NSString *)hotSearchTitle
{
    _hotSearchTitle = [hotSearchTitle copy];
    
    self.hotSearchHeader.text = _hotSearchTitle;
}

- (void)setSearchHistoryTitle:(NSString *)searchHistoryTitle
{
    _searchHistoryTitle = [searchHistoryTitle copy];
    self.searchHistoryHeader.text = _searchHistoryTitle;
    
}

- (void)setShowHotSearch:(BOOL)showHotSearch
{
    _showHotSearch = showHotSearch;
    
    [self setHotSearches:self.hotSearches];
    [self setSearchHistoryStyle:self.searchHistoryStyle];

}

- (void)setSelectButton:(UIBarButtonItem *)selectButton
{
    self.navigationItem.rightBarButtonItem = selectButton;
}

- (void)setSearchHistoriesCachePath:(NSString *)searchHistoriesCachePath
{
    _searchHistoriesCachePath = [searchHistoriesCachePath copy];
    
    self.searchHistories = nil;
    
    [self setSearchHistoryStyle:self.searchHistoryStyle];
    
}

- (void)setHotSearchTags:(NSArray<UILabel *> *)hotSearchTags
{
//    for (UILabel *tagLabel in hotSearchTags) {
//        tagLabel.tag = 1;
//    }
    _hotSearchTags = hotSearchTags;
}

- (void)setSearchBarBackgroundColor:(UIColor *)searchBarBackgroundColor
{
    _searchBarBackgroundColor = searchBarBackgroundColor;
    
    for (UIView *subView in [[self.searchBar.subviews lastObject] subviews]) {
        if ([[subView class] isSubclassOfClass:[UITextField class]]) {
            UITextField *textField = (UITextField *)subView;
            textField.backgroundColor = searchBarBackgroundColor;
            break;
        }
    }
}

- (void)setHotSearches:(NSMutableArray *)hotSearches
{
    _hotSearches = hotSearches;
//    
//    if (0 == hotSearches.count || !self.showHotSearch) {
//        self.hotSearchHeader.hidden = YES;
//        self.hotSearchTagsContentView.hidden = YES;
//        if (XWSearchHistoryStyleCell == self.searchHistoryStyle) {
//            UIView *tableHeaderView = self.baseSearchTableView.tableHeaderView;
//            tableHeaderView.yj_height = 10 * 1.5;
//            [self.baseSearchTableView setTableHeaderView:tableHeaderView];
//        }
//        return;
//    };
    
    self.baseSearchTableView.tableHeaderView.hidden = NO;
    self.hotSearchHeader.hidden = NO;
    self.hotSearchTagsContentView.hidden = NO;
    
    if (XWHotSearchStyleDefault == self.hotSearchStyle) {
         [self setupHotSearchNormalTags];
    }
    [self setSearchHistoryStyle:self.searchHistoryStyle];

}

- (void)setSearchHistoryStyle:(XWSearchHistoryStyle)searchHistoryStyle
{
    _searchHistoryStyle = searchHistoryStyle;
    
    self.searchHistoryHeader.hidden = NO;
    self.searchHistoryTagsContentView.hidden = NO;
    self.searchHistoryView.hidden = NO;
    self.emptyButton.hidden = NO;
    [self setupSearchHistoryTags];
    
    switch (searchHistoryStyle) {
        case XWSearchHistoryStyleColorfulTag:
            for (UILabel *tag in self.searchHistoryTags) {
                tag.textColor = [UIColor whiteColor];
                tag.layer.borderColor = nil;
                tag.layer.borderWidth = 0.0;
                tag.backgroundColor = RandomColor;
            }
            break;
        
        default:
            break;
    }
}

- (void)setHotSearchStyle:(XWHotSearchStyle)hotSearchStyle
{
    _hotSearchStyle = hotSearchStyle;
    
    switch (hotSearchStyle) {
        case XWHotSearchStyleColorfulTag:
            for (UILabel *tag in self.hotSearchTags) {
                tag.textColor = [UIColor whiteColor];
                tag.layer.borderColor = nil;
                tag.layer.borderWidth = 0.0;
                tag.backgroundColor = RandomColor;
            }
            break;
        
        case XWHotSearchStyleRankTag:
            //self.rankTagBackgroundColorHexStrings = nil;
            break;
            
        default:
            break;
    }
}


- (void)searchDidClick:(UISearchBar *)searchBar
{
//    [self.searchBar resignFirstResponder];
//    UILabel *label ;
//    self.searchBar.text = label.text;
//    if ([self.delegate respondsToSelector:@selector(didClickCancel:)]) {
//        [self.delegate searchViewController:self didSearchWithSearchBar:self.searchBar searchText:self.searchBar.text];
//        [self saveSearchCacheAndRefreshView];
//
//        return;
//    }
    
    if (STUserDefaults.isLogin) {
        
        if ([self.searchBar.text isEqualToString:@""]) {
            [SVProgressHUD showSuccessWithStatus:@"请输入关键词"];
        } else {
            if ([self.delegate respondsToSelector:@selector(searchViewController:didSearchWithSearchBar:searchText:)]) {
                [self.delegate searchViewController:self didSearchWithSearchBar:self.searchBar searchText:self.searchBar.text];
                [self saveSearchCacheAndRefreshView];
                return;
            }
            if (self.didSearchBlock) self.didSearchBlock(self, self.searchBar, self.searchBar.text);
            [self saveSearchCacheAndRefreshView];
        }
        
    } else {
        
        [SVProgressHUD showErrorWithStatus:@"请先登录"];
        
    }

}

- (void)keyboardDidShowAll:(NSNotification *)noti
{
    NSDictionary *info = noti.userInfo;
    self.keyboardHeight = [info[UIKeyboardFrameEndUserInfoKey] CGRectValue].size.height;
    self.keyboardShowing = YES;

}

- (void)emptySearchHistoryDidClick
{
    [self.searchHistories removeAllObjects];
    [NSKeyedArchiver archiveRootObject:self.searchHistories toFile:self.searchHistoriesCachePath];
    if (XWSearchHistoryStyleCell == self.searchHistoryStyle) {
        [self.baseSearchTableView reloadData];
    } else {
        self.searchHistoryStyle = self.searchHistoryStyle;
    }
    if (YES == self.swapHotSeachWithSearchHistory) {
        self.hotSearches = self.hotSearches;
    }
    JLLog(@"%@", @"清空搜索历史");
}

- (void)tagDidCLick:(UITapGestureRecognizer *)gr
{
    UILabel *label = (UILabel *)gr.view;
    self.searchBar.text = label.text;
    
    // popular search tagLabel's tag is 1, search history tagLabel's tag is 0.
    if (1 == label.tag) {
        if ([self.delegate respondsToSelector:@selector(searchViewController:didSelectHotSearchAtIndex:searchText:)]) {
            [self.delegate searchViewController:self didSelectHotSearchAtIndex:[self.hotSearchTags indexOfObject:label] searchText:label.text];
            [self saveSearchCacheAndRefreshView];
        } else {
            [self searchBarSearchButtonClicked:self.searchBar];
        }
    } else {
        if ([self.delegate respondsToSelector:@selector(searchViewController:didSelectSearchHistoryAtIndex:searchText:)]) {
            [self.delegate searchViewController:self didSelectSearchHistoryAtIndex:[self.searchHistoryTags indexOfObject:label] searchText:label.text];
            [self saveSearchCacheAndRefreshView];
        } else {
            [self searchBarSearchButtonClicked:self.searchBar];
        }
    }
}

- (void)saveSearchCacheAndRefreshView
{
    UISearchBar *searchBar = self.searchBar;
    [searchBar resignFirstResponder];
    NSString *searchText = searchBar.text;
    if (self.removeSpaceOnSearchString) { // remove sapce on search string
        searchText = [searchBar.text stringByReplacingOccurrencesOfString:@" " withString:@""];
    }
    if (self.showSearchHistory && searchText.length > 0) {
        [self.searchHistories removeObject:searchText];
        [self.searchHistories insertObject:searchText atIndex:0];
        
        if (self.searchHistories.count > self.searchHistoriesCount) {
            [self.searchHistories removeLastObject];
        }
        [NSKeyedArchiver archiveRootObject:self.searchHistories toFile:self.searchHistoriesCachePath];
        
        if (XWSearchHistoryStyleCell == self.searchHistoryStyle) {
            [self.baseSearchTableView reloadData];
        } else {
            self.searchHistoryStyle = self.searchHistoryStyle;
        }
    }
    
    XWSearchDetailListVC *detailsController = [[XWSearchDetailListVC alloc] init];
    detailsController.titleStr = searchText;
    [self.navigationController pushViewController:detailsController animated:YES];
    
}


#pragma mark - UISearchBarDelegate
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    if ([self.delegate respondsToSelector:@selector(searchViewController:didSearchWithSearchBar:searchText:)]) {
        [self.delegate searchViewController:self didSearchWithSearchBar:searchBar searchText:searchBar.text];
        [self saveSearchCacheAndRefreshView];
        return;
    }
    if (self.didSearchBlock) self.didSearchBlock(self, searchBar, searchBar.text);
    [self saveSearchCacheAndRefreshView];
}

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    
    if ([self.delegate respondsToSelector:@selector(searchViewController:searchTextDidChange:searchText:)]) {
        [self.delegate searchViewController:self searchTextDidChange:searchBar searchText:searchText];
    }
}

- (BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar
{

    return YES;
}

- (void)closeDidClick:(UIButton *)sender
{
    UITableViewCell *cell = (UITableViewCell *)sender.superview;
    [self.searchHistories removeObject:cell.textLabel.text];
    [NSKeyedArchiver archiveRootObject:self.searchHistories toFile:self.searchHistoriesCachePath];
    [self.baseSearchTableView reloadData];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return  1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    self.baseSearchTableView.tableFooterView.hidden = 0 == self.searchHistories.count || !self.showSearchHistory;
    return self.showSearchHistory && XWSearchHistoryStyleCell == self.searchHistoryStyle ? self.searchHistories.count : 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellID = @"XWSearchHistoryCellID";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        cell.textLabel.textColor = TextColor;
        cell.textLabel.font = [UIFont systemFontOfSize:14];
        cell.backgroundColor = [UIColor clearColor];
        
        UIButton *closetButton = [[UIButton alloc] init];
        closetButton.yj_size = CGSizeMake(cell.yj_height, cell.yj_height);
        [closetButton setImage:MyImage(@"close") forState:UIControlStateNormal];
        UIImageView *closeView = [[UIImageView alloc] initWithImage:MyImage(@"close")];
        [closetButton addTarget:self action:@selector(closeDidClick:) forControlEvents:UIControlEventTouchUpInside];
        closeView.contentMode = UIViewContentModeCenter;
        cell.accessoryView = closetButton;
        UIImageView *line = [[UIImageView alloc] initWithImage:MyImage(@"cell-content-line")];
        line.yj_height = 0.5;
        line.alpha = 0.7;
        line.yj_x = 10;
        line.yj_y = 43;
        line.yj_width = tableView.yj_width;
        line.autoresizingMask = UIViewAutoresizingFlexibleWidth;
        [cell.contentView addSubview:line];
    }
    
    cell.imageView.image = MyImage(@"search_history");
    cell.textLabel.text = self.searchHistories[indexPath.row];
    
    return cell;
}

//- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
//{
//    return self.showSearchHistory && self.searchHistories.count?@"搜索历史记录" : nil ;
//}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return self.searchHistories.count && self.showSearchHistory && XWSearchHistoryStyleCell == self.searchHistoryStyle ? 25 : 0.01;

}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.01;
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    self.searchBar.text = cell.textLabel.text;
    
    if ([self.delegate respondsToSelector:@selector(searchViewController:didSelectSearchHistoryAtIndex:searchText:)]) {
        [self.delegate searchViewController:self didSelectSearchHistoryAtIndex:indexPath.row searchText:cell.textLabel.text];
        [self saveSearchCacheAndRefreshView];
    } else {
        [self searchBarSearchButtonClicked:self.searchBar];
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (self.keyboardShowing) {
        [self.searchBar resignFirstResponder];
    }
}








@end
