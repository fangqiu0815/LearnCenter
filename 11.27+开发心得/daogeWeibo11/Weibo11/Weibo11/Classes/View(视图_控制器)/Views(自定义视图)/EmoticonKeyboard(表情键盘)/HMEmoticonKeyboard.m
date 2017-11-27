//
//  HMEmoticonKeyboard.m
//  Weibo11
//
//  Created by 刘凡 on 15/12/15.
//  Copyright © 2015年 itheima. All rights reserved.
//

#import "HMEmoticonKeyboard.h"
#import "HMEmoticonToolbar.h"
#import "HMEmoticonCell.h"
#import "HMEmoticonManager.h"
#import "UITextView+Emoticon.h"

/// 可重用标识符
static NSString *const kEmoticonKeyboardCellId = @"EmoticonKeyboardCellId";

#pragma mark - 键盘布局
@interface HMEmoticonKeyboardLayout : UICollectionViewFlowLayout

@end

@implementation HMEmoticonKeyboardLayout

- (void)prepareLayout {
    [super prepareLayout];
    
    self.itemSize = self.collectionView.bounds.size;
    self.minimumInteritemSpacing = 0;
    self.minimumLineSpacing = 0;
    self.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    
    self.collectionView.pagingEnabled = YES;
    self.collectionView.showsHorizontalScrollIndicator = NO;
    self.collectionView.bounces = NO;
}

@end

#pragma mark - 键盘视图
@interface HMEmoticonKeyboard() <UICollectionViewDataSource, UICollectionViewDelegate, HMEmoticonToolbarDelegate, HMEmoticonCellDelegate>
/// 工具栏
@property (nonatomic, strong) HMEmoticonToolbar *toolbar;
/// 集合视图
@property (nonatomic, strong) UICollectionView *collectionView;
/// 分页控件
@property (nonatomic, strong) UIPageControl *pageControl;
/// 调用方的 textView
@property (nonatomic, weak) UITextView *textView;
@end

@implementation HMEmoticonKeyboard

#pragma mark - 构造函数
- (instancetype)initWithTextView:(UITextView *)textView {
    CGRect rect = [UIScreen mainScreen].bounds;
    rect.size.height = 258;
    self = [super initWithFrame:rect];
    
    if (self) {
        [self setupUI];
        
        // 记录textView
        self.textView = textView;
        
        // 选中默认表情分组
        dispatch_async(dispatch_get_main_queue(), ^{
            [self emoticonToolbarDidSelectEmoticonType:EmoticonToolbarNormal];
        });
    }
    return self;
}

#pragma mark - HMEmoticonCellDelegate
- (void)emoticonCellDidSelectedEmoticon:(HMEmoticon *)emoticon isDeleted:(BOOL)isDeleted {
    
    // 执行完成回调
    if (self.textView != nil) {
        [self.textView inputEmoticon:emoticon isDelete:isDeleted];
    }
    
    // 添加最近使用表情
    [[HMEmoticonManager sharedManager] addRecentEmoticon:emoticon];
}

#pragma mark - HMEmoticonToolbarDelegate
- (void)emoticonToolbarDidSelectEmoticonType:(HMEmoticonToolbarType)type {
    NSInteger section = 0;
    switch (type) {
        case EmoticonToolbarRecent:
            section = 0;
            break;
        case EmoticonToolbarNormal:
            section = 1;
            break;
        case EmoticonToolbarEmoji:
            section = 2;
            break;
        case EmoticonToolbarLangXiaohua:
            section = 3;
            break;
    }
    
    NSIndexPath *indexPath = [NSIndexPath indexPathForItem:0 inSection:section];
    
    // 滚动到指定分组第一页
    [self.collectionView scrollToItemAtIndexPath:indexPath atScrollPosition:UICollectionViewScrollPositionLeft animated:NO];
    // 更新分页控件
    [self updatePageControlWithIndexPath:indexPath];
}

#pragma mark - UICollectionView DataSource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return [HMEmoticonManager sharedManager].packages.count;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return [[HMEmoticonManager sharedManager] numberOfPagesInSection:section];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    HMEmoticonCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kEmoticonKeyboardCellId forIndexPath:indexPath];
    
    cell.emoticons = [[HMEmoticonManager sharedManager] emoticonsWithIndexPath:indexPath];
    cell.indexPath = indexPath;
    
    // 设置代理
    cell.delegate = self;
    
    return cell;
}

#pragma mark - UIScrollView Delegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    // 取出基于 contentOffset 的中心点
    CGPoint center = self.collectionView.center;
    center.x += scrollView.contentOffset.x;
    
    // 获取当前可见的 indexPath
    NSArray *indexPaths = [self.collectionView indexPathsForVisibleItems];
    
    // 遍历 indexPaths
    NSIndexPath *targetPath = nil;
    for (NSIndexPath *indexPath in indexPaths) {
        UICollectionViewCell *cell = [self.collectionView cellForItemAtIndexPath:indexPath];
        
        // 判断中心点在哪一个 cell 中
        if (CGRectContainsPoint(cell.frame, center)) {
            targetPath = indexPath;
            break;
        }
    }
    
    if (targetPath != nil) {
        // 更新工具条按钮选中状态
        [self.toolbar setSelectedButtonWithSection:targetPath.section];
        
        // 更新分页控件显示
        [self updatePageControlWithIndexPath:targetPath];
    }
}

#pragma mark - 更新分页控件
/// 根据给定的 indexPath 更新 分页控件显示
- (void)updatePageControlWithIndexPath:(NSIndexPath *)indexPath {
    // 页数
    self.pageControl.numberOfPages = [[HMEmoticonManager sharedManager] numberOfPagesInSection:indexPath.section];
    // 当前页数
    self.pageControl.currentPage = indexPath.item;
}

#pragma mark - 设置界面
- (void)setupUI {
    // 0. 设置背景图片
    self.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"emoticon_keyboard_background"]];
    
    // 1. 工具栏
    [self addSubview:self.toolbar];
    self.toolbar.delegate = self;
    
    CGRect toolBarRect = self.bounds;
    toolBarRect.origin.y = toolBarRect.size.height - 42;
    toolBarRect.size.height = 42;
    self.toolbar.frame = toolBarRect;
    
    // 2. collectionView
    [self addSubview:self.collectionView];
    
    CGRect collectionViewRect = self.bounds;
    collectionViewRect.size.height -= self.toolbar.bounds.size.height;
    self.collectionView.frame = collectionViewRect;
    
    // 注册 cell
    [self.collectionView registerClass:[HMEmoticonCell class] forCellWithReuseIdentifier:kEmoticonKeyboardCellId];
    
    // 3. 分页控件
    [self addSubview:self.pageControl];
    
    // 4. 自动布局
    self.pageControl.translatesAutoresizingMaskIntoConstraints = false;
    [self addConstraint:[NSLayoutConstraint constraintWithItem:_pageControl
                                                     attribute:NSLayoutAttributeCenterX
                                                     relatedBy:NSLayoutRelationEqual
                                                        toItem:self
                                                     attribute:NSLayoutAttributeCenterX
                                                    multiplier:1.0
                                                      constant:0.0]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:_pageControl
                                                     attribute:NSLayoutAttributeBottom
                                                     relatedBy:NSLayoutRelationEqual
                                                        toItem:self.toolbar
                                                     attribute:NSLayoutAttributeTop
                                                    multiplier:1.0
                                                      constant:0.0]];
}

#pragma mark - 懒加载控件
- (HMEmoticonToolbar *)toolbar {
    if (_toolbar == nil) {
        _toolbar = [[HMEmoticonToolbar alloc] init];
    }
    return _toolbar;
}

- (UICollectionView *)collectionView {
    if (_collectionView == nil) {
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:[[HMEmoticonKeyboardLayout alloc] init]];
        
        _collectionView.dataSource = self;
        _collectionView.delegate = self;
        
        _collectionView.backgroundColor = [UIColor clearColor];
    }
    return _collectionView;
}

- (UIPageControl *)pageControl {
    if (_pageControl == nil) {
        _pageControl = [[UIPageControl alloc] init];
        
        // 单页隐藏
        _pageControl.hidesForSinglePage = YES;
        
        // 禁用用户交互
        _pageControl.userInteractionEnabled = NO;
        
        // 用 KVC 设置选中和默认图片
        // 提示，此处打断点，在控制台输入 po [self.pageControl ff_ivarsList] 可以查看所有成员变量
        [_pageControl setValue:[UIImage imageNamed:@"compose_keyboard_dot_selected"] forKey:@"_currentPageImage"];
        [_pageControl setValue:[UIImage imageNamed:@"compose_keyboard_dot_normal"] forKey:@"_pageImage"];
    }
    return _pageControl;
}

@end


