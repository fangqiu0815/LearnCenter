//
//  XWTurnTableVC.m
//  zhangshangPacket
//
//  Created by apple on 2017/7/10.
//  Copyright © 2017年 apple-fangqiu. All rights reserved.
//

#import "XWTurnTableVC.h"
#import "XWTurnTableView.h"
#import "XWMineVC.h"

@interface XWTurnTableVC ()
{
    UIImageView *bgView;
    UIImageView *bgluckWheelView;
    UIButton *closeBtn;
    UIButton *relationBtn;//关系
    UIButton *myCoinBtn;
    UILabel *explainLab;//说明标签
    UIView *getWinView;//奖励弹出视图
    BOOL isDownLoadTurnTableArr;
    UIButton *receiveAwardImageView;
    NSMutableDictionary *winDic;

}
@property (nonatomic,strong) XWTurnTableView * turntable;
@property (nonatomic,strong) UILabel * label;//展示
@property (nonatomic, strong) UIImageView *myCoinImage;
@property (nonatomic, retain) NSArray *imageArray;//图片数组
@property (nonatomic, retain) NSArray *prizeArray;//奖励数组
@property (nonatomic, strong) NSMutableArray *prizeListArray;
@property (nonatomic, strong) NSMutableArray *prizeListDesc;
@property (nonatomic, strong) UIButton *wheelBtn;

@end

@implementation XWTurnTableVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self preferredStatusBarStyle];
    isDownLoadTurnTableArr = NO;

    [self initUI];
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
                    JLLog(@"_prizeListArray---%@",_prizeListArray);
                    [self.turntable initUIWithPrizeArr:_prizeListArray];
                    
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


- (void)initUI{
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    //背景
    bgView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, ScreenW, ScreenH)];
    bgView.image = MyImage(@"bg_luck_single");
    bgView.userInteractionEnabled = YES;
    [self.view addSubview:bgView];
    
    //幸运大抽奖
    bgluckWheelView = [[UIImageView alloc]initWithImage:MyImage(@"bg_luck_wheel")];
    [bgView addSubview:bgluckWheelView];
    [bgluckWheelView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.view);
        make.top.mas_equalTo(10);
        make.width.mas_equalTo(ScreenW*0.8);
        make.height.mas_equalTo(120*AdaptiveScale_W);
    }];
    
    //每次抽奖消耗元宝数
    relationBtn = [[UIButton alloc]initWithFrame:CGRectMake(ScreenW*0.2, 120*AdaptiveScale_W, ScreenW*0.6, 30)];
    NSString *relationStr = [NSString stringWithFormat:@"每次抽奖需消耗%ld元宝",(long)STUserDefaults.costingot];
    [relationBtn setTitle:relationStr forState:0];
    [relationBtn setTitleColor:WhiteColor forState:0];
    [relationBtn setBackgroundImage:MyImage(@"prompt_bg") forState:0];
    [bgView addSubview:relationBtn];
    relationBtn.titleLabel.font = [ToolFontFit getFontSizeWithType:TGFontTypeFive size:RemindFont(16, 17, 18)];
    
    //后退
    closeBtn = [[UIButton alloc]init];
    [closeBtn setImage:MyImage(@"btn_back") forState:0];
    [closeBtn addTarget:self action:@selector(closeClick:) forControlEvents:UIControlEventTouchUpInside];
    [bgView addSubview:closeBtn];
    [closeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15);
        make.top.mas_equalTo(30);
        make.width.mas_equalTo(15*AdaptiveScale_W);
        make.height.mas_equalTo(35*AdaptiveScale_W);
    }];
    
    // 转盘View
    self.turntable = [[XWTurnTableView alloc] initWithFrame:CGRectMake(0, 0, ScreenW-70*AdaptiveScale_W, ScreenW-70*AdaptiveScale_W)];
    __weak XWTurnTableVC *turnVC = self;
    WeakType(self);
    self.turntable.center = self.view.center;
    [self.turntable.playButton addTarget:self action:@selector(wheelBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    [bgView addSubview:self.turntable];
    self.turntable.wBlook = ^(BOOL abool)
    {
        //震动
        AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
        weakself.turntable.playButton.enabled = YES;
        [turnVC createWinPushView];

    };
    
    //我的元宝图片
    _myCoinImage = [[UIImageView alloc]initWithFrame:CGRectMake(ScreenW/2.0-80, CGRectGetMaxY(self.turntable.frame)+30, 80, 30)];
    _myCoinImage.image = MyImage(@"text_my");
    [bgView addSubview:_myCoinImage];
    
    //我的元宝个数
    myCoinBtn = [[UIButton alloc]initWithFrame:CGRectMake(ScreenW/2.0+10, CGRectGetMaxY(self.turntable.frame)+30, 80, 30)];
    [myCoinBtn setBackgroundImage:MyImage(@"my_money_shown_bg") forState:0];
    NSString *myCoinStr = [NSString stringWithFormat:@"%ld",(long)_allIngot];
    [myCoinBtn setTitle:myCoinStr forState:0];
    [myCoinBtn setTitleColor:WhiteColor forState:0];
    myCoinBtn.titleLabel.font = [ToolFontFit getFontSizeWithType:TGFontTypeSix size:RemindFont(15, 16, 17)];
    [bgView addSubview:myCoinBtn];
    
    //说明标签
    explainLab = [[UILabel alloc]initWithFrame:CGRectMake(20*ScreenW/375.0, CGRectGetMaxY(_myCoinImage.frame), ScreenW-40*ScreenW/375.0,80)];
    explainLab.numberOfLines = 0;
    explainLab.text = @"兑换项与活动和设备生产商Apple Inc.公司无关,通过非法途径获得奖品的,主办方有权不提供奖品。";
    explainLab.font = [UIFont systemFontOfSize:14];
    explainLab.backgroundColor = [UIColor clearColor];
    explainLab.textColor = BlackColor;
    [bgView addSubview:explainLab];
    
    if ([[[NSUserDefaults standardUserDefaults] objectForKey:@"turntablearr"] isKindOfClass:[NSArray class]]) {
        NSArray *arrtemp = [[NSUserDefaults standardUserDefaults] objectForKey:@"turntablearr"];
        NSArray *prizearr = [[NSUserDefaults standardUserDefaults]  objectForKey:@"prizeListDesc"];
        if (arrtemp.count>0){
            _prizeListArray = [[NSMutableArray alloc]initWithArray:arrtemp];
            _prizeListDesc = [[NSMutableArray alloc]initWithArray:prizearr];
            [self.turntable initUIWithPrizeArr:_prizeListArray];
            
            isDownLoadTurnTableArr = YES;
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

//- (void)TurnTableViewDidFinishWithIndex:(NSInteger)index BtnClickNum:(NSInteger)btnClickNum{
////    [self loadWinData];
////
////    [self createWinPushView];
//    
//    if ([winDic[@"wheelid"] integerValue] == 0) {
//        
//    } else {
//        
//        
//        [self createWinPushView];
//    }
//    JLLog(@"TurnTableViewDidFinishWithIndex");
//
//    JLLog(@"index---%ld\nbtnclicknum---%ld",(long)index,(long)btnClickNum);
//    
//    
//}

#pragma mark 创建中奖弹出框
-(void)createWinPushView
{
    getWinView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenW, ScreenH+120)];
    getWinView.backgroundColor = [UIColor colorWithWhite:0.3 alpha:0.4];
    [bgView addSubview:getWinView];
    
    //奖励弹框
    receiveAwardImageView = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, ScreenW, ScreenH)];
    receiveAwardImageView.center = CGPointMake(ScreenW/2.0, ScreenH/2.0);
    receiveAwardImageView.userInteractionEnabled = YES;
    [getWinView addSubview:receiveAwardImageView];
    [receiveAwardImageView addTarget:self action:@selector(getWinHidenAction) forControlEvents:UIControlEventTouchUpInside];
    
    //元宝奖励
    UILabel *jifenLab = [[UILabel alloc]initWithFrame:CGRectMake(60, ScreenH*0.5+40*AdaptiveScale_W, receiveAwardImageView.frame.size.width-60*2, 45)];
    jifenLab.textColor = [UIColor whiteColor];
    jifenLab.textAlignment = 1;
    jifenLab.font = [UIFont systemFontOfSize:17];
    jifenLab.backgroundColor = [UIColor clearColor];
    [receiveAwardImageView addSubview:jifenLab];
    
    JLLog(@"269---%@",winDic[@"wheelid"]);
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
        jifenLab.text = [NSString stringWithFormat:@"%@\n(此次不会扣除您的元宝)",descStr];
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


#pragma  mark btn点击方法
#pragma mark - 实现相应的响应者方法  转得方法
-(void)wheelBtnAction:(UIButton *)sender
{
    NSInteger costingot = STUserDefaults.costingot;
    
    JLLog(@"%@",STUserDefaults.phonenum);
    if (![STUserDefaults.phonenum isEqualToString:@""]) {
        if (_allIngot >= costingot) {
            sender.enabled = NO;
            [_turntable startAnimaition];
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
        
        if (STUserDefaults.ischeck == 1) {
            [self createAlertWithString:@"很遗憾，当前元宝不足以抽奖，可通过分享、阅读获得元宝进行抽奖"];
        } else {
            [self wechatLogin];

        }
        
    }
    
}

////判断再抽一次即转盘在转一次
//- (void)judgeAgainTurn
//{
//    NSInteger costingot = STUserDefaults.costingot;
//    if (STUserDefaults.ingot >= costingot) {
//        //STUserDefaults.ingot -= costingot;
//        [_turntable startAnimaition];
//        [self loadWinData];
//        
//    }
//    else
//    {
//        [self createAlertWithString:@"很遗憾，当前元宝不足以抽奖，可通过分享、阅读获得元宝进行抽奖"];
//        
//    }
//    
//}

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
                        
                        [self.turntable endAnimateWithToValue:[self valueFloatByindex:index-1]];

                        
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

-(void)createAlertWithString:(NSString *)msg
{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:msg preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *action = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    
    [alert addAction:action];
    [self presentViewController:alert animated:YES completion:nil];
    
}

- (void)closeClick:(id)sender
{
    NSDictionary *dict = [NSDictionary dictionaryWithObject:myCoinBtn.titleLabel.text forKey:@"Info"];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"sendTurnIngotToMine" object:nil userInfo:dict];
    JLLog(@"123456---%@",myCoinBtn.titleLabel.text);
    [self dismissViewControllerAnimated:YES completion:nil];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (UIStatusBarStyle)preferredStatusBarStyle
{

    return UIStatusBarStyleLightContent;
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

- (NSMutableArray *)prizeListArray
{

    if (!_prizeListArray) {
        _prizeListArray = [NSMutableArray array];
    }
    return _prizeListArray;
    
}

- (NSMutableArray *)prizeListDesc
{
    
    if (!_prizeListDesc) {
        _prizeListDesc = [NSMutableArray array];
    }
    return _prizeListDesc;
    
}

-(CGFloat)valueFloatByindex:(int)index
{
    //    CGFloat valueF = 0.0;
    
    int count = (int)_prizeListArray.count;
    
    int count1 = (1.0 * M_PI - 2 * index * M_PI / count + M_PI / count) * 100000;
    int count2 = (1.0 * M_PI - 2 * index * M_PI / count - M_PI / count) * 100000;
    int r = arc4random() % (count1 - count2 + 1) + count2;
    
    double val = r/100000.000000;
    return val;
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
