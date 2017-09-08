//
//  XWagreeMentVC.m
//  zhangshangPacket
//
//  Created by zhenhui huang on 2017/6/28.
//  Copyright © 2017年 apple-fangqiu. All rights reserved.
//

#import "XWagreeMentVC.h"
@interface XWagreeMentVC ()<UIScrollViewDelegate>

@end

@implementation XWagreeMentVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = MainBGColor;
    
    UIView *topView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenW, 64)];
    topView.backgroundColor = MainRedColor;
    [self.view addSubview:topView];
    
    UIView *titleView = [[UIView alloc]initWithFrame:CGRectMake(0, 20, ScreenW, 44)];
    titleView.backgroundColor = MainRedColor;
    [topView addSubview:titleView];
    
    UIButton *button = [[UIButton alloc]init];
    [titleView addSubview:button];
    [button setImage:MyImage(@"btn_back") forState:0];
    [button addTarget:self action:@selector(dismissTheAgree) forControlEvents:UIControlEventTouchDown];
    [button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(titleView);
        make.left.mas_equalTo(15);
        make.width.mas_equalTo(15);
        make.height.mas_equalTo(30);
    }];
    
    // 设置导航栏标题变大
    UILabel *label = [[UILabel alloc]init];
    label.textColor = [UIColor whiteColor];
    label.text = @"用户协议";
    label.font = [UIFont systemFontOfSize:18];
    [titleView addSubview:label];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.view);
        make.centerY.mas_equalTo(titleView);
        make.width.mas_equalTo(80);
        make.height.mas_equalTo(40);
    }];
    
    UIScrollView *scrollView = [[UIScrollView alloc]initWithFrame:Frame(0, 64, IPHONE_W, IPHONE_H-64)];
    scrollView.contentSize = CGSizeMake(0, 0);
    scrollView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    scrollView.delegate = self;
    [scrollView setShowsVerticalScrollIndicator:YES];//关闭滚动条
    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"协议" ofType:@"txt"];
    NSString *text = [[NSString alloc]initWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
    UIFont *LabFont = [UIFont systemFontOfSize:15 ];
    CGSize LabSize = CGSizeMake(IPHONE_W-20, MAXFLOAT);
    CGRect LabRect = [text boundingRectWithSize:LabSize options:(NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading) attributes:[NSDictionary dictionaryWithObject:LabFont forKey:NSFontAttributeName]  context:nil];
    
    UILabel *textLab = [[UILabel alloc]initWithFrame:Frame(10, 5, IPHONE_W-20, LabRect.size.height)];
    textLab.textColor = MainTextColor;
    textLab.font = [UIFont systemFontOfSize:15];
    textLab.numberOfLines = 0;
    textLab.text = text;
    
//    scrollView.contentOffset = CGPointMake(50, 50);
    scrollView.contentSize = CGSizeMake(IPHONE_W, LabRect.size.height+10);
    [scrollView addSubview:textLab];
    [self.view addSubview:scrollView];
    
    
}

- (void)dismissTheAgree{
    [self dismissViewControllerAnimated:YES completion:nil];
}


//设置字体颜色
- (UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;//黑色
}

//设置状态栏颜色
- (void)setStatusBarBackgroundColor:(UIColor *)color {
    
//    UIView *statusBar = [[[UIApplication sharedApplication] valueForKey:@"statusBarWindow"] valueForKey:@"statusBar"];
//    if ([statusBar respondsToSelector:@selector(setBackgroundColor:)]) {
//        statusBar.backgroundColor = color;
//    }
}
//！！！重点在viewWillAppear方法里调用下面两个方法
-(void)viewWillAppear:(BOOL)animated{
    [self preferredStatusBarStyle];
    [self setStatusBarBackgroundColor:MainRedColor];
    
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
