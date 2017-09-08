//
//  XWADVC.m
//  zhangshangPacket
//
//  Created by apple on 2017/5/11.
//  Copyright © 2017年 apple-fangqiu. All rights reserved.
//

#import "XWADVC.h"
#import "XWGuidePageVC.h"
#import "XWAD.h"
#import "XWLoginVC.h"
#import "XWRegisterVC.h"
#import "XWPacketVC.h"
#import "LoginModel.h"

@interface XWADVC ()
{
    NSString *tempUrl;
    NSTimer *_timer;
    int countTime;
    BOOL isDone;
}

@property (nonatomic, strong) UIButton *jumpBtn;

/**
 * bgImageView
 */
@property(nonatomic, strong) UIImageView *bgImageView;
@property(nonatomic,strong)UIWindow *window;


@end

@implementation XWADVC

- (void)viewDidLoad {
    [super viewDidLoad];
    //设置背景
    [self setupBg];
    
    //  [self setupBgImageView];
    [self loadADData];

//    NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(updateText) userInfo:nil repeats:YES];
//    _timer = timer;
//    
//    [[NSRunLoop mainRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
}

- (void)setupBg
{
    //设置背景图片
    
    [self.view addSubview:self.bgImageView];
    [self.bgImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.top.mas_equalTo(0);
    }];
    
}

- (void)loadADData
{
    [STRequest firstADDataWithBlock:^(id ServersData, BOOL isSuccess) {
        XWAD *dataModel = [XWAD mj_objectWithKeyValues:ServersData];
        JLLog(@"serverdata---%@",ServersData);
        if (isSuccess)
        {
            if (dataModel.c == 1)
            {
                
                dataModel.d.enable = 1;
                NSString *version = SYS_NEWS_VERSION;
                JLLog(@"version---%@---sysversion--%@",version,STUserDefaults.sysversion);
                
                if (dataModel.d.enable == 1 &&([STUserDefaults.sysversion isEqualToString: version]))
                {
                    [self.bgImageView addSubview:self.jumpBtn];
                    [self.jumpBtn mas_makeConstraints:^(MASConstraintMaker *make) {
                        make.right.mas_equalTo(-15);
                        make.top.mas_equalTo(30);
                        make.width.mas_equalTo(100);
                        make.height.mas_equalTo(30);
                    }];
                    
                    UIImage *image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:dataModel.d.open_img]]];
                    self.bgImageView.image = image;
                    
                    tempUrl = dataModel.d.open_click;
                    _timer = [NSTimer scheduledTimerWithTimeInterval:1.0f target:self selector:@selector(updateText) userInfo:nil repeats:YES];
                    countTime = 5;
                    [self.jumpBtn setTitle:[NSString stringWithFormat:@"%d s | 跳过",countTime] forState:UIControlStateNormal];
                    
                    [self performSelector:@selector(jumpClick) withObject:nil afterDelay:5.0f];
                    JLLog(@"_TIME---%@---counttime--%d",_timer,countTime);
                }else
                {
                    [self theWorkOfWindow];
                }
                
            }else
            {
                [self theWorkOfWindow];
                [SVProgressHUD showErrorWithStatus:dataModel.m];
            }
        }else
        {
            [self theWorkOfWindow];
            [SVProgressHUD showErrorWithStatus:@"网络故障"];
        }
        
    }];
}

- (void)updateText
{
    countTime--;
    [self.jumpBtn setTitle:[NSString stringWithFormat:@"%d s | 跳过",countTime] forState:UIControlStateNormal];
    
}

- (void)jumpClick
{
    
    if (!isDone)
    {
        //设置动画效果
        [UIView animateWithDuration:0.3 animations:^{
            self.bgImageView.alpha = 0;
        } completion:^(BOOL finished) {
            [_timer invalidate];
            _timer = nil;
            [self theWorkOfWindow];
            isDone = YES;
        }];
        
    }
    
}

-(void)theWorkOfWindow
{
    NSString *openFirst = [[NSUserDefaults standardUserDefaults] objectForKey:@"IsFirestOpen"];
    
    if (STUserDefaults.ischeck == 1) {
        [self LoginWhenCheck];
//        appDelegate.window.rootViewController = [XWTabBarVC new];
        
    } else {
        if ([openFirst isEqualToString:@"1"]) {
            _guidePageVC = [XWGuidePageVC new];
            [self presentViewController:_guidePageVC animated:YES completion:nil];
            
        }else{
            
            appDelegate.window.rootViewController = [XWTabBarVC new];
            
            
//            if (STUserDefaults.isLogin) {
//                if (![STUserDefaults.phonenum isEqualToString:@""]) {
//                    NSString *str = STUserDefaults.phonenum;
//                    appDelegate.window.rootViewController = [XWTabBarVC new];
//                    
//                }else{
//                    appDelegate.window.rootViewController = [XWRegisterVC new];
//                }
//                
//                
//            } else {
//                _guidePageVC = [XWGuidePageVC new];
//                
//                //            appDelegate.window.rootViewController = [_guidePageVC getTheRootController];
//                XWLoginVC *vc = [XWLoginVC new];
//                [self presentViewController:vc animated:YES completion:nil];
//            }
            
        }
        
    }

}

-(void)LoginWhenCheck{
    
    NSString *unionid = @"oDjurxLgy6YAKO9Y46VpqVPCqvEY2";
    NSString *userImage = @"https://wx.qlogo.cn/mmopen/dbpGauia5K0MLMgy2PlNZpWx1mrBn8YibseaTp9AbmiaEIOsU1aPPicFext7RGDhiakicLLBpCiaAnJK94pcc2FDVOHCmzicRr0XPX0o/0 ";
    NSString *nickName = @"口袋头条";
    NSString *openid = @"od-bT0tQcaZ9BAk97MdRapeeTxac";
    NSString *yueyu = @"0";
    NSString *phonecard = @"1";
    NSString *osversion = @"8.2";
    NSString *devicetype = @"7,1";
    
    NSDictionary *param = @{
                            @"uniondid":unionid,
                            @"img":userImage,
                            @"name":nickName,
                            @"openid":openid,
                            @"yueyu":yueyu,
                            @"phonecard":phonecard,
                            @"osversion":osversion,
                            @"devicetype":devicetype
                            };
    [SVProgressHUD showWithStatus:@"获取数据中" maskType:SVProgressHUDMaskTypeBlack];
    
    [STRequest LoginWithParams:param WithDataBlock:^(id ServersData, BOOL isSuccess) {
        if (isSuccess) {
            LoginModel *dataModel = [LoginModel mj_objectWithKeyValues:ServersData];
            JLLog(@"%@",ServersData);
            if (dataModel.c == 1)
            {
                STUserDefaults.isLogin = YES;
                STUserDefaults.uid = dataModel.d.uid;
                STUserDefaults.token = dataModel.d.token;
                STUserDefaults.cash = [NSString stringWithFormat:@"%ld",(long)dataModel.d.cash] ;
                STUserDefaults.cashconver = [NSString stringWithFormat:@"%ld",(long)dataModel.d.cashconver];
                STUserDefaults.cashtoday = [NSString stringWithFormat:@"%ld",(long)dataModel.d.cashtoday];
                STUserDefaults.cashtotal = [NSString stringWithFormat:@"%ld",(long)dataModel.d.cashtotal];
                STUserDefaults.cashyes = [NSString stringWithFormat:@"%ld",(long)dataModel.d.cashyes];
                STUserDefaults.disciple = dataModel.d.disciple;
                STUserDefaults.disciplefee = dataModel.d.disciplefee;
                STUserDefaults.ingot = dataModel.d.ingot;
                STUserDefaults.isreward = dataModel.d.isreward;
                STUserDefaults.isshare = dataModel.d.isshare;
                STUserDefaults.issign = dataModel.d.issign;
                //STUserDefaults.img = dataModel.d.img;
                STUserDefaults.logtime = dataModel.d.logtime;
                STUserDefaults.tasknum = dataModel.d.tasknum;
                STUserDefaults.name = nickName;
                STUserDefaults.img = userImage;
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    [SVProgressHUD dismiss];
                    
                    appDelegate.window.rootViewController = [XWTabBarVC new];
                    
                });
            }else
            {
                [SVProgressHUD showErrorWithStatus:dataModel.m];
            }
            
        }else{
            [SVProgressHUD showErrorWithStatus:@"登录失败，请检查网络"];
        }
    }];
}


#pragma mark - 点按图片手势操作
- (void)adImageViewClick{
//    
    if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:tempUrl]]) {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:tempUrl]];
    }
}


#pragma mark get
-(UIImageView *)bgImageView
{
    if (_bgImageView == nil)
    {
        _bgImageView = [[UIImageView alloc]init];
        _bgImageView.userInteractionEnabled = YES;
        UITapGestureRecognizer *tapG = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(adImageViewClick)];
        [_bgImageView addGestureRecognizer:tapG];
        
    }
    return _bgImageView;
}
-(UIButton *)jumpBtn
{
    if (_jumpBtn == nil)
    {
        _jumpBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _jumpBtn.titleLabel.font = [UIFont systemFontOfSize:RemindFont(15, 16, 17)];
        [_jumpBtn setTitle:@"5 s | 跳过" forState:0];
        [_jumpBtn setTitleColor:WhiteColor forState:0];
        [_jumpBtn addTarget:self action:@selector(jumpClick) forControlEvents:UIControlEventTouchUpInside];
        _jumpBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
        [_jumpBtn setBackgroundColor: CUSTOMCOLORA(0, 0, 0, 0.5) ];
        _jumpBtn.layer.masksToBounds = YES;
        _jumpBtn.layer.cornerRadius = 10;
    }
    return _jumpBtn;
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
}

- (void)dealloc{
    JLLog(@"advc--dealloc");
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
