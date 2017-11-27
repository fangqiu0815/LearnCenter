//
//  ChangeCodeViewController.m
//  XDCommonApp
//
//  Created by wanglong8889@126.com on 14-6-12.
//  Copyright (c) 2014年 XD-XY. All rights reserved.
//

#import "ChangeCodeViewController.h"
#define XZB  20

@interface ChangeCodeViewController ()

@end

@implementation ChangeCodeViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.titleLabel.text = @"修改密码";
    
    [self createViews];
    // Do any additional setup after loading the view.
}


- (void)createViews{
    UIView * bg = [self createBgViewWithNumber:3 titleArray:@[@"当前密码",@"新密码",@"确认新密码"] y:10 labelWidth:70];

    oldTf = [self createTextFieldInView:bg WithFrame:CGRectMake(90, 7.5f, 230, 20) placeholder:nil];
    oldTf.placeholder = @"请输入密码";
    [oldTf addTarget:self action:@selector(textFieldChange:) forControlEvents:UIControlEventEditingChanged];
    oldTf.clearButtonMode = UITextFieldViewModeWhileEditing;
    newTf = [self createTextFieldInView:bg WithFrame:CGRectMake(90, 7.5f+35, 230, 20) placeholder:nil];
    newTf.placeholder = @"请输入新密码";
    [newTf addTarget:self action:@selector(textFieldChange:) forControlEvents:UIControlEventEditingChanged];
    newTf.clearButtonMode = UITextFieldViewModeWhileEditing;
    confirmTf = [self createTextFieldInView:bg WithFrame:CGRectMake(90, 7.5f+35*2, 230, 20) placeholder:nil];
    confirmTf.clearButtonMode = UITextFieldViewModeWhileEditing;
    confirmTf.placeholder = @"请确认新密码";
    [confirmTf addTarget:self action:@selector(textFieldChange:) forControlEvents:UIControlEventEditingChanged];
    oldTf.secureTextEntry = YES;
    newTf.secureTextEntry = YES;
    confirmTf.secureTextEntry = YES;

    UIButton * btn = [XDTools getAButtonWithFrame:CGRectMake(10, height_y(bg)+10, 300, 40) nomalTitle:@"修改" hlTitle:@"修改" titleColor:[UIColor whiteColor] bgColor:UIColorFromRGB(0xf18d00) nbgImage:nil hbgImage:nil action:@selector(changCodeAction:) target:self buttonTpye:UIButtonTypeCustom];
    [self.contentView addSubview:btn];
}

- (UIView *)createBgViewWithNumber:(int)number titleArray:(NSArray *)titleArray y:(float)height labelWidth:(float)width{
    UIView * bgView = [[UIView alloc] initWithFrame:CGRectMake(0, height+10, UI_SCREEN_WIDTH, 35*number)];
    bgView.backgroundColor = [UIColor whiteColor];
    [self.contentView addSubview:bgView];

    UIImageView * line = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, UI_SCREEN_WIDTH, .5f)];
    line.image = [UIImage imageNamed:@"line"];
    [bgView addSubview:line];

    for (int i = 0; i < number; i++) {
        UIImageView * line = [[UIImageView alloc] initWithFrame:CGRectMake(0, 35*(i+1)-.5f, UI_SCREEN_WIDTH, .5f)];
        line.image = [UIImage imageNamed:@"line"];
        [bgView addSubview:line];
    }


    for (int i = 0; i < number; i++) {
        UILabel * label = [XDTools addAlabelForAView:bgView withText:titleArray[i] frame:CGRectMake(10, 7.5f+35*i, width, 20) font:[UIFont systemFontOfSize:14] textColor:UIColorFromRGB(0x8d8d8d)];
        label.textAlignment = NSTextAlignmentRight;
        //        label.backgroundColor = [UIColor orangeColor];
    }

    return bgView;
}


- (UITextField *)createTextFieldInView:(UIView *)view WithFrame:(CGRect)frame placeholder:(NSString *)placeholder{
    UITextField * myTF = [[UITextField alloc] initWithFrame:frame];
    myTF.font = [UIFont systemFontOfSize:14];
    myTF.delegate = self;
    myTF.placeholder = placeholder;
    //        myTF.backgroundColor = [UIColor orangeColor];
    [view addSubview:myTF];
    return myTF;
}

- (void)save{
    [XDTools showTips:@"保存成功" toView:self.contentView];
    [self performSelector:@selector(backPrePage) withObject:nil afterDelay:1];
}

-(void)initChangeCodeViews{
    
    mScrollView =[[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, UI_SCREEN_WIDTH, UI_SCREEN_HEIGHT -UI_STATUS_BAR_HEIGHT -UI_STATUS_BAR_HEIGHT)];
    mScrollView.contentSize=CGSizeMake(UI_SCREEN_WIDTH, UI_SCREEN_HEIGHT -UI_STATUS_BAR_HEIGHT );
    mScrollView.scrollEnabled =YES;
    mScrollView.delegate = self;
    mScrollView.showsVerticalScrollIndicator = NO;
    [self.contentView addSubview:mScrollView];
    
    UIImageView *oldView = [[UIImageView alloc] initWithFrame:CGRectMake(XZB, 20, 281, 41)];
    [oldView setImage:[UIImage imageNamed:@"input_kuag"]];
    oldView.userInteractionEnabled = YES;
    
    [self.contentView addSubview:oldView];
    
    oldTf = [[UITextField alloc] initWithFrame:CGRectMake(5, 5,271, 31)];
    oldTf.borderStyle = UITextBorderStyleNone;
    oldTf.backgroundColor =  [UIColor clearColor];
    oldTf.placeholder = @"请输入现在的密码";
    oldTf.returnKeyType = UIReturnKeyDone;
    oldTf.textColor = [UIColor grayColor];
    
    
    oldTf.delegate = self;
    oldTf.font = [UIFont systemFontOfSize:15.0];
    oldTf.clearButtonMode = UITextFieldViewModeWhileEditing;
    [oldView addSubview:oldTf];
    
    
    
    //新密码
    UIImageView *newView = [[UIImageView alloc] initWithFrame:CGRectMake(XZB, 20+oldView.frame.origin.y+oldView.frame.size.height, 281, 41)];
    [newView setImage:[UIImage imageNamed:@"input_kuag"]];
    newView.userInteractionEnabled = YES;
    
    [self.contentView addSubview:newView];
    
    newTf = [[UITextField alloc] initWithFrame:CGRectMake(5, 5,271, 31)];
    newTf.borderStyle = UITextBorderStyleNone;
    newTf.backgroundColor =  [UIColor clearColor];
    newTf.placeholder = @"请输入新密码";
    newTf.returnKeyType = UIReturnKeyDone;
    newTf.textColor = [UIColor grayColor];
    
    
    newTf.delegate = self;
    newTf.font = [UIFont systemFontOfSize:15.0];
    newTf.clearButtonMode = UITextFieldViewModeWhileEditing;
    [newView addSubview:newTf];
    
    
    
    //确认密码
    
    UIImageView *confirmView = [[UIImageView alloc] initWithFrame:CGRectMake(XZB, 20+newView.frame.origin.y+newView.frame.size.height, 281, 41)];
    [confirmView setImage:[UIImage imageNamed:@"input_kuag"]];
    confirmView.userInteractionEnabled = YES;
    
    [self.contentView addSubview:confirmView];
    
    confirmTf = [[UITextField alloc] initWithFrame:CGRectMake(5, 5,271, 31)];
    confirmTf.borderStyle = UITextBorderStyleNone;
    confirmTf.backgroundColor =  [UIColor clearColor];
    confirmTf.placeholder = @"请输入确认密码";
    confirmTf.returnKeyType = UIReturnKeyDone;
    confirmTf.textColor = [UIColor grayColor];
    
    
    confirmTf.delegate = self;
    confirmTf.font = [UIFont systemFontOfSize:15.0];
    confirmTf.clearButtonMode = UITextFieldViewModeWhileEditing;
    [confirmView addSubview:confirmTf];
    
    [mScrollView addSubview:oldView];
    
    [mScrollView addSubview:newView];
    
    [mScrollView addSubview:confirmView];
    
    
    //修改按钮
    UIButton *getVerBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    getVerBtn.frame = CGRectMake(XZB, confirmView.frame.origin.y+confirmView.frame.size.height+50, 281, 40);
    [getVerBtn setBackgroundImage:[UIImage imageNamed:@"launch_btn"] forState:UIControlStateNormal];
    [getVerBtn setBackgroundImage:[UIImage imageNamed:@"launch_btn"] forState:UIControlStateHighlighted];
    [getVerBtn addTarget:self action:@selector(changCodeAction:) forControlEvents:UIControlEventTouchUpInside];
    [getVerBtn setTitle:@"修改密码" forState:UIControlStateNormal];
    [getVerBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    getVerBtn.titleLabel.font = [UIFont systemFontOfSize:15.0];
    
    [mScrollView addSubview:getVerBtn];
    
}



//修改密码
-(void)changCodeAction:(UIButton *)btn{
    if (!IS_NOT_EMPTY(oldTf.text)||!IS_NOT_EMPTY(newTf.text)||!IS_NOT_EMPTY(confirmTf.text)) {
        
        if(!IS_NOT_EMPTY(oldTf.text)){
            [XDTools showTips:@"请输入当前密码" toView:self.contentView];
            return;
        }
        if(!IS_NOT_EMPTY(newTf.text)){
            [XDTools showTips:@"请输入新密码" toView:self.contentView];
            return;
        }
        if(!IS_NOT_EMPTY(confirmTf.text)){
            [XDTools showTips:@"请输入确认密码" toView:self.contentView];
            return;
        }
    }else{
        NSString *oldPass = [oldTf.text MD5Hash];
        NSString *newPass = [newTf.text MD5Hash];
        if ([oldPass isEqualToString:newPass]) {
            [XDTools showTips:@"新旧密码不能重复" toView:self.contentView];
        }else{
            if (newTf.text.length>16||newTf.text.length<6){
                [XDTools showTips:@"请输入6-16位密码" toView:self.contentView];
                return;
            }
            if([newTf.text isEqualToString:confirmTf.text]){

                NSDictionary * infoDic = [[NSUserDefaults standardUserDefaults] objectForKey:kMMyUserInfo];
                NSDictionary *dic = @{@"userName":infoDic[@"userName"],
                                      @"password":oldPass,
                                      @"newPassword":newPass,
                                      @"uid":infoDic[@"uid"],
                                      @"token":infoDic[@"token"]};

                [self changeCodeParms:dic];
            }else{
                [XDTools showTips:@"两次密码不一致" toView:self.contentView];
            }
        }

    }
}


//修改密码
- (void)changeCodeParms:(NSDictionary *)parms{

    if (![XDTools NetworkReachable]) {
        [XDTools showTips:brokenNetwork toView:self.view];
        return;
    }
    
    __weak  ASIFormDataRequest *request = [XDTools postRequestWithDict:parms API:API_CHANGECODE];
    
    [request setCompletionBlock:^{
        [XDTools hideProgress:self.view];
        
        NSDictionary *tempDic = [XDTools  JSonFromString:[request responseString]];
        if([[tempDic objectForKey:@"result"]intValue] == 0){
            
            [XDTools showTips:@"修改密码成功" toView:self.view];
            [self performSelector:@selector(backPrePage) withObject:nil afterDelay:1];
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



- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}

-(void)textFieldChange:(UITextField *)textField
{
    if(IS_NOT_EMPTY(textField.text)){
        if (textField == oldTf){
            if (textField.text.length>16){
                oldTf.text = [textField.text substringToIndex:textField.text.length -1];
            }
        }else if (textField == newTf){
            if (textField.text.length>16){
                newTf.text = [newTf.text substringToIndex:textField.text.length -1];
            }
        }else if (textField ==  confirmTf){
            if (textField.text.length>16){
                confirmTf.text = [confirmTf.text substringToIndex:textField.text.length-1];
            }
        }
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    [oldTf resignFirstResponder];
    [newTf resignFirstResponder];
    [confirmTf resignFirstResponder];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
