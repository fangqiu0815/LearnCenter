//
//  XRRegistViewController.m
//  XDLookPic
//
//  Created by xiaorui on 14-4-21.
//  Copyright (c) 2014年 XD-XY. All rights reserved.
//

#import "RegisterViewController.h"
#include "XDTools.h"
#import "UserInfo.h"
#import "AboutViewController.h"
#import "XieyiViewController.h"
@interface RegisterViewController (){
    
    UIButton *agreedBnt;
    UIButton *regbnt;
}
@end

@implementation RegisterViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    if (_type.integerValue == 1) {
        self.titleLabel.text =@"找回密码";
    }else
    self.titleLabel.text =@"注册";
    
}

//- (void)viewWillDisappear:(BOOL)animated{
//    [super viewWillDisappear:YES];
//    
//}

//手势处理
-(void)handleSingleTapFrom{
    [nameTextFiel resignFirstResponder];
    [passwordTextFiel resignFirstResponder];
    [secPassWordTextFiel resignFirstResponder];
    [emailTextFiel resignFirstResponder];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self initRegisterViews];
    
    
    
}
//初始化注册view
-(void)initRegisterViews{
    mScrollView =[[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, UI_SCREEN_WIDTH, UI_SCREEN_HEIGHT -UI_STATUS_BAR_HEIGHT -UI_STATUS_BAR_HEIGHT)];
    mScrollView.contentSize=CGSizeMake(UI_SCREEN_WIDTH, UI_SCREEN_HEIGHT -UI_STATUS_BAR_HEIGHT );
    mScrollView.scrollEnabled =YES;
    mScrollView.delegate = self;
    mScrollView.showsVerticalScrollIndicator = NO;
    [self.contentView addSubview:mScrollView];
    
    UITapGestureRecognizer* singleRecognizer;
    singleRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleSingleTapFrom)];
    singleRecognizer.numberOfTapsRequired = 1; // 单击
    [mScrollView addGestureRecognizer:singleRecognizer];
    
    
    
    
    UIImageView *bgView=[[UIImageView alloc]initWithFrame:CGRectMake(0, 24, UI_SCREEN_WIDTH, 44 *4 +4)];
    bgView.backgroundColor =[UIColor whiteColor];
    bgView.userInteractionEnabled =YES;
    bgView.image =[UIImage imageNamed:@"regist.png"];
    [mScrollView addSubview:bgView];
    
    UIImageView *imageView1=[[UIImageView alloc]initWithFrame:CGRectMake (15,13,12,19)];
    imageView1.image =[UIImage imageNamed:@"useName.png"];
    imageView1.backgroundColor =[UIColor clearColor];
    [bgView addSubview:imageView1];
    nameTextFiel =creatXRTextField(@"请输入手机号", CGRectMake(44,5,150,39));
    nameTextFiel.delegate =self;
    nameTextFiel.font = [UIFont systemFontOfSize:15];
    nameTextFiel.returnKeyType = UIReturnKeyDone;
    nameTextFiel.borderStyle= UITextBorderStyleNone;
    nameTextFiel.keyboardType = UIKeyboardTypeNumberPad;
    nameTextFiel.clearButtonMode = UITextFieldViewModeWhileEditing;
    [nameTextFiel addTarget:self action:@selector(textfieldChange:) forControlEvents:UIControlEventEditingChanged];
    [bgView addSubview:nameTextFiel];
    UIImageView *lineImageView=[[UIImageView alloc]initWithFrame:CGRectMake(0, 43, UI_SCREEN_WIDTH, .5f)];
    lineImageView.backgroundColor =[UIColor clearColor];
    lineImageView.image =[UIImage imageNamed:@"line@2x.png"];
    [bgView addSubview:lineImageView];

    codeBtn = [XDTools getAButtonWithFrame:CGRectMake(VIEW_POINT_MAX_X(nameTextFiel)+20, 10, 90, 24) nomalTitle:@"获取验证码" hlTitle:@"获取验证码" titleColor:[UIColor whiteColor] bgColor:UIColorFromRGB(0xf18d00) nbgImage:nil hbgImage:nil action:@selector(getCode) target:self buttonTpye:UIButtonTypeCustom];
    codeBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    [bgView addSubview:codeBtn];


    UIImageView *emailImageView=[[UIImageView alloc]initWithFrame:CGRectMake(15, 60, 18,12)];
    [emailImageView setBackgroundColor:[UIColor clearColor]];
    [emailImageView setImage:[UIImage imageNamed:@"codeIcon"]];
    [bgView addSubview:emailImageView];
    emailTextFiel =creatXRTextField(@"请输入验证码", CGRectMake(44,48-1, 260, 39));
    emailTextFiel.borderStyle= UITextBorderStyleNone;
    emailTextFiel.delegate = self;
    emailTextFiel.font = [UIFont systemFontOfSize:15];
    emailTextFiel.returnKeyType = UIReturnKeyDone;
    emailTextFiel.keyboardType = UIKeyboardTypeNumberPad;
    emailTextFiel.clearButtonMode = UITextFieldViewModeWhileEditing;
    [emailTextFiel addTarget:self action:@selector(textfieldChange:) forControlEvents:UIControlEventEditingChanged];
    [bgView addSubview:emailTextFiel];
    
    
    UIImageView *passImageView=[[UIImageView alloc]initWithFrame:CGRectMake(15, VIEW_POINT_MAX_Y(emailTextFiel) +11, 13, 38/2.0f)];
    [passImageView setBackgroundColor:[UIColor clearColor]];
    [passImageView setImage:[UIImage imageNamed:@"passdWord"]];
    [bgView addSubview:passImageView];
    passwordTextFiel =creatXRTextField(@"请输入密码,6-16位字符", CGRectMake(44,44 *2 +4-1, 260, 39));
    passwordTextFiel.borderStyle= UITextBorderStyleNone;
    passwordTextFiel.secureTextEntry =YES;
    passwordTextFiel.delegate = self;
    passwordTextFiel.font = [UIFont systemFontOfSize:15];
    passwordTextFiel.returnKeyType = UIReturnKeyDone;
    passwordTextFiel.clearButtonMode = UITextFieldViewModeWhileEditing;
    [passwordTextFiel addTarget:self action:@selector(textfieldChange:) forControlEvents:UIControlEventEditingChanged];
    [bgView addSubview:passwordTextFiel];
    UIImageView *lineImageView2=[[UIImageView alloc]initWithFrame:CGRectMake(0, 44*2-1, UI_SCREEN_WIDTH, .5f)];
    lineImageView2.image =[UIImage imageNamed:@"line@2x.png"];
    [bgView addSubview:lineImageView2];
    
    
    
    UIImageView *secPassImageView=[[UIImageView alloc]initWithFrame:CGRectMake(15, VIEW_POINT_MAX_Y(passwordTextFiel) +10, 13, 38/2.0f)];
    [secPassImageView setBackgroundColor:[UIColor clearColor]];
    [secPassImageView setImage:[UIImage imageNamed:@"passdWord"]];
    [bgView addSubview:secPassImageView];
    secPassWordTextFiel =creatXRTextField(@"请确认密码", CGRectMake(44,44 *3 +4-1, 260, 40));
    secPassWordTextFiel.borderStyle= UITextBorderStyleNone;
    secPassWordTextFiel.secureTextEntry =YES;
    secPassWordTextFiel.delegate = self;
    secPassWordTextFiel.font = [UIFont systemFontOfSize:15];
    secPassWordTextFiel.returnKeyType = UIReturnKeyDone;
    secPassWordTextFiel.clearButtonMode = UITextFieldViewModeWhileEditing;
    [secPassWordTextFiel addTarget:self action:@selector(textfieldChange:) forControlEvents:UIControlEventEditingChanged];
    [bgView addSubview:secPassWordTextFiel];
    UIImageView *lineImageView3=[[UIImageView alloc]initWithFrame:CGRectMake(0, 44*3-1, UI_SCREEN_WIDTH, .5f)];
    lineImageView3.image =[UIImage imageNamed:@"line@2x.png"];
    //    lineImageView.backgroundColor =[UIColor clearColor];
    [bgView addSubview:lineImageView3];
    


    agreedBnt = [XDTools getAButtonWithFrame:CGRectMake(10, VIEW_POINT_MAX_Y(bgView) +18, 25, 25) nomalTitle:nil hlTitle:nil titleColor:nil bgColor:[UIColor clearColor] nbgImage:@"agreement_desel" hbgImage:@"agreement_desel" action:@selector(agreedButtonClick:) target:self buttonTpye:UIButtonTypeCustom];
    [agreedBnt setBackgroundImage:[UIImage imageNamed:@"agreement_sel"] forState:UIControlStateSelected];
    agreedBnt.selected = YES;
    [mScrollView addSubview:agreedBnt];



    UILabel *label = creatXRLable(@"我已阅读并同意《喵贷用户服务协议》", CGRectMake(VIEW_POINT_MAX_X(agreedBnt)-3,VIEW_POINT_MIN_Y(agreedBnt)- 2,250,20));
    label.textColor = RGBA(159, 159, 159, 1);
    label.font = [UIFont systemFontOfSize:14.0];
    label.attributedText = [XDTools getAcolorfulStringWithText1:@"《喵贷用户服务协议》" Color1:[UIColor blueColor] Font1:[UIFont systemFontOfSize:14.0] Text2:nil Color2:nil Font2:nil AllText:label.text];
    label.textAlignment =NSTextAlignmentLeft;
    [mScrollView addSubview:label];

    UIButton * xieyiButton = [UIButton buttonWithType:UIButtonTypeCustom];
    xieyiButton.frame = CGRectMake(140,VIEW_POINT_MIN_Y(agreedBnt)- 7 , 100, 30);
    xieyiButton.backgroundColor = [UIColor clearColor];
    [xieyiButton addTarget:self action:@selector(xieyiClick) forControlEvents:UIControlEventTouchUpInside];
    [mScrollView addSubview:xieyiButton];
    
    regbnt=creatXRButton(CGRectMake(10, VIEW_POINT_MAX_Y(label) +20, UI_SCREEN_WIDTH -20, 44),nil,nil,nil);
    if(_type.intValue == 1){
        label.hidden = YES;
        xieyiButton.hidden = YES;
        agreedBnt.hidden = YES;
    }else{
        label.hidden = NO;
        xieyiButton.hidden = NO;
        agreedBnt.hidden = NO;
    }
    
    if (_type.intValue == 1) {
        [regbnt setTitle:@"重置密码" forState:UIControlStateNormal];
    }else
    [regbnt setTitle:@"立即注册" forState:UIControlStateNormal];
    [regbnt setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    regbnt.backgroundColor = UIColorFromRGB(0xf18d00);
    [regbnt addTarget:self action:@selector(registButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [mScrollView addSubview:regbnt];
    

}

-(void)xieyiClick
{
//    AboutViewController * aboutVC = [[AboutViewController alloc] init];
//    aboutVC.titleString = @"喵贷用户服务协议";
//    aboutVC.urlString = ZhuCeXieYiURLSTRING;
//    [self.navigationController pushViewController:aboutVC animated:YES];

    XieyiViewController * xieyi = [[XieyiViewController alloc] init];
    xieyi.type = @"reg";
    [self.navigationController pushViewController:xieyi animated:YES];
}

#pragma mark BUTTON SEL
-(void)agreedButtonClick:(UIButton *)sender{
    agreedBnt.selected = !agreedBnt.selected;
    if (agreedBnt.selected) {
        [regbnt setBackgroundColor:UIColorFromRGB(0xf18d00)];
        regbnt.enabled = YES;
    }else{
        [regbnt setBackgroundColor:RGBA(203, 203, 203, 1)];
        regbnt.enabled = NO;
    }

}
-(void)registButtonClick:(UIButton *)sender{
    if (!IS_NOT_EMPTY(nameTextFiel.text)||!IS_NOT_EMPTY(passwordTextFiel.text)||!IS_NOT_EMPTY(secPassWordTextFiel.text)||!IS_NOT_EMPTY(emailTextFiel.text)) {
        if (!IS_NOT_EMPTY(nameTextFiel.text)) {
            [XDTools showTips:@"请输入手机号" toView:self.contentView];
            return;
        }

        if (![XDTools chickIphoneNumberRight:nameTextFiel.text]){
            [XDTools showTips:@"请输入有效的手机号" toView:self.contentView];
            return;
        }
        
        if (nameTextFiel.text.length != 11) {
            [XDTools showTips:@"请输入11位手机号" toView:self.contentView];
            return;
        }
        
        if (!IS_NOT_EMPTY(emailTextFiel.text)) {
            [XDTools showTips:@"请输入验证码" toView:self.contentView];
            return;
        }
        
        if (!IS_NOT_EMPTY(passwordTextFiel.text)) {
            [XDTools showTips:@"请输入密码" toView:self.contentView];
            return;
        }
        
        if (passwordTextFiel.text.length > 16 || passwordTextFiel.text.length < 6) {
            [XDTools showTips:@"请输入6-16位密码" toView:self.contentView];
            return;
        }
        
        if (!IS_NOT_EMPTY(secPassWordTextFiel.text)) {
            [XDTools showTips:@"请输入确认密码" toView:self.contentView];
            return;
        }
        if (![secPassWordTextFiel.text isEqualToString:passwordTextFiel.text]){
            [XDTools showTips:@"两次输入的密码不一致" toView:self.contentView];
            return;
        }

    }else{

        if (![XDTools NetworkReachable]) {
            [XDTools showTips:brokenNetwork toView:self.view];
            return;
        }
        NSString *userName = nameTextFiel.text;
        NSString *passWord = [passwordTextFiel.text MD5Hash];

        if (!smsToken.length) {
            [XDTools showTips:@"请先获取验证码" toView:self.view];
            return;
        }
        if (passwordTextFiel.text.length > 16 || passwordTextFiel.text.length < 6) {
            [XDTools showTips:@"请输入6-16位密码" toView:self.contentView];
            return;
        }
        
        if (nameTextFiel.text.length != 11) {
            [XDTools showTips:@"请输入11位手机号" toView:self.contentView];
            return;
        }
        
        if (![XDTools chickIphoneNumberRight:nameTextFiel.text]){
            [XDTools showTips:@"请输入有效的手机号" toView:self.contentView];
            return;
        }

        if([passwordTextFiel.text isEqualToString:secPassWordTextFiel.text]){
            if (_type.intValue != 1) {
                NSDictionary *dic = @{@"userName":userName,
                                      @"password":passWord,
                                      @"smsToken":smsToken,
                                      @"verifyCode":emailTextFiel.text};

                [self getDataWithStr:@"1" parms:dic api:API_REGISTER];
                

            }else{
                NSDictionary *dic = @{@"phone":userName,
                                      @"newPassword":passWord,
                                      @"smsToken":smsToken,
                                      @"verifyCode":emailTextFiel.text};

                [self getDataWithStr:@"1" parms:dic api:API_GETBACKPW];

            }

        }else{
            [XDTools showTips:@"两次密码不一致" toView:self.contentView];
        }
    }
    
    
}
- (void)getDataWithStr:(NSString *)type  parms:(NSDictionary *)parms api:(NSString *)api{
    
    __block  ASIFormDataRequest *request = [XDTools postRequestWithDict:parms API:api];
    
    [request setCompletionBlock:^{
        [XDTools hideProgress:self.view];
        
        NSDictionary *tempDic = [XDTools  JSonFromString:[request responseString]];
        if([[tempDic objectForKey:@"result"]intValue] == 0){

            NSDictionary * dict = @{@"userName":nameTextFiel.text,
                                    @"password":passwordTextFiel.text};

            NSUserDefaults * userDef = [NSUserDefaults standardUserDefaults];
            [userDef setObject:dict forKey:kMMyUserInfo];
            [userDef synchronize];
            if (_type.intValue == 1) {
                [XDTools showTips:@"修改密码成功" toView:self.view];
            }else
            [XDTools showTips:@"注册成功" toView:self.view];

            [self autoLoginIn];

//            [self performSelector:@selector(backPrePage) withObject:nil afterDelay:1];

            
        }else{
            [XDTools showTips:tempDic[@"msg"] toView:self.view];
            
        }
    }];
    
    [request setFailedBlock:^{
        
        [XDTools hideProgress:self.view];
        NSError *error = [request error];
        DDLOG(@"error=%@",error);
    }];
    
    [XDTools showProgress:self.view];
    [request startAsynchronous];
    
}

-(void)autoLoginIn{
        
    if (![XDTools NetworkReachable]) {
        [XDTools showTips:brokenNetwork toView:self.view];
        return;
    }

    NSDictionary *dic = @{@"loginType":@"1",
                          @"userName":nameTextFiel.text,
                          @"password":[passwordTextFiel.text MD5Hash]};

    __block ASIFormDataRequest *request = [XDTools postRequestWithDict:dic API:API_LOGIN];

    [request setCompletionBlock:^{
        [XDTools hideProgress:self.view];

        NSDictionary *tempDic = [XDTools  JSonFromString:[request responseString]];
        DDLOG(@"temdic == %@",tempDic);

        if([[tempDic objectForKey:@"result"]intValue] == 0){

            NSDictionary *subDict=[tempDic objectForKey:@"data"];
            NSUserDefaults *userDef=[NSUserDefaults standardUserDefaults];
            //存登录信息

            [userDef setObject:subDict forKey:kMMyUserInfo];
            [userDef synchronize];

            NSString * uid = [[[NSUserDefaults standardUserDefaults] objectForKey:kMMyUserInfo] objectForKey:@"uid"];
            NSString * string = [NSString stringWithFormat:@"%@",uid];
//            [APService setTags:[NSSet setWithObject:[NSString stringWithFormat:@"%@",string]] callbackSelector:nil object:nil];

//            [XDTools showTips:@"登录成功" toView:self.contentView];


            if (self.navigationController.viewControllers.count > 2) {
                UIViewController * vc = self.navigationController.viewControllers[self.navigationController.viewControllers.count-3];
                [self.navigationController popToViewController:vc animated:YES];
            }else


            [self.navigationController popToRootViewControllerAnimated:YES];


        }else{
//            [APService setTags:[NSSet setWithObject:@""] callbackSelector:nil object:nil];

            [XDTools showTips:[tempDic objectForKey:@"msg"] toView:self.view];
        }

    }];

    [request setFailedBlock:^{
//        [APService setTags:[NSSet setWithObject:@""] callbackSelector:nil object:nil];

        [XDTools hideProgress:self.view];
        NSError *error = [request error];
        DDLOG(@"error=%@",error);
    }];

//    [XDTools showProgress:self.view];
    [request startAsynchronous];

    
}

- (void)getCode{
    if (!IS_NOT_EMPTY(nameTextFiel.text)) {
        [XDTools showTips:@"请输入手机号" toView:self.contentView];
        return;
    }

    if (![XDTools chickIphoneNumberRight:nameTextFiel.text]){
        [XDTools showTips:@"请输入有效的手机号" toView:self.contentView];
        return;
    }

    if (nameTextFiel.text.length != 11) {
        [XDTools showTips:@"请输入11位手机号" toView:self.contentView];
        return;
    }

    if (![XDTools NetworkReachable]){
        [XDTools showTips:brokenNetwork toView:self.contentView];
        return;
    }

    NSDictionary * dic;
    if (_type.integerValue == 1) {
        dic = @{@"phone": nameTextFiel.text,
                @"smsFmtId":@"forgetPwd"};
    }else{
        dic = @{@"phone": nameTextFiel.text,
                @"smsFmtId":@"register"};
    }


    __block  ASIFormDataRequest *request = [XDTools postRequestWithDict:dic API:API_GETCODE];

    [request setCompletionBlock:^{
        [XDTools hideProgress:self.view];
        NSDictionary *tempDic = [XDTools  JSonFromString:[request responseString]];
        if([[tempDic objectForKey:@"result"]intValue] == 0){
//            emailTextFiel.text = tempDic[@"data"][@"verifyCode"];
            smsToken = tempDic[@"data"][@"smsToken"];
            
            second = 60;
            _timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(changeCodeBtn) userInfo:nil repeats:YES];
            codeBtn.userInteractionEnabled = NO;
            nameTextFiel.userInteractionEnabled = NO;

        }else{
            [XDTools showTips:tempDic[@"msg"] toView:self.view];

        }
    }];

    [request setFailedBlock:^{

        [XDTools hideProgress:self.view];
        NSError *error = [request error];
        DDLOG(@"error=%@",error);
    }];

    [XDTools showProgress:self.view];
    [request startAsynchronous];

}

- (void)changeCodeBtn{
    second--;
    [codeBtn setTitle:[NSString stringWithFormat:@"重新发送(%d)",second] forState:UIControlStateNormal];
    [codeBtn setBackgroundColor:RGBA(203, 203, 203, 1)];
    NSLog(@"%@",[NSString stringWithFormat:@"重新发送(%d)",second]);
    DDLOG(@"codeBtn.titleLabel.text = %@",codeBtn.titleLabel.text);
    if (!second) {
        [codeBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
        codeBtn.userInteractionEnabled = YES;
        nameTextFiel.userInteractionEnabled = YES;
        [_timer setFireDate:[NSDate distantFuture]];
        _timer = nil;
        [codeBtn setBackgroundColor:RGBA(241, 141, 0, 1)];
    }
}


-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [self theKeyboardTextHide];
}
-(void)theKeyboardTextHide{
    [nameTextFiel resignFirstResponder];
    [passwordTextFiel resignFirstResponder];
    [secPassWordTextFiel resignFirstResponder];
    [emailTextFiel resignFirstResponder];
    
}

- (void)textfieldChange:(UITextField *)textField{
    
    if (IS_NOT_EMPTY(textField.text)){
        if (textField == nameTextFiel) {
            if (textField.text.length > 11) {
                nameTextFiel.text = [textField.text substringToIndex:textField.text.length -1];
            }
        }else if (textField == passwordTextFiel){
            if (textField.text.length > 16) {
                passwordTextFiel.text = [textField.text substringToIndex:textField.text.length -1];
            }
        }else if (textField == secPassWordTextFiel){
            if (textField.text.length > 16) {
                secPassWordTextFiel.text = [textField.text substringToIndex:textField.text.length -1];
            }
        }else if (textField == emailTextFiel){
            if (textField.text.length > 4) {
                emailTextFiel.text = [textField.text substringToIndex:textField.text.length -1];
            }
        }
    }
}

#pragma mark 重写父类的方法
- (void)backPrePage
{
    [_timer setFireDate:[NSDate distantFuture]];
    _timer = nil;
   [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
   
    return YES;
}


- (void)textFieldDidBeginEditing:(UITextField *)textField{
//    if (!iPhone5) {
//        if (textField == emailTextFiel) {
//            [UIView animateWithDuration:0.6 animations:^{
//                mScrollView.contentOffset = CGPointMake(0, 40);
//                [emailTextFiel becomeFirstResponder];
//            }];
//        }else if (textField == passwordTextFiel) {
//            [UIView animateWithDuration:0.6 animations:^{
//                mScrollView.contentOffset = CGPointMake(0, 80);
//                [passwordTextFiel becomeFirstResponder];
//            }];
//        }else if (textField == secPassWordTextFiel) {
//            [UIView animateWithDuration:0.6 animations:^{
//                mScrollView.contentOffset = CGPointMake(0, 120);
//                [secPassWordTextFiel becomeFirstResponder];
//            }];
//        }
//        
//    }

}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    [UIView animateWithDuration:.3 animations:^{
        mScrollView.contentOffset = CGPointMake(0, 0);
    }];
    return YES;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    [emailTextFiel resignFirstResponder];
    [nameTextFiel resignFirstResponder];
    [passwordTextFiel resignFirstResponder];
    [secPassWordTextFiel resignFirstResponder];
}
/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
 {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
