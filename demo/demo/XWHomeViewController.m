//
//  XWHomeViewController.m
//  zhangshangPacket
//
//  Created by apple on 2017/5/25.
//  Copyright © 2017年 apple-fangqiu. All rights reserved.
//

#import "XWHomeViewController.h"
#import "XWHomeChooseItemVC.h"
#import "XWHobbyItemManager.h"
#import "XWHobbyItemModel.h"
#import "FQTestViewC.h"



@interface XWHomeViewController ()<WMMenuViewDelegate,WMMenuViewDataSource,WMPageControllerDelegate,WMPageControllerDataSource,WMMenuItemDelegate>
{
    UIButton *_button;
    UIWindow *_window;
    NSMutableArray *_dataArr;
}

@property (nonatomic, strong) NSMutableArray *titleData;
@property (nonatomic, strong) NSMutableArray *IDData;

@property (nonatomic, weak) XWHobbyItemManager *manager;

@property (nonatomic, strong) NSMutableArray<XWHobbyItemModel *>* topChannelArr;

@property (nonatomic, strong) NSMutableArray<XWHobbyItemModel *>* bottomChannelArr;

@property (nonatomic, strong) NSMutableArray *topTitleArr;


@end

@implementation XWHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    [self setupUI];
    
}


//设置字体颜色
- (UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;//白色
}

//设置状态栏颜色
- (void)setStatusBarBackgroundColor:(UIColor *)color {
    
//    UIView *statusBar = [[[UIApplication sharedApplication] valueForKey:@"statusBarWindow"] valueForKey:@"statusBar"];
//    if ([statusBar respondsToSelector:@selector(setBackgroundColor:)]) {
//        statusBar.backgroundColor = color;
//    }
    
}

- (void)setupUI
{
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeUserChannelItem:) name:@"ChangeUserChannelsItem" object:nil];

}

- (void)changeUserChannelItem:(NSNotification *)noti
{
    NSMutableArray *dataArr = [noti.userInfo[@"topChannelArr"] mutableCopy];
//    [self.titleData removeAllObjects];
    for (int i = 0; i<dataArr.count; i++) {
        XWHobbyItemModel *model = dataArr[i];
        [self.titleData addObject:model.channel_name];
    }
    
    [self reloadData];
    NSLog(@"dataarr---%@\nself.totledata---%@",dataArr,self.titleData);
}

//！！！重点在viewWillAppear方法里调用下面两个方法
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self preferredStatusBarStyle];
    [self setStatusBarBackgroundColor:MainRedColor];
    self.navigationController.navigationBar.translucent = NO;
    self.navigationItem.titleView = [[UIImageView alloc]initWithImage:MyImage(@"icon_logo")];
    self.navigationController.navigationBar.barTintColor = MainRedColor;
//    self.menuView.backgroundColor = WhiteColor;
//    
//    self.titleColorNormal = NightMainTextColor;
//    self.titleColorSelected = MainRedColor;
//    self.menuView.lineColor = MainRedColor;

    self.hidesBottomBarWhenPushed = NO;
    
    
}

- (NSMutableArray *)titleData
{
    if (!_titleData) {
        _titleData = [NSMutableArray array];
    }
    return _titleData;
}

- (instancetype)init
{
    if (self = [super init]) {
        self.titleData = STUserDefaults.mainfuncs;

        self.menuView.backgroundColor = WhiteColor;
        self.menuViewStyle = WMMenuViewStyleLine;
        self.titleSizeNormal = RemindFont(14, 15, 16);
        self.titleSizeSelected = RemindFont(16, 17, 18);
        self.menuView.lineColor = MainRedColor;
        self.menuView.delegate = self;
        self.menuView.dataSource = self;
        self.titleColorNormal = NightMainTextColor;
        self.titleColorSelected = MainRedColor;
        self.progressViewIsNaughty = YES;
        self.progressViewCornerRadius = 5.0;
        if (self.titleData.count > 5) {
            self.menuItemWidth = 60;
        } else {
            self.menuItemWidth = (ScreenW) / self.titleData.count;
        }
        
        self.showOnNavigationBar = NO;
        
        //添加右侧加号按钮
        UIButton *plusBtn = [[UIButton alloc]initWithFrame:CGRectMake(ScreenW-44, 0, 44, 44)];
        plusBtn.backgroundColor = WhiteColor;
        [plusBtn setImage:MyImage(@"icon_editor_add_red") forState:0];
        [plusBtn addTarget:self action:@selector(plusClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:plusBtn];
    }
    return self;
}

- (CGRect)pageController:(WMPageController *)pageController preferredFrameForMenuView:(WMMenuView *)menuView {
    return CGRectMake(0, 0, self.view.frame.size.width - 44, 44);

}

- (void)plusClick:(UIButton *)sender
{
    XWHomeChooseItemVC *chooseItemVC = [[XWHomeChooseItemVC alloc]init];
    chooseItemVC.hidesBottomBarWhenPushed  = YES;
    self.titleData = chooseItemVC.dataArray;
    [self presentViewController:chooseItemVC animated:YES completion:nil];
    
}

- (NSInteger)numbersOfChildControllersInPageController:(WMPageController *)pageController {
    return self.titleData.count;
}

- (UIViewController *)pageController:(WMPageController *)pageController viewControllerAtIndex:(NSInteger)index {
    
    FQTestViewC *VC = [[FQTestViewC alloc] init];
//    XBPlanCatModel *model = self.catModelArr[index];
//    VC.tags = model.tags;
//    VC.cat_id = model.ID;
    return VC;
}

#pragma mark 返回index对应的标题
- (NSString *)pageController:(WMPageController *)pageController titleAtIndex:(NSInteger)index {
    self.selectItemIndex = [self.titleData[index] integerValue];
    return self.titleData[index];
}



- (void)dealloc
{
    NSLog(@"dealloc");
    [[NSNotificationCenter defaultCenter] removeObserver:self];


}

-(BOOL)isBlankString:(NSString *)string {
    if (string == nil || string == NULL) {
        return YES;
    }
    if ([string isKindOfClass:[NSNull class]]) {
        return YES;
    }
    if ([[string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] length]==0) {
        return YES;
    }
    if ([string isEqualToString:@"(null)"]) {
        return YES;
    }
    if ([string isEqualToString:@"<null>"]) {
        return YES;
    }
    return NO;
}






@end
