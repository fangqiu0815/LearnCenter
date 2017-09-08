//
//  XWLoginVC.m
//  zhangshangPacket
//
//  Created by apple on 2017/5/22.
//  Copyright © 2017年 apple-fangqiu. All rights reserved.
//

#import "XWLoginVC.h"
#import "XWRegisterVC.h"
#import <UMSocialCore/UMSocialCore.h>
#import "LoginModel.h"
#import "RegisterPhoneView.h"
#import "XWHomeViewController.h"
#import "WKWebViewController.h"
#import "XWagreeMentVC.h"
#import "XWLoginNewModel.h"

@interface XWLoginVC ()
{

    NSString *phonenumer;
    NSString *ingot;
    NSString *desc;
    NSInteger status;
    
}
/**
 * headView
 */
@property(nonatomic, strong)UIImageView *headView;

/**
 * wechatBtn
 */
@property(nonatomic, strong)UIButton *wechatBtn;


/**
 * 对号按钮
 */
@property(nonatomic, strong) UIButton *rightBtn;


/**
 *  xieyilab
 */
@property(nonatomic, strong) UIButton *xieyiLab;




@end

@implementation XWLoginVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = WhiteColor;
    //添加视图
    [self addView];

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(getInfo) name:@"XWGETINFOCLICK" object:nil];
    
}

// 微信登录按钮点击
- (void)weixinLoginClick
{
//    JLLog(@"weixinLoginClick");
    [[UMSocialManager defaultManager] getUserInfoWithPlatform:UMSocialPlatformType_WechatSession currentViewController:nil completion:^(id result, NSError *error) {
        MyLog(@"123-%@",error.description);

        if (error) {
            [SVProgressHUD showErrorWithStatus:@"取消登录"];
//            MyLog(@"%@",error.description);
        } else {
            UMSocialUserInfoResponse *resp = result;
            NSString *unionid = resp.unionId;
            NSString *nickName = resp.name;
            NSString *userImage = resp.iconurl;
            NSString *openid = resp.openid;
            
            JLLog(@"unionid--%@\n-nickName--%@\n-userImage--%@\n-openid--%@",unionid,nickName,userImage,openid);
            
            if ([self isBlankString:unionid]) {
                [SVProgressHUD showErrorWithStatus:@"微信登录失败，请检查微信账号是否绑定过本APP"];
                return;
            }
            
            NSDictionary *param = @{
                                    @"uniondid":unionid,
                                    @"img":userImage,
                                    @"name":nickName,
                                    @"openid":openid
                                    };
            
            NSDictionary *dict = @{
                                   @"nickName":nickName,
                                   @"userImage":userImage
                                   };
            [[NSNotificationCenter defaultCenter] postNotificationName:@"SendNameAndImageToMine" object:nil userInfo:dict];
            
            [STRequest LoginTwoWithParams:param WithDataBlock:^(id ServersData, BOOL isSuccess) {
                
                STUserDefaults.name = nickName;
                STUserDefaults.img = userImage;
                JLLog(@"110---serverdata---%@",ServersData);
                if (isSuccess) {
                    if ([ServersData isKindOfClass:[NSDictionary class]]) {
                        if ([ServersData[@"c"] integerValue]== 1) {
                            NSDictionary *dictemp = [NSDictionary dictionaryWithDictionary:ServersData[@"d"]];
                            NSArray *tempArr = [NSArray arrayWithArray:dictemp[@"taskstatus"]];
                            if (tempArr.count == 0) {
                                JLLog(@"无");
                            } else {
                                desc = [NSString stringWithFormat:@"%@",tempArr[0][@"desc"]];
                                ingot = [NSString stringWithFormat:@"%@",tempArr[0][@"ingot"]];
                                status = [tempArr[0][@"status"] integerValue];
                                
                            }
                            
                            if ([ingot integerValue] > 0 ) {
                                NSDictionary *userInfo = @{
                                                           @"allingot":ingot
                                                           };
                                //发送值给我的界面
                                [[NSNotificationCenter defaultCenter] postNotificationName:@"sendIngotToMine" object:nil userInfo:userInfo];
                                //发送状态给任务界面刷新
                                [[NSNotificationCenter defaultCenter ] postNotificationName:@"reloadTaskInfo" object:nil];
//                                [SVProgressHUD showSuccessWithStatus:desc];
                            } else {
                                
                                JLLog(@"没有给元宝");
                                
                            }
//                            //获取用户个人信息
//                            [self getInfo];
                            if ([self isBlankString:STUserDefaults.phonenum]) {
                                [SVProgressHUD dismiss];
                                //注册
                                //[self createPhoneNumData];
                                
                                XWRegisterVC *regVc = [[XWRegisterVC alloc]init];
                                [self presentViewController:regVc animated:YES completion:nil];
                                
                            }
                            else
                            {
                                [self dismissViewControllerAnimated:YES completion:nil];
//                                [[NSNotificationCenter defaultCenter] postNotificationName:@"reloadMessage" object:nil];
                                [SVProgressHUD showSuccessWithStatus:@"登录成功"];
                                //跳转首页
                                appDelegate.window.rootViewController = [XWTabBarVC new];
                            }
                            
//                            [[NSNotificationCenter defaultCenter] postNotificationName:@"reloadMessage" object:nil];
                            
                        }else{
                            
                            [SVProgressHUD showErrorWithStatus:ServersData[@"m"]];
                            
                        }
                    } else {
                        JLLog(@"login----请求不成功");
                    }
                    
                } else {
                    JLLog(@"login----请求不成功");
                }
                
//                    
//                    //                     // 获取个人用户信息
//                    //                     [self getInfo];
//                    
//                    if ([self isBlankString:dataModel.d.phonenum]) {
//                        [SVProgressHUD dismiss];
//                        //注册
//                        //[self createPhoneNumData];
//                        
//                        XWRegisterVC *regVc = [[XWRegisterVC alloc]init];
//                        [self presentViewController:regVc animated:YES completion:nil];
//                        
//                    }
//                    else
//                    {
//                        STUserDefaults.phonenum = dataModel.d.phonenum;
//                        [self dismissViewControllerAnimated:YES completion:nil];
//                        [[NSNotificationCenter defaultCenter] postNotificationName:@"reloadMessage" object:nil];
//                        [SVProgressHUD showSuccessWithStatus:@"登录成功"];
//                        //跳转首页
//                        appDelegate.window.rootViewController = [XWTabBarVC new];
//                    }
//                    
//                    [[NSNotificationCenter defaultCenter] postNotificationName:@"reloadMessage" object:nil];
                
            }];
            
        }
        
    }];

    
    //获取用户个人信息
    [self getInfo];
    
    
}

- (void)getInfo
{
    
    NSString *osversion = DeviceInfo_shared->getOSVersion();
    NSString *devicetype = DeviceInfo_shared->getDeviceType();
    NSString *yueyu = DeviceInfo_shared->getYueYuState();
    NSString *phonecard = DeviceInfo_shared->getCardState();
    
    NSDictionary *param = @{
                            @"yueyu":yueyu,
                            @"phonecard":phonecard,
                            @"osversion":osversion,
                            @"devicetype":devicetype
                            };
    
    [STRequest downLoadUserDataTwoWithDict:param WithBlock:^(id ServersData, BOOL isSuccess) {
        if (isSuccess){
            if ([ServersData isKindOfClass:[NSDictionary class]]) {
                if ([ServersData[@"c"] intValue] == 1) {
                    NSDictionary *dictemp = [NSDictionary dictionaryWithDictionary:ServersData[@"d"]];
                    NSString *uid = [NSString stringWithFormat:@"%@",dictemp[@"uid"]];
                    NSString *userName=[NSString stringWithFormat:@"%@",dictemp[@"name"]];
                    NSString *usericon = [NSString stringWithFormat:@"%@",dictemp[@"img"]];
                    NSString *phoneNum = [NSString stringWithFormat:@"%@",dictemp[@"phonenum"]];
                    NSString *token = [NSString stringWithFormat:@"%@",dictemp[@"token"]];
                    NSString *cash = [NSString stringWithFormat:@"%@",dictemp[@"cash"]];
                    NSString *cashyes = [NSString stringWithFormat:@"%@",dictemp[@"cashyes"]];
                    NSString *cashtoday = [NSString stringWithFormat:@"%@",dictemp[@"cashtoday"]];
                    NSString *cashconver = [NSString stringWithFormat:@"%@",dictemp[@"cashconver"]];
                    NSString *ingot = [NSString stringWithFormat:@"%@",dictemp[@"ingot"]];
                    NSString *isshare = [NSString stringWithFormat:@"%@",dictemp[@"isshare"]];
                    NSString *tasknum = [NSString stringWithFormat:@"%@",dictemp[@"tasknum"]];
                    NSString *isreward = [NSString stringWithFormat:@"%@",dictemp[@"isreward"]];
                    NSString *disciple = [NSString stringWithFormat:@"%@",dictemp[@"disciple"]];
                    NSString *disciplefee = [NSString stringWithFormat:@"%@",dictemp[@"disciplefee"]];
                    NSString *cashtotal = [NSString stringWithFormat:@"%@",dictemp[@"cahstotal"]];
                    NSString *issign = [NSString stringWithFormat:@"%@",dictemp[@"issign"]];
                    NSInteger empudid = [dictemp[@"empudid"] integerValue];
                    BOOL boundwx = [dictemp[@"boundwx"] integerValue];
                    
                    NSString *shebeiid = [NSString stringWithFormat:@"%@",dictemp[@"udid"]];
                    
                    if ([phoneNum isEqualToString:@""]) {
                        JLLog(@"无手机号");
                        STUserDefaults.phonenum = phoneNum;
                        
                    } else {
                        JLLog(@"有手机号---%@",phoneNum);
                        STUserDefaults.phonenum = phoneNum;
                    }
                    
                    STUserDefaults.isLogin = YES;
                    STUserDefaults.uid = uid;
                    STUserDefaults.name = userName;
                    STUserDefaults.img = usericon;
                    if ([STUserDefaults.token isEqualToString:token]) {
                        
                    } else {
                        STUserDefaults.token = token;
                    }
                    JLLog(@"442----st.token---%@\ntoken--%@",STUserDefaults.token,token);
                    
                    STUserDefaults.cash = [NSString stringWithFormat:@"%.2f",[cash floatValue]/100.0];
                    STUserDefaults.cashtotal = [NSString stringWithFormat:@"%.2f",[cashtotal floatValue]/100.0];
                    STUserDefaults.cashyes = [NSString stringWithFormat:@"%.2f",[cashyes floatValue]/100.0];
                    STUserDefaults.cashtoday = [NSString stringWithFormat:@"%.2f",[cashtoday floatValue]/100.0];
                    STUserDefaults.cashconver = [NSString stringWithFormat:@"%.2f",[cashconver floatValue]/100.0];

                    STUserDefaults.ingot = [ingot intValue];
                    STUserDefaults.isshare = [isshare boolValue];
                    STUserDefaults.tasknum = [tasknum integerValue];
                    STUserDefaults.isreward = [isreward boolValue];
                    STUserDefaults.disciple = [disciple integerValue];
                    STUserDefaults.disciplefee = [disciplefee integerValue];
                    STUserDefaults.issign = [issign boolValue];
//                    STUserDefaults.inviteCode = [NSString stringWithFormat:@"%@%@",uid,[self getCurrentTime]];
                    STUserDefaults.boundwx = boundwx;
                    STUserDefaults.empudid = empudid;
                    if (![self isBlankString:shebeiid]) {
                        JLLog(@"shebeiid");
                        STUserDefaults.shebeiID = shebeiid;
                        
                    }
                    [[NSNotificationCenter defaultCenter]postNotificationName:@"reloadPerson123" object:nil];
                }
                else
                {
                    NSLog(@"获取用户信息：%@",ServersData[@"m"]);
                    if ([self isBlankString:STUserDefaults.token]) {
                        STUserDefaults.isLogin = NO;
                    }
                    else
                    {
                        STUserDefaults.isLogin = NO;
                        [SVProgressHUD showErrorWithStatus:@"登录已过期，请到个人中心进行登录"];
                        // [ShareSDK cancelAuthorize:SSDKPlatformTypeWechat];
                        STUserDefaults.uid = 0;
                        STUserDefaults.img = NULL;
                        STUserDefaults.token = @"";
                        
                        STUserDefaults.cash = 0;
                        STUserDefaults.cashtotal = 0;
                        STUserDefaults.cashyes = 0;
                        STUserDefaults.cashtoday = 0;
                        STUserDefaults.cashconver = 0;
                        STUserDefaults.ingot = 0;
                        STUserDefaults.isshare = NO;
                        STUserDefaults.tasknum = 0;
                        STUserDefaults.isreward = NO;
                        STUserDefaults.disciple = 0;
                        STUserDefaults.disciplefee = 0;
//                        STUserDefaults.inviteCode = 0;
                    }
                }
                
            }
            else
            {
//                [SVProgressHUD showErrorWithStatus:@"服务端数据出错"];
                JLLog(@"getinfo--服务端数据出错");

            }
            
        }
        else
        {
            
//            [SVProgressHUD showErrorWithStatus:@"网络错误，请重试"];
            JLLog(@"getinfo--网络错误，请重试");

        }
        
    }];

}


- (void)createPhoneNumData
{
    RegisterPhoneView *registerView = [[RegisterPhoneView alloc]initWithFrame:self.view.bounds];
    [self.view addSubview:registerView];

}

//添加视图
- (void)addView
{
    [self.headView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.bottom.mas_equalTo(0);
        
    }];
    
    [self.wechatBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.headView.mas_centerX);
        make.top.mas_equalTo(ScreenH*0.75);
        make.width.mas_equalTo(ScreenW*0.7);
        make.height.mas_equalTo(70*AdaptiveScale_W);
    }];
    
    [self.xieyiLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.view);
        make.top.mas_equalTo(self.wechatBtn.mas_bottom).offset(15*AdaptiveScale_W);
        make.width.mas_equalTo([self.xieyiLab.titleLabel.text widthWithfont:self.xieyiLab.titleLabel.font]);
        make.height.mas_equalTo(40);
        
    }];
    
//    [self.rightBtn mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.centerY.mas_equalTo(self.xieyiLab);
//        make.right.mas_equalTo(self.xieyiLab.mas_left).offset(-5);
//        make.width.height.mas_equalTo(15);
//    }];
    
}

- (UIImageView *)headView
{
    if (!_headView) {
        //headView
        _headView = [[UIImageView alloc]init];
        _headView.image = MyImage(@"bg_entry");
        _headView.backgroundColor = WhiteColor;
        _headView.userInteractionEnabled = YES;
        [self.view addSubview:_headView];
    }
    return _headView;
}

- (UIButton *)wechatBtn
{
    if (!_wechatBtn) {
        //微信登录
        _wechatBtn = [[UIButton alloc]init];
        [_wechatBtn setBackgroundImage:MyImage(@"icon_inform_binding_login") forState:0];
//        [_wechatBtn setTitle:@"绑定微信" forState:0];
//        //[_wechatBtn setBackgroundImage:MyImage(@"bg_login_code_enable") forState:0];
//        [_wechatBtn setTitleColor:WhiteColor forState:0];
//        _wechatBtn.backgroundColor = MainRedColor;
        [_wechatBtn addTarget:self action:@selector(weixinLoginClick) forControlEvents:UIControlEventTouchUpInside];
//        _wechatBtn.clipsToBounds = YES;
//        _wechatBtn.layer.cornerRadius = 20;
//        _wechatBtn.titleLabel.font = [ToolFontFit getFontSizeWithType:TGFontTypeFive size:RemindFont(16, 17, 18)];
        [self.headView addSubview:_wechatBtn];
    }
    return _wechatBtn;
}

- (void)labelClick {
    
    JLLog(@"点击了服务协议");
    XWagreeMentVC *vc = [[XWagreeMentVC alloc]init];
    self.hidesBottomBarWhenPushed = YES;
    [self presentViewController:vc animated:YES completion:nil];
    
}

- (UIButton *)rightBtn
{
    if (!_rightBtn) {
        _rightBtn = [[UIButton alloc]init];
        [_rightBtn setImage:MyImage(@"icon_entry_tick") forState:UIControlStateNormal];
        [_rightBtn setImage:MyImage(@"icon_entry_tick") forState:UIControlStateSelected];
        
        [self.headView addSubview:_rightBtn];
        
    }
    return _rightBtn;
}

- (UIButton *)xieyiLab
{
    if (!_xieyiLab) {
        _xieyiLab = [[UIButton alloc]init];
        
        _xieyiLab.titleLabel.textAlignment = NSTextAlignmentLeft;
        _xieyiLab.titleLabel.font = [UIFont systemFontOfSize:RemindFont(13, 14, 15)];
        NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:
                                          @"登录即代表阅读并同意《服务条款》"];
        [str addAttribute:NSForegroundColorAttributeName value:MainTextColor range:NSMakeRange(0,10)];
        [str addAttribute:NSForegroundColorAttributeName value:MainRedColor range:NSMakeRange(10,6)];
        
        [_xieyiLab setAttributedTitle:str forState:0] ;
        [_xieyiLab addTarget:self action:@selector(labelClick) forControlEvents:UIControlEventTouchDown];
        
        [self.headView addSubview:_xieyiLab];
        
        
    }
    return _xieyiLab;

}

- (void)dealloc
{
    JLLog(@"--dealloc--");
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

//设置字体颜色
- (UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
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
    [self setStatusBarBackgroundColor:WhiteColor];
    self.navigationController.navigationBar.translucent = NO;
    self.navigationController.navigationBar.barTintColor = WhiteColor;
    self.navigationController.navigationBarHidden = YES;

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

//获取当地时间
- (NSString *)getCurrentTime {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyyMMdd"];
    NSString *dateTime = [formatter stringFromDate:[NSDate date]];
    return dateTime;
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
