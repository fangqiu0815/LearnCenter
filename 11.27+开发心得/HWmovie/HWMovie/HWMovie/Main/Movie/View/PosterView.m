//
//  PosterView.m
//  HWMovie
//
//  Created by hyrMac on 15/7/24.
//  Copyright (c) 2015年 hyrMac. All rights reserved.
//

#import "PosterView.h"
#import "common.h"
#import "UIViewExt.h"
#import "MovieModal.h"

// 各视图位置的宏
#define kHeaderViewH 136
#define kIndexCollectionViewH 100
#define kBottomTitleLableH 35
#define kBottomTitleLableY (kHeight-kTabBarHeight-kBottomTitleLableH)
#define kHeaderOffH 36
#define kPosterColletionViewY (kHeaderViewH-kHeaderOffH)
#define kPosterColletionViewH (kHeight-kPosterColletionViewY-kTabBarHeight-kBottomTitleLableH)

@implementation PosterView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self _createPosterCollectionView];
        [self _createBottomLabelView];
        [self _createCoverView];
        [self _createHeaderView];
        [self _createLight];
        [self _createSwipeGesture];
        
        [_posterCollectionView addObserver:self forKeyPath:@"currentIndex" options:NSKeyValueObservingOptionNew  context:nil];
        [_indexCollectionView addObserver:self forKeyPath:@"currentIndex" options:NSKeyValueObservingOptionNew  context:nil];
        
    }
    return self;
}

// 观察
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    NSNumber *number = [change objectForKey:@"new"];
    NSInteger index = [number integerValue];
    NSIndexPath *indexPath = [NSIndexPath indexPathForItem:index inSection:0];
    if ([object isKindOfClass:[IndexUICollectionView class]] && _posterCollectionView.currentIndex != index) {
        [_posterCollectionView scrollToItemAtIndexPath:indexPath atScrollPosition: UICollectionViewScrollPositionCenteredHorizontally animated:YES];
        _posterCollectionView.currentIndex = index;
    } else if ([object isKindOfClass:[PosterUICollectionView class]] && _indexCollectionView.currentIndex != index) {
        [_indexCollectionView scrollToItemAtIndexPath:indexPath atScrollPosition: UICollectionViewScrollPositionCenteredHorizontally animated:YES];
        _indexCollectionView.currentIndex = index;
    }
    
    // 下方电影文字
    MovieModal *modal1 = _movieModalArray[index];
    _bottomTitleLabel.text = modal1.title;
    
}

- (void)setMovieModalArray:(NSArray *)movieModalArray {
    _movieModalArray = movieModalArray;
    _posterCollectionView.movieModalArray = movieModalArray;
    _indexCollectionView.movieModalArray = movieModalArray;
}

#pragma mark - createSubviews 

- (void)_createPosterCollectionView {
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    layout.minimumLineSpacing = 0;
     layout.minimumInteritemSpacing = 0;

    _posterCollectionView.movieModalArray = _movieModalArray;
    _posterCollectionView = [[PosterUICollectionView alloc] initWithFrame:CGRectMake(0, kPosterColletionViewY, kWidth, kPosterColletionViewH) collectionViewLayout:layout];
    _posterCollectionView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"bg_main"]];
    _posterCollectionView.itemWidth = kWidth;
    
    [self addSubview:_posterCollectionView];
}

- (void)_createBottomLabelView {
    _bottomTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, kBottomTitleLableY, kWidth, kBottomTitleLableH)];
    _bottomTitleLabel.backgroundColor = [UIColor clearColor];
    _bottomTitleLabel.textColor = [UIColor whiteColor];
    _bottomTitleLabel.textAlignment = NSTextAlignmentCenter;
    _bottomTitleLabel.font = [UIFont boldSystemFontOfSize:20];
//    MovieModal *modal1 = _movieModalArray[0];
//    _bottomTitleLabel.text = modal1.title;
    [self addSubview:_bottomTitleLabel];
}

// 阴影效果
- (void)_createCoverView {
    _coverView = [[UIControl alloc] initWithFrame:self.bounds];
    _coverView.backgroundColor = [UIColor colorWithWhite:0.8 alpha:0.8];
    [_coverView addTarget:self action:@selector(coverAction:) forControlEvents:UIControlEventTouchUpInside];
    _coverView.hidden = YES;
    [self addSubview:_coverView];
}

- (void)_createHeaderView {
    _headerView = [[UIView alloc] initWithFrame:CGRectMake(0, -kHeaderOffH, kWidth, kHeaderViewH)];
    _headerView.backgroundColor = [UIColor clearColor];
    
    // 头视图背景图片
    UIImage *image = [UIImage imageNamed:@"indexBG_home"];
    image = [image stretchableImageWithLeftCapWidth:0 topCapHeight:1];
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:_headerView.bounds];
    imageView.image = image;
    [_headerView addSubview:imageView];
    
    [self addSubview:_headerView];
    
    // 头视图中的小海报
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    layout.minimumLineSpacing = 0;
    layout.minimumInteritemSpacing = 0;
    _indexCollectionView = [[IndexUICollectionView alloc] initWithFrame:CGRectMake(0, 0, kWidth, kIndexCollectionViewH) collectionViewLayout:layout];
    _indexCollectionView.movieModalArray = _movieModalArray;
    _indexCollectionView.itemWidth = kWidth/4;
    [_headerView addSubview:_indexCollectionView];
    
    // 按钮
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake((kWidth-70)/2, kHeaderViewH-25, 70, 20)];
    button.tag = 100;
    [button setImage:[UIImage imageNamed:@"down_home"] forState:UIControlStateNormal];
    [button setImage:[UIImage imageNamed:@"up_home"] forState: UIControlStateSelected ];
    [button addTarget:self action:@selector(headerButtonAction:) forControlEvents:UIControlEventTouchUpInside ];
    [_headerView addSubview:button];    
}

- (void)_createLight {
    _img1 = [[UIImageView alloc] initWithFrame:CGRectMake(kWidth/5+5, 62, 80, 120)];
    _img1.image = [UIImage imageNamed:@"light@2x"];
    [self addSubview:_img1];
    _img2 = [[UIImageView alloc] initWithFrame:CGRectMake(kWidth/5*3-5, 62, 80, 120)];
    _img2.image = [UIImage imageNamed:@"light@2x"];
    [self addSubview:_img2];
    _img1.hidden = YES;
    _img2.hidden = YES;
}

// 轻扫手势
- (void)_createSwipeGesture {
    UISwipeGestureRecognizer *swipeDown = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeDownAction)];
    swipeDown.direction = UISwipeGestureRecognizerDirectionDown;
    [self addGestureRecognizer:swipeDown];
}

#pragma mark - Actions

- (void)swipeDownAction {
    UIButton *button = (UIButton *)[_headerView viewWithTag:100];
    
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.3];
    
    [self showHeader];
    
    button.selected = !button.selected;
    [UIView commitAnimations];
}

- (void)headerButtonAction:(UIButton *)button {
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.3];
    
    if (button.selected == YES) {
        [self hideHeader];
    } else {
        [self showHeader];
    }
    button.selected = !button.selected;
    
    [UIView commitAnimations];
}

- (void)coverAction:(UIControl *)control {
    UIButton *button = (UIButton *)[_headerView viewWithTag:100];
    
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.3];
    
    [self hideHeader];
    
    button.selected = !button.selected;
    [UIView commitAnimations];
}

- (void)showHeader {
    _headerView.top = kNavHeight;
    _coverView.hidden = NO;
    _img1.hidden = NO;
    _img2.hidden = NO;
}

- (void)hideHeader {
    _headerView.top = -kHeaderOffH;
    _coverView.hidden = YES;
    _img1.hidden = YES;
    _img2.hidden = YES;
}

- (void)layoutSubviews {
    MovieModal *modal1 = _movieModalArray[0];
    _bottomTitleLabel.text = modal1.title;
}
@end
