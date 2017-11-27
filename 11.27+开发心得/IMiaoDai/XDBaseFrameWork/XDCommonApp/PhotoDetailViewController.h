//
//  PhotoDetailViewController.h
//  HengHuaSupervision
//
//  Created by wanglong8889@126.com on 14-3-27.
//  Copyright (c) 2014年 XD-XY. All rights reserved.
//

#import "XDBaseViewController.h"
#import "ImageView.h"
@class DetailsViewController;
@interface PhotoDetailViewController : XDBaseViewController<UIScrollViewDelegate>
{
    UIScrollView *myScrollView;
    NSMutableSet *recycledPages;
    NSMutableSet *visiblePages;
    UIImage      *currentImage;
    UIImage      *currentImageBig;
    UIPageControl *pageController;
    NSMutableArray * bigImageArray;
    UIImageView * navigationBarVie;
    UIButton * leftButtonTT;
    UIButton * rightButton;
    UILabel *titLabel;
}

@property (nonatomic, strong) NSArray *myArray,* photoArray;
@property (nonatomic, assign) int contentOffset;
@property (nonatomic, strong) NSString * userName;
@property (nonatomic, strong) NSString * findUID;
@property (nonatomic,strong) DetailsViewController *deVC;
@property (nonatomic,assign) BOOL isDefualt; //是否是本地的图片
- (void)tilePages;
- (ImageView *)dequeueRecycledPage;
- (BOOL)isDisplayingPageForIndex:(NSUInteger)index;
- (void)configurePage:(ImageView *)page forIndex:(NSUInteger)index;
@property (nonatomic,strong)UIImage * image;
@end
