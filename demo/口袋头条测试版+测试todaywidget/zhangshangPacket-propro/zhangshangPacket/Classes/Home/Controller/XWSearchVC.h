//
//  XWSearchVC.h
//  zhangshangPacket
//
//  Created by apple on 2017/5/23.
//  Copyright © 2017年 apple-fangqiu. All rights reserved.
//

#import <UIKit/UIKit.h>
@class XWSearchVC;
typedef void(^XWDidSearchBlock)(XWSearchVC *searchViewController, UISearchBar *searchBar, NSString *searchText);

typedef NS_ENUM(NSInteger, XWHotSearchStyle)  {
    XWHotSearchStyleNormalTag,
    XWHotSearchStyleColorfulTag,
    XWHotSearchStyleRankTag,
    XWHotSearchStyleDefault = XWHotSearchStyleNormalTag
};

typedef NS_ENUM(NSInteger, XWSearchHistoryStyle) {
    XWSearchHistoryStyleCell,           // style of UITableViewCell
    XWSearchHistoryStyleNormalTag,      // style of PYHotSearchStyleNormalTag
    XWSearchHistoryStyleColorfulTag,    // style of PYHotSearchStyleColorfulTag
    XWSearchHistoryStyleDefault = XWSearchHistoryStyleNormalTag // default is `PYSearchHistoryStyleCell`
};

typedef NS_ENUM(NSInteger, XWSearchResultShowMode) {
    XWSearchResultShowModeCustom,   // custom, can be push or pop and so on.
    XWSearchResultShowModePush,     // push, dispaly the view of search result by push
    XWSearchResultShowModeEmbed,    // embed, dispaly the view of search result by embed
    XWSearchResultShowModeDefault = XWSearchResultShowModePush
};

@protocol XWSearchViewControllerDelegate <NSObject>

@optional

- (void)searchViewController:(XWSearchVC *)searchViewController
      didSearchWithSearchBar:(UISearchBar *)searchBar
                  searchText:(NSString *)searchText;

- (void)searchViewController:(XWSearchVC *)searchViewController
   didSelectHotSearchAtIndex:(NSInteger)index
                  searchText:(NSString *)searchText;

- (void)searchViewController:(XWSearchVC *)searchViewController
didSelectSearchHistoryAtIndex:(NSInteger)index
                  searchText:(NSString *)searchText;

- (void)searchViewController:(XWSearchVC *)searchViewController
         searchTextDidChange:(UISearchBar *)searchBar
                  searchText:(NSString *)searchText;

- (void)didClickCancel:(XWSearchVC *)searchViewController;

@end




@interface XWSearchVC : UIViewController

@property (nonatomic, strong) id<XWSearchViewControllerDelegate> delegate;

@property (nonatomic, copy) NSArray<NSString *> *hotSearches;

@property (nonatomic, copy) NSArray<UILabel *> *hotSearchTags;

@property (nonatomic, copy) NSArray<UILabel *> *searchHistoryTags;

@property (nonatomic, assign) BOOL showHotSearch;

@property (nonatomic, assign) BOOL showSearchHistory;

@property (nonatomic, weak) UILabel *hotSearchHeader;

@property (nonatomic, weak) UISearchBar *searchBar;
//清空历史记录
@property (nonatomic, weak) UIButton *emptyButton;

@property (nonatomic, weak) UIButton *turnButton;

@property (nonatomic, weak) UILabel *searchHistoryHeader;

@property (nonatomic, weak) UILabel *emptySearchHistoryLabel;

//搜索记录缓存
@property (nonatomic, copy) NSString *searchHistoriesCachePath;
//右侧搜索按钮
@property (nonatomic, weak) UIBarButtonItem *selectButton;

//搜索历史条数 20
@property (nonatomic, assign) NSUInteger searchHistoriesCount;

@property (nonatomic, assign) BOOL swapHotSeachWithSearchHistory;

@property (nonatomic, copy) NSString *hotSearchTitle;

@property (nonatomic, copy) NSString *searchHistoryTitle;
// search背景颜色
@property (nonatomic, strong) UIColor *searchBarBackgroundColor;

//移除搜索字符空白
@property (nonatomic, assign) BOOL removeSpaceOnSearchString;

@property (nonatomic, copy) XWDidSearchBlock didSearchBlock;

@property (nonatomic, assign) XWHotSearchStyle hotSearchStyle;


@property (nonatomic, assign) XWSearchHistoryStyle searchHistoryStyle;

@property (nonatomic, assign) XWSearchResultShowMode searchResultShowMode;

@end
