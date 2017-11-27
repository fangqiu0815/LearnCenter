//
//  MaterialsViewController.m
//  XDCommonApp
//
//  Created by xindao on 14-8-6.
//  Copyright (c) 2014年 XD-XY. All rights reserved.
//

#import "MaterialsViewController.h"
#import "SuccessViewController.h"
#import "PersonInfoViewController.h"
#import "ZhengJianUploadViewController.h"
#import "BankCardViewController.h"
#import <AddressBook/AddressBook.h>
#import <AddressBookUI/AddressBookUI.h>
@interface MaterialsViewController ()

@end

@implementation MaterialsViewController

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];

    if (!_isreflash) {
        NSDictionary * infoDic = [[NSUserDefaults standardUserDefaults] objectForKey:kMMyUserInfo];
        NSDictionary *dict = @{@"uid":infoDic[@"uid"],
                               @"token":infoDic[@"token"],
                               @"userName":infoDic[@"userName"]
                               };
        [self getDataWithDict:dict api:API_GETFENGKONGINFO];

        _isreflash = YES;
    }


}

- (void)viewDidLoad{
    [super viewDidLoad];

    self.titleLabel.text = @"申请资料";

//    if (self.type.intValue == 2) {
        _baseInfoDict = [[NSMutableDictionary alloc] init];
        _baseInfoErrorDict = [[NSMutableDictionary alloc] init];
        _picInfoDict = [[NSMutableDictionary alloc] init];
        _picInfoErrorDict = [[NSMutableDictionary alloc] init];
        _otherInfoDict = [[NSMutableDictionary alloc] init];
        _otherInfoErrorDict = [[NSMutableDictionary alloc] init];
//    }

//    self.isreflash = YES;

    self.leftBtn.hidden = YES;

    UIImageView * IV = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, 300, 43/2.0f)];
    IV.image = [UIImage imageNamed:@"jdt02"];
    [self.contentView addSubview:IV];

    UIView * bg1 = [[UIView alloc] initWithFrame:CGRectMake(0, 43/2.0f+20, 320, 135)];
    bg1.backgroundColor = [UIColor whiteColor];
    [self.contentView addSubview:bg1];


    float height = 55;
    if (_type.intValue == 2) {
        height = 0;
    }

    for (int i = 0; i < 2; i++) {
        UIImageView * line = [[UIImageView alloc] initWithFrame:CGRectMake(0, i*79.5f+height, 320, .5f)];
        line.image = [UIImage imageNamed:@"line"];
        [bg1 addSubview:line];
    }

    UILabel * label1 = [XDTools addAlabelForAView:bg1 withText:@"喵~订单已提交" frame:CGRectMake(0,12.5f,320,15) font:[UIFont systemFontOfSize:14] textColor:UIColorFromRGB(0x696969)];
    UILabel * label2 = [XDTools addAlabelForAView:bg1 withText:@"请尽快填写一下申请资料哦" frame:CGRectMake(0,12.5+15,320,15) font:[UIFont systemFontOfSize:14] textColor:UIColorFromRGB(0x696969)];
    label1.textAlignment = NSTextAlignmentCenter;
    label2.textAlignment = NSTextAlignmentCenter;



    NSArray * nameArray = @[@"个人信息",@"证件上传"];
    for (int i = 0; i < 2; i++) {
        UIImageView * line = [[UIImageView alloc] initWithFrame:CGRectMake(0, height+40*i, UI_SCREEN_WIDTH, .5f)];
        line.image = [UIImage imageNamed:@"line"];
        [bg1 addSubview:line];

        UIImageView * leftIcon = [[UIImageView alloc] initWithFrame:CGRectMake(10, height+9+40*i, 23, 22)];
        leftIcon.image = [UIImage imageNamed:[NSString stringWithFormat:@"fk0%d",i+1]];
        [bg1 addSubview:leftIcon];

        [XDTools addAlabelForAView:bg1 withText:nameArray[i] frame:CGRectMake(VIEW_POINT_MAX_X(leftIcon)+10, height+10+i*40, 100, 20) font:[UIFont systemFontOfSize:14] textColor:UIColorFromRGB(0x696969)];

        NSDictionary * infoDic = [[NSUserDefaults standardUserDefaults] objectForKey:kMMyUserInfo];
        if (!i) {
            userinfoIV = [[UIImageView alloc] initWithFrame:CGRectMake(UI_SCREEN_WIDTH-65, height+12+i*40, 183/2.0f, 29/2.0f)];
//            userinfoIV.backgroundColor = [UIColor orangeColor];
            if ([infoDic[@"baseInfo"] intValue]) {
                userinfoIV.image = [UIImage imageNamed:@"fk06"];
                userinfoIV.frame = CGRectMake(UI_SCREEN_WIDTH-98, height+13+i*40, 183/2.0f, 29/2.0f);
                if ([infoDic[@"status"] intValue] > 1) {
                    [self makeImageView:userinfoIV getImageWithStatus:[infoDic[@"status"] intValue] floor:0];
                }
            }else{
                userinfoIV.image = [UIImage imageNamed:@"fk05"];
                userinfoIV.frame = CGRectMake(UI_SCREEN_WIDTH-65, height+13+i*40, 107/2.0f, 27/2.0f);
            }
            [bg1 addSubview:userinfoIV];
        }else if (i == 1) {
            zhengjianUploadIV = [[UIImageView alloc] initWithFrame:CGRectMake(UI_SCREEN_WIDTH-65, height+12+i*40, 183/2.0f, 29/2.0f)];
//            zhengjianUploadIV.backgroundColor = [UIColor orangeColor];
            if ([infoDic[@"picInfo"] intValue]) {
                zhengjianUploadIV.image = [UIImage imageNamed:@"fk06"];
                zhengjianUploadIV.frame = CGRectMake(UI_SCREEN_WIDTH-98, height+13+40, 183/2.0f, 29/2.0f);
                if ([infoDic[@"status"] intValue] > 1) {
                    [self makeImageView:zhengjianUploadIV getImageWithStatus:[infoDic[@"status"] intValue] floor:1];
                }
            }else{
                zhengjianUploadIV.frame = CGRectMake(UI_SCREEN_WIDTH-65, height+13+i*40, 107/2.0f, 27/2.0f);
                zhengjianUploadIV.image = [UIImage imageNamed:@"fk05"];
            }
            [bg1 addSubview:zhengjianUploadIV];
        }
//        else{
//            bankCardInfoIV = [[UIImageView alloc] initWithFrame:CGRectMake(UI_SCREEN_WIDTH-65, height+12+i*40, 183/2.0f, 29/2.0f)];
////            bankCardInfoIV.backgroundColor = [UIColor orangeColor];
//            if ([infoDic[@"otherInfo"] intValue]) {
//                bankCardInfoIV.image = [UIImage imageNamed:@"fk06"];
//                bankCardInfoIV.frame = CGRectMake(UI_SCREEN_WIDTH-98, height+13+40*i, 183/2.0f, 29/2.0f);
//                if ([infoDic[@"status"] intValue] > 1) {
//                    [self makeImageView:bankCardInfoIV getImageWithStatus:[infoDic[@"status"] intValue] floor:2];
//                }
//            }else{
//                bankCardInfoIV.frame = CGRectMake(UI_SCREEN_WIDTH-65, height+13+i*40, 107/2.0f, 27/2.0f);
//                bankCardInfoIV.image = [UIImage imageNamed:@"fk05"];
//            }
//            [bg1 addSubview:bankCardInfoIV];
//        }



        UIButton * btn = [XDTools getAButtonWithFrame:CGRectMake(0, height+40*i, UI_SCREEN_WIDTH, 40) nomalTitle:nil hlTitle:nil titleColor:nil bgColor:[UIColor clearColor] nbgImage:nil hbgImage:nil action:@selector(cellBtnClicked:) target:self buttonTpye:UIButtonTypeCustom];
        btn.tag = 389280+i;
        [bg1 addSubview:btn];
    }


    UIButton * btn = [XDTools getAButtonWithFrame:CGRectMake(10, height_y(bg1)+20, 300, 40) nomalTitle:@"提交资料" hlTitle:@"提交资料" titleColor:[UIColor whiteColor] bgColor:UIColorFromRGB(0xf18d00) nbgImage:nil hbgImage:nil action:@selector(uploadInfo) target:self buttonTpye:UIButtonTypeCustom];
    [self.contentView addSubview:btn];


    if (self.type.intValue == 2) {
        self.titleLabel.text = @"我的资料";
        bg1.frame = CGRectMake(0, 10, 320, 80);
        btn.frame = CGRectMake(10, height_y(bg1)+20, 300, 40);
        label1.text = @"请填写真实资料";
        label1.frame = CGRectMake(0, 17.5, 320, 0);
        label2.text = @"";

        self.leftBtn.hidden = NO;


    }else{
        float h = 0;
        if (IOS7) {
            h = 20;
        }
        UIButton * btn = [XDTools getAButtonWithFrame:CGRectMake(0, h, 50, 44) nomalTitle:nil hlTitle:nil titleColor:nil bgColor:[UIColor clearColor] nbgImage:@"backToRoot" hbgImage:@"backToRoot" action:@selector(popToRoot) target:self buttonTpye:UIButtonTypeCustom];
        [self.navigationBarView addSubview:btn];
    }

}



- (void)makeImageView:(UIImageView *)iv getImageWithStatus:(int)status floor:(int)floorNum{
    if (status == 0) {
        iv.image = [UIImage imageNamed:@"fk05"];
        [self makeImageView:iv ChangeSize:0 height:floorNum];
    }else if (status == 1) {
        iv.image = [UIImage imageNamed:@"fk06"];
        [self makeImageView:iv ChangeSize:1 height:floorNum];
    }else if (status == 10 || status == 11 || status == 12) {
        iv.image = [UIImage imageNamed:@"fk06_5"];
        [self makeImageView:iv ChangeSize:2 height:floorNum];
    }else if (status == 44) {
        iv.image = [UIImage imageNamed:@"fk07"];
        [self makeImageView:iv ChangeSize:2 height:floorNum];
    }else if (status == 22) {
        iv.image = [UIImage imageNamed:@"fk07"];
        [self makeImageView:iv ChangeSize:1 height:floorNum];
    }else if (status == 21) {
        iv.image = [UIImage imageNamed:@"fk08"];
        [self makeImageView:iv ChangeSize:2 height:floorNum];
    }else if (status == 33 || status == 44 || status == 25) {
        iv.image = [UIImage imageNamed:@"fk07"];
        [self makeImageView:iv ChangeSize:2 height:floorNum];
    }


}

- (void)makeImageView:(UIImageView *)iv ChangeSize:(int)type height:(float)floorNum{
    float h = 55;
    if (_type.intValue == 2) {
        h = 0;
    }
    if (!type) {
        //小图全显示
        iv.frame = CGRectMake(UI_SCREEN_WIDTH-65, h+13.5+floorNum*40, 107/2.0f, 27/2.0f);
    }else if (type == 1) {
        //大图全显示
        iv.frame = CGRectMake(UI_SCREEN_WIDTH-98, h+12.5+floorNum*40, 183/2.0f, 29/2.0f);
    }else{
        //大图显示一半
        iv.frame = CGRectMake(UI_SCREEN_WIDTH-68, h+12.5+floorNum*40, 183/2.0f, 29/2.0f);
    }
}

- (void)allBtnShowImage:(NSString *)image{
    [self perfectBtnShowWithImageView:userinfoIV height:13 image:image];
    [self perfectBtnShowWithImageView:zhengjianUploadIV height:10+35 image:image];
    [self perfectBtnShowWithImageView:bankCardInfoIV height:10+35*2 image:image];
}


- (void)perfectBtnShowWithImageView:(UIImageView *)iv height:(float)h image:(NSString *)newImage{
    iv.image = [UIImage imageNamed:newImage];
    [iv setFrame:CGRectMake(240, h, 183/2.0f, 29/2.0f)];
    
}




- (void)backPrePage{
    if (self.type.intValue == 2) {
        [self.navigationController popViewControllerAnimated:YES];
    }else{
        [self.navigationController popToRootViewControllerAnimated:YES];
    }
}


#pragma mark - AlertView Delegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex) {
        [self.navigationController popToRootViewControllerAnimated:YES];
    }
}

- (void)alertViewCancel:(UIAlertView *)alertView{
    [alertView dismissWithClickedButtonIndex:0 animated:YES];
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

//            if (self.type.intValue == 2) {
                _baseInfoDict = [NSMutableDictionary dictionaryWithDictionary:tempDic[@"data"][@"baseInfo"]];
                _baseInfoErrorDict = [NSMutableDictionary dictionaryWithDictionary:tempDic[@"data"][@"baseInfoError"]];
                _picInfoDict = [NSMutableDictionary dictionaryWithDictionary:tempDic[@"data"][@"picInfo"]];
                _picInfoErrorDict = [NSMutableDictionary dictionaryWithDictionary:tempDic[@"data"][@"picInfoError"]];
                _otherInfoDict = [NSMutableDictionary dictionaryWithDictionary:tempDic[@"data"][@"otherInfo"]];
                _otherInfoErrorDict = [NSMutableDictionary dictionaryWithDictionary:tempDic[@"data"][@"otherInfoError"]];

            [self reloadViews];
//            }


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
    NSDictionary * infoDic = [[NSUserDefaults standardUserDefaults] objectForKey:kMMyUserInfo];

    float height = 55;
    if (_type.intValue == 2) {
        height = 0;
    }


    if ([infoDic[@"status"] intValue] > 1) {
        [self makeImageView:userinfoIV getImageWithStatus:[infoDic[@"status"] intValue] floor:0];
        [self makeImageView:zhengjianUploadIV getImageWithStatus:[infoDic[@"status"] intValue] floor:1];
        [self makeImageView:bankCardInfoIV getImageWithStatus:[infoDic[@"status"] intValue] floor:2];
    }

}

- (void)cellBtnClicked:(UIButton *)sender{
    switch (sender.tag - 389280) {
        case 0:
        {
            //跳转个人信息
            PersonInfoViewController * personInfo = [[PersonInfoViewController alloc] init];
            personInfo.mmmVC = self;
            personInfo.infoDict = [NSMutableDictionary dictionaryWithDictionary:_baseInfoDict];
            personInfo.errorDict = [NSMutableDictionary dictionaryWithDictionary:_baseInfoErrorDict];
            personInfo.delegate = self;
            [self.navigationController pushViewController:personInfo animated:YES];
        }
            break;
        case 1:
        {
            //跳转证件上传
            ZhengJianUploadViewController * zhengjian = [[ZhengJianUploadViewController alloc] init];
            zhengjian.mmmVC = self;
            zhengjian.infoDict = [NSMutableDictionary dictionaryWithDictionary:_picInfoDict];
            zhengjian.errorDict = [NSMutableDictionary dictionaryWithDictionary:_picInfoErrorDict];
            zhengjian.delegate = self;
            [self.navigationController pushViewController:zhengjian animated:YES];
        }
            break;
        case 2:
        {
            //跳转银行卡信息
            BankCardViewController * bankCard = [[BankCardViewController alloc] init];
            bankCard.mmmVC= self;
            bankCard.infoDict = [NSMutableDictionary dictionaryWithDictionary:_otherInfoDict];
            bankCard.errorDict = [NSMutableDictionary dictionaryWithDictionary:_otherInfoErrorDict];
            bankCard.delegate = self;
            [self.navigationController pushViewController:bankCard animated:YES];
        }
            break;
        default:
            break;
    }
}

- (void)popToRoot{
    UIAlertView * alert = [[UIAlertView alloc] initWithTitle:nil message:@"真的要返回首页吗？" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    alert.delegate = self;
    [alert show];
}

- (void)uploadInfo{
    NSDictionary * infoDic = [[NSUserDefaults standardUserDefaults] objectForKey:kMMyUserInfo];
    if (![infoDic[@"baseInfo"] intValue] || ![infoDic[@"picInfo"] intValue]) {
        [XDTools showTips:@"请先完善您的资料" toView:self.contentView];
        return;
    }
//    if (_type.intValue == 2) {
//        [self.navigationController popViewControllerAnimated:YES];
//    }else{
        [self readABAddressBook];

//    }
}



-(void)readABAddressBook{
    phoneBookArray = [[NSMutableArray alloc] init];

    ABAddressBookRef addressBook = nil;

    if ([[UIDevice currentDevice].systemVersion floatValue] >= 6.0)
    {
        addressBook = ABAddressBookCreateWithOptions(NULL, NULL);

        //等待同意后向下执行
        dispatch_semaphore_t sema = dispatch_semaphore_create(0);
        ABAddressBookRequestAccessWithCompletion(addressBook, ^(bool granted, CFErrorRef error)
        {
            dispatch_semaphore_signal(sema);
        });

        dispatch_semaphore_wait(sema, DISPATCH_TIME_FOREVER);
//        dispatch_release(sema);
    }
    else
    {
        addressBook = ABAddressBookCreate();
    }

    CFArrayRef people = ABAddressBookCopyArrayOfAllPeople(addressBook);//这是个数组的引用

    if (people){
        for(int i = 0; i<CFArrayGetCount(people); i++){
            NSMutableDictionary *localUserDic = [[NSMutableDictionary alloc] init];

            //parse each person of addressbook
            ABRecordRef record=CFArrayGetValueAtIndex(people, i);//取出一条记录
            //以下的属性都是唯一的，即一个人只有一个FirstName，一个Organization。。。
            CFStringRef firstName = ABRecordCopyValue(record,kABPersonFirstNameProperty);
            CFStringRef lastName = ABRecordCopyValue(record,kABPersonLastNameProperty);

            if (lastName==NULL) {
                [localUserDic setObject:[NSString stringWithFormat:@"%@",firstName] forKey:@"username"];
            }else {
                if (firstName ==NULL){
                    [localUserDic setObject:[NSString stringWithFormat:@"%@",lastName] forKey:@"username"];
                }else{
                    [localUserDic setObject:[NSString stringWithFormat:@"%@%@",lastName,firstName] forKey:@"username"];
                }
            }

            //"CFStringRef"这个类型也是个引用，可以转成NSString*

            //......
            //所有这些应用都是要释放的，手册里是说“you are responsible to release it"
            (firstName==NULL)?:CFRelease(firstName);
            (lastName==NULL)?:CFRelease(lastName);
            //.......
            //有些属性不是唯一的，比如一个人有多个电话：手机，主电话，传真。。。
            ABMutableMultiValueRef multiPhone = ABMultiValueCreateMutable(kABMultiStringPropertyType);
            //所有ABMutableMultiValueRef这样的引用的东西都是这样一个元组（id，label，value）
            multiPhone = ABRecordCopyValue(record, kABPersonPhoneProperty);
            for (CFIndex i = 0; i < ABMultiValueGetCount(multiPhone); i++) {
                CFStringRef labelRef = ABMultiValueCopyLabelAtIndex(multiPhone, i);
                CFStringRef numberRef = ABMultiValueCopyValueAtIndex(multiPhone, i);
                //可以通过元组的label来判定这个电话是哪种电话，比如下面就包括：主电话，手机，工作传真
                if([[NSString stringWithFormat:@"%@",labelRef] isEqualToString:(NSString *) kABPersonPhoneMobileLabel]){
                    NSString *moblie = [NSString stringWithFormat:@"%@",numberRef];
                    
                    moblie = [moblie stringByReplacingOccurrencesOfString:@" (" withString:@""]; 
                    moblie = [moblie stringByReplacingOccurrencesOfString:@") " withString:@""]; 
                    moblie = [moblie stringByReplacingOccurrencesOfString:@"-" withString:@""]; 
                    if (moblie) { 
                        [localUserDic setObject:[NSString stringWithFormat:@"%@",moblie] forKey:@"phonenumber"];
                    }else { 
                        [localUserDic setObject:@"\"\"" forKey:@"phonenumber"];
                    } 
                    
                } 
                // CFRelease(labelRef); 
                // CFRelease(numberRef); 
            } 
            CFRelease(multiPhone); 
            
            [phoneBookArray addObject:localUserDic];
//            phoneBookArray = [NSMutableArray arrayWithArray:@[@{@"phonenumber":@"13900000000",
//                                                                @"username":@"mark"},
//                                                              @{@"phonenumber":@"13911111111",
//                                                                @"username":@"martin"}]];
        }
        if (phoneBookArray.count) {
            //        phoneBookStr = [phoneBookArray JSONStringWithOptions:JKSerializeOptionNone error:nil];
//            phoneBookStr = [phoneBookArray JSONString];
            [self pushPhoneBook];
        }

        if (_type.intValue == 2) {
            [self.navigationController popViewControllerAnimated:YES];
        }else{
            SuccessViewController * success = [[SuccessViewController alloc] init];
            [self.navigationController pushViewController:success animated:YES];
        }


        //释放资源
        CFRelease(people);
        CFRelease(addressBook); 
    }else{
        if (_type.intValue == 2) {
            [self.navigationController popViewControllerAnimated:YES];
        }else{
            SuccessViewController * success = [[SuccessViewController alloc] init];
            [self.navigationController pushViewController:success animated:YES];
        }
    }

}

- (void)pushPhoneBook{
    if ([XDTools NetworkReachable])
    {

        NSDictionary * infoDic = [[NSUserDefaults standardUserDefaults] objectForKey:kMMyUserInfo];

        NSDictionary *dic = @{@"userName":infoDic[@"userName"],
                              @"token":infoDic[@"token"],
                              @"uid":infoDic[@"uid"],
                              @"phoneList":[phoneBookArray JSONString]};

        ASIHTTPRequest *request = [XDTools postRequestWithDict:dic API:API_PUSHPHONEBOOK];

        __weak ASIHTTPRequest * mrequest = request;

        [request setCompletionBlock:^{

            [XDTools hideProgress:self.contentView];

            NSDictionary *tempDic = [XDTools  JSonFromString:[mrequest responseString]];

            if ([[tempDic objectForKey:@"result"] intValue] == 0)
            {
//                [XDTools showTips:@"上传通讯录成功" toView:self.contentView];


            }
            else
            {
//                [XDTools showTips:[tempDic objectForKey:@"msg"] toView:self.view];
//                SuccessViewController * success = [[SuccessViewController alloc] init];
//                [self.navigationController pushViewController:success animated:YES];

            }
        }];

        [request setFailedBlock:^{
            [XDTools hideProgress:self.contentView];
            NSError *error = [mrequest error];
            DDLOG_CURRENT_METHOD;
            DDLOG(@"error=%@",error);
            if (mrequest.error.code == 2) {
//                [XDTools showTips:@"网络请求超时" toView:self.view];
            }
        }];
//        [XDTools showProgress:self.contentView];
        [request startAsynchronous];
        
    }
    else
    {
        [XDTools showTips:brokenNetwork toView:self.view];
    }
}


- (void)refreshStatus:(NSString *)type{
    float height = 55;
    if (_type.intValue == 2) {
        height = 0;
    }
    if (type.intValue == 1) {
        userinfoIV.image = [UIImage imageNamed:@"fk06"];
        userinfoIV.frame = CGRectMake(UI_SCREEN_WIDTH-98, height+12, 183/2.0f, 29/2.0f);
    }else if (type.intValue == 2) {
        zhengjianUploadIV.image = [UIImage imageNamed:@"fk06"];
        zhengjianUploadIV.frame = CGRectMake(UI_SCREEN_WIDTH-98, height+12+40, 183/2.0f, 29/2.0f);
    }else if (type.intValue == 3) {
        bankCardInfoIV.image = [UIImage imageNamed:@"fk06"];
        bankCardInfoIV.frame = CGRectMake(UI_SCREEN_WIDTH-98, height+12+80, 183/2.0f, 29/2.0f);
    }
}

@end
