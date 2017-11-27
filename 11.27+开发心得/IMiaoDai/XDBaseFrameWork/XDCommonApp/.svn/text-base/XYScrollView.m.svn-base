//
//  XYScrollView.m
//  XDCommonApp
//
//  Created by XD-XY on 2/18/14.
//  Copyright (c) 2014 XD-XY. All rights reserved.
//

#import "XYScrollView.h"
#import "XDHeader.h"
#import "XDTools.h"
#import "UIImageView+WebCache.h"

#define TimeSeconds 3
#define gesture_tag 10000
@implementation XYScrollView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

-(id)initPageScrollView:(CGRect)sPect pageControllerFrame:(CGRect)pRect backgroudImage:(UIImage *)image pageNumber:(int)number
{
    self = [super initWithFrame:sPect];
    if (self){
        self.myScrollView = [[UIScrollView alloc] initWithFrame:sPect];
        _myScrollView.contentSize = CGSizeMake(UI_SCREEN_WIDTH*(number+2), sPect.size.height);
        _myScrollView.contentOffset = CGPointMake(UI_SCREEN_WIDTH, 0);
        _myScrollView.showsHorizontalScrollIndicator=NO;
        _myScrollView.pagingEnabled=YES;
        _myScrollView.delegate = self;
        _myScrollView.backgroundColor = [UIColor clearColor];
        [self addSubview:_myScrollView];
        
        pageNumber = number;
        self.pageControl = [[UIPageControl alloc] initWithFrame:pRect];
        _pageControl.numberOfPages = pageNumber;
        _pageControl.userInteractionEnabled =NO;
        _pageControl.pageIndicatorTintColor =[UIColor blackColor];//RGBA(255,255,255,0.5); //默认未选中颜色
        _pageControl.currentPageIndicatorTintColor =[UIColor redColor];//[UIColor whiteColor]; //默认选中颜色
        [self addSubview:_pageControl];
    }
    
    return self;
}

//请求来的图片
-(void)setTheImageUrlArray:(NSArray *)imageUrlArray andplaceholderImage:(UIImage *)defaultImage
{
    self.imageUrlArray = [[NSArray alloc] initWithArray:imageUrlArray];
    for (int i =0;i<[_imageUrlArray count]+2;i++){
        UIImageView * imageView = [[UIImageView alloc] initWithFrame:CGRectMake(UI_SCREEN_WIDTH*i, 0, UI_SCREEN_WIDTH, _myScrollView.frame.size.height)];
        if (i == 0){
            [imageView setImageWithURL:[_imageUrlArray objectAtIndex:[_imageUrlArray count]-1] placeholderImage:defaultImage];
        }else if(i == [_imageUrlArray count]+1){
            [imageView setImageWithURL:[_imageUrlArray objectAtIndex:0] placeholderImage:defaultImage];
        }else{
            imageView.userInteractionEnabled =YES;
            UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imageClick:)];
            imageView.tag =gesture_tag+i;
            [imageView addGestureRecognizer:tap];
            [imageView setImageWithURL:[_imageUrlArray objectAtIndex:i-1] placeholderImage:defaultImage];
        }
        [_myScrollView addSubview:imageView];
    }
    [self performSelector:@selector(createTimer) withObject:nil afterDelay:0];
}

-(void)createTimer
{
    myTimer = [NSTimer scheduledTimerWithTimeInterval:TimeSeconds target:self selector:@selector(runTimePage) userInfo:nil repeats:YES];
    //[self closeTimerTask];
}

//固定的图片
-(void)setTheImageArray:(NSArray *)imageArray
{
    self.imageArray = [[NSArray alloc] initWithArray:imageArray];
    if (ARRAY_IS_NOT_EMPTY(_imageArray)){
        for (int i = 0; i <imageArray.count+2;i++){
            UIImageView * imageView = [[UIImageView alloc] initWithFrame:CGRectMake(UI_SCREEN_WIDTH*i, 0, UI_SCREEN_WIDTH, _myScrollView.frame.size.height)];
            if (i == 0){
                imageView.image = [UIImage imageNamed:[_imageArray objectAtIndex:[_imageArray count]-1]];
            }else if(i == [_imageArray count]+1){
                imageView.image = [UIImage imageNamed:[_imageArray objectAtIndex:0]];
            }else{
                imageView.image = [UIImage imageNamed:[_imageArray objectAtIndex:i-1]];
                imageView.userInteractionEnabled =YES;
                UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imageClick:)];
                imageView.tag =gesture_tag+i;
                [imageView addGestureRecognizer:tap];
            }
            [_myScrollView addSubview:imageView];
        }
    }
    [self performSelector:@selector(createTimer) withObject:nil afterDelay:0];
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat pagewidth = scrollView.frame.size.width;
    CGPoint point = scrollView.contentOffset;
    int currentPage = floor((point.x - pagewidth / 2)/pagewidth) + 1;
    currentPage--;
    _pageControl.currentPage = currentPage;
}

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    CGFloat pagewidth = scrollView.frame.size.width;
    CGPoint point = scrollView.contentOffset;
    int currentPage = floor((point.x - pagewidth / 2)/pagewidth) + 1;
    if (currentPage==0)
    {
        [scrollView scrollRectToVisible:CGRectMake(320 * pageNumber,0,320,460) animated:NO]; // 序号0 最后1页
    }
    else if (currentPage==pageNumber+1)
    {
        [scrollView scrollRectToVisible:CGRectMake(320,0,320,460) animated:NO]; // 最后+1,循环第1页
    }
}

// pagecontrol 选择器的方法
- (void)turnPage
{
    int page = _pageControl.currentPage; // 获取当前的page
    BOOL isanimated=YES;
    if (page == 0||page == pageNumber){
        isanimated=NO;
    }
    [_myScrollView scrollRectToVisible:CGRectMake(320*(page+1),0,320,460) animated:isanimated]; // 触摸pagecontroller那个点点 往后翻一页 +1
}

// 定时器 绑定的方法
- (void)runTimePage
{
    int page = _pageControl.currentPage; // 获取当前的page
    page++;
    page = page > pageNumber-1 ? 0 : page ;
    _pageControl.currentPage = page;
    [self turnPage];

}

//开启定时器
-(void)openTimerTask
{
    [myTimer setFireDate:[NSDate distantPast]];
}

//关闭定时器
-(void)closeTimerTask
{
    [myTimer setFireDate:[NSDate distantFuture]];
}

-(void)imageClick:(UITapGestureRecognizer *)sender
{
    DDLOG_CURRENT_METHOD;
    [_delegate gestureClick:sender];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
