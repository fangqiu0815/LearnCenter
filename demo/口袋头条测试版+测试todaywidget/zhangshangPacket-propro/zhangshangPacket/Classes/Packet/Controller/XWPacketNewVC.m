//
//  XWPacketNewVC.m
//  zhangshangPacket
//
//  Created by apple on 2017/5/16.
//  Copyright © 2017年 apple-fangqiu. All rights reserved.
//

#import "XWPacketNewVC.h"
#import "WheelAnimationView.h"
#import "XWMineVC.h"
@interface XWPacketNewVC ()
{
    UILabel *titleLab;//标题
    UIImageView *bacgroundImageView;//背景图
    UIButton *closeBtn;
    UIButton *myCoinBtn;
    UILabel *explainLab;//说明标签
    UIButton *relationBtn;//关系
    UIView *getWinView;//奖励弹出视图
    UIScrollView *scrollView;
    NSMutableDictionary *winDic;
    BOOL isDownLoadTurnTableArr;
    UIButton *receiveAwardImageView;
}

@property (nonatomic, strong) WheelAnimationView * wAniView;
@property (nonatomic, strong) UIButton *wheelBtn;    //转  btn
@property (nonatomic, strong) UIImageView *myBottomImg;
@property (nonatomic, strong) UIImageView *myCoinImage;
@property (nonatomic, strong) NSMutableArray *prizeListArray;

@end

@implementation XWPacketNewVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"转盘抽奖";
    self.view.backgroundColor = WhiteColor;
    self.navigationController.navigationBar.translucent = NO ;

    //    //改变按钮颜色
    //    self.navigationController.navigationBar.tintColor=[UIColor whiteColor];
    //    //取消返回文字
    //    [[UIBarButtonItem appearance] setBackButtonTitlePositionAdjustment:UIOffsetMake(0, -60)forBarMetrics:UIBarMetricsDefault];
    titleLab = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 70, 20)];
    titleLab.text = @"幸运大转盘";
    titleLab.textAlignment = NSTextAlignmentCenter;
    titleLab.center = CGPointMake(ScreenW/2, 42);
    titleLab.backgroundColor = [UIColor clearColor];
    titleLab.font = [UIFont systemFontOfSize:18];
    titleLab.textColor = WhiteColor;
    self.navigationItem.titleView = titleLab;
    isDownLoadTurnTableArr = NO;
    
    scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, ScreenW, ScreenH)];
    scrollView.bounces = NO;
    scrollView.backgroundColor = [UIColor whiteColor];
    scrollView.contentSize = CGSizeMake(ScreenW, ScreenH + 90);
    //scrollView.pagingEnabled = YES;
    [self.view addSubview:scrollView];
    
    [self createView];

    
}

//设置字体颜色
- (UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;//黑色
}

////设置状态栏颜色
//- (void)setStatusBarBackgroundColor:(UIColor *)color {
//    
//    UIView *statusBar = [[[UIApplication sharedApplication] valueForKey:@"statusBarWindow"] valueForKey:@"statusBar"];
//    if ([statusBar respondsToSelector:@selector(setBackgroundColor:)]) {
//        statusBar.backgroundColor = color;
//    }
//}
//！！！重点在viewWillAppear方法里调用下面两个方法
-(void)viewWillAppear:(BOOL)animated{
    [self preferredStatusBarStyle];
//    [self setStatusBarBackgroundColor:MainRedColor];
    self.tabBarController.tabBar.hidden = YES;
    self.navigationController.navigationBar.barTintColor = MainRedColor;
    self.navigationController.navigationBar.translucent = NO;
    self.navigationController.navigationBar.hidden = YES;


}

- (BOOL)prefersStatusBarHidden{
    return YES;
}

- (void)popToMineViewClick{
    
    NSDictionary *dict = [NSDictionary dictionaryWithObject:myCoinBtn.titleLabel.text forKey:@"Info"];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"sendTurnIngotToMine" object:nil userInfo:dict];
    JLLog(@"123456---%@",myCoinBtn.titleLabel.text);
    
    [self dismissViewControllerAnimated:YES completion:nil];
}


-(void)createView
{
    //背景图
    bacgroundImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0,0, ScreenW, ScreenH+90)];
    bacgroundImageView.image = [UIImage imageNamed:@"bg1"];
    bacgroundImageView.userInteractionEnabled = YES;
    [scrollView addSubview:bacgroundImageView];
    
    //左上角后退按钮
    closeBtn = [[UIButton alloc]init];
    [closeBtn setImage:MyImage(@"btn_back") forState:0];
    [closeBtn addTarget:self action:@selector(popToMineViewClick) forControlEvents:UIControlEventTouchUpInside];
    [scrollView addSubview:closeBtn];
    [closeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15);
        make.top.mas_equalTo(30);
        make.width.mas_equalTo(20*AdaptiveScale_W);
        make.height.mas_equalTo(43*AdaptiveScale_W);
    }];
    
    //每次抽奖消耗元宝数
    relationBtn = [[UIButton alloc]initWithFrame:CGRectMake(ScreenW*0.2, 200*AdaptiveScale_W, ScreenW*0.6, 30)];
    NSString *relationStr = [NSString stringWithFormat:@"每次抽奖需消耗%ld元宝",STUserDefaults.costingot];
    [relationBtn setTitle:relationStr forState:0];
    [relationBtn setTitleColor:WhiteColor forState:0];
    [relationBtn setBackgroundImage:MyImage(@"prompt_bg") forState:0];
    [scrollView addSubview:relationBtn];
    relationBtn.titleLabel.font = [ToolFontFit getFontSizeWithType:TGFontTypeFive size:RemindFont(16, 17, 18)];
    
    //转盘
    int sexWidth = 0;
    if (ScreenW > ScreenH  - 160) {
        sexWidth = ScreenH - 160;
    }else{
        sexWidth = ScreenW;
    }
    ///转盘视图
    WheelAnimationView *animaView = [[WheelAnimationView alloc] initWithFrame:CGRectMake(ScreenW/2 - sexWidth/2, CGRectGetMaxY(relationBtn.frame), sexWidth, sexWidth)];
    self.wAniView = animaView;
    __weak XWPacketNewVC *controller = self;
    animaView.wBlook = ^(BOOL abool)
    {
        //震动
        AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
        controller.wheelBtn.enabled = YES;
        [controller createWinPushView];
    };
    
    //转盘下方阴影
    _myBottomImg = [[UIImageView alloc]initWithFrame:CGRectMake(ScreenW*0.5-50, CGRectGetMaxY(_wAniView.frame)-40, 100, 30)];
    _myBottomImg.image = MyImage(@"shadow");
    [scrollView addSubview:_myBottomImg];
    
    //我的元宝图片
    _myCoinImage = [[UIImageView alloc]initWithFrame:CGRectMake(ScreenW/2.0-80, CGRectGetMaxY(_myBottomImg.frame)-5, 80, 30)];
    _myCoinImage.image = MyImage(@"text_my");
    [scrollView addSubview:_myCoinImage];
    
    //我的元宝个数
    myCoinBtn = [[UIButton alloc]initWithFrame:CGRectMake(ScreenW/2.0+10, CGRectGetMaxY(_myBottomImg.frame)-5, 80, 30)];
    [myCoinBtn setBackgroundImage:MyImage(@"my_money_shown_bg") forState:0];
    NSString *myCoinStr = [NSString stringWithFormat:@"%ld",(long)_allIngot];
    [myCoinBtn setTitle:myCoinStr forState:0];
    [myCoinBtn setTitleColor:WhiteColor forState:0];
    myCoinBtn.titleLabel.font = [ToolFontFit getFontSizeWithType:TGFontTypeSix size:RemindFont(15, 16, 17)];
    [scrollView addSubview:myCoinBtn];
    
    //说明标签
    explainLab = [[UILabel alloc]initWithFrame:CGRectMake(20*ScreenW/375.0, CGRectGetMaxY(_myCoinImage.frame)-10, ScreenW-40*ScreenW/375.0,80)];
    explainLab.numberOfLines = 0;
    explainLab.text = @"兑换项与活动和设备生产商Apple Inc.公司无关,通过非法途径获得奖品的,主办方有权不提供奖品。";
    explainLab.font = [UIFont systemFontOfSize:14];
    explainLab.backgroundColor = [UIColor clearColor];
    explainLab.textColor = BlackColor;
    [scrollView addSubview:explainLab];
    
    [scrollView addSubview:self.wAniView];
    [self.wAniView addSubview:self.wheelBtn];
    
    if ([[[NSUserDefaults standardUserDefaults] objectForKey:@"turntablearr"] isKindOfClass:[NSArray class]]) {
        NSArray *arrtemp = [[NSUserDefaults standardUserDefaults] objectForKey:@"turntablearr"];
        if (arrtemp.count>0){
            _prizeListArray = [[NSMutableArray alloc]initWithArray:arrtemp];
            isDownLoadTurnTableArr = YES;
            [_wAniView setwhooleViewWithArray:self.prizeListArray];
        }
        else
        {
            [self sysTurnTableDataInfo];
            
        }
    }
    else
    {
        [self sysTurnTableDataInfo];
        
    }
}

#pragma mark ================== 系统转盘抽奖奖励数据信息 ==================
- (void)sysTurnTableDataInfo
{
    [SVProgressHUD showWithMaskType:SVProgressHUDMaskTypeBlack];

    [STRequest SysWheelDrawWinWithDataBlock:^(id ServersData, BOOL isSuccess) {
        if (isSuccess){
            [SVProgressHUD dismiss];
            if ([ServersData isKindOfClass:[NSDictionary class]]) {
                if ([ServersData[@"c"] integerValue]==1) {
                    JLLog(@"抽奖接口数据：%@",ServersData);
                    NSDictionary *dicD = ServersData[@"d"];
                    
                    NSArray *arrRlist = dicD[@"wheeldrawinfo"];
                    _prizeListArray = [[NSMutableArray alloc]initWithArray:arrRlist];
                    isDownLoadTurnTableArr = YES;
                    
                    [[NSUserDefaults standardUserDefaults] setObject:_prizeListArray forKey:@"turntablearr"];
                    [_wAniView setwhooleViewWithArray:self.prizeListArray];
                    for (int i=0; i<arrRlist.count; i++) {
                        NSLog(@"%@",arrRlist[i][@"desc"]);
                    }
                    
                }
                else
                {
                    [SVProgressHUD showErrorWithStatus:ServersData[@"m"]];
                    
                }
                
            }
            else
            {
                [SVProgressHUD showErrorWithStatus:@"服务器出错，请重试"];
                
            }
            
        }
        else
        {
            [SVProgressHUD showErrorWithStatus:@"网络故障，请重试!"];
            NSLog(@"失败");
        }
        
        
    }];
    
}

#pragma mark 创建中奖弹出框
-(void)createWinPushView
{
    getWinView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenW, ScreenH+120)];
    getWinView.backgroundColor = [UIColor colorWithWhite:0.3 alpha:0.4];
    [scrollView addSubview:getWinView];
    
    //奖励弹框
    receiveAwardImageView = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, ScreenW, ScreenH)];
    receiveAwardImageView.center = CGPointMake(ScreenW/2.0, ScreenH/2.0);
    receiveAwardImageView.userInteractionEnabled = YES;
    [getWinView addSubview:receiveAwardImageView];
    [receiveAwardImageView addTarget:self action:@selector(getWinHidenAction) forControlEvents:UIControlEventTouchUpInside];
    
    //元宝奖励
    UILabel *jifenLab = [[UILabel alloc]initWithFrame:CGRectMake(60, ScreenH*0.5+50*AdaptiveScale_W, receiveAwardImageView.frame.size.width-60*2, 30)];
    jifenLab.textColor = [UIColor whiteColor];
    jifenLab.textAlignment = 1;
    jifenLab.font = [UIFont systemFontOfSize:20];
    jifenLab.backgroundColor = [UIColor clearColor];
    [receiveAwardImageView addSubview:jifenLab];
    
   
    NSInteger index = [winDic[@"wheelid"] integerValue];
    NSString *descStr = [NSString stringWithFormat:@"%@",_prizeListArray[index-1][@"desc"]];
    
    NSInteger costingot = STUserDefaults.costingot;
    _allIngot -= costingot;
    NSString *str = [NSString stringWithFormat:@"%ld",(long)_allIngot];
    [myCoinBtn setTitle:str forState:0];
    
    //写入数据
    if ([descStr isEqualToString:@"谢谢参与"]) {
        
        [receiveAwardImageView setBackgroundImage: [UIImage imageNamed:@"bg_reward_sha"] forState:0];
        jifenLab.text = [NSString stringWithFormat:@"%@",descStr];
    }
    else if([descStr isEqualToString:@"再抽一次"])
    {
        [receiveAwardImageView setBackgroundImage: [UIImage imageNamed:@"bg_reward_con"] forState:0];
        jifenLab.text = [NSString stringWithFormat:@"%@",descStr];
        _allIngot += costingot;
        NSString *str = [NSString stringWithFormat:@"%ld",(long)_allIngot];
        [myCoinBtn setTitle:str forState:0];
        
    }else{
        [receiveAwardImageView setBackgroundImage: [UIImage imageNamed:@"bg_reward_con"] forState:0];
        jifenLab.text = [NSString stringWithFormat:@"%@",descStr];
        _allIngot += [descStr integerValue];
        NSString *str = [NSString stringWithFormat:@"%ld",(long)_allIngot];
        [myCoinBtn setTitle:str forState:0];
    
    }

    receiveAwardImageView.transform = CGAffineTransformMakeScale(0.05, 0.05);
    [UIView animateWithDuration:0.5 animations:^{
        receiveAwardImageView.transform = CGAffineTransformMakeScale(1.2, 1.2);
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.5 animations:^{
            receiveAwardImageView.transform = CGAffineTransformMakeScale(1, 1);
            
        } completion:^(BOOL finished) {
            
            
        }];
    }];
    
}

//点击奖励弹出框的按钮事件
-(void)getWinHidenAction
{
    
    [UIView animateWithDuration:0.5 animations:^{
        getWinView.transform=CGAffineTransformMakeScale(0.1, 0.1);
        getWinView.alpha=0;
        
    } completion:^(BOOL finished) {
        [getWinView removeFromSuperview];
        getWinView=nil;
        
    }];
    
}

#pragma mark 中间点击按钮创建
- (UIButton *)wheelBtn {
    if (!_wheelBtn) {
        _wheelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _wheelBtn.frame = CGRectMake(self.wAniView.frame.size.width/2 - 25, self.wAniView.frame.size.height/2 ,50,50+10);
        [_wheelBtn setImage:[UIImage imageNamed:@"Pointer"] forState:0];
        _wheelBtn.center = CGPointMake(_wAniView.center.x, _wAniView.center.y/2-30);
        _wheelBtn.layer.masksToBounds = YES;
        _wheelBtn.layer.cornerRadius = 25;
        [_wheelBtn setTitleColor:[UIColor whiteColor] forState:0];
        [_wheelBtn addTarget:self action:@selector(wheelBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _wheelBtn;
}

#pragma  mark btn点击方法
#pragma mark - 实现相应的响应者方法  转得方法
-(void)wheelBtnAction:(UIButton *)sender
{
    NSInteger costingot = STUserDefaults.costingot;

    JLLog(@"%@",STUserDefaults.phonenum);
    if (![STUserDefaults.phonenum isEqualToString:@""]) {
        if (_allIngot >= costingot) {
            sender.enabled = NO;
            
            [_wAniView startAnimate];
            
            [self loadWinData];
            
        }
        else
        {
            [self createAlertWithString:@"很遗憾，当前元宝不足以抽奖，可通过分享、阅读获得元宝进行抽奖"];
            
        }
    }
    else
    {
        [SVProgressHUD dismiss];
        [self wechatLogin];
        
    }
   
}

//判断再抽一次即转盘在转一次
- (void)judgeAgainTurn
{
    NSInteger costingot = STUserDefaults.costingot;
    if (STUserDefaults.ingot >= costingot) {
        //STUserDefaults.ingot -= costingot;
        [_wAniView startAnimate];
        [self loadWinData];
            
    }
    else
    {
        [self createAlertWithString:@"很遗憾，当前元宝不足以抽奖，可通过分享、阅读获得元宝进行抽奖"];
            
    }
   
}

#pragma mark ==================== 调用抽奖接口 =======================
//调用抽奖接口
-(void)loadWinData
{
    int ingotAccount = STUserDefaults.costingot ;
    [STRequest turnTableWinDataParam:ingotAccount andDataBlock:^(id ServersData, BOOL isSuccess){
        if (isSuccess){
            if ([ServersData isKindOfClass:[NSDictionary class]]) {
                if ( ServersData[@"c"]) {
                    JLLog(@"%@",ServersData);
                    JLLog(@"%@",ServersData[@"m"]);
                    if (ServersData[@"d"]) {
                        //抽奖结果
                        NSDictionary *dictemp = ServersData[@"d"];
                        winDic = [[NSMutableDictionary alloc]initWithDictionary:dictemp];
                        
                        int index = [winDic[@"wheelid"] intValue];
                        NSString *valStr = [NSString stringWithFormat:@"%@",_prizeListArray[index-1][@"val"]];
                        NSString *descStr = [NSString stringWithFormat:@"%@",_prizeListArray[index-1][@"desc"]];
                        
                        [_wAniView endAnimateWithToValue:[self valueFloatByindex:index-1]];
                        
                        
                    } else {
                        [self createAlertWithString:@"很遗憾，当前元宝不足以抽奖，可通过分享、阅读获得元宝进行抽奖"];
                        
                    }
                    
                }
                else
                {
                    JLLog(@"error---%@",ServersData[@"m"]);
                    
                }
                
            }
            else
            {
                [SVProgressHUD showErrorWithStatus:@"数据格式不对，请重试!"];
                
            }
            
        }
        else
        {
            
            [SVProgressHUD showErrorWithStatus:@"网络故障"];
            
        }
        
    }];
    
}

-(void)createAlertWithString:(NSString *)msg
{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:msg preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *action = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    
    [alert addAction:action];
    [self presentViewController:alert animated:YES completion:nil];
    
}
-(CGFloat)valueFloatByindex:(int)index
{
    //    CGFloat valueF = 0.0;
    
    int count = (int)_prizeListArray.count;
    
    int count1 = (1.5 * M_PI - 2 * index * M_PI / count + M_PI / count) * 100000;
    int count2 = (1.5 * M_PI - 2 * index * M_PI / count - M_PI / count) * 100000;
    int r = arc4random() % (count1 - count2 + 1) + count2;
    
    double val = r/100000.000000;
    return val;
}
- (void)wechatLogin
{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"是否前往微信登录?" preferredStyle:UIAlertControllerStyleAlert];
    [alert addAction:[UIAlertAction actionWithTitle:@"是" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [[NSNotificationCenter defaultCenter] postNotificationName:@"login" object:nil];
        XWLoginVC *loginVC = [[XWLoginVC alloc]init];
        [self presentViewController:loginVC animated:YES completion:nil];
        
    }]];
    
    [alert addAction:[UIAlertAction actionWithTitle:@"否" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
    }]];
    
    [self presentViewController:alert animated:YES completion:nil];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
