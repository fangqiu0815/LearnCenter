//
//  XWNavigationVC.m
//  zhangshangnews
//
//  Created by apple on 2017/5/8.
//  Copyright © 2017年 apple-fangqiu. All rights reserved.
//

#import "XWNavigationVC.h"
#import "UIBarButtonItem+Item.h"

@interface XWWrapViewController : UIViewController

@property (nonatomic, strong, readonly) UIViewController *rootViewController;
+ (XWWrapViewController *)wrapViewControllerWithViewController:(UIViewController *)viewController;

@end

@interface XWWrapNavigationController : UINavigationController

@end

@interface XWNavigationVC()<UINavigationControllerDelegate, UIGestureRecognizerDelegate>

@property (nonatomic, strong) UIPanGestureRecognizer *popPanGesture;
@property (nonatomic, strong) id popGestureDelegate;

@end


@implementation XWWrapViewController

static NSValue *xw_tabBarRectValue;

+ (XWWrapViewController *)wrapViewControllerWithViewController:(UIViewController *)viewController {
    
    XWWrapNavigationController *wrapNavController = [[XWWrapNavigationController alloc] init];
    wrapNavController.viewControllers = @[viewController];
    XWWrapViewController *wrapViewController = [[XWWrapViewController alloc] init];
    [wrapViewController.view addSubview:wrapNavController.view];
    [wrapViewController addChildViewController:wrapNavController];
    
    return wrapViewController;
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    
    if (self.tabBarController && !xw_tabBarRectValue) {
        xw_tabBarRectValue = [NSValue valueWithCGRect:self.tabBarController.tabBar.frame];
    }
    
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    if (self.tabBarController && [self rootViewController].hidesBottomBarWhenPushed) {
        self.tabBarController.tabBar.frame = CGRectZero;
    }
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.tabBarController.tabBar.translucent = YES;
    if (self.tabBarController && !self.tabBarController.tabBar.hidden && xw_tabBarRectValue) {
        self.tabBarController.tabBar.frame = xw_tabBarRectValue.CGRectValue;
    }
}

- (BOOL)jt_fullScreenPopGestureEnabled {
    return [self rootViewController].xw_fullScreenPopGestureEnabled;
}

- (BOOL)hidesBottomBarWhenPushed {
    return [self rootViewController].hidesBottomBarWhenPushed;
}

- (UITabBarItem *)tabBarItem {
    return [self rootViewController].tabBarItem;
}

- (NSString *)title {
    return [self rootViewController].title;
}

- (UIViewController *)childViewControllerForStatusBarStyle {
    return [self rootViewController];
}

- (UIViewController *)childViewControllerForStatusBarHidden {
    return [self rootViewController];
}

- (UIViewController *)rootViewController {
    XWWrapNavigationController *wrapNavController = self.childViewControllers.firstObject;
    return wrapNavController.viewControllers.firstObject;
}

@end


@implementation XWWrapNavigationController

- (UIViewController *)popViewControllerAnimated:(BOOL)animated {
    return [self.navigationController popViewControllerAnimated:animated];
}

- (NSArray<UIViewController *> *)popToRootViewControllerAnimated:(BOOL)animated {
    return [self.navigationController popToRootViewControllerAnimated:animated];
}

- (NSArray<UIViewController *> *)popToViewController:(UIViewController *)viewController animated:(BOOL)animated {
    XWNavigationVC *jt_navigationController = (XWNavigationVC *)viewController.xw_navigationController;
    NSInteger index = [jt_navigationController.xw_viewControllers indexOfObject:viewController];
    return [self.navigationController popToViewController:jt_navigationController.viewControllers[index] animated:animated];
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
    viewController.xw_navigationController = (XWNavigationVC *)self.navigationController;
    viewController.xw_fullScreenPopGestureEnabled = viewController.xw_navigationController.fullScreenPopGestureEnabled;

    viewController.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamedWithRenderOriginal:@"btn_back"] style:UIBarButtonItemStyleDone target:self action:@selector(didTapBackAtion)];
    ;
    
    // 设置日间和夜间两种状态
    viewController.xw_navigationController.navigationBar.dk_barTintColorPicker = DKColorPickerWithColors(MainRedColor,NightMainNaviColor,MainRedColor);
    
    [viewController.xw_navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor],UITextAttributeTextColor,nil]];
    
    viewController.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:[XWWrapViewController wrapViewControllerWithViewController:viewController] animated:animated];
}

- (void)didTapBackAtion {
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)dismissViewControllerAnimated:(BOOL)flag completion:(void (^)(void))completion{
    [self.navigationController dismissViewControllerAnimated:flag completion:completion];
    self.viewControllers.firstObject.xw_navigationController=nil;
}

@end

@implementation XWNavigationVC

- (instancetype)initWithRootViewController:(UIViewController *)rootViewController {
    if (self = [super init]) {
        rootViewController.xw_navigationController = self;
        self.viewControllers = @[[XWWrapViewController wrapViewControllerWithViewController:rootViewController]];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super initWithCoder:aDecoder]) {
        self.viewControllers.firstObject.xw_navigationController = self;
        self.viewControllers = @[[XWWrapViewController wrapViewControllerWithViewController:self.viewControllers.firstObject]];
    }
    return self;
}

+ (void)load
{
    //导航栏字体
    UINavigationBar *navBar = [UINavigationBar appearance];
    
    [navBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:RemindFont(18, 20, 22)],NSForegroundColorAttributeName:[UIColor blackColor]}];
//    UIImage *backgroundImage = [XWCommonFunction createImageWithColor:MainColor];
//    [navBar setBackgroundImage:backgroundImage forBarMetrics:UIBarMetricsDefault];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setNavigationBarHidden:YES];
    self.delegate = self;
    self.navigationController.navigationBar.translucent = NO ;
    self.popGestureDelegate = self.interactivePopGestureRecognizer.delegate;
    SEL action = NSSelectorFromString(@"handleNavigationTransition:");
    self.popPanGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self.popGestureDelegate action:action];
    self.popPanGesture.maximumNumberOfTouches = 1;
    
    
}

#pragma mark - UINavigationControllerDelegate

- (void)navigationController:(UINavigationController *)navigationController didShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
    
    BOOL isRootVC = viewController == navigationController.viewControllers.firstObject;
    
    if (viewController.xw_fullScreenPopGestureEnabled) {
        if (isRootVC) {
            [self.view removeGestureRecognizer:self.popPanGesture];
        } else {
            [self.view addGestureRecognizer:self.popPanGesture];
        }
        self.interactivePopGestureRecognizer.delegate = self.popGestureDelegate;
        self.interactivePopGestureRecognizer.enabled = NO;
    } else {
        [self.view removeGestureRecognizer:self.popPanGesture];
        self.interactivePopGestureRecognizer.delegate = self;
        self.interactivePopGestureRecognizer.enabled = !isRootVC;
    }
    
}

#pragma mark - UIGestureRecognizerDelegate

//修复有水平方向滚动的ScrollView时边缘返回手势失效的问题
-(BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    return YES;
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldBeRequiredToFailByGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    return [gestureRecognizer isKindOfClass:UIScreenEdgePanGestureRecognizer.class];
}

#pragma mark - Getter

- (NSArray *)jt_viewControllers {
    NSMutableArray *viewControllers = [NSMutableArray array];
    for (XWWrapViewController *wrapViewController in self.viewControllers) {
        [viewControllers addObject:wrapViewController.rootViewController];
    }
    return viewControllers.copy;
}


/**
 *  更改状态栏颜色
 */
- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

//设置状态栏是否隐藏
- (BOOL)prefersStatusBarHidden
{
    return NO;
}


@end
