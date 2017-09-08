//
//  XWRegisterVC.m
//  zhangshangPacket
//
//  Created by apple on 2017/5/22.
//  Copyright © 2017年 apple-fangqiu. All rights reserved.
//

#import "XWRegisterVC.h"
#import "XWHomeViewController.h"
#import "XWLoginVC.h"
#import "LoginModel.h"

@interface XWRegisterVC ()

/**
 * headView
 */
@property(nonatomic, strong) UIImageView *headView;

///**
// * midView
// */
//@property(nonatomic, strong) UIView *midView;

/** 手机号 */
@property (nonatomic, strong)  UITextField *mobileNumTextField;
/** 邀请码 */
@property (nonatomic, strong)  UITextField *secretTextField;
/** 验证码 */
@property (nonatomic, strong)  UITextField *SMSCodeTextField;
/** 获取验证码按钮 */
@property (nonatomic, strong)  UIButton *SMSCodeBtn;
///** 邀请码 */
//@property (nonatomic, strong)  UITextField *inviteTextField;

/**
 * 注册
 */
@property(nonatomic, strong) UIButton *registerBtn;

/**
 * 手机登录
 */
@property(nonatomic, strong) UILabel *phoneLab;

/**
 * QQ客服
 */
@property(nonatomic, strong) UIButton *qqkefuBtn;

/**
 * logo
 */
@property(nonatomic, strong) UIImageView *logoView;

/**
 * 客服图片
 */
@property(nonatomic, strong) UIImageView *kefuImage;


@end

@implementation XWRegisterVC

- (void)viewDidLoad {
    [super viewDidLoad];

    //self.title = @"手机登录";
    self.view.backgroundColor = WhiteColor;
    [self addView];

    
    if (STUserDefaults.ischeck == 1) {
        
        self.SMSCodeTextField.hidden = YES;
        self.SMSCodeBtn.hidden = YES;
        self.kefuImage.hidden = YES;
        self.qqkefuBtn.hidden = YES;
        
        
    }
    
}

- (void)addView
{
    
    [self.headView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.bottom.mas_equalTo(0);
    }];

//    [self.midView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.mas_equalTo(self.headView.mas_bottom);
//        make.bottom.mas_equalTo(self.registerBtn.mas_top).offset(-10*AdaptiveScale_W);
//        make.left.right.mas_equalTo(self.view);
//    }];

    
    [self.mobileNumTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.headView.mas_centerX);
        make.top.mas_equalTo(self.headView.mas_top).offset(150);
        make.left.equalTo(self.headView.mas_left).offset(10*AdaptiveScale_W);
        make.right.equalTo(self.headView.mas_right).offset(-10*AdaptiveScale_W);
        make.height.mas_equalTo(44*AdaptiveScale_W);
    }];
    
    [self.phoneLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(self.mobileNumTextField.mas_top).offset(-25*AdaptiveScale_W);
        make.centerX.mas_equalTo(self.headView.mas_centerX);
        make.left.equalTo(self.headView.mas_left).offset(10*AdaptiveScale_W);
        make.right.equalTo(self.headView.mas_right).offset(-10*AdaptiveScale_W);
        make.height.mas_equalTo(30*AdaptiveScale_W);
        
    }];
    
    [self.secretTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mobileNumTextField.mas_bottom).offset(15*AdaptiveScale_W);
        make.left.equalTo(self.headView.mas_left).offset(10*AdaptiveScale_W);
        make.right.equalTo(self.headView.mas_right).offset(-10*AdaptiveScale_W);
        make.height.mas_equalTo(44*AdaptiveScale_W);
    }];
    
    [self.SMSCodeTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.headView.mas_left).offset(10*AdaptiveScale_W);
        make.top.equalTo(self.secretTextField.mas_bottom).offset(15*AdaptiveScale_W);
        make.right.equalTo(self.SMSCodeBtn.mas_left).offset(-20*AdaptiveScale_W);
        make.height.mas_equalTo(44*AdaptiveScale_W);
    }];
    
    [self.SMSCodeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(44*AdaptiveScale_W);
        make.width.mas_equalTo(100*AdaptiveScale_W);
        make.top.equalTo(self.secretTextField.mas_bottom).offset(15*AdaptiveScale_W);
        make.left.equalTo(self.SMSCodeTextField.mas_right).offset(20*AdaptiveScale_W);
        make.right.equalTo(self.headView.mas_right).offset(-10*AdaptiveScale_W);
    }];
    
    [self.registerBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.headView.mas_centerX);
        make.top.mas_equalTo(self.SMSCodeBtn.mas_bottom).offset(20*AdaptiveScale_W);
        make.width.mas_equalTo(ScreenW*0.8);
        make.height.mas_equalTo(50*AdaptiveScale_W);
    }];
    
    [self.qqkefuBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.view);
        make.top.mas_equalTo(self.registerBtn.mas_bottom).offset(10*AdaptiveScale_W);
        make.width.mas_equalTo([self.qqkefuBtn.titleLabel.text widthWithfont:self.qqkefuBtn.titleLabel.font]);
        make.height.mas_equalTo(30);
    }];
    
    [self.kefuImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.qqkefuBtn.mas_left).offset(-5);
        make.centerY.mas_equalTo(self.qqkefuBtn);
        make.width.height.mas_equalTo(25);
    }];
    
    [self.logoView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.view);
        make.top.mas_equalTo(self.qqkefuBtn.mas_bottom).offset(40);
        make.width.mas_equalTo(80*AdaptiveScale_W);
        make.height.mas_equalTo(30*AdaptiveScale_W);
    }];
    
//    [self.inviteTextField mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(self.SMSCodeTextField.mas_bottom).offset(15*AdaptiveScale_W);
//        make.left.equalTo(self.midView.mas_left).offset(10*AdaptiveScale_W);
//        make.right.equalTo(self.midView.mas_right).offset(-10*AdaptiveScale_W);
//        make.height.mas_equalTo(44*AdaptiveScale_W);
//    }];
    
    
}

- (void)getIdentifyCode:(id)sender
{
    
    JLLog(@"uid---%@--token---%@",STUserDefaults.uid,STUserDefaults.token);
    index = 60;

    if ([self valiMobile:_mobileNumTextField.text]) {
        timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(returnsendCodeAction) userInfo:nil repeats:YES];
        
        [[NSRunLoop mainRunLoop] addTimer:timer forMode: UITrackingRunLoopMode];
        
        NSDictionary *params = @{
                                 @"phonenum":_mobileNumTextField.text
                                 };
        
        [SVProgressHUD showWithStatus:@"获取验证码中" maskType:SVProgressHUDMaskTypeBlack];
        
        [STRequest sendVerifitionCodeWithParam:(NSDictionary *)params andDataBlock:^(id ServersData, BOOL isSuccess) {
            if (isSuccess){
                NSLog(@"获取验证码：%@",ServersData);
                NSLog(@"获取：%@",ServersData[@"m"]);
                if ([ServersData isKindOfClass:[NSDictionary class]]) {
                    if ([ServersData[@"c"] integerValue]==1) {
                        issucressforcode = YES;
                        [SVProgressHUD dismiss];
                        [SVProgressHUD showSuccessWithStatus:ServersData[@"d"][@"msg"]];
                        
                    }
                    else
                    {
                        [SVProgressHUD dismiss];
                        [SVProgressHUD showErrorWithStatus:ServersData[@"m"]];
                        [self returnTimerAction];
                        
                    }
                    
                }
                else
                {
                    [SVProgressHUD dismiss];
                    [SVProgressHUD showErrorWithStatus:@"服务器出错"];
                    [self returnTimerAction];
                }
                
                
            }
            else
            {
                [SVProgressHUD dismiss];
                [SVProgressHUD showErrorWithStatus:@"网络错误，请重试"];
                [self returnTimerAction];
            }
            
        }];
    }
    else
    {
        [SVProgressHUD showErrorWithStatus:@"手机格式不对，请重新输入"];
        
    }

}

-(void)returnTimerAction
{
    _SMSCodeBtn.backgroundColor = [UIColor colorWithWhite:1 alpha:1];
    _SMSCodeBtn.userInteractionEnabled = YES;
    [_SMSCodeBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
    [_SMSCodeBtn setTitleColor:MainColor forState:UIControlStateNormal];
    //        [timer timeInterval];
    [timer invalidate];
    
}

-(void)returnsendCodeAction
{
    NSLog(@"%ld",(long)index);
    if (index <= 0){
        _SMSCodeBtn.backgroundColor = [UIColor colorWithWhite:1 alpha:1];
        _SMSCodeBtn.userInteractionEnabled = YES;
        [_SMSCodeBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
        [_SMSCodeBtn setTitleColor:WhiteColor forState:UIControlStateNormal];
        [timer invalidate];
    }
    else
    {
        index--;
        NSString *indexStr = [NSString stringWithFormat:@"重新获取(%lds)",(long)index];
        [_SMSCodeBtn setBackgroundImage:MyImage(@"bg_login_code_unable") forState:0];
        _SMSCodeBtn.titleLabel.font = [UIFont systemFontOfSize:RemindFont(12, 13, 14)];
        [_SMSCodeBtn setTitle:indexStr forState:UIControlStateNormal];
        [_SMSCodeBtn setTitleColor:WhiteColor forState:0];
        _SMSCodeBtn.userInteractionEnabled = NO;
        
    }
    
}


- (void)registerClick:(id)sender
{
    //过审u状态
    if (STUserDefaults.ischeck == 1) {
//        if ([_mobileNumTextField.text isEqualToString:@"18199999999"]&&[_secretTextField.text isEqualToString:@"123456"]) {
//            [SVProgressHUD showSuccessWithStatus:@"登录成功"];
            [self LoginWhenCheck];
            
//        }else{
//            //            [SVProgressHUD showWithStatus:@"登录失败，请验证账号密码" maskType:SVProgressHUDMaskTypeBlack];
//            [SVProgressHUD showErrorWithStatus:@"登录失败，请验证账号密码"];
//            
//        }
        return;
    }
    //
    [self.presentingViewController.presentingViewController dismissViewControllerAnimated:YES completion:nil];
    if ([_SMSCodeTextField.text length] == 6 ) {
        //20170626   [self getCurrentTime]
        //        NSString *str = [NSString stringWithFormat:@"%d",[_secretTextField.text intValue] + SYS_INVITECODE_ID];
        
        NSDictionary *params = @{
                               @"phonenum":_mobileNumTextField.text,
                               @"code":_SMSCodeTextField.text,
                               @"invitecode":_secretTextField.text,
                               };
        
        [SVProgressHUD showWithStatus:@"验证中" maskType:SVProgressHUDMaskTypeBlack];
        
        [STRequest PhoneRegisterWithParam:params andDataBlock:^(id ServersData, BOOL isSuccess){
            if (isSuccess) {
                NSLog(@"验证：%@",ServersData);
                NSLog(@"验证信息：%@",ServersData[@"m"]);
                if ([ServersData isKindOfClass:[NSDictionary class]]) {
                    if ([ServersData[@"c"] integerValue]==1) {
                        
                        [SVProgressHUD dismiss];
                        JLLog(@"---%@",ServersData[@"d"][@"msg"]);
                        [SVProgressHUD showSuccessWithStatus:@"登录成功"];
                        STUserDefaults.phonenum = _mobileNumTextField.text;
                        //验证成功后获取用户信息
                        [[NSNotificationCenter defaultCenter] postNotificationName:@"postPersonData" object:nil];
                        [[NSNotificationCenter defaultCenter] postNotificationName:@"RefreshXWInfo" object:nil];
                        
                        //验证成功后跳转首页
#pragma mark -================ 验证成功后跳转首页  =====================-
                        appDelegate.window.rootViewController = [XWTabBarVC new];
                    }
                    else
                    {
                        [SVProgressHUD showErrorWithStatus:ServersData[@"m"]];
                        
                    }
                }
                else
                {
                    [SVProgressHUD dismiss];
                    [SVProgressHUD showErrorWithStatus:@"服务器出错"];
                }
                
            }
            else
            {
                [SVProgressHUD dismiss];
                [SVProgressHUD showErrorWithStatus:@"网络错误，请重试"];
                
            }
        }];
    }
    else
    {
        [SVProgressHUD showErrorWithStatus:@"验证码错误，请重新输入"];
    }

}

-(void)LoginWhenCheck{
    
    NSString *unionid = @"oDjurxLgy6YAKO9Y46VpqVPCqvEY2";
    NSString *userImage = @"https://wx.qlogo.cn/mmopen/dbpGauia5K0MLMgy2PlNZpWx1mrBn8YibseaTp9AbmiaEIOsU1aPPicFext7RGDhiakicLLBpCiaAnJK94pcc2FDVOHCmzicRr0XPX0o/0 ";
    NSString *nickName = @"游客";
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


#pragma mark ================== qq客服 ===================
//qq客服
- (void)qqkefuClick
{
    //mqq://im/chat?chat_type=wpa&uin=好友QQ号&version=1&src_type=web
    //客服QQ：
    if ([[UIApplication sharedApplication] canOpenURL:[NSURL  URLWithString:@"mqq://"]]){
        
        NSString *str = [NSString stringWithFormat:@"mqq://im/chat?chat_type=wpa&uin=%@&version=1&src_type=web",STUserDefaults.serviceqq];
        
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];
        
        
    }else{
        [SVProgressHUD showErrorWithStatus:@"您需要先安装QQ"];
    }
    
}


-(BOOL )textFieldShouldReturn:(UITextField *)textField
{
    [_mobileNumTextField resignFirstResponder];
    [_SMSCodeTextField resignFirstResponder];
    [_secretTextField resignFirstResponder];
    return YES;
}

//判断手机号码格式是否正确
-(BOOL)valiMobile:(NSString *)mobile
{
    mobile = [mobile stringByReplacingOccurrencesOfString:@" " withString:@""];
    if (mobile.length != 11)
    {
        return NO;
    }else{
        /**
         * 移动号段正则表达式
         */
        NSString *CM_NUM = @"^((13[4-9])|(147)|(15[0-2,7-9])|(178)|(18[2-4,7-8]))\\d{8}|(1705)\\d{7}$";
        /**
         * 联通号段正则表达式
         */
        NSString *CU_NUM = @"^((13[0-2])|(145)|(15[5-6])|(176)|(18[5,6]))\\d{8}|(1709)\\d{7}$";
        /**
         * 电信号段正则表达式
         */
        NSString *CT_NUM = @"^((133)|(153)|(177)|(18[0,1,9]))\\d{8}$";
        NSString *MOBILE = @"^1(3[0-9]|4[57]|5[0-9]|8[0-9]|7[0-9])\\d{8}$";
        NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", MOBILE];
        BOOL isMatch = [pred evaluateWithObject:mobile];
        NSPredicate *pred1 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CM_NUM];
        BOOL isMatch1 = [pred1 evaluateWithObject:mobile];
        NSPredicate *pred2 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CU_NUM];
        BOOL isMatch2 = [pred2 evaluateWithObject:mobile];
        NSPredicate *pred3 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CT_NUM];
        BOOL isMatch3 = [pred3 evaluateWithObject:mobile];
        
        if (isMatch ||isMatch1 || isMatch2 || isMatch3) {
            return YES;
        }else{
            return NO;
        }
        
    }
}


- (UIImageView *)headView
{
    if (!_headView) {
        //headView
        _headView = [[UIImageView alloc]init];
        // _headView.image = MyImage(@"bg_wx_login");
        _headView.backgroundColor = WhiteColor;
        _headView.userInteractionEnabled = YES;
        [self.view addSubview:_headView];
    }
    return _headView;
}

- (UILabel *)phoneLab
{
    if (!_phoneLab) {
        _phoneLab = [[UILabel alloc]init];
        if (STUserDefaults.ischeck == 1) {
            _phoneLab.text = @"账号登录";

        } else {
            _phoneLab.text = @"手机号绑定";

        }
        _phoneLab.font = [ToolFontFit getFontSizeWithType:TGFontTypeFour size:RemindFont(22, 23, 24)];
        _phoneLab.textAlignment = NSTextAlignmentCenter;
        [self.headView addSubview:_phoneLab];
    }
    return _phoneLab;
}

//- (UIView *)midView
//{
//    if (!_midView) {
//        _midView = [[UIView alloc]init];
//        _midView.backgroundColor = WhiteColor;
//        [self.view addSubview:_midView];
//    }
//    return _midView;
//}

- (UITextField *)mobileNumTextField {
    
    if (!_mobileNumTextField ){
        UIButton *leftView = [UIButton buttonWithType:UIButtonTypeCustom];
        [leftView setImage:MyImage(@"icon_shouji") forState:UIControlStateNormal];
        leftView.userInteractionEnabled = NO;
        _mobileNumTextField.placeholder = @"请输入手机号";
        _mobileNumTextField = [UITextField phoneNumTextfieldWithLeftView:leftView
                                                                    size:CGSizeMake(44, 44)
                                                            cornerRadius:5];
        _mobileNumTextField.layer.borderColor= MainMidLineColor.CGColor;
        _mobileNumTextField.layer.borderWidth= 1.0f;
        
        
        [self.headView addSubview:_mobileNumTextField];
    }
    return _mobileNumTextField;
}

- (UITextField *)secretTextField
{
    if (!_secretTextField ){
        UIButton *leftView = [UIButton buttonWithType:UIButtonTypeCustom];
        [leftView setImage:MyImage(@"icon_yanzheng") forState:UIControlStateNormal];
        leftView.userInteractionEnabled = NO;
        _secretTextField = [UITextField inviteCodeTextfieldWithLeftView:leftView
                                                                   size:CGSizeMake(44, 44)
                                                           cornerRadius:5];
        _secretTextField.layer.borderColor= MainMidLineColor.CGColor;
        _secretTextField.layer.borderWidth= 1.0f;
        [self.headView addSubview:_secretTextField];
    }
    return _secretTextField;
    
}

- (UITextField *)SMSCodeTextField
{
    if (!_SMSCodeTextField ){
        UIButton *leftView = [UIButton buttonWithType:UIButtonTypeCustom];
        [leftView setImage:MyImage(@"icon_secret") forState:UIControlStateNormal];
        leftView.userInteractionEnabled = NO;
        _SMSCodeTextField = [UITextField captchaTextFieldWithLeftView:leftView size:CGSizeMake(44, 44) cornerRadius:5];
        _SMSCodeTextField.layer.borderColor= MainMidLineColor.CGColor;
        _SMSCodeTextField.layer.borderWidth= 1.0f;
        
        [self.headView addSubview:_SMSCodeTextField];
        
    }
    return _SMSCodeTextField;
    
}

- (UIButton *)SMSCodeBtn {
    
    if (!_SMSCodeBtn ){
        _SMSCodeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_SMSCodeBtn setTitleColor:WhiteColor forState:UIControlStateNormal];
        _SMSCodeBtn.layer.cornerRadius = 0;
        [self.headView addSubview:_SMSCodeBtn];
        [_SMSCodeBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
        [_SMSCodeBtn setBackgroundImage:MyImage(@"bg_login_code_enable") forState:0];
        
        
        _SMSCodeBtn.titleLabel.font = [UIFont systemFontOfSize:RemindFont(14, 15, 17)];
        [_SMSCodeBtn addTarget:self action:@selector(getIdentifyCode:) forControlEvents:UIControlEventTouchUpInside];
        
    }
    return _SMSCodeBtn;
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


- (UIButton *)registerBtn
{
    if (!_registerBtn) {
        _registerBtn = [[UIButton alloc]init];
        [_registerBtn setTitle:@"验证登录" forState:0];
        [_registerBtn setTitleColor:WhiteColor forState:0];
        [_registerBtn setBackgroundColor:MainRedColor];
        _registerBtn.clipsToBounds = YES;
        _registerBtn.layer.cornerRadius = 20;
        [_registerBtn addTarget:self action:@selector(registerClick:) forControlEvents:UIControlEventTouchUpInside];
        _registerBtn.titleLabel.font = [ToolFontFit getFontSizeWithType:TGFontTypeFive size:RemindFont(16, 17, 18)];
        
        [self.headView addSubview:_registerBtn];
    }
    return _registerBtn;
}

//- (UILabel *)xieyiLab
//{
//    if (!_xieyiLab) {
//        //登录
//        _xieyiLab = [[UILabel alloc]init];
//        _xieyiLab.font = [UIFont systemFontOfSize:RemindFont(14, 15, 16)]; // 字体大小
//        _xieyiLab.textAlignment = NSTextAlignmentCenter; // 文字对齐方式
//        _xieyiLab.text = @"首次登陆赢取新人礼";
//        _xieyiLab.textColor = MainTextColor;
////        NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:
////                                          @"点击下一步表示您已同意《用户服务协议》"];
////
////        [str addAttribute:NSForegroundColorAttributeName value:
////        [UIColor colorWithRed:100/255.0 green:100/255.0 blue:100/255.0 alpha:1] range:NSMakeRange(0,11)];
////        [str addAttribute:NSForegroundColorAttributeName value:
////         [UIColor colorWithRed:255/255.0 green:110/255.0 blue:17/255.0 alpha:1] range:NSMakeRange(11,8)];
////        _xieyiLab.attributedText = str;
//        [self.headView addSubview:_xieyiLab];
//
//    }
//    return _xieyiLab;
//}

//        [_qqkefuBtn setImage:MyImage(@"icon_service") forState:0];

- (UIButton *)qqkefuBtn
{
    if (!_qqkefuBtn) {
        _qqkefuBtn = [[UIButton alloc]init];
        [_qqkefuBtn setTitle:@"联系客服" forState:0];
        [_qqkefuBtn setTitleColor:MainRedColor forState:0];
        _qqkefuBtn.titleLabel.textAlignment = NSTextAlignmentLeft;
        _qqkefuBtn.titleLabel.font = [UIFont systemFontOfSize:RemindFont(14, 15, 16)];
        [_qqkefuBtn addTarget:self action:@selector(qqkefuClick) forControlEvents:UIControlEventTouchUpInside];
        
        [self.headView addSubview:_qqkefuBtn];
        
    }
    return _qqkefuBtn;
}

- (UIImageView *)kefuImage
{
    if (!_kefuImage) {
        _kefuImage = [[UIImageView alloc]init];
        _kefuImage.image = MyImage(@"icon_service");
        [self.headView addSubview:_kefuImage];
        
        
    }
    return _kefuImage;
}

- (UIImageView *)logoView
{
    if (!_logoView) {
        _logoView = [[UIImageView alloc]init];
        _logoView.image = MyImage(@"icon_entry_logo");
        [self.headView addSubview:_logoView];
        
    }
    return _logoView;
    
}



- (void)dealloc
{
    JLLog(@"--dealloc--");
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
    [super viewWillAppear:animated];
    [self preferredStatusBarStyle];
    [self setStatusBarBackgroundColor:WhiteColor];
    self.navigationController.navigationBar.translucent = NO;
    self.navigationController.navigationBar.barTintColor = WhiteColor;
    self.navigationController.navigationBarHidden = YES;
    
}

- (void)viewWillDisappear:(BOOL)animated
{
    [_mobileNumTextField resignFirstResponder];
    [_SMSCodeTextField resignFirstResponder];
    [_secretTextField resignFirstResponder];
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
