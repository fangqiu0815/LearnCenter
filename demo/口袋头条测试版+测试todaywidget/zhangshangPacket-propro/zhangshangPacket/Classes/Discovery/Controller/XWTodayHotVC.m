//
//  XWTodayHotVC.m
//  zhangshangPacket
//
//  Created by apple on 2017/8/3.
//  Copyright © 2017年 apple-fangqiu. All rights reserved.
//

#import "XWTodayHotVC.h"
#import "XWDisTodayVC.h"
#import "XWDisWeekVC.h"

@interface XWTodayHotVC ()<UIScrollViewDelegate>
@property (nonatomic, strong) NSArray *titleData;
@end

@implementation XWTodayHotVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = MainBGColor;
}

#pragma mark 标题数组
- (NSArray *)titleData {
    if (!_titleData) {
        _titleData = @[@"24小时", @"本周"];
    }
    return _titleData;
}
#pragma mark 初始化代码
- (instancetype)init {
    if (self = [super init]) {
        self.menuBGColor = MainRedColor;
        self.titleSizeNormal = 15;
        self.titleSizeSelected = 16;
        self.showOnNavigationBar = NO;
        self.progressViewIsNaughty = YES;
        self.menuViewStyle = WMMenuViewStyleLine;
        self.menuItemWidth = 80;
        self.menuHeight = 44;
        self.titleColorNormal = NightMainTextColor;
        self.titleColorSelected = MainRedColor;
        self.menuView.lineColor = MainRedColor;
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
            
            XWDisTodayVC   *vcClass = [[XWDisTodayVC alloc] init];
            return vcClass;
        }
            break;
            
        default:{
            
            XWDisWeekVC *vcClass = [[XWDisWeekVC alloc]init];
            return vcClass;
        }
            break;
    }
    
    
}

#pragma mark 返回index对应的标题
- (NSString *)pageController:(WMPageController *)pageController titleAtIndex:(NSInteger)index {
    
    return self.titleData[index];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self preferredStatusBarStyle];
    self.navigationController.navigationBar.translucent = NO;
    self.navigationController.navigationBar.dk_barTintColorPicker = DKColorPickerWithColors(MainRedColor,NightMainNaviColor,MainRedColor);
    self.menuView.dk_backgroundColorPicker = DKColorPickerWithColors(WhiteColor,NightMainNaviColor,MainRedColor);
    
    // 设置导航栏标题变大
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(ScreenW/2, self.view.yj_centerX, 80, 40)];
    label.textColor = [UIColor whiteColor];
    label.text = @"热门文章";
    label.font = [UIFont systemFontOfSize:18];
    self.navigationItem.titleView = label;
    
    
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
