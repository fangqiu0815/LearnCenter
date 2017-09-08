//
//  RegisterPhoneView.m
//  CrazyPacket
//
//  Created by huangyujie on 17/3/6.
//  Copyright © 2017年 WuYanZu. All rights reserved.
//

#import "RegisterPhoneView.h"

@implementation RegisterPhoneView
-(instancetype)initWithFrame:(CGRect)frame
{
    if (self){
        self = [super initWithFrame:frame];
        self.backgroundColor = [UIColor colorWithWhite:0.4 alpha:0.4];
        index = 60;
        issucressforcode = NO;
        [self createView];
    }
    return self;
    
}
-(void)createView
{
    //主界面
    mainView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenW-20*AdaptiveScale_W, 223*AdaptiveScale_W)];
    mainView.backgroundColor=[UIColor colorWithWhite:0.95 alpha:1];
    mainView.center=CGPointMake(ScreenW/2.0, 150*AdaptiveScale_W+80);
    mainView.layer.cornerRadius=5;
    mainView.layer.masksToBounds=YES;
    mainView.backgroundColor = CUSTOMCOLOR(245, 245, 245);
    [self addSubview:mainView];
    
    UILabel *title = [[UILabel alloc]initWithFrame:Frame(0, 12*AdaptiveScale_W, ScreenW-20*AdaptiveScale_W, 16*AdaptiveScale_W)];
    title.text = @"手机注册";
    title.textAlignment = NSTextAlignmentCenter;
    title.textColor = CUSTOMCOLOR(49, 144, 232);
    [mainView addSubview:title];
    
    UIView *line=[[UIView alloc]initWithFrame:CGRectMake(0,40*AdaptiveScale_W, ScreenW, 0.5)];
    line.backgroundColor=[UIColor colorWithWhite:0.80 alpha:0.5];
    [mainView addSubview:line];
    
//    //输入框View
//    UIView *textView=[[UIView alloc]initWithFrame:CGRectMake(30*AdaptiveScale_W, 200*AdaptiveScale_W, mainView.frame.size.width-60*AdaptiveScale_W, 38*AdaptiveScale_W)];
//    textView.backgroundColor=[UIColor whiteColor];
//    textView.layer.borderColor=[UIColor colorWithWhite:0.80 alpha:1].CGColor;
//    textView.layer.borderWidth=0.5;
//    textView.layer.cornerRadius=2;
//    textView.layer.masksToBounds=YES;
//    [mainView addSubview:textView];
//    
//    //分割线
//    UIView *lineView1=[[UIView alloc]initWithFrame:CGRectMake(0.5,39.5, textView.frame.size.width-0.5, 0.5)];
//    lineView1.backgroundColor=[UIColor colorWithWhite:0.80 alpha:0.5];
//    [textView addSubview:lineView1];
//    
//    UIView *lineView2=[[UIView alloc]initWithFrame:CGRectMake(textView.frame.size.width/2.0-0.5,39.5,0.5,40)];
//    lineView2.backgroundColor=[UIColor colorWithWhite:0.80 alpha:1];
//    [textView addSubview:lineView2];
    
    //手机输入
    phoneText=[[UITextField alloc]initWithFrame:CGRectMake(30*AdaptiveScale_W,65*AdaptiveScale_W, mainView.frame.size.width-60*AdaptiveScale_W, 38*AdaptiveScale_W)];
    phoneText.backgroundColor = WhiteColor;
    phoneText.font = [UIFont systemFontOfSize:RemindFont(13, 14, 16)];
    phoneText.layer.cornerRadius = 2;
    phoneText.layer.masksToBounds = YES;
    phoneText.layer.borderColor = CUSTOMCOLOR(237, 237, 237).CGColor;
    phoneText.layer.borderWidth = 1.0f;
    phoneText.keyboardType = UIKeyboardTypePhonePad;
    phoneText.placeholder=@"请输入手机号码";
    phoneText.delegate=self;
    [mainView addSubview:phoneText];
    
    //验证码输入
    verificationCode=[[UITextField alloc]initWithFrame:CGRectMake(30*AdaptiveScale_W,CGRectGetMaxY(phoneText.frame)-1*AdaptiveScale_W, phoneText.frame.size.width/2.0, 38*AdaptiveScale_W)];
    verificationCode.backgroundColor = WhiteColor;
    verificationCode.font = [UIFont systemFontOfSize:RemindFont(13, 14, 16)];
    verificationCode.layer.cornerRadius = 2;
    verificationCode.layer.masksToBounds = YES;
    verificationCode.layer.borderColor = CUSTOMCOLOR(237, 237, 237).CGColor;
    verificationCode.layer.borderWidth = 1.0f;
    verificationCode.keyboardType = UIKeyboardTypePhonePad;
    verificationCode.placeholder=@"请输入验证码";
    verificationCode.delegate=self;
    [mainView addSubview:verificationCode];
    
    //验证码按钮
    sendCodeBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    sendCodeBtn.frame=CGRectMake(CGRectGetMaxX(verificationCode.frame)-1*AdaptiveScale_W,CGRectGetMaxY(phoneText.frame)-1*AdaptiveScale_W, phoneText.frame.size.width/2.0+1*AdaptiveScale_W, 38*AdaptiveScale_W);
    [sendCodeBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
    [sendCodeBtn setTitleColor:MainColor forState:UIControlStateNormal];
    sendCodeBtn.backgroundColor=[UIColor whiteColor];
    sendCodeBtn.titleLabel.font=[UIFont systemFontOfSize:RemindFont(13, 14, 16)];
    sendCodeBtn.layer.cornerRadius = 2;
    sendCodeBtn.layer.masksToBounds = YES;
    sendCodeBtn.layer.borderColor = CUSTOMCOLOR(237, 237, 237).CGColor;
    sendCodeBtn.layer.borderWidth = 1.0f;
    [sendCodeBtn addTarget:self action:@selector(sendCodeAction:) forControlEvents:UIControlEventTouchUpInside];
    [mainView addSubview:sendCodeBtn];
    
    //发送注册信息
    registerBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    
    registerBtn.frame=CGRectMake(30*AdaptiveScale_W, CGRectGetMaxY(sendCodeBtn.frame)+20*AdaptiveScale_W, mainView.frame.size.width-60*AdaptiveScale_W, 35*AdaptiveScale_W);
    
    [registerBtn setTitle:@"注册手机号码" forState:UIControlStateNormal];
    
    registerBtn.backgroundColor=MainColor;
    
    [registerBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    registerBtn.layer.cornerRadius=2;
    
    registerBtn.layer.masksToBounds=YES;
    
    registerBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    
    [registerBtn addTarget:self action:@selector(registerBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    
    [mainView addSubview:registerBtn];
    
    
}

-(void)sendCodeAction:(UIButton *)sender
{
//    [SMSSDK getVerificationCodeByMethod:SMSGetCodeMethodSMS phoneNumber:phoneText.text zone:@"86" customIdentifier:nil result:^(NSError *error){
//        if (!error){
//            
//            NSLog(@"获取验证码成功");
//            
//        }
//        else
//        {
//            NSString *errorStr=[NSString stringWithFormat:@"%@",error];
//            [self.delegate errorVerificationCode:errorStr];
//            
//        }
//        
//    }];
    if ([self valiMobile:phoneText.text]) {
        timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(returnsendCodeAction) userInfo:nil repeats:YES];
        
        [[NSRunLoop mainRunLoop] addTimer:timer forMode: UITrackingRunLoopMode];
        
         NSDictionary *params=@{@"phonenum":phoneText.text};
        
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
    sendCodeBtn.backgroundColor=[UIColor colorWithWhite:1 alpha:1];
    sendCodeBtn.userInteractionEnabled=YES;
    [sendCodeBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
    [sendCodeBtn setTitleColor:MainColor forState:UIControlStateNormal];
    //        [timer timeInterval];
    [timer invalidate];
 
    
}

-(void)returnsendCodeAction
{
    NSLog(@"%ld",(long)index);
    if (index <= 0){
        sendCodeBtn.backgroundColor=[UIColor colorWithWhite:1 alpha:1];
        sendCodeBtn.userInteractionEnabled=YES;
        [sendCodeBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
        [sendCodeBtn setTitleColor:MainColor forState:UIControlStateNormal];
//        [timer timeInterval];
        [timer invalidate];
    }
    else
    {
        index--;
        NSString *indexStr=[NSString stringWithFormat:@"重新获取(%lds)",(long)index];
        [sendCodeBtn setTitle:indexStr forState:UIControlStateNormal];
        [sendCodeBtn setTitleColor:[UIColor colorWithWhite:0.80 alpha:1] forState:UIControlStateNormal];
        sendCodeBtn.backgroundColor = [UIColor colorWithWhite:1 alpha:1];
        sendCodeBtn.userInteractionEnabled = NO;
        
    }
    
}
-(void)registerBtnAction:(UIButton *)sender
{
//    [SMSSDK commitVerificationCode:verificationCode.text phoneNumber:phoneText.text zone:@"86" result:^(SMSSDKUserInfo *userInfo, NSError *error) {
//        
//        {
//            if (!error)
//            {
//                
//                NSLog(@"验证成功");
//                
//                
//                
//            }
//            else
//            {
//                NSLog(@"错误信息:%@",error);
//                NSString *errorStr=[NSString stringWithFormat:@"%@",error];
//                [self.delegate errorVerification:errorStr];
//            }
//        }
//    }];
    if ([verificationCode.text length]==6) {
        
    NSDictionary *params = @{@"phonenum":phoneText.text,
                           @"code":verificationCode.text
                           };
    [SVProgressHUD showWithStatus:@"验证中" maskType:SVProgressHUDMaskTypeBlack];

    [STRequest PhoneRegisterWithParam:params andDataBlock:^(id ServersData, BOOL isSuccess){
        if (isSuccess) {
            NSLog(@"验证：%@",ServersData);
            NSLog(@"验证信息：%@",ServersData[@"m"]);
            if ([ServersData isKindOfClass:[NSDictionary class]]) {
                if ([ServersData[@"c"] integerValue]==1) {
                    
                    [SVProgressHUD dismiss];
                    [SVProgressHUD showSuccessWithStatus:ServersData[@"d"][@"msg"]];
                    [self removeFromSuperview];
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

-(BOOL )textFieldShouldReturn:(UITextField *)textField
{
    [phoneText resignFirstResponder];
    [verificationCode resignFirstResponder];
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
        NSPredicate *pred1 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CM_NUM];
        BOOL isMatch1 = [pred1 evaluateWithObject:mobile];
        NSPredicate *pred2 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CU_NUM];
        BOOL isMatch2 = [pred2 evaluateWithObject:mobile];
        NSPredicate *pred3 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CT_NUM];
        BOOL isMatch3 = [pred3 evaluateWithObject:mobile];
        
        if (isMatch1 || isMatch2 || isMatch3) {
            return YES;
        }else{
            return NO;
        }
    }
}


@end
