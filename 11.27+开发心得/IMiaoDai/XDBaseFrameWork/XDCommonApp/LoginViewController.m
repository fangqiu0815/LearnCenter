//
//  LoginViewController.m
//  XDCommonApp
//
//  Created by XD-WangLong on 2/13/14.
//  Copyright (c) 2014 XD-WangLong. All rights reserved.
//

#import "LoginViewController.h"
#import "XDTabBarViewController.h"
#import "UserInfo.h"
#import "RegisterViewController.h"
//#import "WBParams.h"
//#import "APService.h"
#define kRedirectURL  @"https://api.weibo.com/oauth2/default.html"
@interface LoginViewController ()

@end

@implementation LoginViewController

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
    self.titleLabel.text =@"登录";

}

-(void)handleSingleTapFrom{
    [userNameField resignFirstResponder];
    [passWordField resignFirstResponder];
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self initRegisterButton];
    
    //注册腾讯信息
//    _tencentOAuth = [[TencentOAuth alloc] initWithAppId:QQAPPID andDelegate:self];
//    //    _tencentOAuth.redirectURI = @"www.qq.com";
//    _permissions = [NSArray arrayWithObjects:@"all", nil];
//    UIButton *rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
//    [rightButton setTitle:@"注册" forState:UIControlStateNormal];
//    [rightButton setTintColor:[UIColor whiteColor]];
//    [rightButton setFrame:CGRectMake(520/2.0f, 13+aHeight, 60, 25)];
//    rightButton.titleLabel.font = [UIFont systemFontOfSize:18];
    //[rightButton addTarget:self action:@selector(goToRegister) forControlEvents:UIControlEventTouchUpInside];
    
    //[self.navigationBarView addSubview:rightButton];
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
    
    
    
    
    UIImageView *bgImageView=creatXRImageView(CGRectMake(0, 10, UI_SCREEN_WIDTH , 88), [UIImage imageNamed:@"backGround.png"]);
    bgImageView.backgroundColor=[UIColor whiteColor];
    bgImageView.userInteractionEnabled = YES;
    [mScrollView addSubview:bgImageView];
    
    UIImageView *imageView=[[UIImageView alloc]initWithFrame:CGRectMake(10,14.5f, 12, 19)];
    imageView.backgroundColor=[UIColor whiteColor];
    imageView.image =[UIImage imageNamed:@"useName.png"];
    [bgImageView addSubview:imageView];
    
    
    userNameField =creatXRTextField(@"请输入手机号", CGRectMake(VIEW_POINT_MAX_X(imageView) +8,5 ,260,39));
    userNameField.borderStyle= UITextBorderStyleNone;
    userNameField.font = [UIFont systemFontOfSize:15];
    userNameField.delegate=self;
    userNameField.returnKeyType = UIReturnKeyDone;
    userNameField.keyboardType = UIKeyboardTypeNumberPad;
    userNameField.clearButtonMode = UITextFieldViewModeWhileEditing;
    [userNameField addTarget:self action:@selector(textFieldChange:) forControlEvents:UIControlEventEditingChanged];
    [bgImageView addSubview:userNameField];
    
    
    UIImageView *lineImageView=[[UIImageView alloc]initWithFrame:CGRectMake(0, VIEW_POINT_MAX_Y(userNameField)-2, UI_SCREEN_WIDTH, .5f)];
    //    lineImageView.image =[UIImage imageNamed:@"line.png"];
    lineImageView.backgroundColor =UIColorFromRGB(0xdfdfdf);
    [bgImageView addSubview:lineImageView];
    
    
    UIImageView *passImageView=[[UIImageView alloc]initWithFrame:CGRectMake(10, 57.5f, 13, 19)];
    [passImageView setBackgroundColor:[UIColor clearColor]];
    [passImageView setImage:[UIImage imageNamed:@"passdWord"]];
    imageView.userInteractionEnabled = YES;
    [bgImageView addSubview:passImageView];
    
    
    passWordField =creatXRTextField(@"请输入密码，6-16位字符", CGRectMake(VIEW_POINT_MAX_X(passImageView) +8,44, 260, 44));
    passWordField.borderStyle= UITextBorderStyleNone;
    passWordField.font = [UIFont systemFontOfSize:15];
    passWordField.delegate = self;
    passWordField.returnKeyType = UIReturnKeyDone;
    passWordField.secureTextEntry  =YES;
    passWordField.clearButtonMode = UITextFieldViewModeWhileEditing;
    [passWordField addTarget:self action:@selector(textFieldChange:) forControlEvents:UIControlEventEditingChanged];
    [bgImageView addSubview:passWordField];
    
    
    UILabel *forgetLabel = [[UILabel alloc] initWithFrame:CGRectMake(250, bgImageView.frame.origin.y+bgImageView.frame.size.height+10, 60, 15)];
    forgetLabel.text = @"忘记密码?";
    forgetLabel.textColor = RGBA(151, 151, 151, 1);
    forgetLabel.font = [UIFont systemFontOfSize:13.0];
    forgetLabel.backgroundColor = [UIColor clearColor];
    
    [mScrollView addSubview:forgetLabel];
    
    
    UIButton *forgetBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    
    forgetBtn.frame = CGRectMake(250-5, forgetLabel.frame.origin.y, 65, 20);
    
    [forgetBtn addTarget:self action:@selector(forgetCode:) forControlEvents:UIControlEventTouchUpInside];
    
    [mScrollView addSubview:forgetBtn];
    
    
    
    UIButton *bnt=creatXRButton(CGRectMake(10, VIEW_POINT_MAX_Y(bgImageView) + 30, UI_SCREEN_WIDTH -20, 40),@"登录",nil,nil);
    [bnt setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    bnt.tag =UIBUTTON_TAG;
    [bnt setTintColor:[UIColor whiteColor]];
    bnt.backgroundColor = UIColorFromRGB(0xf18d00);
    [bnt addTarget:self action:@selector(loginButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [mScrollView addSubview:bnt];
    
    
    
//    //第三方登录
//    UIButton *sineLoginBnt=creatXRButton(CGRectMake(19, UI_SCREEN_HEIGHT - UI_NAVIGATION_BAR_HEIGHT -185, UI_SCREEN_WIDTH-38, 39),nil,[UIImage imageNamed:@"sine_nomale"] ,[UIImage imageNamed:@"sine_nomale"]);
//    sineLoginBnt.tag = UIBUTTON_TAG +5;
//    [sineLoginBnt addTarget:self action:@selector(loginButtonClick:) forControlEvents:UIControlEventTouchUpInside];
//    [mScrollView addSubview:sineLoginBnt];
//    
//    UIButton *qqLoginBnt=creatXRButton(CGRectMake(19, UI_SCREEN_HEIGHT -UI_NAVIGATION_BAR_HEIGHT -130, UI_SCREEN_WIDTH-38, 39), nil,[UIImage imageNamed:@"qq_nomale.png"] ,[UIImage imageNamed:@"qq_nomale.png"]);
//    qqLoginBnt.tag =UIBUTTON_TAG +10;
//    [qqLoginBnt addTarget:self action:@selector(loginButtonClick:) forControlEvents:UIControlEventTouchUpInside];
//    [mScrollView addSubview:qqLoginBnt];
//    
//    
//    //微博登录通知
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(wbLoginToservice:) name:@"wblogin" object:nil];

}

- (void)getLoginParms:(NSDictionary *)parms{
    if (!IS_NOT_EMPTY(userNameField.text)) {
        [XDTools showTips:@"请输入手机号" toView:self.contentView];
        return;
    }

    if (userNameField.text.length != 11) {
        [XDTools showTips:@"手机格式不正确" toView:self.view];
        return;
    }

    if (!IS_NOT_EMPTY(passWordField.text)) {
        [XDTools showTips:@"请输入密码" toView:self.contentView];
        return;
    }

    if (passWordField.text.length > 16 || passWordField.text.length < 6) {
        [XDTools showTips:@"请输入6-16位密码" toView:self.contentView];
        return;
    }

    if (![XDTools NetworkReachable]) {
        [XDTools showTips:brokenNetwork toView:self.view];
        return;
    }
    
    __block ASIFormDataRequest *request = [XDTools postRequestWithDict:parms API:API_LOGIN];
    
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
            
            [XDTools showTips:@"登录成功" toView:self.contentView];
            
            NSString * overdue = [[[NSUserDefaults standardUserDefaults] objectForKey:kMMyUserInfo] objectForKey:@"overdue"];
            if ([overdue isEqualToString:@"1"]){
                [XDTools setPushInfoType:@"2" andValue:@"1"];
            }
            
            [self backPrePage];

            
        }else{
//             [APService setTags:[NSSet setWithObject:@""] callbackSelector:nil object:nil];
            
            [XDTools showTips:[tempDic objectForKey:@"msg"] toView:self.view];
        }
        
    }];
    
    [request setFailedBlock:^{
//         [APService setTags:[NSSet setWithObject:@""] callbackSelector:nil object:nil];
        
        [XDTools hideProgress:self.view];
        NSError *error = [request error];
        DDLOG(@"error=%@",error);
    }];
    
    [XDTools showProgress:self.view];
    [request startAsynchronous];
    
}

-(void)loginButtonClick:(UIButton *)button{

    if (!IS_NOT_EMPTY(userNameField.text)) {
        [XDTools showTips:@"请输入手机号" toView:self.contentView];
        return;
    }
    
    if (![XDTools chickIphoneNumberRight:userNameField.text]){
        [XDTools showTips:@"请输入有效的手机号" toView:self.contentView];
        return;
    }

    if (!IS_NOT_EMPTY(passWordField.text)) {
        [XDTools showTips:@"请输入密码" toView:self.contentView];
        return;
    }

    if (passWordField.text.length > 16 ||passWordField.text.length < 6) {
        [XDTools showTips:@"请输入6-16位密码" toView:self.contentView];
        return;
    }



    NSDictionary *dic = @{@"loginType":@"1",
                          @"userName":userNameField.text,
                          @"password":[passWordField.text MD5Hash]};
    [self getLoginParms:dic];



}



#pragma mark  重写父类的方法和键盘消失
- (void)backPrePage
{
//    _tencentOAuth = nil;
//    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"wblogin" object:nil];
    [self.navigationController popViewControllerAnimated:YES];
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [UIView animateWithDuration:0.6 animations:^{
        mScrollView.contentOffset = CGPointMake(0, 0);
    }];
    [self keyBoardHide];
    
}
-(void)keyBoardHide{
    [userNameField resignFirstResponder];
    [passWordField resignFirstResponder];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)initRegisterButton
{
    UIButton *registerButton= [UIButton buttonWithType:UIButtonTypeCustom];
    //_leftBtn.frame = LEFTBUTTONFRAME(aHeight);
    CGFloat backForIOS6 =0;
    if (IOS7) {
        backForIOS6 = 20;
    }
    registerButton.frame = CGRectMake((UI_SCREEN_WIDTH - 44-10),backForIOS6, 44, 44);
    [registerButton setTitle:@"注册" forState:UIControlStateNormal];
    [registerButton setTintColor:[UIColor whiteColor]];
    
    [registerButton addTarget:self action:@selector(goToRegister) forControlEvents:UIControlEventTouchUpInside];
    registerButton.adjustsImageWhenHighlighted =NO;
    [self.navigationBarView addSubview:registerButton];
}


#pragma mark - scroller view 注销键盘
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    [userNameField resignFirstResponder];
    [passWordField resignFirstResponder];
}

//去注册
-(void)goToRegister{
    RegisterViewController *registerVC = [[RegisterViewController alloc] init];
    [self.navigationController pushViewController:registerVC animated:YES];
    
}

#pragma mark - TextField Delegate
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
//    if (!iPhone5) {
//        [UIView animateWithDuration:.3 animations:^{
//            mScrollView.contentOffset = CGPointMake(0, 30);
//        }];
//    }

    return YES;
}

-(void)textFieldChange:(UITextField *)textField
{
    if (IS_NOT_EMPTY(textField.text)){
        if (textField == userNameField){
            if (textField.text.length>11){
                userNameField.text = [textField.text substringToIndex:textField.text.length -1];
            }
        }else if(textField == passWordField){
            if (textField.text.length>16){
                passWordField.text = [textField.text substringToIndex:textField.text.length -1];
            }
        }
    }
}






- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    [UIView animateWithDuration:.3 animations:^{
        mScrollView.contentOffset = CGPointMake(0, 0);
    }];
    return YES;
}


//忘记密码
-(void)forgetCode:(UIButton *)btn{

    [self forgetCodeParms];
    
}


//忘记密码 接口

- (void)forgetCodeParms{
    RegisterViewController * forgetPW = [[RegisterViewController alloc] init];
    forgetPW.type = @"1";
    [self.navigationController pushViewController:forgetPW animated:YES];

}




-(void)viewWillDisappear:(BOOL)animated{
    
}


@end
