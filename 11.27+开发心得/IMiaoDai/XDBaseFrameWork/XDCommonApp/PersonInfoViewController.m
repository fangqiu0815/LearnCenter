//
//  PersonInfoViewController.m
//  XDCommonApp
//
//  Created by xindao on 14-8-6.
//  Copyright (c) 2014年 XD-XY. All rights reserved.
//

#import "PersonInfoViewController.h"
#import "MaterialsViewController.h"
@implementation PersonInfoViewController
- (void)viewDidLoad{
    [super viewDidLoad];
    self.titleLabel.text = @"个人信息";

    cityId = [[NSString alloc] init];
    schoolId = [[NSString alloc] init];

    relationBtnArray = [[NSMutableArray alloc] init];

    backScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, UI_SCREEN_WIDTH, UI_MAINSCREEN_HEIGHT - UI_NAVIGATION_BAR_HEIGHT)];
    backScrollView.contentSize = CGSizeMake(UI_SCREEN_WIDTH, 920);
    backScrollView.pagingEnabled = NO;
    backScrollView.delegate = self;
    [self.contentView addSubview:backScrollView];

    UIView * bg1 = [self createBgViewWithNumber:7 titleArray:@[@"基本信息",@"姓名",@"性别",@"手机号",@"身份证",@"QQ号",@"新浪微博"] y:10 labelWidth:65];
    UIView * bg2 = [self createBgViewWithNumber:8 titleArray:@[@"学校信息",@"城市",@"学校名称",@"专业",@"入学时间",@"学制",@"宿舍楼",@"房间号"] y:height_y(bg1)+10 labelWidth:65];
    UIView * bg3 = [self createBgViewWithNumber:4 titleArray:@[@"紧急联系人",@"姓名",@"手机号",@"关系"] y:height_y(bg2)+10 labelWidth:65];
    UIView * bg4 = [self createBgViewWithNumber:3 titleArray:@[@"家庭信息(选填)",@"家庭地址",@"家庭座机"] y:height_y(bg3)+10 labelWidth:65];

    selLabel.attributedText = [XDTools getAcolorfulStringWithTextArray:@[@"(选填)"] Color:UIColorFromRGB(0x636363) Font:[UIFont systemFontOfSize:13] AllText:selLabel.text];


    maleBtn = [XDTools getAButtonWithFrame:CGRectMake(80, 77, 72, 20) nomalTitle:@"男" hlTitle:@"男" titleColor:UIColorFromRGB(0x8d8d8d) bgColor:[UIColor clearColor] nbgImage:nil hbgImage:nil action:@selector(chooseSex:) target:self buttonTpye:UIButtonTypeCustom];
    maleBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    [maleBtn setTitleColor:UIColorFromRGB(0xf48b00) forState:UIControlStateSelected];
    maleBtn.selected = YES;
    maleBtn.layer.borderColor = UIColorFromRGB(0xf48b00).CGColor;
    maleBtn.layer.borderWidth = .5f;
    [bg1 addSubview:maleBtn];

    femaleBtn = [XDTools getAButtonWithFrame:CGRectMake(182, 77, 72, 20) nomalTitle:@"女" hlTitle:@"女" titleColor:UIColorFromRGB(0x8d8d8d) bgColor:[UIColor clearColor] nbgImage:nil hbgImage:nil action:@selector(chooseSex:) target:self buttonTpye:UIButtonTypeCustom];
    femaleBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    [femaleBtn setTitleColor:UIColorFromRGB(0xf48b00) forState:UIControlStateSelected];
    femaleBtn.layer.borderColor = UIColorFromRGB(0xcbcbcb).CGColor;
    femaleBtn.layer.borderWidth = .5f;
    [bg1 addSubview:femaleBtn];

    classmateBtn = [XDTools getAButtonWithFrame:CGRectMake(70, 112.5f, 45, 20) nomalTitle:@"同学" hlTitle:@"同学" titleColor:UIColorFromRGB(0x8d8d8d) bgColor:[UIColor clearColor] nbgImage:nil hbgImage:nil action:@selector(chooseRelation:) target:self buttonTpye:UIButtonTypeCustom];
    classmateBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    [classmateBtn setTitleColor:UIColorFromRGB(0xf48b00) forState:UIControlStateNormal];
//    [classmateBtn setTitleColor:UIColorFromRGB(0xf48b00) forState:UIControlStateSelected];
//    [classmateBtn setTitleColor:[UIColor orangeColor] forState:UIControlStateSelected];

    classmateBtn.selected = YES;
    classmateBtn.layer.borderColor = UIColorFromRGB(0xf48b00).CGColor;
    classmateBtn.layer.borderWidth = .5f;
    [bg3 addSubview:classmateBtn];

    familyBtn = [XDTools getAButtonWithFrame:CGRectMake(VIEW_POINT_MAX_X(classmateBtn)+12, 112.5f, 45, 20) nomalTitle:@"家人" hlTitle:@"家人" titleColor:UIColorFromRGB(0x8d8d8d) bgColor:[UIColor clearColor] nbgImage:nil hbgImage:nil action:@selector(chooseRelation:) target:self buttonTpye:UIButtonTypeCustom];
    familyBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    [familyBtn setTitleColor:UIColorFromRGB(0xf48b00) forState:UIControlStateSelected];
    familyBtn.layer.borderColor = UIColorFromRGB(0xcbcbcb).CGColor;
    familyBtn.layer.borderWidth = .5f;
    [bg3 addSubview:familyBtn];

    friendBtn = [XDTools getAButtonWithFrame:CGRectMake(VIEW_POINT_MAX_X(familyBtn)+12, 112.5f, 45, 20) nomalTitle:@"朋友" hlTitle:@"朋友" titleColor:UIColorFromRGB(0x8d8d8d) bgColor:[UIColor clearColor] nbgImage:nil hbgImage:nil action:@selector(chooseRelation:) target:self buttonTpye:UIButtonTypeCustom];
    friendBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    [friendBtn setTitleColor:UIColorFromRGB(0xf48b00) forState:UIControlStateSelected];
    friendBtn.layer.borderColor = UIColorFromRGB(0xcbcbcb).CGColor;
    friendBtn.layer.borderWidth = .5f;
    [bg3 addSubview:friendBtn];

    othersBtn = [XDTools getAButtonWithFrame:CGRectMake(VIEW_POINT_MAX_X(friendBtn)+12, 112.5f, 45, 20) nomalTitle:@"其他" hlTitle:@"其他" titleColor:UIColorFromRGB(0x8d8d8d) bgColor:[UIColor clearColor] nbgImage:nil hbgImage:nil action:@selector(chooseRelation:) target:self buttonTpye:UIButtonTypeCustom];
    othersBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    [othersBtn setTitleColor:UIColorFromRGB(0xf48b00) forState:UIControlStateSelected];
    othersBtn.layer.borderColor = UIColorFromRGB(0xcbcbcb).CGColor;
    othersBtn.layer.borderWidth = .5f;
    [bg3 addSubview:othersBtn];

    relationBtnArray = [NSMutableArray arrayWithObjects:classmateBtn,familyBtn,friendBtn,othersBtn, nil];

    NSDictionary * infoDic = [[NSUserDefaults standardUserDefaults] objectForKey:kMMyUserInfo];

    nameTF = [self createTextFieldInView:bg1 WithFrame:CGRectMake(80, 7.5f+35, 200, 20) placeholder:@"请填写真实姓名"];
    [XDTools addAlabelForAView:bg1 withText:infoDic[@"userName"] frame:CGRectMake(80, 7.5f+35*3, 200, 20) font:[UIFont systemFontOfSize:14] textColor:[UIColor blackColor]];
    humanCardTF = [self createTextFieldInView:bg1 WithFrame:CGRectMake(80, 7.5f+35*4, 200, 20) placeholder:@"请填写身份证号码"];
    QQTF = [self createTextFieldInView:bg1 WithFrame:CGRectMake(80, 7.5f+35*5, 200, 20) placeholder:@"请填写QQ号"];
    QQTF.keyboardType = UIKeyboardTypeNumberPad;
    weiboTF = [self createTextFieldInView:bg1 WithFrame:CGRectMake(80, 7.5f+35*6, 200, 20) placeholder:@"请填写新浪微博昵称（选填）"];

    cityTF = [self createTextFieldInView:bg2 WithFrame:CGRectMake(80, 7.5f+35, 200, 20) placeholder:@"请填写城市名称"];
    schoolNameTF = [self createTextFieldInView:bg2 WithFrame:CGRectMake(80, 7.5f+35*2, 200, 20) placeholder:@"请填写学校名称"];
    zhuanyeTF = [self createTextFieldInView:bg2 WithFrame:CGRectMake(80, 7.5f+35*3, 200, 20) placeholder:@"请填写专业名称"];
    schoolAddressTF = [self createTextFieldInView:bg2 WithFrame:CGRectMake(80, 7.5f+35*6, 200, 20) placeholder:@"请填写宿舍地址"];
    roomNumTF = [self createTextFieldInView:bg2 WithFrame:CGRectMake(80, 7.5f+35*7, 200, 20) placeholder:@"请填写房间号"];
    goSchoolTimeTF = [self createTextFieldInView:bg2 WithFrame:CGRectMake(80, 7.5f+35*4, 200, 20) placeholder:@"请选择"];
    xuezhiTF = [self createTextFieldInView:bg2 WithFrame:CGRectMake(80, 7.5f+35*5, 200, 20) placeholder:@"请选择"];

    for (int i = 0; i < 2; i++) {
        UIImageView * rightArrow = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"rightArrow"]];
        rightArrow.frame = CGRectMake(UI_SCREEN_WIDTH-20, 7.5f+35+3+35*i, 7, 14);
        [bg2 addSubview:rightArrow];
    }

    for (int i = 0; i < 2; i++) {
        UIImageView * rightArrow = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"rightArrow"]];
        rightArrow.frame = CGRectMake(UI_SCREEN_WIDTH-20, 7.5f+35*4+3+35*i, 7, 14);
        [bg2 addSubview:rightArrow];
    }

    relationNameTF = [self createTextFieldInView:bg3 WithFrame:CGRectMake(80, 7.5f+35, 200, 20) placeholder:@"请填写姓名"];
    relationPhoneTF = [self createTextFieldInView:bg3 WithFrame:CGRectMake(80, 7.5f+35*2, 200, 20) placeholder:@"请填写手机号"];
    relationPhoneTF.keyboardType = UIKeyboardTypeNumberPad;

    familyAddressPlaceHolderLB = [XDTools addAlabelForAView:bg4 withText:@"请填写家庭地址" frame:CGRectMake(80, 7.5f+35, 200, 20) font:[UIFont systemFontOfSize:14] textColor:RGBA(200, 200, 204, 1)];
    familyAddressTV = [[UITextView alloc] initWithFrame:CGRectMake(75, 35, 200, 34)];
    familyAddressTV.font = [UIFont systemFontOfSize:14];
    familyAddressTV.delegate = self;
    familyAddressTV.backgroundColor = [UIColor clearColor];
    [bg4 addSubview:familyAddressTV];
    //[self createTextFieldInView:bg4 WithFrame:CGRectMake(80, 7.5f+35, 200, 20) placeholder:@"请填写家庭地址"];
    familyPhoneTF = [self createTextFieldInView:bg4 WithFrame:CGRectMake(80, 7.5f+35*2, 200, 20) placeholder:@"请填写家庭座机"];
    familyPhoneTF.keyboardType = UIKeyboardTypeNumberPad;

    saveBtn = [XDTools getAButtonWithFrame:CGRectMake(10, height_y(bg4)+10, 300, 40) nomalTitle:@"保存" hlTitle:@"保存" titleColor:[UIColor whiteColor] bgColor:UIColorFromRGB(0xf18d00) nbgImage:nil hbgImage:nil action:@selector(save) target:self buttonTpye:UIButtonTypeCustom];
    [backScrollView addSubview:saveBtn];


    NSDictionary * shortTimeInfo = [[NSUserDefaults standardUserDefaults] objectForKey:@"shortTimeInfo"];
    if (shortTimeInfo) {
        nameTF.text = shortTimeInfo[@"name"];
        schoolId = shortTimeInfo[@"schoolId"];
        schoolNameTF.text = [XDTools changeStringOrCode:schoolId type:@"code" table:@"T_P_COLLAGE"];
        cityId = shortTimeInfo[@"cityId"];
        oldCityId = shortTimeInfo[@"cityId"];
        cityTF.text = [XDTools changeStringOrCode:cityId type:@"code" table:@"T_P_CITY"];
    }


    if (_infoDict.count) {
        if ([_infoDict[@"name"] length]) {
            nameTF.text = _infoDict[@"name"];
        }
        if ([_infoDict[@"sex"] intValue] == 2) {
            femaleBtn.selected = YES;
            [self chooseSex:femaleBtn];
        }else{
            maleBtn.selected = YES;
            [self chooseSex:maleBtn];
        }
        humanCardTF.text = _infoDict[@"identityCode"];
        QQTF.text = _infoDict[@"qq"];
        weiboTF.text = _infoDict[@"weibo"];
        if ([_infoDict[@"schoolId"] length]) {
            schoolId = _infoDict[@"schoolId"];
            schoolNameTF.text = [XDTools changeStringOrCode:schoolId type:@"code" table:@"T_P_COLLAGE"];
        }
        if ([_infoDict[@"cityId"] length]) {
            cityId = _infoDict[@"cityId"];
            oldCityId = _infoDict[@"cityId"];
            cityTF.text = [XDTools changeStringOrCode:cityId type:@"code" table:@"T_P_CITY"];
        }

        zhuanyeTF.text = _infoDict[@"subject"];
        NSString * str = _infoDict[@"dormAddress"];
        NSArray * arr = [str componentsSeparatedByString:@"#"];
        schoolAddressTF.text = arr.firstObject;
        roomNumTF.text = arr.lastObject;
        goSchoolTimeTF.text = _infoDict[@"ruxuenianfen"];
        if ([_infoDict[@"xuezhi"] intValue]) {
            xuezhiTF.text = _infoDict[@"xuezhi"];
        }
        relationNameTF.text = _infoDict[@"contactName"];
        relationPhoneTF.text = _infoDict[@"contactPhone"];
        for (UIButton * btn in relationBtnArray) {
            btn.selected = NO;
        }
        if ([_infoDict[@"contactRelation"] intValue] > 1) {
            for (UIButton * btn in relationBtnArray) {
                btn.selected = NO;
                btn.layer.borderColor = UIColorFromRGB(0xcbcbcb).CGColor;
            }
            UIButton * btn = relationBtnArray[[_infoDict[@"contactRelation"] intValue]-1];
//            btn.selected = YES;
//            btn.layer.borderColor = UIColorFromRGB(0xf48b00).CGColor;
            [self chooseRelation:btn];
        }
        if ([_infoDict[@"familyAddress"] length]) {
            familyAddressPlaceHolderLB.hidden = YES;
        }else{
            familyAddressPlaceHolderLB.hidden = NO;
        }
        familyAddressTV.text = _infoDict[@"familyAddress"];
        familyPhoneTF.text = _infoDict[@"familyPhone"];


        //状态不等于00、01、22，不可以修改资料
        NSDictionary * infoDic = [[NSUserDefaults standardUserDefaults] objectForKey:kMMyUserInfo];
        if ([infoDic[@"status"] intValue] != 0 && [infoDic[@"status"] intValue] != 1 && [infoDic[@"status"] intValue] != 22) {
            for (UITextField * myTF in bg1.subviews) {
                if ([myTF isKindOfClass:[UITextField class]]) {
                    myTF.userInteractionEnabled = NO;
                }
            }
            for (UITextField * myTF in bg2.subviews) {
                if ([myTF isKindOfClass:[UITextField class]]) {
                    myTF.userInteractionEnabled = NO;
                }
            }
            for (UITextField * myTF in bg3.subviews) {
                if ([myTF isKindOfClass:[UITextField class]]) {
                    myTF.userInteractionEnabled = NO;
                }
            }

            saveBtn.hidden = YES;

//            for (UITextField * myTF in bg4.subviews) {
//                if ([myTF isKindOfClass:[UITextField class]]) {
//                    myTF.userInteractionEnabled = NO;
//                }else if ([myTF isKindOfClass:[UITextView class]]) {
//                    myTF.userInteractionEnabled = NO;
//                }
//            }
        }
    }

    if (_errorDict.count) {
        NSArray * titleArray1 = @[@"name",@"sex",@"telephone",@"identityCode",@"qq",@"weibo"];
        NSArray * titleArray2 = @[@"cityId",@"schoolId",@"subject",@"ruxuenianfen",@"xuezhi",@"dormAddress"];
        NSArray * titleArray3 = @[@"contactName",@"contactPhone",@"contactRelation"];
        NSArray * titleArray4 = @[@"familyAddress",@"familyPhone"];

        [self showErrorInfoWithTitleArray:titleArray1 bgView:bg1];
        [self showErrorInfoWithTitleArray:titleArray2 bgView:bg2];
        [self showErrorInfoWithTitleArray:titleArray3 bgView:bg3];
        [self showErrorInfoWithTitleArray:titleArray4 bgView:bg4];

    }



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
    [backScrollView addSubview:bgView];

    UIImageView * firstBg = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, UI_SCREEN_WIDTH, 35)];
    firstBg.image = [UIImage imageNamed:@"fk04"];
    [bgView addSubview:firstBg];

    for (int i = 0; i < number; i++) {
        UIImageView * line = [[UIImageView alloc] initWithFrame:CGRectMake(0, 35*(i+1)-.5f, UI_SCREEN_WIDTH, .5f)];
        line.image = [UIImage imageNamed:@"line"];
        [bgView addSubview:line];
    }

    selLabel = [XDTools addAlabelForAView:bgView withText:titleArray[0] frame:CGRectMake(10, 7.5f, 150, 20) font:[UIFont systemFontOfSize:16] textColor:UIColorFromRGB(0xf48b00)];

    for (int i = 1; i < number; i++) {
        UILabel * label = [XDTools addAlabelForAView:bgView withText:titleArray[i] frame:CGRectMake(0, 7.5f+35*i, width, 20) font:[UIFont systemFontOfSize:14] textColor:UIColorFromRGB(0x8d8d8d)];
        label.textAlignment = NSTextAlignmentRight;
        label.tag = 135790+i;
//        label.backgroundColor = [UIColor orangeColor];
    }

    return bgView;
}


- (UITextField *)createTextFieldInView:(UIView *)view WithFrame:(CGRect)frame placeholder:(NSString *)placeholder{
    UITextField * myTF = [[UITextField alloc] initWithFrame:frame];
    myTF.font = [UIFont systemFontOfSize:14];
    myTF.delegate = self;
    myTF.placeholder = placeholder;
    myTF.returnKeyType = UIReturnKeyDone;
//    [myTF addTarget:self action:@selector(textFieldChange:) forControlEvents:UIControlEventEditingChanged];
//    myTF.backgroundColor = [UIColor orangeColor];
    myTF.clearButtonMode = UITextFieldViewModeWhileEditing;
    [view addSubview:myTF];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(textFiledEditChanged:)
                                                name:@"UITextFieldTextDidChangeNotification"
                                              object:myTF];
    return myTF;
}


- (void)chooseSex:(UIButton *)sender{
    if (sender == maleBtn) {
        maleBtn.enabled = NO;
        femaleBtn.enabled = YES;
        maleBtn.selected = YES;
        femaleBtn.selected = NO;
        maleBtn.layer.borderColor = UIColorFromRGB(0xf48b00).CGColor;
        [maleBtn setTitleColor:UIColorFromRGB(0xf48b00) forState:UIControlStateNormal];
        femaleBtn.layer.borderColor = UIColorFromRGB(0xcbcbcb).CGColor;
        [femaleBtn setTitleColor:UIColorFromRGB(0x8d8d8d) forState:UIControlStateNormal];
    }else{
        maleBtn.enabled = YES;
        femaleBtn.enabled = NO;
        maleBtn.selected = NO;
        femaleBtn.selected = YES;
        femaleBtn.layer.borderColor = UIColorFromRGB(0xf48b00).CGColor;
        [femaleBtn setTitleColor:UIColorFromRGB(0xf48b00) forState:UIControlStateNormal];
        maleBtn.layer.borderColor = UIColorFromRGB(0xcbcbcb).CGColor;
        [maleBtn setTitleColor:UIColorFromRGB(0x8d8d8d) forState:UIControlStateNormal];
    }
}

- (void)chooseRelation:(UIButton *)sender{
    for (UIButton * btn in relationBtnArray) {
        [btn setTitleColor:UIColorFromRGB(0x8d8d8d) forState:UIControlStateNormal];
        btn.layer.borderColor = UIColorFromRGB(0xcbcbcb).CGColor;
        btn.enabled = YES;
        btn.selected = NO;
    }
    sender.enabled = NO;
    sender.selected = YES;
    [sender setTitleColor:UIColorFromRGB(0xf48b00) forState:UIControlStateNormal];
    sender.layer.borderColor = UIColorFromRGB(0xf48b00).CGColor;
    if (sender == classmateBtn) {

    }else if (sender == familyBtn) {

    }else if (sender == friendBtn) {

    }else{

    }
}



- (void)save{

    if (!nameTF.text.length) {
        [XDTools showTips:@"请填写姓名" toView:self.view];
        return;
    }

    if (nameTF.text.length < 2 || ![XDTools chickTextIsChinese:nameTF.text]) {
        [XDTools showTips:@"姓名请填写2-10个汉字" toView:self.view];
        return;
    }

    if (!humanCardTF.text.length) {
        [XDTools showTips:@"请填写身份证号码" toView:self.view];
        return;
    }

    if (![XDTools validateIdentityCard:humanCardTF.text]) {
        [XDTools showTips:@"身份证号码格式错误" toView:self.view];
        return;
    }

    if (QQTF.text.length < 5 || QQTF.text.length > 15) {
        [XDTools showTips:@"请填写QQ号，5-15位数字" toView:self.view];
        return;
    }

    if (weiboTF.text.length && weiboTF.text.length < 2) {
        [XDTools showTips:@"微博昵称为2-30个字" toView:self.view];
        return;
    }

    if (!cityId.length) {
        [XDTools showTips:@"请选择城市" toView:self.view];
        return;
    }

    if (!schoolId.length) {
        [XDTools showTips:@"请填写学校名称" toView:self.view];
        return;
    }

    if (!zhuanyeTF.text.length || zhuanyeTF.text.length < 2 || zhuanyeTF.text.length > 15 || ![XDTools chickTextIsChinese:zhuanyeTF.text]) {
        [XDTools showTips:@"请填写专业名称，2-15个汉字" toView:self.view];
        return;
    }

    if (!goSchoolTimeTF.text.length) {
        [XDTools showTips:@"请选择入学时间" toView:self.view];
        return;
    }

    if (!xuezhiTF.text.length) {
        [XDTools showTips:@"请选择学制" toView:self.view];
        return;
    }

    if (!schoolAddressTF.text.length) {
        [XDTools showTips:@"请填写宿舍楼，2-20个字" toView:self.view];
        return;
    }

    if (!roomNumTF.text.length) {
        [XDTools showTips:@"请填写房间号，2-10个字" toView:self.view];
        return;
    }

    if (![XDTools chickTextIsChinese:relationNameTF.text] || relationNameTF.text.length < 2) {
        [XDTools showTips:@"请填写联系人姓名，2-10个汉字" toView:self.view];
        return;
    }

    if (relationPhoneTF.text.length != 11) {
        [XDTools showTips:@"请填写联系人电话，11位手机号" toView:self.view];
        return;
    }

    if (![XDTools chickIphoneNumberRight:relationPhoneTF.text]) {
        [XDTools showTips:@"请输入有效的手机号" toView:self.view];
        return;
    }

    if (familyPhoneTF.text.length && familyPhoneTF.text.length != 11) {
        [XDTools showTips:@"请输入正确座机格式" toView:self.view];
        return;
    }

    if (familyPhoneTF.text.length && familyPhoneTF.text.length != 11) {
        [XDTools showTips:@"请输入正确座机格式" toView:self.view];
        return;
    }

    NSDictionary * infoDic = [[NSUserDefaults standardUserDefaults] objectForKey:kMMyUserInfo];
    NSString * sex = @"";
    if (maleBtn.selected) {
        sex = @"1";
    }else{
        sex = @"2";
    }

    NSString * relation = @"1";
    for (int i = 0; i < 4; i++) {
        UIButton * btn = relationBtnArray[i];
        if (btn.selected) {
            relation = [NSString stringWithFormat:@"%d",i+1];
        }
    }
    NSDictionary * dic = @{@"uid": infoDic[@"uid"],
                           @"token": infoDic[@"token"],
                           @"userName": infoDic[@"userName"],
                           @"name": nameTF.text,
                           @"sex": sex,
                           @"identityCode": humanCardTF.text,
                           @"telephone": infoDic[@"userName"],
                           @"qq": QQTF.text,
                           @"weibo":weiboTF.text,
                           @"cityId":cityId,
                           @"schoolId": schoolId,
                           @"subject": zhuanyeTF.text,
                           @"ruxuenianfen": goSchoolTimeTF.text,
                           @"xuezhi": xuezhiTF.text,
                           @"dormAddress": [NSString stringWithFormat:@"%@#%@",schoolAddressTF.text,roomNumTF.text],
                           @"familyAdress": familyAddressTV.text,
                           @"familyPhone": familyPhoneTF.text,
                           @"contactName": relationNameTF.text,
                           @"contactPhone": relationPhoneTF.text,
                           @"contactRelation": relation
                           };


    __weak  ASIFormDataRequest *request = [XDTools postRequestWithDict:dic API:API_UPDATEUSERBASEINFO];

    [request setCompletionBlock:^{
        [XDTools hideProgress:self.view];

        NSDictionary *tempDic = [XDTools  JSonFromString:[request responseString]];
        if([[tempDic objectForKey:@"result"]intValue] == 0){

            [XDTools showTips:@"保存信息成功" toView:self.view];

            [self.delegate refreshStatus:@"1"];

            NSMutableDictionary * infoDic = [NSMutableDictionary dictionaryWithDictionary:[[NSUserDefaults standardUserDefaults] objectForKey:kMMyUserInfo]];
            [infoDic setObject:@"1" forKey:@"baseInfo"];

            NSUserDefaults *userDef=[NSUserDefaults standardUserDefaults];
            //存登录信息

            [userDef setObject:infoDic forKey:kMMyUserInfo];
            [userDef synchronize];

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

#pragma mark choosecityDelegate
-(void)chooseCityOrScholl:(NSDictionary *)dict andTitle:(NSString *)tilte
{
    if ([tilte isEqualToString:@"城市名称"]){
        cityTF.text = [dict valueForKey:@"name"];
        cityId = [NSString stringWithFormat:@"%@",[dict valueForKey:@"id"]];
        if (cityId.intValue != oldCityId.intValue) {
            schoolId = @"";
            schoolNameTF.text = @"";
        }
    }else{
        schoolNameTF.text = [dict valueForKey:@"name"];
        schoolId = [NSString stringWithFormat:@"%@",[dict valueForKey:@"id"]];
    }
}


-(void)getSchoolInfo:(NSString *)info type:(NSString *)type{
    if ([type isEqualToString:@"shijian"]) {
        goSchoolTimeTF.text = info;
    }else{
        xuezhiTF.text = info;
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if (scrollView.dragging) {
        [nameTF resignFirstResponder];
        [humanCardTF resignFirstResponder];
        [QQTF resignFirstResponder];
        [weiboTF resignFirstResponder];
        [cityTF resignFirstResponder];
        [schoolNameTF resignFirstResponder];
        [zhuanyeTF resignFirstResponder];
        [schoolAddressTF resignFirstResponder];
        [roomNumTF resignFirstResponder];
        [goSchoolTimeTF resignFirstResponder];
        [xuezhiTF resignFirstResponder];
        [relationNameTF resignFirstResponder];
        [relationPhoneTF resignFirstResponder];
        [familyAddressTV resignFirstResponder];
        [familyPhoneTF resignFirstResponder];
    }




}

- (void)resignAllTextField{
    [nameTF resignFirstResponder];
    [humanCardTF resignFirstResponder];
    [QQTF resignFirstResponder];
    [schoolNameTF resignFirstResponder];
    [zhuanyeTF resignFirstResponder];
    [schoolAddressTF resignFirstResponder];
    [goSchoolTimeTF resignFirstResponder];
    [xuezhiTF resignFirstResponder];
    [relationNameTF resignFirstResponder];
    [relationPhoneTF resignFirstResponder];
    [familyAddressTV resignFirstResponder];
    [familyPhoneTF resignFirstResponder];
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    if (textField == cityTF) {
        [cityTF resignFirstResponder];
        ChooseCityViewController * chooseCity = [[ChooseCityViewController alloc] init];
        chooseCity.delegate = self;
        chooseCity.titleString = @"城市名称";
        [self.navigationController pushViewController:chooseCity animated:YES];
        return YES;
    }else if (textField == schoolNameTF) {
        [schoolNameTF resignFirstResponder];
        if (!cityId.length) {
            [XDTools showTips:@"请先选择城市名称" toView:self.contentView];
            return YES;
        }
        ChooseCityViewController * chooseCity = [[ChooseCityViewController alloc] init];
        chooseCity.delegate = self;
        chooseCity.titleString = @"学校名称";
        chooseCity.cityId = cityId;
        [self.navigationController pushViewController:chooseCity animated:YES];
        return YES;
    }else if (textField == goSchoolTimeTF) {
        SchoolInfoViewController * schoolInfo = [[SchoolInfoViewController alloc] init];
        schoolInfo.delegate = self;
        schoolInfo.type = @"shijian";
        [self.navigationController pushViewController:schoolInfo animated:YES];
        return YES;
    }else if (textField == xuezhiTF) {
        SchoolInfoViewController * schoolInfo = [[SchoolInfoViewController alloc] init];
        schoolInfo.type = @"xuezhi";
        schoolInfo.delegate = self;
        [self.navigationController pushViewController:schoolInfo animated:YES];
        return YES;
    }

    float h = 620;
    if (iPhone5) {
        h = 550;
    }

    if (textField == relationNameTF || textField == relationPhoneTF) {
        [UIView animateWithDuration:.3f animations:^{
            backScrollView.contentOffset = CGPointMake(0, h);
        }];
        return YES;
    }

    h = 700;
    if (iPhone5) {
        h = 630;
    }

    if (textField == familyPhoneTF) {
        [UIView animateWithDuration:.3f animations:^{
            backScrollView.contentOffset = CGPointMake(0, h);
        }];
        return YES;
    }
    return YES;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField{

}

-(void)textFiledEditChanged:(NSNotification *)obj{
    UITextField *textField = (UITextField *)obj.object;

    int length = 0;

    if (textField == nameTF) {
        length = 10;
    }else if (textField == humanCardTF) {
        length = 18;
    }else if (textField == QQTF) {
        length = 15;
    }else if (textField == weiboTF) {
        length = 30;
    }else if (textField == zhuanyeTF) {
        length = 15;
    }else if (textField == schoolAddressTF) {
        length = 20;
    }else if (textField == roomNumTF) {
        length = 10;
    }else if (textField == relationNameTF) {
        length = 10;
    }else if (textField == relationPhoneTF) {
        length = 11;
    }else if (textField == familyAddressTV) {
        length = 50;
    }else if (textField == familyPhoneTF) {
        length = 11;
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

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [nameTF resignFirstResponder];
    [humanCardTF resignFirstResponder];
    [QQTF resignFirstResponder];
    [schoolNameTF resignFirstResponder];
    [zhuanyeTF resignFirstResponder];
    [schoolAddressTF resignFirstResponder];
    [goSchoolTimeTF resignFirstResponder];
    [xuezhiTF resignFirstResponder];
    [relationNameTF resignFirstResponder];
    [relationPhoneTF resignFirstResponder];
    [familyAddressTV resignFirstResponder];
    [familyPhoneTF resignFirstResponder];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    float h = 350;
    if (IOS7) {
        h = 270;
    }
    if ([familyPhoneTF isFirstResponder]) {
        [UIView animateWithDuration:.3f animations:^{
            backScrollView.contentOffset = CGPointMake(0, h);
        }];
    }
    [textField resignFirstResponder];
    return YES;
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

- (void)textViewDidBeginEditing:(UITextView *)textView{
    float h = 700;
    if (IOS7) {
        h = 630;
    }
    if ([familyAddressTV isFirstResponder]) {
        [UIView animateWithDuration:.3f animations:^{
            backScrollView.contentOffset = CGPointMake(0, h);
        }];
    }
}

- (void)textViewDidChange:(UITextView *)textView{
    if (textView.text.length) {
        familyAddressPlaceHolderLB.hidden = YES;
    }else{
        familyAddressPlaceHolderLB.hidden = NO;
    }



}
@end
