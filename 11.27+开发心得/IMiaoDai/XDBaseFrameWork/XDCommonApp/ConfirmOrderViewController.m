//
//  ConfirmOrderViewController.m
//  XDCommonApp
//
//  Created by xindao on 14-8-4.
//  Copyright (c) 2014年 XD-XY. All rights reserved.
//

#import "ConfirmOrderViewController.h"
#import "MaterialsViewController.h"
#import "AddressCell.h"
#import "UIImageView+WebCache.h"
#import "AboutViewController.h"
#import "SuccessViewController.h"
#import "XieyiViewController.h"
#import "MyOrdersViewController.h"
@interface ConfirmOrderViewController ()

@end

@implementation ConfirmOrderViewController

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

    if ([_type isEqualToString:@"address"]) {
        self.titleLabel.text = @"收货地址";
    }else
    self.titleLabel.text = @"确认订单";

    dataArray = [[NSMutableArray alloc] init];
    dataArray2 = [[NSMutableArray alloc] init];
    dataArray3 = [[NSMutableArray alloc] init];

    baseInfoDict = [[NSMutableDictionary alloc] init];
    baseInfoErrorDict = [[NSMutableDictionary alloc] init];
    picInfoDict = [[NSMutableDictionary alloc] init];
    picInfoErrorDict = [[NSMutableDictionary alloc] init];
    otherInfoDict = [[NSMutableDictionary alloc] init];
    otherInfoErrorDict = [[NSMutableDictionary alloc] init];

    backScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, UI_SCREEN_WIDTH, UI_MAINSCREEN_HEIGHT - UI_NAVIGATION_BAR_HEIGHT)];
    backScrollView.contentSize = CGSizeMake(UI_SCREEN_WIDTH, 585);
    backScrollView.pagingEnabled = NO;
    backScrollView.delegate = self;
    [self.contentView addSubview:backScrollView];

    bgscrollviewSize = backScrollView.contentSize;



    UIImageView * IV = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, 300, 43/2.0f)];
    IV.image = [UIImage imageNamed:@"jdt01"];
    [backScrollView addSubview:IV];

    //bg1
    UIView * bg1 = [[UIView alloc] initWithFrame:CGRectMake(0, 41.5f, 320, 115)];
    bg1.backgroundColor = [UIColor whiteColor];
    [backScrollView addSubview:bg1];

    for (int i = 0; i < 3; i++) {
        int h = 0;
        if (!i) {
            h = 0;
        }else if (i == 1) {
            h = 75;
        }else{
            h = 114.5f;
        }
        UIImageView * line = [[UIImageView alloc] initWithFrame:CGRectMake(0, h, 320, .5f)];
        line.image = [UIImage imageNamed:@"line"];
        [bg1 addSubview:line];
    }

    headIV = [[UIImageView alloc] initWithFrame:CGRectMake(13, 10, 55, 55)];
    [headIV setImageWithURL:[NSURL URLWithString:_picStr] placeholderImage:[UIImage imageNamed:@"headerPlaceholder"]];
    [bg1 addSubview:headIV];

    titleLB = [XDTools addAlabelForAView:bg1 withText:_goodsName frame:CGRectMake(77,10,220,30) font:[UIFont systemFontOfSize:15] textColor:[UIColor blackColor]];
    canshuLB = [XDTools addAlabelForAView:bg1 withText:_canshu frame:CGRectMake(77,45,220,15) font:[UIFont systemFontOfSize:13] textColor:[UIColor grayColor]];
    payTypeLB = [XDTools addAlabelForAView:bg1 withText:[NSString stringWithFormat:@"分期：0首付，分%@期，月供%.2f元",_months,[_price floatValue]/100] frame:CGRectMake(13,85,290,20) font:[UIFont systemFontOfSize:13] textColor:[UIColor darkGrayColor]];//UIColorFromRGB(0xf18d00)
    NSArray * strArray = @[@"0",_months,[NSString stringWithFormat:@"%.2f",[_price floatValue]/100]];
    payTypeLB.attributedText = [XDTools getAcolorfulStringWithTextArray:strArray Color:UIColorFromRGB(0xf18d00) Font:[UIFont systemFontOfSize:13] AllText:payTypeLB.text];

    //bg2
    UIView * bg2 = [[UIView alloc] initWithFrame:CGRectMake(0, 166.5f, 320, 230)];
    bg2.backgroundColor = [UIColor whiteColor];
    [backScrollView addSubview:bg2];

    NSArray * nameArray = @[@"收货人姓名",@"联系电话",@"城市名称",@"学校名称",@"详细地址"];

    for (int i = 0; i < 6; i++) {
        int h = 0;
        if (i != 5) {
            h = i * 40;
            UILabel * label = [XDTools addAlabelForAView:bg2 withText:nameArray[i] frame:CGRectMake(0, 10+i*40, 80, 20) font:[UIFont systemFontOfSize:14] textColor:UIColorFromRGB(0x656565)];
            label.textAlignment = NSTextAlignmentRight;
            if (!i) {
                nameTF = [[UITextField alloc] initWithFrame:CGRectMake(VIEW_POINT_MAX_X(label)+10, 11+i*40, 220, 20)];
                nameTF.backgroundColor = [UIColor clearColor];
                nameTF.placeholder = @"请填写真实姓名";
                nameTF.clearButtonMode = UITextFieldViewModeWhileEditing;
                nameTF.font = [UIFont systemFontOfSize:14];
                [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(textFiledEditChanged:)
                                                            name:@"UITextFieldTextDidChangeNotification"
                                                          object:nameTF];
                nameTF.delegate = self;
                [bg2 addSubview:nameTF];
            }else if (i == 1) {
                phoneTF = [[UITextField alloc] initWithFrame:CGRectMake(VIEW_POINT_MAX_X(label)+10, 11+i*40, 200, 20)];
                phoneTF.backgroundColor = [UIColor clearColor];
                phoneTF.placeholder = @"请填写联系电话";
                phoneTF.font = [UIFont systemFontOfSize:14];
                phoneTF.delegate = self;
                [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(textFiledEditChanged:)
                                                            name:@"UITextFieldTextDidChangeNotification"
                                                          object:phoneTF];
                [bg2 addSubview:phoneTF];
            }else if (i == 2) {
//                cityLB = [XDTools addAlabelForAView:bg2 withText:@"" frame:CGRectMake(VIEW_POINT_MAX_X(label)+10, 10+i*40, 200, 20) font:[UIFont systemFontOfSize:14] textColor:UIColorFromRGB(0x656565)];
                
                cityContentLB = [[UILabel alloc] initWithFrame:CGRectMake(VIEW_POINT_MAX_X(label)+10, 10+i*40, 215, 20)];
                cityContentLB.backgroundColor = [UIColor clearColor];
                cityContentLB.font = [UIFont systemFontOfSize:14];
                cityContentLB.text = @"请填写城市名称";
                cityContentLB.textColor = UIColorFromRGB(0xc7c7cd);
                [bg2 addSubview:cityContentLB];
                
                UIImageView * img1 = [[UIImageView alloc] initWithFrame:CGRectMake(604/2.0f,13+i*40, 7, 14)];
                img1.image = [UIImage imageNamed:@"rightArrow"];
                img1.tag = 873751;
                [bg2 addSubview:img1];
                
                cityBtn = [XDTools getAButtonWithFrame:CGRectMake(VIEW_POINT_MAX_X(label)+10, 5+i*40, 200, 30) nomalTitle:nil hlTitle:nil titleColor:nil bgColor:[UIColor clearColor] nbgImage:nil hbgImage:nil action:@selector(chooseCity:) target:self buttonTpye:UIButtonTypeCustom];
                cityBtn.tag = 1000;
                [bg2 addSubview:cityBtn];
            }else if (i == 3) {
//                schoolLB = [XDTools addAlabelForAView:bg2 withText:@"" frame:CGRectMake(VIEW_POINT_MAX_X(label)+10, 10+i*40, 200, 20) font:[UIFont systemFontOfSize:14] textColor:UIColorFromRGB(0x656565)];
                
                schoolContentLB = [[UILabel alloc] initWithFrame:CGRectMake(VIEW_POINT_MAX_X(label)+10, 10+i*40, 215, 20)];
                schoolContentLB.backgroundColor = [UIColor clearColor];
                schoolContentLB.font = [UIFont systemFontOfSize:14];
                schoolContentLB.text = @"请填写学校名称";
                schoolContentLB.textColor = UIColorFromRGB(0xc7c7cd);
                [bg2 addSubview:schoolContentLB];
                
                UIImageView * img2 = [[UIImageView alloc] initWithFrame:CGRectMake(604/2.0f,13+i*40, 7, 14)];
                img2.image = [UIImage imageNamed:@"rightArrow"];
                img2.tag = 873752;
                [bg2 addSubview:img2];
                
                schoolBtn = [XDTools getAButtonWithFrame:CGRectMake(VIEW_POINT_MAX_X(label)+10, 5+i*40, 200, 30) nomalTitle:nil hlTitle:nil titleColor:nil bgColor:[UIColor clearColor] nbgImage:nil hbgImage:nil action:@selector(chooseCity:) target:self buttonTpye:UIButtonTypeCustom];
                schoolBtn.tag = 1001;
                [bg2 addSubview:schoolBtn];
            }else if (i == 4) {
                label.frame = CGRectMake(0, 172, 80, 20);
                
                addressTV = [[UITextView alloc] initWithFrame:CGRectMake(VIEW_POINT_MAX_X(label)+6, 5+i*40, 220, 60)];
                addressTV.delegate = self;
                addressTV.contentOffset = CGPointMake(0, 4);
                addressTV.font = [UIFont systemFontOfSize:14];
                addressTV.textColor = [UIColor blackColor];//UIColorFromRGB(0x656565);
                [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(textFiledEditChanged:)
                                                            name:@"UITextFieldTextDidChangeNotification"
                                                          object:addressTV];
                [bg2 addSubview:addressTV];
                
                
                addressPlaceholderLB = [[UILabel alloc] initWithFrame:CGRectMake(VIEW_POINT_MAX_X(label)+11.5, 7+i*40+5, 220, 20)];
                addressPlaceholderLB.backgroundColor = [UIColor clearColor];
                addressPlaceholderLB.font = [UIFont systemFontOfSize:14];
                addressPlaceholderLB.text = @"请填写详细地址";
                addressPlaceholderLB.textColor = UIColorFromRGB(0xc7c7cd);
                [bg2 addSubview:addressPlaceholderLB];
            }
        }else{
            h = 229.5f;
        }
        UIImageView * line = [[UIImageView alloc] initWithFrame:CGRectMake(0, h, 320, .5f)];
        line.image = [UIImage imageNamed:@"line"];
        [bg2 addSubview:line];

    }


    //bg3
    UIView * bg3 = [[UIView alloc] initWithFrame:CGRectMake(0, height_y(bg2)+10, 320, 40)];
    bg3.backgroundColor = [UIColor whiteColor];
    [backScrollView addSubview:bg3];

    for (int i = 0; i < 2; i++) {
        UIImageView * line = [[UIImageView alloc] initWithFrame:CGRectMake(0, i*39.5, 320, .5f)];
        line.image = [UIImage imageNamed:@"line"];
        [bg3 addSubview:line];
    }

    UILabel * label = [XDTools addAlabelForAView:bg3 withText:@"代理人手机" frame:CGRectMake(0, 10, 80, 20) font:[UIFont systemFontOfSize:14] textColor:UIColorFromRGB(0x656565)];
    label.textAlignment = NSTextAlignmentRight;

    proxyTF = [[UITextField alloc] initWithFrame:CGRectMake(VIEW_POINT_MAX_X(label)+10, 11, 200, 20)];
    proxyTF.placeholder = @"如有代理人请填写";
//    [proxyTF addTarget:self action:@selector(textFieldChange:) forControlEvents:UIControlEventEditingChanged];
    proxyTF.keyboardType = UIKeyboardTypeNumberPad;
    proxyTF.font = [UIFont systemFontOfSize:14];
    proxyTF.delegate = self;
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(textFiledEditChanged:)
                                                name:@"UITextFieldTextDidChangeNotification"
                                              object:proxyTF];
    [bg3 addSubview:proxyTF];


    //bottom
    agreementBtn = [XDTools getAButtonWithFrame:CGRectMake(10, height_y(bg3)+10-4, 50/2.0f, 50/2.0f) nomalTitle:nil hlTitle:nil titleColor:nil bgColor:[UIColor clearColor] nbgImage:@"agreement_desel" hbgImage:@"agreement_desel" action:@selector(agree) target:self buttonTpye:UIButtonTypeCustom];
    [agreementBtn setBackgroundImage:[UIImage imageNamed:@"agreement_sel"] forState:UIControlStateSelected];
    agreementBtn.selected = YES;
    [backScrollView addSubview:agreementBtn];

    UILabel * label1 = [XDTools addAlabelForAView:backScrollView withText:@"我已阅读并同意《喵贷分期服务协议》" frame:CGRectMake(VIEW_POINT_MAX_X(agreementBtn)-5,height_y(bg3)+10,250,16) font:[UIFont systemFontOfSize:14] textColor:[UIColor darkGrayColor]];
    label1.attributedText = [XDTools getAcolorfulStringWithText1:@"《喵贷分期服务协议》" Color1:UIColorFromRGB(0x005aff) Font1:[UIFont systemFontOfSize:14] Text2:nil Color2:nil Font2:nil AllText:label1.text];

    label2 = [XDTools addAlabelForAView:backScrollView withText:[NSString stringWithFormat:@"本商品将由%@为您发货",_bussinessName] frame:CGRectMake(0,height_y(label1)+10,320,16) font:[UIFont systemFontOfSize:14] textColor:[UIColor darkGrayColor]];
    label2.textAlignment = NSTextAlignmentCenter;
    label2.attributedText = [XDTools getAcolorfulStringWithText1:_bussinessName Color1:UIColorFromRGB(0xf18d00) Font1:[UIFont systemFontOfSize:14] Text2:nil Color2:nil Font2:nil AllText:label2.text];

    label3 = [XDTools addAlabelForAView:backScrollView withText:[NSString stringWithFormat:@"商家承诺：%@",_bussinessPromise] frame:CGRectMake(0,height_y(label2),320,16) font:[UIFont systemFontOfSize:14] textColor:[UIColor darkGrayColor]];
    label3.textAlignment = NSTextAlignmentCenter;

    upbtn = [XDTools getAButtonWithFrame:CGRectMake(10, height_y(label3)+10, 300, 40) nomalTitle:@"提交订单" hlTitle:@"提交订单" titleColor:[UIColor whiteColor] bgColor:UIColorFromRGB(0xf18d00) nbgImage:nil hbgImage:nil action:@selector(pushInfo) target:self buttonTpye:UIButtonTypeCustom];
    
    [backScrollView addSubview:upbtn];


    UIButton * xieyiButton = [UIButton buttonWithType:UIButtonTypeCustom];
    xieyiButton.frame = CGRectMake(135,VIEW_POINT_MIN_Y(agreementBtn)- 7 , 120, 30);
    xieyiButton.backgroundColor = [UIColor clearColor];
    [xieyiButton addTarget:self action:@selector(xieyiClick) forControlEvents:UIControlEventTouchUpInside];
    [backScrollView addSubview:xieyiButton];

//    NSDictionary * infoDic = [[NSUserDefaults standardUserDefaults] objectForKey:kMMyUserInfo];
//    NSDictionary *dict = @{@"uid":infoDic[@"uid"],
//                           @"token":infoDic[@"token"],
//                           @"userName":infoDic[@"userName"]
//                           };
//    [self getDataWithDict:dict api:API_GETFENGKONGINFO];

    [self reloadViews];

}

-(void)xieyiClick
{
//    AboutViewController * aboutVC = [[AboutViewController alloc] init];
//    aboutVC.titleString = @"喵贷分期服务协议";
//    aboutVC.urlString = JieDaiXieYiURLSTRING;
//    [self.navigationController pushViewController:aboutVC animated:YES];

    XieyiViewController * xieyi = [[XieyiViewController alloc] init];
    xieyi.type = @"serv";
    [self.navigationController pushViewController:xieyi animated:YES];

}


- (void)chooseCity:(UIButton *)button{
    [nameTF resignFirstResponder];
    [phoneTF resignFirstResponder];
    [addressTV resignFirstResponder];
    [proxyTF resignFirstResponder];
    
    if(button.tag == 1000){
        ChooseCityViewController * chooseVC = [[ChooseCityViewController alloc] init];
        chooseVC.titleString = @"城市名称";
        chooseVC.delegate =self;
        [self.navigationController pushViewController:chooseVC animated:YES];
    }else{
        if (!cityId){
            [XDTools showTips:@"请先选择城市名称" toView:self.contentView];
            return;
        }
        ChooseCityViewController * chooseVC = [[ChooseCityViewController alloc] init];
        chooseVC.titleString = @"学校名称";
        chooseVC.cityId = cityId;
        chooseVC.delegate =self;
        [self.navigationController pushViewController:chooseVC animated:YES];
    }
}

#pragma mark - 遍历数据库,通过id取name
-(NSString *)getNameWithTable:(NSString *)table andId:(NSString *)cid
{
    FMDatabase * db = [XDTools getDb];
    if (![db open]){
        DDLOG(@"open fail!");
        return nil;
    }

    NSString *queryString;
    if ([table isEqualToString:@"T_P_PROV_DEF"]) {
        queryString = [NSString stringWithFormat:@"SELECT * FROM %@ where PROV_ID = ?",table];
    }else if ([table isEqualToString:@"T_P_CITY"]) {
        queryString = [NSString stringWithFormat:@"SELECT * FROM %@ where CITY_ID = ?",table];
    }else{
        queryString = [NSString stringWithFormat:@"SELECT * FROM %@ where COLLAGE_ID = ?",table];
    }
    FMResultSet * rs = [db executeQuery:queryString,cid];
    while ([rs next]) {
        return [rs objectForColumnName:@"name"];
    }
    return nil;
}

#pragma mark - 选择所在地区
-(void)chooseProvienceidAndCityAndArea
{
    [nameTF resignFirstResponder];
    [phoneTF resignFirstResponder];
    [proxyTF resignFirstResponder];

    chooseAd_BgView.transform = CGAffineTransformMakeScale(0, 0);
    [UIView animateWithDuration:0.2 animations:^{
        chooseAd_BgView.transform = CGAffineTransformIdentity;
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.1 animations:^{
            chooseAd_BgView.transform=CGAffineTransformScale(chooseAd_BgView.transform, 1.1, 1.1);
        } completion:^(BOOL finished) {
            [UIView animateWithDuration:0.1 animations:^{
                chooseAd_BgView.transform = CGAffineTransformIdentity;
            } completion:^(BOOL finished) {

            }];
        }];
    }];
    [lastBtn setHidden:YES];
    [chooseAd_BgView setHidden:NO];

    addressLayer = @"T_P_PROV_DEF";
    [cityTableView reloadData];
}

- (void)agree{
    agreementBtn.selected = !agreementBtn.selected;
    if (!agreementBtn.selected){
        upbtn.backgroundColor = UIColorFromRGB(0xcbcbcb);
        upbtn.enabled = NO;
    }else{
       upbtn.backgroundColor = UIColorFromRGB(0xf18d00);
        upbtn.enabled = YES;
    }
}

- (void)pushInfo{

    [nameTF resignFirstResponder];
    [phoneTF resignFirstResponder];
    [addressTV resignFirstResponder];
    [proxyTF resignFirstResponder];


    if (!nameTF.text.length) {
        [XDTools showTips:@"请填写收货人姓名" toView:self.contentView];
        return;
    }
    

    if (nameTF.text.length < 2 || ![XDTools chickTextIsChinese:nameTF.text]) {
        [XDTools showTips:@"姓名请填写2-10个汉字" toView:self.contentView];
        return;
    }

    if (phoneTF.text.length != 11) {
        [XDTools showTips:@"请输入11位手机号" toView:self.contentView];
        return;
    }
    
    if (!cityId) {
        [XDTools showTips:@"请填写城市名称" toView:self.contentView];
        return;
    }
    if (!schoolId) {
        [XDTools showTips:@"请填写学校名称" toView:self.contentView];
        return;
    }
    
    if (!addressTV.text.length) {
        [XDTools showTips:@"请填写详细地址" toView:self.contentView];
        return;
    }
    
    if (addressTV.text.length < 6) {
        [XDTools showTips:@"详细地址最少6个汉字" toView:self.contentView];
        return;
    }

    if (![XDTools chickIphoneNumberRight:phoneTF.text]) {
        [XDTools showTips:@"请输入有效手机号" toView:self.view];
        return;
    }

    if (!agreementBtn.selected) {
        [XDTools showTips:@"请先遵守喵贷借贷协议！" toView:self.contentView];
        return;
    }

    if (proxyTF.text.length) {
        if(![XDTools chickIphoneNumberRight:proxyTF.text]){
            [XDTools showTips:@"请填写有效手机号码" toView:self.contentView];
            return;
        }
    }

    
    [self putUpOrder];


}


- (void)putUpOrder{
    if ([XDTools NetworkReachable])
    {
        if ([_type isEqualToString:@"address"]) {
            //提交收货地址

        }else{
            NSDictionary * infoDic = [[NSUserDefaults standardUserDefaults] objectForKey:kMMyUserInfo];

            NSMutableDictionary * dic = [NSMutableDictionary dictionaryWithDictionary:@{@"productId": _goodsId,
                                                                                        @"paymentId": _months,
                                                                                        @"shopName": nameTF.text,
                                                                                        @"telephone": phoneTF.text,
                                                                                        @"city": cityId,
                                                                                        @"school": schoolId,
                                                                                        @"address": addressTV.text,
                                                                                        @"uid": infoDic[@"uid"],
                                                                                        @"token": infoDic[@"token"],
                                                                                        @"userName": infoDic[@"userName"]
                                                                                        }];



            if (proxyTF.text.length) {
                [dic setObject:proxyTF.text forKey:@"agentId"];
            }

            ASIHTTPRequest *request = [XDTools postRequestWithDict:dic API:API_PUSHORDER];

            __weak ASIHTTPRequest * mrequest = request;

            [request setCompletionBlock:^{

                [XDTools hideProgress:self.contentView];

                NSDictionary *tempDic = [XDTools JSonFromString:[mrequest responseString]];

                NSUserDefaults * user = [NSUserDefaults standardUserDefaults];
                if (proxyTF.text.length) {
                    [user setObject:@{@"name": nameTF.text,
                                      @"cityId":cityId,
                                      @"schoolId":schoolId,
                                      @"telephone":phoneTF.text,
                                      @"address":addressTV.text,
                                      @"proxy":proxyTF.text} forKey:@"shortTimeInfo"];
                }else{
                    [user setObject:@{@"name": nameTF.text,
                                      @"cityId":cityId,
                                      @"schoolId":schoolId,
                                      @"telephone":phoneTF.text,
                                      @"address":addressTV.text} forKey:@"shortTimeInfo"];
                }

                [user synchronize];

                if ([[tempDic objectForKey:@"result"] isEqualToString:@"0"])
                {


                    [XDTools showTips:@"提交订单成功！" toView:self.contentView];

                    NSDictionary * infoDic = [[NSUserDefaults standardUserDefaults] objectForKey:kMMyUserInfo];
                    if ([infoDic[@"status"] intValue] == 21) {
                        SuccessViewController * success = [[SuccessViewController alloc] init];
                        [self.navigationController pushViewController:success animated:YES];
                    }else{

                        MaterialsViewController * material = [[MaterialsViewController alloc] init];
                        [self.navigationController pushViewController:material animated:YES];

                    }
                }
                else if([[tempDic objectForKey:@"result"] isEqualToString:@"1"])
                {
//                    [XDTools showTips:[tempDic objectForKey:@"msg"] toView:self.view];
                    UIAlertView * alert = [[UIAlertView alloc] initWithTitle:nil message:tempDic[@"msg"] delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定",nil];
                    alert.tag = 128770;
                    [alert show];
                }
                else if ([[tempDic objectForKey:@"result"] isEqualToString:@"MP0001"]) {
                    UIAlertView * alert = [[UIAlertView alloc] initWithTitle:nil message:tempDic[@"msg"] delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"马上填写",nil];
                    alert.tag = 128771;
                    [alert show];
                }else{
                    UIAlertView * alert = [[UIAlertView alloc] initWithTitle:nil message:tempDic[@"msg"] delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"查看订单",nil];
                    alert.tag = 128772;
                    [alert show];
                }
            }];

            [request setFailedBlock:^{

                [XDTools hideProgress:self.contentView];
                NSError *error = [mrequest error];
                DDLOG_CURRENT_METHOD;
                DDLOG(@"error=%@",error);
                if (mrequest.error.code == 2) {
                    [XDTools showTips:@"网络请求超时" toView:self.view];
                }
            }];
            
            [XDTools showProgress:self.contentView];
            [request startAsynchronous];
        }
        
    }
    else
    {
        [XDTools showTips:brokenNetwork toView:self.view];
        
    }

}



-(void)getDataWithDict:(NSDictionary *)dict api:(NSString *)api
{

    if (![XDTools NetworkReachable]) {
        [XDTools showTips:brokenNetwork toView:self.contentView];
        return;
    }

    __weak ASIHTTPRequest *request = [XDTools postRequestWithDict:dict API:api];
    [request setCompletionBlock:^{
        [XDTools hideProgress:self.contentView];

        NSDictionary *tempDic = [XDTools  JSonFromString:[request responseString]];

        if([[tempDic objectForKey:@"result"]intValue] == 0){

            DDLOG(@"dic = %@",tempDic);

            baseInfoDict = [NSMutableDictionary dictionaryWithDictionary:tempDic[@"data"][@"baseInfo"]];

            nameTF.text = baseInfoDict[@"name"];
            if (nameTF.text.length) {
                nameTF.userInteractionEnabled = NO;
            }

            if ([baseInfoDict[@"cityId"] length]) {
                cityId = baseInfoDict[@"cityId"];
                oldCityId = baseInfoDict[@"cityId"];
                cityContentLB.text = [self matchingCity:baseInfoDict[@"cityId"]];
                cityContentLB.textColor = [UIColor blackColor];
                UIImageView * iv = (UIImageView *)[self.view viewWithTag:873751];
                iv.hidden = YES;
                cityBtn.userInteractionEnabled = NO;
            }

            if ([baseInfoDict[@"schoolId"] length]) {
                schoolId = baseInfoDict[@"schoolId"];
                schoolContentLB.text = [self matchingSchool:baseInfoDict[@"schoolId"]];
                schoolContentLB.textColor = [UIColor blackColor];
                UIImageView * iv = (UIImageView *)[self.view viewWithTag:873752];
                iv.hidden = YES;
                schoolBtn.userInteractionEnabled = NO;
            }

        }else{
            [XDTools showTips:tempDic[@"msg"] toView:self.view];

        }

    }];

    [request setFailedBlock:^{
        [XDTools hideProgress:self.contentView];
    }];
    [request startAsynchronous];
    [XDTools showProgress:self.contentView];
}

- (void)reloadViews{
    NSDictionary * shortTimeInfo = [[NSUserDefaults standardUserDefaults] objectForKey:@"shortTimeInfo"];
    NSDictionary * infoDic = [[NSUserDefaults standardUserDefaults] objectForKey:kMMyUserInfo];

    phoneTF.text = infoDic[@"userName"];
    if (phoneTF.text.length) {
        phoneTF.userInteractionEnabled = NO;
    }

    if ([infoDic[@"status"] intValue] == 21) {
        NSDictionary * infoDic = [[NSUserDefaults standardUserDefaults] objectForKey:kMMyUserInfo];
        NSDictionary *dict = @{@"uid":infoDic[@"uid"],
                               @"token":infoDic[@"token"],
                               @"userName":infoDic[@"userName"]
                               };
        [self getDataWithDict:dict api:API_GETFENGKONGINFO];

    }else if (shortTimeInfo) {

        nameTF.text = shortTimeInfo[@"name"];
        if (nameTF.text.length) {
            nameTF.userInteractionEnabled = NO;
        }

        if ([shortTimeInfo[@"cityId"] length]) {
            cityId = shortTimeInfo[@"cityId"];
            oldCityId = shortTimeInfo[@"cityId"];
            cityContentLB.text = [self matchingCity:shortTimeInfo[@"cityId"]];
            cityContentLB.textColor = [UIColor blackColor];
            UIImageView * iv = (UIImageView *)[self.view viewWithTag:873751];
            iv.hidden = YES;
            cityBtn.userInteractionEnabled = NO;
        }

        if ([shortTimeInfo[@"schoolId"] length]) {
            schoolId = shortTimeInfo[@"schoolId"];
            schoolContentLB.text = [self matchingSchool:shortTimeInfo[@"schoolId"]];
            schoolContentLB.textColor = [UIColor blackColor];
            UIImageView * iv = (UIImageView *)[self.view viewWithTag:873752];
            iv.hidden = YES;
            schoolBtn.userInteractionEnabled = NO;
        }

        if ([shortTimeInfo[@"address"] length]) {
            addressTV.text = shortTimeInfo[@"address"];
            addressPlaceholderLB.hidden = YES;
        }

        if ([shortTimeInfo[@"proxy"] length]) {
            proxyTF.text = shortTimeInfo[@"proxy"];
            proxyTF.textColor = [UIColor blackColor];
        }

    }
    

}

//匹配城市
-(NSString *)matchingCity:(NSString *)aCity
{
    [dataArray removeAllObjects];
    FMDatabase * db = [XDTools getDb];
    if (![db open]){
        DDLOG(@"open fail!");
        return nil;
    }
    NSString *queryString = [NSString stringWithFormat:@"SELECT * FROM T_P_CITY WHERE CITY_ID = %@",aCity];

    FMResultSet * rs = [db executeQuery:queryString];
    NSString * cityName;
    while ([rs next]) {
        cityName = [rs objectForColumnName:@"CITY_NAME"];
    }
    [db close];
    return cityName;

}

//匹配学校
-(NSString *)matchingSchool:(NSString *)aSchool
{
    [dataArray removeAllObjects];
    FMDatabase * db = [XDTools getDb];
    if (![db open]){
        DDLOG(@"open fail!");
        return nil;
    }
    NSString *queryString = [NSString stringWithFormat:@"SELECT * FROM T_P_COLLAGE WHERE COLLAGE_ID = %@",aSchool];

    FMResultSet * rs = [db executeQuery:queryString];
    NSString * collageName;
    while ([rs next]) {
        collageName = [rs objectForColumnName:@"COLLAGE_NAME"];

    }
    [db close];

    return collageName;

}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{

    if (scrollView.dragging){
        [nameTF resignFirstResponder];
        [phoneTF resignFirstResponder];
        [addressTV resignFirstResponder];
        [proxyTF resignFirstResponder];
    }else{
    
    }
}


-(void)textFiledEditChanged:(NSNotification *)obj{
    UITextField *textField = (UITextField *)obj.object;

    int length = 0;

    if (textField == nameTF) {
        length = 10;
    }else if (textField == phoneTF) {
        length = 11;
    }else if (textField == proxyTF) {
        length = 11;
    }else
        length = 50;

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





- (void)textFieldDidBeginEditing:(UITextField *)textField{
    if ([_type isEqualToString:@"address"]) {
        return;
    }
    if (textField == proxyTF) {
        [UIView animateWithDuration:.3f animations:^{
            backScrollView.contentOffset = CGPointMake(0, 240+80);
        }];
    }
}



//-(void)textFieldChange:(UITextField *)textField
//{
//    if(IS_NOT_EMPTY(textField.text)){
//        if (textField == proxyTF){
//            if (textField.text.length>11){
//                proxyTF.text = [proxyTF.text substringToIndex:textField.text.length -1];
//            }
//        }else if (textField == nameTF){
//            if (textField.text.length>10){
//                nameTF.text = [textField.text substringToIndex:textField.text.length -1];
//            }
//        }else if(textField == phoneTF){
//            if (textField.text.length>11){
//                phoneTF.text = [textField.text substringToIndex:textField.text.length -1];
//            }
//        }
//    }
//}

- (void)textViewDidBeginEditing:(UITextView *)textView{
    if ([_type isEqualToString:@"address"]) {
        return;
    }
    if (textView == addressTV) {
        [UIView animateWithDuration:.3f animations:^{
            backScrollView.contentOffset = CGPointMake(0, 240+80);
        }];
    }
}

-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if (range.length == 1){
        return YES;
    }
    
    if ([@"\n" isEqualToString:text] == YES)
    {
//        [textView resignFirstResponder];
//        [UIView animateWithDuration:.3 animations:^{
//            backScrollView.contentOffset = CGPointMake(0, 0);
//        }];
        return NO;
    }
    
    if ([textView.text length]<50){
        return YES;
    }
    return NO;
}

- (void)textViewDidChange:(UITextView *)textView{
    if (textView.text.length) {
        addressPlaceholderLB.hidden = YES;
    }else{
        addressPlaceholderLB.hidden = NO;
    }
}


#pragma mark choosecityDelegate
-(void)chooseCityOrScholl:(NSDictionary *)dict andTitle:(NSString *)tilte
{
    if ([tilte isEqualToString:@"城市名称"]){
        cityContentLB.text = [dict valueForKey:@"name"];
        cityContentLB.textColor = [UIColor blackColor];
        cityId = [dict valueForKey:@"id"];
        if (cityId.intValue != oldCityId.intValue) {
            schoolId = @"";
            schoolContentLB.text = @"请填写学校名称";
            schoolContentLB.textColor = UIColorFromRGB(0xc7c7cd);
        }
    }else{
        schoolContentLB.text = [dict valueForKey:@"name"];
        schoolContentLB.textColor = [UIColor blackColor];
        schoolId = [NSString stringWithFormat:@"%@",[dict valueForKey:@"id"]];
    }
}

- (void)backPrePage
{
    UIAlertView * al = [[UIAlertView alloc] initWithTitle:@"" message:@"喵~你要放弃本订单吗？" delegate:self cancelButtonTitle:@"离开" otherButtonTitles:@"留下", nil];
    al.tag = 1321;
    [al show];
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (alertView.tag == 1321){
        if (buttonIndex){
            
        }else{
            [self.navigationController popViewControllerAnimated:YES];
            
        }
    }else if (alertView.tag == 128771) {
        if (buttonIndex){
            MaterialsViewController * material = [[MaterialsViewController alloc] init];
            material.type = @"2";
            [self.navigationController pushViewController:material animated:YES];
        }else{

        }
    }else if (alertView.tag == 128772) {
        if (buttonIndex){
            MyOrdersViewController * orders = [[MyOrdersViewController alloc] init];
            [self.navigationController pushViewController:orders animated:YES];
        }else{

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
