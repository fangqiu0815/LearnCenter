//
//  BankCardViewController.m
//  XDCommonApp
//
//  Created by xindao on 14-8-7.
//  Copyright (c) 2014年 XD-XY. All rights reserved.
//

#import "BankCardViewController.h"
#import "MaterialsViewController.h"
@interface BankCardViewController ()

@end

@implementation BankCardViewController
{
    int  passwordLegth;
}
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

    self.titleLabel.text = @"银行卡信息";
    passwordLegth =0;
    UIView * bg = [self createBgViewWithNumber:2 titleArray:@[@"银行卡号",@"银行名称"] y:10 labelWidth:60];

    cardNumberTF = [self createTextFieldInView:bg WithFrame:CGRectMake(80, 7.5f, 200, 20) placeholder:@"请填写银行卡号"];
    cardNumberTF.keyboardType = UIKeyboardTypeNumberPad;
    cardNumberTF.clearsOnBeginEditing =YES;

    bankNameTF = [self createTextFieldInView:bg WithFrame:CGRectMake(80, 7.5f+35, 200, 20) placeholder:@"请填写银行名称"];
    bankNameTF.clearsOnBeginEditing =YES;

    [cardNumberTF addTarget:self action:@selector(textFieldChange:) forControlEvents:UIControlEventEditingChanged];
    [bankNameTF addTarget:self action:@selector(textFieldChange:) forControlEvents:UIControlEventEditingChanged];

    saveBtn = [XDTools getAButtonWithFrame:CGRectMake(10, height_y(bg)+10, 300, 40) nomalTitle:@"保存" hlTitle:@"保存" titleColor:[UIColor whiteColor] bgColor:UIColorFromRGB(0xf18d00) nbgImage:nil hbgImage:nil action:@selector(save) target:self buttonTpye:UIButtonTypeCustom];
    [self.contentView addSubview:saveBtn];

    if (_infoDict) {
        if ([_infoDict[@"bankName"] length]) {
            bankNameTF.text = _infoDict[@"bankName"];
        }
        if ([_infoDict[@"bankCardCode"] length]) {
            oldCardNumber = _infoDict[@"bankCardCode"];
            NSMutableString * card = [NSMutableString stringWithFormat:@"%@",_infoDict[@"bankCardCode"]];
            [card replaceCharactersInRange:NSMakeRange(0, 12) withString:@"************"];
            [card insertString:@" " atIndex:4];
            [card insertString:@" " atIndex:9];
            if (card.length > 14) {
                [card insertString:@" " atIndex:14];
            }

            if (card.length > 19) {
                [card insertString:@" " atIndex:19];
            }
            cardNumberTF.text = card;
        }
    }

    if (_errorDict.count) {
        NSArray * titleArray1 = @[@"bankCardCode",@"bankName"];

        [self showErrorInfoWithTitleArray:titleArray1 bgView:bg];


    }

    //状态不等于00、01、22，不可以修改资料
    NSDictionary * infoDic = [[NSUserDefaults standardUserDefaults] objectForKey:kMMyUserInfo];
    if ([infoDic[@"status"] intValue] != 0 && [infoDic[@"status"] intValue] != 1 && [infoDic[@"status"] intValue] != 22) {
        for (UITextField * myTF in bg.subviews) {
            myTF.userInteractionEnabled = NO;

        }

        saveBtn.hidden = YES;

    }

    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(textFiledEditChanged:)
                                                name:@"UITextFieldTextDidChangeNotification"
                                              object:bankNameTF];


}

- (void)showErrorInfoWithTitleArray:(NSArray *)titleArray bgView:(UIView *)bgView{
    for (int i = 0; i < titleArray.count; i++) {
        if ([_errorDict[titleArray[i]] length]) {
            UILabel * errorLB = (UILabel *)[bgView viewWithTag:135791+i];
            errorLB.textColor = [UIColor redColor];
        }
    }
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
        label.tag = 135791+i;
        //        label.backgroundColor = [UIColor orangeColor];
    }

    return bgView;
}


- (UITextField *)createTextFieldInView:(UIView *)view WithFrame:(CGRect)frame placeholder:(NSString *)placeholder{
    UITextField * myTF = [[UITextField alloc] initWithFrame:frame];
    myTF.font = [UIFont systemFontOfSize:14];
    myTF.delegate = self;
    myTF.placeholder = placeholder;


    myTF.borderStyle= UITextBorderStyleNone;
    myTF.returnKeyType = UIReturnKeyDone;
    myTF.clearButtonMode = UITextFieldViewModeWhileEditing;
//        myTF.backgroundColor = [UIColor orangeColor];
    [view addSubview:myTF];
    return myTF;
}

- (void)save{
    if (!IS_NOT_EMPTY(cardNumberTF.text)||!IS_NOT_EMPTY(bankNameTF.text)) {
        [XDTools showTips:@"信息不能为空" toView:mKeyWindow];
    }else{

        if (cardNumberTF.userInteractionEnabled == NO && bankNameTF.userInteractionEnabled == NO) {
            [self.navigationController popViewControllerAnimated:YES];
            return;
        }
        
        NSArray * arr = [cardNumberTF.text componentsSeparatedByString:@" "];
        NSMutableString * cardNumber = [NSMutableString stringWithFormat:@"%@",arr[0]];
        for (int i = 1; i < arr.count; i++) {
            if (IS_NOT_EMPTY(arr[i])) {
                [cardNumber appendString:arr[i]];
            }
        }
        if ([cardNumber hasPrefix:@"****"]) {
            cardNumber = [NSMutableString stringWithFormat:@"%@",oldCardNumber];
        }

        NSString * bankName = bankNameTF.text;
        
        if (bankNameTF.text.length<4||bankNameTF.text.length>10){
            [XDTools showTips:@"请填写银行名称，4-10个汉字" toView:mKeyWindow];
            return;
        }
        if (![XDTools chickTextIsChinese:bankNameTF.text]){
            [XDTools showTips:@"请填写银行名称，4-10个汉字" toView:mKeyWindow];
            return;
        }
        
        NSDictionary * infoDic = [[NSUserDefaults standardUserDefaults] objectForKey:kMMyUserInfo];
        NSDictionary *dic = @{@"userName":infoDic[@"userName"],
                              @"bankName":bankName,
                              @"bankCardCode":cardNumber,
                              @"uid":infoDic[@"uid"],
                              @"token":infoDic[@"token"]};


        [self changeInfoParms:dic];


    }
}


- (void)changeInfoParms:(NSDictionary *)parms{

    if (![XDTools NetworkReachable]) {
        [XDTools showTips:brokenNetwork toView:self.view];
        return;
    }


    __weak  ASIFormDataRequest *request = [XDTools postRequestWithDict:parms API:API_UPDATEUSERBANKINFO];

    [request setCompletionBlock:^{
        [XDTools hideProgress:self.view];

        NSDictionary *tempDic = [XDTools  JSonFromString:[request responseString]];
        if([[tempDic objectForKey:@"result"]intValue] == 0){

            [XDTools showTips:@"信息保存成功" toView:self.view];

            NSMutableDictionary * infoDic = [NSMutableDictionary dictionaryWithDictionary:[[NSUserDefaults standardUserDefaults] objectForKey:kMMyUserInfo]];
            [infoDic setObject:@"1" forKey:@"otherInfo"];

            NSUserDefaults *userDef=[NSUserDefaults standardUserDefaults];
            //存登录信息

            [userDef setObject:infoDic forKey:kMMyUserInfo];
            [userDef synchronize];

            [self.delegate refreshStatus:@"3"];

            self.mmmVC.isreflash = NO;

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
    [bankNameTF resignFirstResponder];
    [cardNumberTF resignFirstResponder];
    return YES;
}

-(void)textFieldChange:(UITextField *)textField
{
    if (IS_NOT_EMPTY(textField.text)){


        if (textField == cardNumberTF){

            if (textField.text.length > passwordLegth){
                if (textField.text.length == 4) {
                    cardNumberTF.text = [textField.text stringByAppendingString:@" "];
                    isAdd = YES;
                }else if (textField.text.length == 9) {
                    cardNumberTF.text = [textField.text stringByAppendingString:@" "];
                    isAdd = YES;
                }else if (textField.text.length == 14) {
                    cardNumberTF.text = [textField.text stringByAppendingString:@" "];
                    isAdd = YES;
                }else if (textField.text.length == 19) {
                    cardNumberTF.text = [textField.text stringByAppendingString:@" "];
                    isAdd = YES;
                }
            }else if (textField.text.length < passwordLegth) {
                if (textField.text.length == 5) {
                    cardNumberTF.text = [textField.text substringToIndex:textField.text.length -2];
                    isAdd = YES;
                }else if (textField.text.length == 10) {
                    cardNumberTF.text = [textField.text substringToIndex:textField.text.length -2];
                    isAdd = YES;
                }else if (textField.text.length == 15) {
                    cardNumberTF.text = [textField.text substringToIndex:textField.text.length -2];
                    isAdd = YES;
                }else if (textField.text.length == 20) {
                    cardNumberTF.text = [textField.text substringToIndex:textField.text.length -2];
                    isAdd = YES;
                }
            }


            if (textField.text.length>24){
                cardNumberTF.text = [textField.text substringToIndex:textField.text.length -1];
            }
        }
    }
    if (IS_NOT_EMPTY(textField.text)){
        passwordLegth = textField.text.length;
    }else{
        passwordLegth = 0;
    }
}

-(void)textFiledEditChanged:(NSNotification *)obj{
    UITextField *textField = (UITextField *)obj.object;

    int length = 0;

    if (textField == bankNameTF) {
        length = 10;
    }

    NSString *toBeString = textField.text;
    NSString *lang = [[UITextInputMode currentInputMode] primaryLanguage]; // 键盘输入模式
    if ([lang isEqualToString:@"zh-Hans"]) { // 简体中文输入，包括简体拼音，健体五笔，简体手写
        UITextRange *selectedRange = [textField markedTextRange];
        //获取高亮部分
        UITextPosition *position = [textField positionFromPosition:selectedRange.start offset:0];
        // 没有高亮选择的字，则对已输入的文字进行字数统计和限制
        if (!position) {
            if (toBeString.length > length) {
                textField.text = [toBeString substringToIndex:length];
            }
        }
        // 有高亮选择的字符串，则暂不对文字进行统计和限制
        else{

        }
    }
    // 中文输入法以外的直接对其统计限制即可，不考虑其他语种情况
    else{
        if (toBeString.length > length) {
            textField.text = [toBeString substringToIndex:length];
        }
    }
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
