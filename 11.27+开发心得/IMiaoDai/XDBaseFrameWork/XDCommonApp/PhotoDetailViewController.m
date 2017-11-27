//
//  PhotoDetailViewController.m
//  HengHuaSupervision
//
//  Created by wanglong8889@126.com on 14-3-27.
//  Copyright (c) 2014年 XD-XY. All rights reserved.
//

#import "PhotoDetailViewController.h"
#import "ImageView.h"
#import "XDHeader.h"
#import "XDTools.h"
@interface PhotoDetailViewController ()

@end

@implementation PhotoDetailViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    float height;
    if (IOS7) {
        height = 20;
    }else{
        height = 0;
    }
    
    self.navigationBarView.hidden = YES;
    UIView * bgView = [[UIView alloc] initWithFrame:CGRectMake(0, height, 320, self.view.frame.size.height)];
    [self.view addSubview:bgView];
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapAction)];
//    bgView.backgroundColor = [UIColor redColor];
    [bgView addGestureRecognizer:tap];
    
    
    myScrollView=[[UIScrollView alloc] initWithFrame:CGRectMake(0, height, 320, self.view.frame.size.height)];
    myScrollView.bounces = NO;
    myScrollView.pagingEnabled = YES;
    myScrollView.delegate = self;
    myScrollView.userInteractionEnabled = YES;
    myScrollView.showsHorizontalScrollIndicator=NO;
    myScrollView.showsVerticalScrollIndicator= NO;
    myScrollView.contentSize = CGSizeMake(myScrollView.frame.size.width * [self.myArray count],myScrollView.frame.size.height);
    myScrollView.contentOffset = CGPointMake(320*self.contentOffset, 0);
    [bgView addSubview:myScrollView];
    
    recycledPages=[[NSMutableSet alloc] init];
    visiblePages =[[NSMutableSet alloc] init];
    
    //显示有多少页的pageController
    pageController=[[UIPageControl alloc] initWithFrame:CGRectMake(0, 440, 320, 20)];
    [pageController setNumberOfPages:[self.myArray count]];
    [pageController setCurrentPage:0];
//    [bgView addSubview:pageController];
    
    [self tilePages];
    
    navigationBarVie = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0,
                                                                 320,
                                                                 44+20)];
    navigationBarVie.userInteractionEnabled = YES;
    navigationBarVie.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"nav_bg_ios7@2x"]];
    navigationBarVie.image = [[UIImage imageNamed:@"nav_bg_ios7@2x"] resizableImageWithCapInsets:UIEdgeInsetsMake(5, 10, 5, 10)];
    
    navigationBarVie.alpha = 0.9;
    [self.view addSubview:navigationBarVie];

    float h = 0;
    if (IOS7) {
        h = 20;
    }
    leftButtonTT = [[UIButton alloc] initWithFrame:CGRectMake(10,h, 44 , 44)];
//    [leftButton setBackgroundColor:[UIColor clearColor]];
    [leftButtonTT setBackgroundImage:[UIImage imageNamed:@"backBtn_image@2x"]
                           forState:UIControlStateNormal];
    [leftButtonTT addTarget:self action:@selector(backPrePage) forControlEvents:UIControlEventTouchUpInside];
    
    [navigationBarVie addSubview:leftButtonTT];

    titLabel = [XDTools addAlabelForAView:navigationBarVie withText:[NSString stringWithFormat:@"%d/%d",self.contentOffset+1,self.myArray.count] frame:CGRectMake(110,20,100,44) font:[UIFont systemFontOfSize:13.0] textColor:[UIColor whiteColor]];
    titLabel.textAlignment = NSTextAlignmentCenter;
//    rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
//    rightButton.frame = CGRectMake(250, 7-44, 55, 30);
//    [rightButton setTitle:@"举报" forState:(UIControlStateNormal)];
//    [rightButton setBackgroundImage:[UIImage imageNamed:@"greenButton"] forState:UIControlStateNormal];
//    [rightButton addTarget:self action:@selector(reportButtonPressed)
//          forControlEvents:UIControlEventTouchUpInside];
//    [self.view addSubview:rightButton];
    [self createImageViews];
    
}

- (void)createImageViews
{
    for (int i=0; i<self.myArray.count; i++) {
        ImageView * page = [[ImageView alloc]init];
        [self configurePage:page forIndex:i];
        [myScrollView addSubview:page];
    }
}
#pragma mark -
#pragma mark -scrollViewDelegate
//视图滑动时
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    //    [self tilePages];
    if (myScrollView.contentOffset.x>myScrollView.frame.size.width*([self.myArray count]-1)+100) {
        [myScrollView scrollRectToVisible:CGRectMake(myScrollView.frame.size.width*0,0,myScrollView.frame.size.width,myScrollView.frame.size.height) animated:NO];
        [pageController setCurrentPage:0];
    }
    
}
//我们移动手指开始
- (void)scrollViewWillBeginDecelerating:(UIScrollView *)scrollView{
    
}
//当滚动视图停止
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView;{
    int currentPage = floor((scrollView.contentOffset.x - scrollView.frame.size.width / 2) /  scrollView.frame.size.width) + 1;
    [pageController setCurrentPage:currentPage];
    titLabel.text = [NSString stringWithFormat:@"%d/%d",currentPage+1,self.myArray.count];
    
}

#pragma mark-
#pragma mark-scrollView重用机制-
- (void)tilePages
{
    // Calculate which pages are visible
    CGRect visibleBounds =myScrollView.bounds;
    int firstNeededPageIndex = floorf(CGRectGetMinX(visibleBounds) / CGRectGetWidth(visibleBounds));
    int lastNeededPageIndex  = floorf((CGRectGetMaxX(visibleBounds)-1) / CGRectGetWidth(visibleBounds));
    firstNeededPageIndex = MAX(firstNeededPageIndex, 0);
    lastNeededPageIndex  = MIN(lastNeededPageIndex, [self.myArray count] - 1);
    
    // Recycle no-longer-visible pages
    for (ImageView *page in visiblePages) {
        if (page.index < firstNeededPageIndex || page.index > lastNeededPageIndex) {
            [recycledPages addObject:page];
            [page removeFromSuperview];
        }
    }
    [visiblePages minusSet:recycledPages];
    
    // add missing pages
    for (int index = firstNeededPageIndex; index <= lastNeededPageIndex; index++) {
        if (![self isDisplayingPageForIndex:index]) {
            ImageView *page = [self dequeueRecycledPage];
            if (page == nil) {
                page = [[ImageView alloc] init];
            }
            [self configurePage:page forIndex:index];
            [myScrollView addSubview:page];
            [visiblePages addObject:page];
        }
    }
}

- (ImageView *)dequeueRecycledPage
{
    ImageView *page = [recycledPages anyObject];
    if (page) {
        [recycledPages removeObject:page];
    }
    return page;
}

- (BOOL)isDisplayingPageForIndex:(NSUInteger)index
{
    BOOL foundPage = NO;
    for (ImageView *page in visiblePages) {
        if (page.index == index) {
            foundPage = YES;
            break;
        }
    }
    return foundPage;
}

- (void)configurePage:(ImageView *)page forIndex:(NSUInteger)index
{
    page.index = index;
    page.frame =CGRectMake( myScrollView.frame.size.width*index, 0, myScrollView.frame.size.width,myScrollView.frame.size.height);
    page.backgroundColor = [UIColor grayColor];
   
        [page initView:[self.myArray objectAtIndex:index]];
    
    
    
}

- (void)tapAction
{
    if (navigationBarVie.hidden == NO) {
        [UIView animateWithDuration:0.3 animations:^{
//            navigationBarVie.frame = CGRectMake(0, 0,
//                                                 320,
//                                                 44+20);
            navigationBarVie.frame = CGRectMake(0,-66,
                                                320,
                                                44+20);
            
//            leftButton.frame = CGRectMake(0, 0, 36 , 32);
//            rightButton.frame = CGRectMake(250, 7, 55, 30);
            
        } completion:^(BOOL finished) {
            navigationBarVie.hidden = YES;
        }];
    }
    else{
        
        [UIView animateWithDuration:0.3 animations:^{
//            navigationBarVie.frame = CGRectMake(0,-66,
//                                                 320,
//                                                 44+20);
            navigationBarVie.frame = CGRectMake(0, 0,
                                                320,
                                                44+20);
//            leftButton.frame = CGRectMake(0, -44, 36 , 32);
//            rightButton.frame = CGRectMake(250, 7-44, 55, 30);
        } completion:^(BOOL finished) {
            navigationBarVie.hidden = NO;
        }];
        
    }
}

-(void)backPrePage{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)viewDidUnload
{
    [self setMyArray:nil];
    [super viewDidUnload];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
