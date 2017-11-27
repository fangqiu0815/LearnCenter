//
//  ZhengJianUploadViewController.m
//  XDCommonApp
//
//  Created by xindao on 14-8-7.
//  Copyright (c) 2014年 XD-XY. All rights reserved.
//

#import "ZhengJianUploadViewController.h"
#import "MaterialsViewController.h"
#import <AVFoundation/AVFoundation.h>

@implementation ZhengJianUploadViewController
- (void)backPrePage{
    if (isChanged) {
        self.mmmVC.isreflash = NO;
    }
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)viewDidLoad{
    [super viewDidLoad];
    self.titleLabel.text = @"证件上传";

    backScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, UI_SCREEN_WIDTH, UI_MAINSCREEN_HEIGHT - UI_NAVIGATION_BAR_HEIGHT)];
    backScrollView.contentSize = CGSizeMake(UI_SCREEN_WIDTH, 780);
    backScrollView.pagingEnabled = NO;
    backScrollView.delegate = self;
    [self.contentView addSubview:backScrollView];

    bg1 = [self createBgViewWithNumber:3 titleArray:@[@"身份证正面",@"身份证反面",@"手持身份证正面照"] y:10 labelWidth:150];
    bg2 = [self createBgViewWithNumber:1 titleArray:@[@"学生证"] y:height_y(bg1)+10 labelWidth:150];

    NSArray * nameArray = @[@"身份证上传说明：请参照以下样式拍摄上传",@"学生证上传说明：请参照以下样式拍摄上传"];
    for (int i = 0; i < 2; i++) {
        UILabel * label1 = [XDTools addAlabelForAView:backScrollView withText:nameArray[i] frame:CGRectMake(10,height_y(bg2)+10+200*i,300,20) font:[UIFont systemFontOfSize:14] textColor:UIColorFromRGB(0x8d8d8d)];
        UIImageView * IV = [[UIImageView alloc] initWithFrame:CGRectMake(10, height_y(label1), 300, 175)];
//        IV.backgroundColor = [UIColor orangeColor];
        IV.image = [UIImage imageNamed:[NSString stringWithFormat:@"fanli0%d.jpg",i+1]];
        [backScrollView addSubview:IV];
    }

//    UIButton * btn = [XDTools getAButtonWithFrame:CGRectMake(10, 585+10, 300, 40) nomalTitle:@"提交资料" hlTitle:@"提交资料" titleColor:[UIColor whiteColor] bgColor:UIColorFromRGB(0xf18d00) nbgImage:nil hbgImage:nil action:@selector(save) target:self buttonTpye:UIButtonTypeCustom];
//    [backScrollView addSubview:btn];

    backScrollView.contentSize = CGSizeMake(UI_SCREEN_WIDTH, 615);


    NSDictionary * infoDic = [[NSUserDefaults standardUserDefaults] objectForKey:kMMyUserInfo];


    if ([infoDic[@"status"] intValue] == 21) {
        [self allBtnShowImage:@"fk08"];

    }else{
        if (_infoDict) {
            if ([_infoDict[@"identityPic1"] length]) {
                finishNum1 = 1;
                UIButton * btn = (UIButton *)[bg1 viewWithTag:783400];
                [btn setTitle:@"" forState:UIControlStateNormal];
                [btn setBackgroundImage:[UIImage imageNamed:@"fk06"] forState:UIControlStateNormal];
                btn.frame = CGRectMake(UI_SCREEN_WIDTH-98, 10, 183/2.0f, 29/2.0f);
                [btn setTitleColor:UIColorFromRGB(0x666666) forState:UIControlStateNormal];
            }

            if ([_infoDict[@"identityPic2"] length]) {
                finishNum2 = 1;
                UIButton * btn = (UIButton *)[bg1 viewWithTag:783401];
                [btn setTitle:@"" forState:UIControlStateNormal];
                [btn setBackgroundImage:[UIImage imageNamed:@"fk06"] forState:UIControlStateNormal];
                btn.frame = CGRectMake(UI_SCREEN_WIDTH-98, 10+35, 183/2.0f, 29/2.0f);
                [btn setTitleColor:UIColorFromRGB(0x666666) forState:UIControlStateNormal];
            }

            if ([_infoDict[@"identityPic3"] length]) {
                finishNum3 = 1;
                UIButton * btn = (UIButton *)[bg1 viewWithTag:783402];
                [btn setTitle:@"" forState:UIControlStateNormal];
                [btn setBackgroundImage:[UIImage imageNamed:@"fk06"] forState:UIControlStateNormal];
                btn.frame = CGRectMake(UI_SCREEN_WIDTH-98, 10+35*2, 183/2.0f, 29/2.0f);
                [btn setTitleColor:UIColorFromRGB(0x666666) forState:UIControlStateNormal];
            }

            if ([_infoDict[@"studentCard"] length]) {
                finishNum4 = 1;
                UIButton * btn = (UIButton *)[bg2 viewWithTag:783400];
                [btn setTitle:@"" forState:UIControlStateNormal];
                [btn setBackgroundImage:[UIImage imageNamed:@"fk06"] forState:UIControlStateNormal];
                btn.frame = CGRectMake(UI_SCREEN_WIDTH-98, 10, 183/2.0f, 29/2.0f);
                [btn setTitleColor:UIColorFromRGB(0x666666) forState:UIControlStateNormal];
            }

        }

        if (_errorDict) {
            if ([_errorDict[@"identityPic1"] length]) {
                UIButton * btn = (UIButton *)[bg1 viewWithTag:783400];
                [btn setTitle:@"" forState:UIControlStateNormal];
                [btn setBackgroundImage:[UIImage imageNamed:@"fk07"] forState:UIControlStateNormal];
                btn.frame = CGRectMake(UI_SCREEN_WIDTH-98, 10, 183/2.0f, 29/2.0f);
                [btn setTitleColor:UIColorFromRGB(0x666666) forState:UIControlStateNormal];
            }

            if ([_errorDict[@"identityPic2"] length]) {
                UIButton * btn = (UIButton *)[bg1 viewWithTag:783401];
                [btn setTitle:@"" forState:UIControlStateNormal];
                [btn setBackgroundImage:[UIImage imageNamed:@"fk07"] forState:UIControlStateNormal];
                btn.frame = CGRectMake(UI_SCREEN_WIDTH-98, 10+35, 183/2.0f, 29/2.0f);
                [btn setTitleColor:UIColorFromRGB(0x666666) forState:UIControlStateNormal];
            }

            if ([_errorDict[@"identityPic3"] length]) {
                UIButton * btn = (UIButton *)[bg1 viewWithTag:783402];
                [btn setTitle:@"" forState:UIControlStateNormal];
                [btn setBackgroundImage:[UIImage imageNamed:@"fk07"] forState:UIControlStateNormal];
                btn.frame = CGRectMake(UI_SCREEN_WIDTH-98, 10+35*2, 183/2.0f, 29/2.0f);
                [btn setTitleColor:UIColorFromRGB(0x666666) forState:UIControlStateNormal];
            }

            if ([_errorDict[@"studentCard"] length]) {
                UIButton * btn = (UIButton *)[bg2 viewWithTag:783400];
                [btn setTitle:@"" forState:UIControlStateNormal];
                [btn setBackgroundImage:[UIImage imageNamed:@"fk07"] forState:UIControlStateNormal];
                btn.frame = CGRectMake(UI_SCREEN_WIDTH-98, 10, 183/2.0f, 29/2.0f);
                [btn setTitleColor:UIColorFromRGB(0x666666) forState:UIControlStateNormal];
            }
            
        }

    }

    if ([_infoDict[@"identityPic1"] length] && [_infoDict[@"identityPic2"] length] && [_infoDict[@"identityPic3"] length] && [_infoDict[@"studentCard"] length]) {
        [self getImageWithStatus:[infoDic[@"status"] intValue]];
    }



}


- (void)getImageWithStatus:(int)status{
    if (status == 0) {
        //未填写
        [self allBtnShowImage:@"fk05"];
        [self allBtnChangeSize:0];
    }else if (status == 1) {
        [self allBtnShowImage:@"fk06"];
        [self allBtnChangeSize:1];
    }else if (status == 10 || status == 11 || status == 12) {
        [self allBtnShowImage:@"fk06_5"];
        [self allBtnChangeSize:2];
    }else if (status == 44) {
        [self allBtnShowImage:@"fk07"];
        [self allBtnChangeSize:2];
    }else if (status == 22) {
        [self allBtnShowImage:@"fk07"];
        [self allBtnChangeSize:1];
    }else if (status == 21) {
        [self allBtnShowImage:@"fk08"];
        [self allBtnChangeSize:2];
    }else if (status == 33 || status == 44 || status == 25) {
        [self allBtnShowImage:@"fk07"];
        [self allBtnChangeSize:2];
    }


}

- (void)allBtnChangeSize:(int)type{
    UIButton * btn1 = (UIButton *)[bg1 viewWithTag:783400];
    UIButton * btn2 = (UIButton *)[bg1 viewWithTag:783401];
    UIButton * btn3 = (UIButton *)[bg1 viewWithTag:783402];
    UIButton * btn4 = (UIButton *)[bg2 viewWithTag:783400];


    if (!type) {
        btn1.frame = CGRectMake(UI_SCREEN_WIDTH-65, 12, 107/2.0f, 27/2.0f);
        btn2.frame = CGRectMake(UI_SCREEN_WIDTH-65, 12+35, 107/2.0f, 27/2.0f);
        btn3.frame = CGRectMake(UI_SCREEN_WIDTH-65, 12+2*35, 107/2.0f, 27/2.0f);
        btn4.frame = CGRectMake(UI_SCREEN_WIDTH-65, 12, 107/2.0f, 27/2.0f);
    }else if (type == 1) {
        btn1.frame = CGRectMake(UI_SCREEN_WIDTH-98, 11, 183/2.0f, 29/2.0f);
        btn2.frame = CGRectMake(UI_SCREEN_WIDTH-98, 11+35, 183/2.0f, 29/2.0f);
        btn3.frame = CGRectMake(UI_SCREEN_WIDTH-98, 11+35*2, 183/2.0f, 29/2.0f);
        btn4.frame = CGRectMake(UI_SCREEN_WIDTH-98, 11, 183/2.0f, 29/2.0f);
    }else{
        btn1.frame = CGRectMake(UI_SCREEN_WIDTH-68, 11, 183/2.0f, 29/2.0f);
        btn2.frame = CGRectMake(UI_SCREEN_WIDTH-68, 11+35, 183/2.0f, 29/2.0f);
        btn3.frame = CGRectMake(UI_SCREEN_WIDTH-68, 11+2*35, 183/2.0f, 29/2.0f);
        btn4.frame = CGRectMake(UI_SCREEN_WIDTH-68, 11, 183/2.0f, 29/2.0f);
    }
}

- (void)allBtnShowImage:(NSString *)image{
    UIButton * btn1 = (UIButton *)[bg1 viewWithTag:783400];
    UIButton * btn2 = (UIButton *)[bg1 viewWithTag:783401];
    UIButton * btn3 = (UIButton *)[bg1 viewWithTag:783402];
    UIButton * btn4 = (UIButton *)[bg2 viewWithTag:783400];

    [btn1 setTitle:@"" forState:UIControlStateNormal];
    [btn2 setTitle:@"" forState:UIControlStateNormal];
    [btn3 setTitle:@"" forState:UIControlStateNormal];
    [btn4 setTitle:@"" forState:UIControlStateNormal];

    [self perfectBtnShowWithBtn:btn1 height:10 image:image];
    [self perfectBtnShowWithBtn:btn2 height:10+35 image:image];
    [self perfectBtnShowWithBtn:btn3 height:10+35*2 image:image];
    [self perfectBtnShowWithBtn:btn4 height:10 image:image];
}


- (void)perfectBtnShowWithBtn:(UIButton *)btn height:(float)h image:(NSString *)image{
    [btn setBackgroundImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
    [btn setTitle:nil forState:UIControlStateNormal];
    [btn setFrame:CGRectMake(240, h, 183/2.0f, 29/2.0f)];

}

- (UIView *)createBgViewWithNumber:(int)number titleArray:(NSArray *)titleArray y:(float)height labelWidth:(float)width{
    UIView * bgView = [[UIView alloc] initWithFrame:CGRectMake(0, height+10, UI_SCREEN_WIDTH, 35*number)];
    bgView.backgroundColor = [UIColor whiteColor];
    [backScrollView addSubview:bgView];

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
        label.textAlignment = NSTextAlignmentLeft;
        //        label.backgroundColor = [UIColor orangeColor];

        UIImageView * greenIV = [[UIImageView alloc] initWithFrame:CGRectMake(215, 11+35*i, 107/2.0f, 27/2.0f)];
        greenIV.image = [UIImage imageNamed:@"fk06"];
        greenIV.tag = 873600+i;
        greenIV.hidden = YES;
        [bgView addSubview:greenIV];

        UIButton * btn = [XDTools getAButtonWithFrame:CGRectMake(265, 7+35*i, 50, 20) nomalTitle:@"请上传" hlTitle:@"" titleColor:UIColorFromRGB(0xc60203) bgColor:[UIColor clearColor] nbgImage:nil hbgImage:nil action:@selector(chooseImage:) target:self buttonTpye:UIButtonTypeCustom];
        btn.titleLabel.font = [UIFont systemFontOfSize:13];
        btn.tag = 783400+i;
        [bgView addSubview:btn];

    }
    
    return bgView;
}


- (void)save{
    if (finishNum1 == 1 && finishNum2 == 1 && finishNum3 == 1 && finishNum4 == 1) {
        NSMutableDictionary * infoDic = [NSMutableDictionary dictionaryWithDictionary:[[NSUserDefaults standardUserDefaults] objectForKey:kMMyUserInfo]];
        [infoDic setObject:@"1" forKey:@"picInfo"];

        NSUserDefaults *userDef=[NSUserDefaults standardUserDefaults];
        //存登录信息

        [userDef setObject:infoDic forKey:kMMyUserInfo];
        [userDef synchronize];

        [self.delegate refreshStatus:@"2"];
        [self.navigationController popViewControllerAnimated:YES];
    }else{
        [XDTools showTips:@"请按说明上传照片" toView:self.contentView];
    }
}

- (void)chooseImage:(UIButton *)sender{

    //状态不等于00、01、22，不可以修改资料
    NSDictionary * infoDic = [[NSUserDefaults standardUserDefaults] objectForKey:kMMyUserInfo];
    if ([infoDic[@"status"] intValue] != 0 && [infoDic[@"status"] intValue] != 1 && [infoDic[@"status"] intValue] != 22 && [infoDic[@"status"] intValue] != 11 && [infoDic[@"status"] intValue] != 12) {
        return;
    }


    switch (sender.tag - 783400) {
        case 0:
        {
            if (sender.superview.bounds.size.height > 40) {
//                [XDTools showTips:@"身份证正面" toView:self.contentView];
                uploadStr = @"1";
            }else{
//                [XDTools showTips:@"学生证" toView:self.contentView];
                uploadStr = @"4";
            }
        }
            break;
        case 1:
        {
//            [XDTools showTips:@"身份证背面" toView:self.contentView];
            uploadStr = @"2";
        }
            break;
        case 2:
        {
//            [XDTools showTips:@"手持身份证正面照片" toView:self.contentView];
            uploadStr = @"3";
        }
            break;

        default:
            break;
    }
    UIActionSheet * alertAction = [[UIActionSheet alloc]initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"拍照", nil];
    alertAction.tag = 100003;
    [alertAction showInView:self.view];
}


#pragma mark xuan ze zhao pian de dai li
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingImage:(UIImage *)image editingInfo:(NSDictionary *)editingInfo {

    CGSize imagesize = image.size;
    imagesize.height =626;
    imagesize.width =413;
    image = [self imageWithImage:image scaledToSize:imagesize];
    NSData *imageData = UIImageJPEGRepresentation(image,0.00001);

    //http://bbs.chinapet.com/plugin.php?id=leepet_thread:api&action=changePic

    NSDictionary *dict=[[NSUserDefaults standardUserDefaults]objectForKey:kMMyUserInfo];



    NSArray * keyArr = @[@"identityPic1",@"identityPic2",@"identityPic3",@"studentCard"];

    NSString * keyStr = keyArr[uploadStr.intValue-1];


    NSDictionary * dic = @{@"uid": dict[@"uid"],
                           @"token":dict[@"token"],
                           @"userName":dict[@"userName"]};


    ASIFormDataRequest *request = [XDTools postRequestWithDict:dict Data:imageData imageKey:keyStr API:API_UPDATEUSERPIC];


    //[[ASIFormDataRequest alloc]initWithURL:[NSURL URLWithString:requestUrl]];
    //    [request setPostValue:@"leepet_thread:api" forKey:@"uid"];
    //    [request setPostValue:@"changePic" forKey:@"action"];
    //    [request setPostValue:[dict objectForKey:@"uid"]forKey:@"uid"];
    //
    //    [request addData:imageData withFileName:@"KKK" andContentType:@"image/jpeg" forKey:@"img"];
    //
    //    [request setRequestMethod:@"POST"];
    //    [request setTimeOutSeconds:12];
    //    [request setDelegate:self];
    //    [request setDidFinishSelector:@selector(requestFinishedReturned:)];
    //    [request setDidFailSelector:@selector(requestFinishedReturnedFailed:)];




    [request setCompletionBlock:^{
        [XDTools hideProgress:self.contentView];

        NSDictionary *tempDic = [XDTools  JSonFromString:[request responseString]];

        DDLOG(@"dic   ===    %@",tempDic);


        if([[tempDic objectForKey:@"result"]intValue] == 0){

            isChanged = YES;

            if (uploadStr.intValue == 1) {
                finishNum1 = 1;
            }else if (uploadStr.intValue == 2) {
                finishNum2 = 1;
            }else if (uploadStr.intValue == 3) {
                finishNum3 = 1;
            }else{
                finishNum4 = 1;
            }

            //图片状态显示成功
            if (uploadStr.intValue < 4) {
//                UIImageView * greenIcon = (UIImageView *)[bg1 viewWithTag:873600+uploadStr.intValue-1];
//                greenIcon.hidden = NO;

                UIButton * btn = (UIButton *)[bg1 viewWithTag:783400+uploadStr.intValue-1];
                [btn setTitle:@"" forState:UIControlStateNormal];
                [btn setBackgroundImage:[UIImage imageNamed:@"fk06"] forState:UIControlStateNormal];
                btn.frame = CGRectMake(UI_SCREEN_WIDTH-98, 10+35*(uploadStr.intValue-1), 183/2.0f, 29/2.0f);
                [btn setTitleColor:UIColorFromRGB(0x666666) forState:UIControlStateNormal];

            }else{
//                UIImageView * greenIcon = (UIImageView *)[bg2 viewWithTag:873600];
//                greenIcon.hidden = NO;

                UIButton * btn = (UIButton *)[bg2 viewWithTag:783400];
                [btn setTitle:@"" forState:UIControlStateNormal];
                [btn setBackgroundImage:[UIImage imageNamed:@"fk06"] forState:UIControlStateNormal];
                btn.frame = CGRectMake(UI_SCREEN_WIDTH-98, 10, 183/2.0f, 29/2.0f);
                [btn setTitleColor:UIColorFromRGB(0x666666) forState:UIControlStateNormal];
            }

            if (finishNum1 == 1 && finishNum2 == 1 && finishNum3 == 1 && finishNum4 == 1) {
                NSMutableDictionary * infoDic = [NSMutableDictionary dictionaryWithDictionary:[[NSUserDefaults standardUserDefaults] objectForKey:kMMyUserInfo]];
                [infoDic setObject:@"1" forKey:@"picInfo"];

                NSUserDefaults *userDef=[NSUserDefaults standardUserDefaults];
                //存登录信息

                [userDef setObject:infoDic forKey:kMMyUserInfo];
                [userDef synchronize];

                self.mmmVC.isreflash = NO;

                [self.delegate refreshStatus:@"2"];
            }

//            [XDTools showTips:@"修改头像成功" toView:self.view];
//
//            [self performSelector:@selector(backPrePage) withObject:nil afterDelay:1];

        }else{
            [XDTools showTips:tempDic[@"msg"] toView:self.view];

        }
    }];

    [request setFailedBlock:^{

        [XDTools hideProgress:self.contentView];
        NSError *error = [request error];
        DDLOG(@"error=%@",error);
    }];
    
    
    
    [request startAsynchronous];
    [XDTools showProgress:self.contentView];
    
    [picker dismissViewControllerAnimated:YES completion:^{
        
    }];


//    if([self respondsToSelector:@selector(requestFinishedReturned:)]){





//    }
}
-(void)requestFinishedReturned:(id)senser{

    DDLOG(@"chenggong");
}
-(void)requestFinishedReturnedFailed:(id)sender{
    DDLOG(@"shibai");
}
//对图片尺寸进行压缩--
-(UIImage*)imageWithImage:(UIImage*)image scaledToSize:(CGSize)newSize
{
    // Create a graphics image context
    UIGraphicsBeginImageContext(newSize);

    // Tell the old image to draw in this new context, with the desired
    // new size
    [image drawInRect:CGRectMake(0,0,newSize.width,newSize.height)];

    // Get the new image from the context
    UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();

    // End the context
    UIGraphicsEndImageContext();

    // Return the new image.
    return newImage;
}
//- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
//
//}
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    [picker dismissViewControllerAnimated:YES completion:^{

    }];
}


#pragma mark UIActionSheet Delegate
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    if(buttonIndex ==0){
        if (IOS7) {
            AVAuthorizationStatus status = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
//            [XDTools showTips:[NSString stringWithFormat:@"%d",status] toView:self.contentView];
            if (status == AVAuthorizationStatusAuthorized) {
                [self choseImageWithTypeCameraTypePhotoLibrary:UIImagePickerControllerSourceTypeCamera];
            }else{
                UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"无法使用相机" message:@"请在iPhone的“设置-隐私-相机”中允许访问相机" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
                [alert show];
            }
        }else{
            [self choseImageWithTypeCameraTypePhotoLibrary:UIImagePickerControllerSourceTypeCamera];
        }

    }

}
- (void)actionSheetCancel:(UIActionSheet *)actionSheet{

}
- (void)willPresentActionSheet:(UIActionSheet *)actionSheet{

}
- (void)didPresentActionSheet:(UIActionSheet *)actionSheet{


}
- (void)actionSheet:(UIActionSheet *)actionSheet willDismissWithButtonIndex:(NSInteger)buttonIndex{

}
- (void)actionSheet:(UIActionSheet *)actionSheet didDismissWithButtonIndex:(NSInteger)buttonIndex{

}-(void)choseImageWithTypeCameraTypePhotoLibrary:(UIImagePickerControllerSourceType)type{
    UIImagePickerController * imagePicker = [[UIImagePickerController alloc] init];

    imagePicker.delegate =self;
    imagePicker.sourceType = type;

    imagePicker.modalTransitionStyle = UIModalTransitionStyleCoverVertical;

    imagePicker.allowsEditing =YES;
    [self presentViewController:imagePicker animated:YES completion:^{

    }];
}




@end
