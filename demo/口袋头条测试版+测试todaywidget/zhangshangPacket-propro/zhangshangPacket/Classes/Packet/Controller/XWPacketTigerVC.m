//
//  XWPacketTigerVC.m
//  zhangshangPacket
//
//  Created by apple on 2017/5/16.
//  Copyright © 2017年 apple-fangqiu. All rights reserved.
//

#import "XWPacketTigerVC.h"
#import "XWTigerView.h"
@interface XWPacketTigerVC ()<LuckViewDelegate,UIScrollViewDelegate>
{
    UIImageView *_headView;
    
    UIButton *_lostBtn;
    
    UIImageView *_myimageView;
    
    UILabel *_moneyLab;
    
    UILabel *_infoLab;
    NSMutableDictionary *winDic;
    BOOL isDownLoadTurnTableArr;
}
@property (nonatomic, strong) XWTigerView *tigerView;

@property (nonatomic, strong) UIImageView *backImg;

@property (nonatomic, strong) NSMutableArray *prizeListArray;

@end

@implementation XWPacketTigerVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = WhiteColor;
    self.navigationController.navigationBar.translucent = NO ;
    // 设置导航栏标题变大
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(ScreenW/2, self.view.yj_centerX, 80, 40)];
    label.textColor = [UIColor whiteColor];
    label.text = @"开心转转乐";
    label.font = [UIFont systemFontOfSize:18];
    self.navigationItem.titleView = label;
    [self setupUI];
    [self setupInfo];
}

//设置字体颜色
- (UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
}

//设置状态栏颜色
- (void)setStatusBarBackgroundColor:(UIColor *)color {
    
    UIView *statusBar = [[[UIApplication sharedApplication] valueForKey:@"statusBarWindow"] valueForKey:@"statusBar"];
    if ([statusBar respondsToSelector:@selector(setBackgroundColor:)]) {
        statusBar.backgroundColor = color;
    }
}
//！！！重点在viewWillAppear方法里调用下面两个方法
-(void)viewWillAppear:(BOOL)animated{
    [self preferredStatusBarStyle];
    [self setStatusBarBackgroundColor:MainRedColor];
    self.navigationController.navigationBar.translucent = NO;
}

- (void)setupUI
{
    UIScrollView *scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, ScreenW, ScreenH)];
    scrollView.contentSize = CGSizeMake(ScreenW, ScreenH*1.2);
    [self.view addSubview:scrollView];
    UIImageView *backImg = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, ScreenW, ScreenH*1.2)];
    self.backImg = backImg;
    backImg.image = MyImage(@"icon_bg.jpg");
    [scrollView addSubview:backImg];
    
    _headView = [[UIImageView alloc]initWithFrame:CGRectMake(ScreenW*0.5 - 100, 50, 200, 80)];
    _headView.image = MyImage(@"icon_text");
    [backImg addSubview:_headView];
    
    _lostBtn = [[UIButton alloc]initWithFrame:CGRectMake(ScreenW*0.5-80, 50+80, 160, 30)];
    NSString *lostStr = [NSString stringWithFormat:@"每次抽奖需消耗%@元宝",STUserDefaults.slotrmb];
    [_lostBtn setTitle:lostStr forState:0];
    [_lostBtn setTitleColor:WhiteColor forState:0];
    [_lostBtn setBackgroundImage:MyImage(@"show_bg") forState:0];
    _lostBtn.titleLabel.font = [ToolFontFit getFontSizeWithType:TGFontTypeSix size:12];
    [backImg addSubview:_lostBtn];
    
    _myimageView = [[UIImageView alloc]initWithFrame:CGRectMake(ScreenW*0.5-90, CGRectGetMaxY(self.tigerView.frame)+10, 180, 60)];
    _myimageView.image = MyImage(@"my_bg");
    [backImg addSubview:_myimageView];
    
    _moneyLab = [[UILabel alloc]initWithFrame:CGRectMake(ScreenW*0.5, CGRectGetMaxY(self.tigerView.frame)+18, 100, 40)];
    _moneyLab.text = [NSString stringWithFormat:@"%d",STUserDefaults.ingot];
    _moneyLab.textColor = WhiteColor;
    _moneyLab.font = [ToolFontFit getFontSizeWithType:TGFontTypeSix size:18];
    [backImg addSubview:_moneyLab];
    
    _infoLab = [[UILabel alloc]initWithFrame:CGRectMake(ScreenW*0.5-140, CGRectGetMaxY(self.tigerView.frame)+60, 280, 60)];
    _infoLab.text = @"通过非法途径获得奖品的,主办方有权不提供奖品,兑换项与活动和设备生产商Apple Inc.公司无关。";
    _infoLab.font = [UIFont systemFontOfSize:12];
    _infoLab.numberOfLines = 0;
    _infoLab.textColor = WhiteColor;
    [backImg addSubview:_infoLab];
    
    
    if ([[[NSUserDefaults standardUserDefaults] objectForKey:@"turntablearr"] isKindOfClass:[NSArray class]]) {
        NSArray *arrtemp = [[NSUserDefaults standardUserDefaults] objectForKey:@"turntablearr"];
        if (arrtemp.count>0){
            _prizeListArray = [[NSMutableArray alloc]initWithArray:arrtemp];
            isDownLoadTurnTableArr = YES;
            _tigerView.imageArray = self.prizeListArray;
        }
        else
        {
            [self setupInfo];
            
        }
    }
    else
    {
        [self setupInfo];
        
    }

    
}

- (void)setupInfo
{
    [SVProgressHUD showWithMaskType:SVProgressHUDMaskTypeBlack];
    [STRequest SysHappyTurnDataWithDataBlock:^(id ServersData, BOOL isSuccess) {
        if (isSuccess){
            [SVProgressHUD dismiss];
            if ([ServersData isKindOfClass:[NSDictionary class]]) {
                if ([ServersData[@"c"] integerValue]==1) {
                    NSLog(@"抽奖接口数据：%@",ServersData);
                    NSDictionary *dicD=ServersData[@"d"];
                    
                    NSArray *arrRlist = dicD[@"slotmachines"];
                    
                    _prizeListArray = [[NSMutableArray alloc]initWithArray:arrRlist];
                    
                    isDownLoadTurnTableArr = YES;
                    
                    [[NSUserDefaults standardUserDefaults] setObject:_prizeListArray forKey:@"turntablearr"];
                    
                    
                    self.tigerView.imageArray = _prizeListArray;
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

- (void)loadWinData
{
    [STRequest turnTableWinDataParam:10 andDataBlock:^(id ServersData, BOOL isSuccess){
        if (isSuccess){
            if ([ServersData isKindOfClass:[NSDictionary class]]) {
                if ( ServersData[@"c"]) {
                    NSLog(@"%@",ServersData);
                    NSLog(@"%@",ServersData[@"m"]);
                    //抽奖结果
                    NSDictionary *dictemp = ServersData[@"d"];
                    winDic = [[NSMutableDictionary alloc]initWithDictionary:dictemp];
                    //抽中第几个
                    NSString *numstr = [NSString stringWithFormat:@"%@",dictemp[@"slotid"]];
                    int num = [numstr intValue];
                    NSLog(@"%d",num);
                    //抽奖结束，元宝情况
                    STUserDefaults.ingot += num ;
                    [self.tigerView getLuckResult:^(NSInteger result) {
                        
                    }];
                }
                else
                {
                    [self createAlertWithString:ServersData[@"m"]];
                    
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

- (XWTigerView *)tigerView
{
    if (!_tigerView) {
        _tigerView = [[XWTigerView alloc]initWithFrame:CGRectMake(20*AdaptiveScale_W, 50+80+30+10, ScreenW - 2*20*AdaptiveScale_W, ScreenW - 2*20*AdaptiveScale_W)];
        _tigerView.stopCount = arc4random()%_tigerView.imageArray.count;
        _tigerView.delegate = self;
        JLLog(@"stopCount = %d",_tigerView.stopCount);
        
        [self.backImg addSubview:_tigerView];
        
    }
    return _tigerView;
}

-(void)createAlertWithString:(NSString *)msg
{
    UIAlertController *alert=[UIAlertController alertControllerWithTitle:@"提示" message:msg preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *action=[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        
    }];
    
    [alert addAction:action];
    
    [self presentViewController:alert animated:YES completion:nil];
    
}


#pragma mark - LuckViewDelegate
/**
 *  中奖
 *  返回结果数组的下标
 */
- (void)luckViewDidStopWithArrayCount:(NSInteger)count {
    NSLog(@"抽到了第%ld个",count);
    
    
    
}


/**
 *  点击了数组中的第几个元素

 */
- (void)luckSelectBtn:(UIButton *)btn {
    NSLog(@"点击了数组中的第%ld个元素",btn.tag);
    
}


@end
