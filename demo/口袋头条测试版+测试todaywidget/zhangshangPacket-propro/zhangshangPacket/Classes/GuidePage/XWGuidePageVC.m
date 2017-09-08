//
//  XWGuidePageVC.m
//  zhangshangPacket
//
//  Created by apple on 2017/5/11.
//  Copyright © 2017年 apple-fangqiu. All rights reserved.
//

#import "XWGuidePageVC.h"

@interface XWGuidePageVC ()<UIScrollViewDelegate>

@property (nonatomic ,strong) UIScrollView *scrollV;

@property (nonatomic ,strong) UIPageControl *pageC;

@end

@implementation XWGuidePageVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self preferredStatusBarStyle];

    [self setTheGuideVisitorsLayout];
}

//设置字体颜色
- (UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;//白色
}

-(void)setTheGuideVisitorsLayout
{
    NSString *ImgPath = [[NSBundle mainBundle]pathForResource:@"XWGuidePageVC" ofType:@"plist"];
    //图片组
    NSMutableArray *imgArr = [[NSMutableArray alloc]initWithContentsOfFile:ImgPath];
    _scrollV = [[UIScrollView alloc]initWithFrame:CGRectMake(0,0, ScreenW,ScreenH)];
    _scrollV.delegate = self;
    //设置滚动视图属性
    _scrollV.pagingEnabled = YES;
    _scrollV.bounces = NO;
    _scrollV.showsHorizontalScrollIndicator = NO;
    _scrollV.showsVerticalScrollIndicator = NO;
    //滚动范围设置
    _scrollV.contentSize = CGSizeMake(imgArr.count*ScreenW, 0);
    for (int i = 0; i < imgArr.count; i++) {
        UIImageView *img = [[UIImageView alloc]initWithFrame:CGRectMake(i*ScreenW, 0,ScreenW,ScreenH)];
        //图片赋值
        img.image = MyImage(imgArr[i]);
        img.userInteractionEnabled = YES;
        
        if (i == imgArr.count - 1) {
            UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
            
            btn.frame = CGRectMake(112 * AdaptiveScale_W, ScreenH -90 * AdaptiveScale_W,  152 * AdaptiveScale_W, 44 * AdaptiveScale_W);
            
            [btn setImage:[UIImage imageNamed:@"icon_guide_con"] forState:UIControlStateNormal];
            [btn addTarget:self action:@selector(tapAction) forControlEvents:UIControlEventTouchUpInside];
            [img addSubview:btn];
        }
        [_scrollV addSubview:img];
    }
    
    [self.view addSubview:_scrollV];
    
}


#pragma mark UIScrollView delegate
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    int currPage = scrollView.contentOffset.x/ScreenW;
    _pageC.currentPage = currPage;
}


#pragma mark ColseGuid
-(void)tapAction
{
    NSString *version = SYS_NEWS_VERSION;
    STUserDefaults.sysversion = version;
    
    // 当前用户是否进行登录 默认是不登录
    self.view.window.rootViewController = self.tabBarVC;
    
    
}

-(UIViewController *)getTheRootController
{
    NSString *version = SYS_NEWS_VERSION;
    if ([version isEqualToString:STUserDefaults.sysversion])
    {
        
        return self.tabBarVC;
        
    }else
    {
        return self;
    }
    
}

- (XWLoginVC *)loginVC
{
    if (_loginVC == nil) {
        _loginVC = [XWLoginVC new];
    }
    return _loginVC;
}


#pragma mark get
-(XWTabBarVC *)tabBarVC
{
    if (_tabBarVC == nil)
    {
        _tabBarVC = [XWTabBarVC new];
    }
    return _tabBarVC;
}

- (void)dealloc
{
    JLLog(@"dealloc");
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}




@end
