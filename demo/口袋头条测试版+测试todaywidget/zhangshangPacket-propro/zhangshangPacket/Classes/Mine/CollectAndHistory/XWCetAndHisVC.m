//
//  XWCetAndHisVC.m
//  zhangshangPacket
//
//  Created by apple on 2017/7/21.
//  Copyright © 2017年 apple-fangqiu. All rights reserved.
//

#import "XWCetAndHisVC.h"
#import "XWCollectVC.h"
#import "XWHistoryVC.h"

@interface XWCetAndHisVC ()<UIScrollViewDelegate>

//@property (nonatomic, weak) UIView *topView;
//
//@property (nonatomic, weak) UIView *lineView;
//
//@property (nonatomic, weak) UIScrollView *contentScrollView;
////收藏按钮
//@property (nonatomic, weak) UIButton *collectBtn;
////历史按钮
//@property (nonatomic, weak) UIButton *historyBtn;
//
//@property (nonatomic, weak) UIButton *lastBtn;

@property (nonatomic, strong) NSArray *titleData;


@end

@implementation XWCetAndHisVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = MainBGColor;

    
    
//    self.automaticallyAdjustsScrollViewInsets = NO;
//    [self addContentScrollView];
//    [self addTopView];
//    [self addChildViewController:[XWCollectVC new]];
//    [self addChildViewController:[XWHistoryVC new]];
//    [self selectBtn:self.collectBtn];


}

#pragma mark 标题数组
- (NSArray *)titleData {
    if (!_titleData) {
        _titleData = @[@"收藏", @"历史"];
    }
    return _titleData;
}
#pragma mark 初始化代码
- (instancetype)init {
    if (self = [super init]) {
        self.menuBGColor = MainRedColor;
        self.titleSizeNormal = 15;
        self.titleSizeSelected = 16;
        self.titleColorNormal = MainBGColor;
        self.titleColorSelected = WhiteColor;
        self.showOnNavigationBar = YES;
        self.progressViewIsNaughty = YES;
        self.menuViewStyle = WMMenuViewStyleLine;
        self.menuItemWidth = 50;
        self.menuHeight = 44;
    }
    return self;
}

#pragma mark 返回子页面的个数
- (NSInteger)numbersOfChildControllersInPageController:(WMPageController *)pageController {
    return self.titleData.count;
}

#pragma mark 返回某个index对应的页面
- (UIViewController *)pageController:(WMPageController *)pageController viewControllerAtIndex:(NSInteger)index {
    
    
    switch (index) {
        case 0:{
            
            XWCollectVC   *vcClass = [[XWCollectVC alloc] init];
            return vcClass;
        }
            break;
            
        default:{
            
            XWHistoryVC *vcClass = [[XWHistoryVC alloc]init];
            return vcClass;
        }
            break;
    }
    
    
}

#pragma mark 返回index对应的标题
- (NSString *)pageController:(WMPageController *)pageController titleAtIndex:(NSInteger)index {
    
    return self.titleData[index];
}



//- (void)addTopView
//{
//    UIView *topView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.yj_width, 64)];
//    topView.backgroundColor = MainRedColor;
//    self.topView = topView;
//    [self.view addSubview:topView];
//    
//   // UIButton *backBtn = [[UIButton alloc]initWithFrame:CGRectMake(15, 25, 20, 40)];
//   // [topView addSubview:backBtn];
//   // [backBtn setImage:MyImage(@"btn_back") forState:0];
//   // [backBtn addTarget:self action:@selector(backClick) forControlEvents:UIControlEventTouchUpInside];
//
//    for (int i = 0 ;i<2; i++) {
//        
//        UIButton *titleBtn = [[UIButton alloc]init];
//        [self.topView addSubview:titleBtn];
//        
//        [titleBtn setTitleColor:WhiteColor forState:0];
//        
//        if(i == 0){
//            self.collectBtn = titleBtn;
//            [titleBtn setTitle:@"收藏" forState:0];
//        }else{
//            self.historyBtn = titleBtn;
//            [titleBtn setTitle:@"历史" forState:0];
//        }
//        
//        [titleBtn sizeToFit];
//        titleBtn.tag = i;
//        titleBtn.titleLabel.font = [UIFont systemFontOfSize:18];
//        titleBtn.backgroundColor = [UIColor clearColor];
//        
//        WeakType(self);
//        titleBtn.clickBtn=^(UIButton *btn){
//            [weakself selectBtn:btn];
//        };
//    }
//
//    [self addBtnLine];
//
//}
//
//- (void)backClick
//{
//    [self.navigationController popViewControllerAnimated:YES];
//}
//
//
//-(void)viewWillLayoutSubviews{
//    
//    [super viewWillLayoutSubviews];
//    
//    CGFloat leftMargin=0;
//    CGFloat midMargin=0;
//    if(iphoneSE){
//        leftMargin=16;
//        midMargin=13;
//    }else if (iphone7){
//        leftMargin=30;
//        midMargin=20;
//    }else if (iphone7p){
//        leftMargin=48;
//        midMargin=27;
//    }else{
//        leftMargin=10;
//        midMargin=8;
//    }
//    [self.collectBtn mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(self.view.mas_left).offset(ScreenW*0.3);
//        make.bottom.offset(0);
//    }];
//    
//    [self.historyBtn mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(self.view.mas_left).offset(ScreenW*0.6);
//        make.bottom.offset(0);
//    }];
//    
//    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.bottom.offset(0);
//        make.centerX.equalTo(self.collectBtn);
//        make.width.equalTo(self.collectBtn);
//        make.height.mas_equalTo(2);
//    }];
//    
//}
//
//-(void)selectBtn :(UIButton *)btn{
//    
//    NSInteger index = btn.tag;
//    self.lastBtn.transform = CGAffineTransformMakeScale(1, 1);
//    self.lastBtn.selected = NO;
//    btn.transform = CGAffineTransformMakeScale(1.2, 1.2);
//    btn.selected = YES;
//    self.lineView.yj_width = btn.titleLabel.yj_width*1.2;
//    [UIView animateWithDuration:0.3 animations:^{
//        self.lineView.yj_centerX = btn.yj_centerX;
//    }];
//    //点击使scrollView偏移到指定位置
//    self.contentScrollView.contentOffset=CGPointMake(index*self.contentScrollView.yj_width, 0);
//    
//    self.lastBtn = btn;
//    
//    UIViewController *tc = self.childViewControllers[btn.tag];
//    
//    if(tc.view.superview){
//        return;
//    }
//    tc.view.frame = CGRectMake(btn.tag*ScreenW, 0, self.contentScrollView.yj_width, self.contentScrollView.yj_height);
//    
//    [self.contentScrollView addSubview:tc.view];
//    
//}
//
//-(void)addBtnLine{
//    UIView *lineView = [[UIView alloc]init];
//    self.lineView = lineView;
//    self.lineView.yj_centerX = self.collectBtn.yj_centerX;
//    lineView.backgroundColor = WhiteColor;
//    [self.topView addSubview:lineView];
//}
//
//-(void)addContentScrollView{
//    UIScrollView *contentScrollView=[[UIScrollView alloc]init];
//    [self.view addSubview:contentScrollView];
//    contentScrollView.frame = CGRectMake(0, 64, self.view.yj_width, self.view.yj_height-64);
//    contentScrollView.showsHorizontalScrollIndicator = NO;
//    contentScrollView.contentSize=CGSizeMake(self.view.bounds.size.width*3, 0);
//    contentScrollView.bounces=NO;
//    contentScrollView.pagingEnabled=YES;
//    contentScrollView.delegate=self;
//    self.contentScrollView=contentScrollView;
//}
//
//#pragma mark - scrollView已经减速后调用按钮点击事件
//-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
//    
//    NSInteger index=scrollView.contentOffset.x/ScreenW;
//    [self selectBtn:self.topView.subviews[index]];
//}
//
//#pragma mark - scrollView滚动半个屏幕宽度时滑动下划线
//-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
//    
//    NSInteger index = (scrollView.contentOffset.x/ScreenW)+0.5;
//    UIButton *btn = self.topView.subviews[index];
//    self.lastBtn.transform = CGAffineTransformMakeScale(1, 1);
//    self.lastBtn.selected = NO;
//    btn.transform = CGAffineTransformMakeScale(1.2, 1.2);
//    btn.selected = YES;
//    [UIView animateWithDuration:0.3 animations:^{
//        
//        self.lineView.yj_width = btn.titleLabel.yj_width*1.2;
//        self.lineView.yj_centerX = btn.yj_centerX;
//    }];
//    self.lastBtn = btn;
//}


-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self preferredStatusBarStyle];
    self.navigationController.navigationBar.translucent = NO;
    self.navigationController.navigationBar.dk_barTintColorPicker = DKColorPickerWithColors(MainRedColor,NightMainNaviColor,MainRedColor);
    self.menuView.dk_backgroundColorPicker = DKColorPickerWithColors(MainRedColor,NightMainNaviColor,MainRedColor);
}

- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;

}



-(void)dealloc{
    JLLog(@"%@",self);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
