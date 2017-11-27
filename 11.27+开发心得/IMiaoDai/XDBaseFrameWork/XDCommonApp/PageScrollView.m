//
//  PageScrollView.m
//  NeedYouPower
//
//  Created by XD-XY on 7/2/14.
//  Copyright (c) 2014 XD-XY. All rights reserved.
//

#import "PageScrollView.h"
#import "UIImageView+WebCache.h"
#import "UIImageView+category.h"

#define bg_color RGBA(100,100,100,0)
#define TimeSeconds 3.0f
#define gesture_tag 10000

@implementation PageScrollView

- (id)initWithFrame:(CGRect)frame andPageControllRect:(CGRect)rect
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.backgroundColor = bg_color;
        imgCount = 0;
        self.scrollView = [[UIScrollView alloc] initWithFrame:frame];
        _scrollView.contentSize = CGSizeZero;
        _scrollView.backgroundColor = bg_color;
        _scrollView.delegate = self;
        _scrollView.showsHorizontalScrollIndicator =NO;
        _scrollView.showsVerticalScrollIndicator = NO;
        _scrollView.pagingEnabled =YES;
        [self addSubview:_scrollView];
     
        self.pageControl = [[UIPageControl alloc] initWithFrame:rect];
        _pageControl.backgroundColor = [UIColor clearColor];
        _pageControl.numberOfPages = 0;
        _pageControl.userInteractionEnabled =NO;
        _pageControl.pageIndicatorTintColor =[UIColor blackColor];       //默认未选中颜色
        _pageControl.currentPageIndicatorTintColor =[UIColor redColor];//默认选中颜色
        [self addSubview:_pageControl];
    }
    return self;
}

-(void)createTimer
{
    myTimer = [NSTimer scheduledTimerWithTimeInterval:TimeSeconds target:self selector:@selector(runTimePage) userInfo:nil repeats:YES];
}

// pagecontrol 选择器的方法
- (void)turnPage
{
    int page = (int)_pageControl.currentPage; // 获取当前的page
    BOOL isanimated=YES;
    if (page == 0||page == imgCount){
        isanimated= NO;
    }
    [_scrollView scrollRectToVisible:CGRectMake(320*(page+1),0,320,460) animated:isanimated]; // 触摸pagecontroller那个点点 往后翻一页 +1
}

// 定时器 绑定的方法
- (void)runTimePage
{
    int page =(int) _pageControl.currentPage; // 获取当前的page
    page++;
    page = page > imgCount-1 ? 0 : page ;
    _pageControl.currentPage = page;
    [self turnPage];
    
}

//开启定时器
-(void)openTimerTask
{
    isRunning = YES;
    [myTimer setFireDate:[NSDate distantPast]];
}

//关闭定时器
-(void)closeTimerTask
{
    isRunning = NO;
    [myTimer setFireDate:[NSDate distantFuture]];
}


-(void)setImageUrlArray:(NSMutableArray *)imageUrlArray
{
    [self closeTimerTask];
    myTimer = nil;
    if (_imageUrlArray!=nil){
        [_imageUrlArray removeAllObjects];
    }
    _imageUrlArray = imageUrlArray;
    [self createTimer];
    if(imgCount !=[_imageUrlArray count]){
        
        for (UIView * view in _scrollView.subviews){
            [view removeFromSuperview];
        }
        
        imgCount = (int)[_imageUrlArray count];
        _scrollView.contentOffset = CGPointMake(UI_SCREEN_WIDTH, 0);
        _scrollView.contentSize =CGSizeMake(UI_SCREEN_WIDTH*(imgCount+2), _scrollView.frame.size.height);
        _pageControl.numberOfPages =imgCount;
        
        for (int i = 0 ; i <[_imageUrlArray count]+2;i++){
            UIImageView * imageView = [UIImageView initImageViewRect:CGRectMake(UI_SCREEN_WIDTH*i, 0, UI_SCREEN_WIDTH, _scrollView.frame.size.height) andImage:nil andUserInteractionEnabled:NO];
            imageView.contentMode = UIViewContentModeScaleAspectFit;
            imageView.backgroundColor = [UIColor whiteColor];
            [self addSubview:imageView];
            UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imageClick:)];
            imageView.tag = 10001;
            [imageView addGestureRecognizer:tap];
            
            NSString * imageUrl;
            
            if (i == 0){
                imageUrl = [[_imageUrlArray objectAtIndex:[_imageUrlArray count]-1] objectForKey:@"image_url"];
            }else if(i == [_imageUrlArray count]+1){
                imageUrl = [[_imageUrlArray objectAtIndex:0] objectForKey:@"image_url"];
            }else{
                imageView.userInteractionEnabled =YES;
                UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imageClick:)];
                [imageView addGestureRecognizer:tap];
                
                imageUrl = [[_imageUrlArray objectAtIndex:i-1] objectForKey:@"image_url"];
                imageView.tag = gesture_tag+i;
            }
            [_scrollView addSubview:imageView];
    
            [imageView setImageWithURL:[NSURL URLWithString:imageUrl] placeholderImage:self.placeholderImg options:SDWebImageRefreshCached completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType) {
//                if (!error){
//                    if (!myTimer.isValid){
//                        [self createTimer];
//                    }
//                }
            }];
            
        }
    }else{
        if ([_imageUrlArray count]==0){
            return;
        }
        for(int i = 0;i <[_imageUrlArray count]+2;i++){
            if (i <[_scrollView.subviews count]){
                NSString * imageUrl;
                if (i == 0){
                    imageUrl = [[_imageUrlArray objectAtIndex:[_imageUrlArray count]-1] objectForKey:@"image_url"];
                }else if(i == [_imageUrlArray count]+1){
                    imageUrl = [[_imageUrlArray objectAtIndex:0] objectForKey:@"image_url"];
                }else{
                    imageUrl = [[_imageUrlArray objectAtIndex:i-1] objectForKey:@"image_url"];
                }
                UIImageView * imageView =(UIImageView *)[_scrollView.subviews objectAtIndex:i];
                imageView.image = nil;
                [imageView setImageWithURL:[NSURL URLWithString:imageUrl]
                             placeholderImage:self.placeholderImg
                                      options:SDWebImageRefreshCached
                                    completed:^(UIImage *image, NSError * error, SDImageCacheType cacheType) {

                                    }];
            }
        }
    }
}

-(void)imageClick:(UITapGestureRecognizer *)sender
{
    UIImageView * iv =(UIImageView *)sender.view;
    int number = (int)iv.tag;
    [_delegate gestureClick:sender andUrl:[NSString stringWithFormat:@"%d",number-gesture_tag]];
}

#pragma mark - UIScrollView Delegate

-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat pagewidth = scrollView.frame.size.width;
    CGPoint point = scrollView.contentOffset;
    int currentPage = floor((point.x - pagewidth / 2)/pagewidth) + 1;
//    NSLog(@"currentPage = %d",currentPage);
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
        [scrollView scrollRectToVisible:CGRectMake(320 * imgCount,0,320,460) animated:NO]; // 序号0 最后1页
    }
    else if (currentPage==imgCount+1)
    {
        [scrollView scrollRectToVisible:CGRectMake(320,0,320,460) animated:NO]; // 最后+1,循环第1页
    }
}

-(void)layoutSubviews
{
    DDLOG_CURRENT_METHOD;
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
