//
//  MyInfoViewController.m
//  XDCommonApp
//
//  Created by xindao on 14-8-8.
//  Copyright (c) 2014年 XD-XY. All rights reserved.
//

#import "MyInfoViewController.h"
#import "ChangeCodeViewController.h"
#import "UIImageView+WebCache.h"
//#import "APService.h"
#import <AVFoundation/AVFoundation.h>
@implementation MyInfoViewController

- (void)viewDidLoad{
    [super viewDidLoad];

    self.titleLabel.text = @"我的";

    myTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, UI_SCREEN_WIDTH, UI_MAINSCREEN_HEIGHT - UI_NAVIGATION_BAR_HEIGHT) style:UITableViewStylePlain];
    myTableView.dataSource = self;
    myTableView.delegate = self;
    myTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    myTableView.backgroundColor =[UIColor clearColor];
    [self.contentView addSubview:myTableView];

}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (!section) {
        return 2;
    }
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (!indexPath.row) {
        return 75;
    }
    return 40;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 20;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView * view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 20)];
    view.backgroundColor = [UIColor clearColor];
    return view;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString * cellIde = @"cell";
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellIde];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIde];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;

        cell.textLabel.font = [UIFont systemFontOfSize:14];
        UIImageView * line1 = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, UI_SCREEN_WIDTH, .5f)];
        line1.image = [UIImage imageNamed:@"line"];
        line1.tag = 782718;
        line1.hidden = YES;
        [cell.contentView addSubview:line1];

        UIImageView * line2 = [[UIImageView alloc] initWithFrame:CGRectMake(0, 39.5f, UI_SCREEN_WIDTH, .5f)];
        line2.image = [UIImage imageNamed:@"line"];
        line2.tag = 782719;
        [cell.contentView addSubview:line2];

        UIImageView * headIV = [[UIImageView alloc] initWithFrame:CGRectMake(235, 10, 55, 55)];
        headIV.tag = 977653;
        headIV.hidden = YES;
        headIV.layer.cornerRadius = headIV.bounds.size.height/2;
        headIV.layer.masksToBounds = YES;
        [cell.contentView addSubview:headIV];


    }
    if (!indexPath.section) {
        if (!indexPath.row) {
            cell.textLabel.text = @"头像";
            UIImageView * line = (UIImageView *)[cell.contentView viewWithTag:782718];
            line.hidden = NO;
            UIImageView * line1 = (UIImageView *)[cell.contentView viewWithTag:782719];
            line1.frame = CGRectMake(0, 74.5f, UI_SCREEN_WIDTH, .5f);

            UIImageView * headIV = (UIImageView *)[cell.contentView viewWithTag:977653];
            headIV.hidden = NO;
            [headIV setImageWithURL:[NSURL URLWithString:[[[NSUserDefaults standardUserDefaults] objectForKey:kMMyUserInfo] objectForKey:@"pic"]] placeholderImage:[UIImage imageNamed:@"humanHeader"]];

        }else if (indexPath.row == 1) {
            cell.textLabel.text = @"修改密码";
            UIImageView * line = (UIImageView *)[cell.contentView viewWithTag:782718];
            line.hidden = YES;
            UIImageView * headIV = (UIImageView *)[cell.contentView viewWithTag:977653];
            headIV.hidden = YES;
        }
    }else{
        UIButton * btn = [XDTools getAButtonWithFrame:CGRectMake(10, 0, 300, 40) nomalTitle:@"退出" hlTitle:@"退出" titleColor:UIColorFromRGB(0x636363) bgColor:UIColorFromRGB(0xcbcbcb) nbgImage:nil hbgImage:nil action:@selector(checkOut) target:self buttonTpye:UIButtonTypeCustom];
        btn.tag = 181240;
        [cell.contentView addSubview:btn];

        cell.backgroundColor = [UIColor clearColor];
        UIImageView * line = (UIImageView *)[cell.contentView viewWithTag:782719];
        line.hidden = YES;
        cell.accessoryType = UITableViewCellAccessoryNone;

        UIImageView * headIV = (UIImageView *)[cell.contentView viewWithTag:977653];
        headIV.hidden = YES;
    }
    if (indexPath.section) {
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (!indexPath.section) {
        if (!indexPath.row) {
            UIActionSheet * alertAction = [[UIActionSheet alloc]initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"拍照",@"从相册选择", nil];
            alertAction.tag = 100003;
            [alertAction showInView:self.view];
        }else if (indexPath.row == 1) {
            ChangeCodeViewController * change = [[ChangeCodeViewController alloc] init];
            [self.navigationController pushViewController:change animated:YES];
        }
    }
    
}

- (void)checkOut{
    UIActionSheet * alertAction = [[UIActionSheet alloc]initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"确认退出", nil];
//    alertAction.
    alertAction.tag = 100007;
    [alertAction showInView:self.view];
}

- (void)quit{
    [XDTools setPushInfoType:@"1" andValue:@"0"];
    [XDTools setPushInfoType:@"2" andValue:@"0"];
    [XDTools setPushInfoType:@"3" andValue:@"0"];
    [XDTools setPushInfoType:@"4" andValue:@"0"];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:kMMyUserInfo];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"shortTimeInfo"];
    [[NSUserDefaults standardUserDefaults] synchronize];
//    [APService setTags:[NSSet setWithObject:@""] callbackSelector:nil object:nil];

    [XDTools showTips:@"退出成功" toView:self.contentView];
    [self performSelector:@selector(backPrePage) withObject:nil afterDelay:1];
}

#pragma mark xuan ze zhao pian de dai li
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingImage:(UIImage *)image editingInfo:(NSDictionary *)editingInfo {

    if (![XDTools NetworkReachable]) {
        [XDTools showTips:brokenNetwork toView:self.view];
        return;
    }

    
    CGSize imagesize = image.size;
    imagesize.height =626;
    imagesize.width =413;
    image = [self imageWithImage:image scaledToSize:imagesize];
    NSData *imageData = UIImageJPEGRepresentation(image,0.00001);

    //http://bbs.chinapet.com/plugin.php?id=leepet_thread:api&action=changePic

    NSDictionary *dict=[[NSUserDefaults standardUserDefaults]objectForKey:kMMyUserInfo];
//    NSString *requestUrl = @"http://bbs.chinapet.com/plugin.php?id=leepet_thread:api&action=changePic";

//    uid
//    token
//    userName
//    pic

    NSDictionary * dic = @{@"uid": dict[@"uid"],
                           @"token":dict[@"token"],
                           @"userName":dict[@"userName"]};


    ASIFormDataRequest *request = [XDTools postRequestWithDict:dict Data:imageData imageKey:@"pic" API:API_CHANGEHEADIMAGE];

    [request setCompletionBlock:^{
        [XDTools hideProgress:self.view];

        NSDictionary *tempDic = [XDTools  JSonFromString:[request responseString]];

        DDLOG(@"dic   ===    %@",tempDic);

        if([[tempDic objectForKey:@"result"]intValue] == 0){

            [[SDImageCache sharedImageCache] removeImageForKey:[dict objectForKey:@"userface"]];
            [[SDImageCache sharedImageCache] removeImageForKey:[dict objectForKey:@"userface"]fromDisk:YES];
            [[SDImageCache sharedImageCache] removeImageForKey:[[tempDic objectForKey:@"userinfo"] objectForKey:@"pic"]];
            [[SDImageCache sharedImageCache] removeImageForKey:[[tempDic objectForKey:@"userinfo"] objectForKey:@"pic"]fromDisk:YES];

            NSMutableDictionary * infoDic = [NSMutableDictionary dictionaryWithDictionary:[[NSUserDefaults standardUserDefaults] objectForKey:kMMyUserInfo]];
            [infoDic setObject:tempDic[@"data"][@"pic"] forKey:@"pic"];
            [[NSUserDefaults standardUserDefaults] setObject:infoDic forKey:kMMyUserInfo];

            [XDTools showTips:@"修改头像成功" toView:self.view];
//            [self performSelector:@selector(backPrePage) withObject:nil afterDelay:1];
            [myTableView reloadData];

        }else{
            [XDTools showTips:tempDic[@"msg"] toView:self.view];
        }
    }];

    [request setFailedBlock:^{

        [XDTools hideProgress:self.view];
        NSError *error = [request error];
        DDLOG(@"error=%@",error);
    }];



    [request startAsynchronous];

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
    if (actionSheet.tag == 100003) {
        if(buttonIndex ==0){
            if (IOS7) {
                AVAuthorizationStatus status = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
                //            [XDTools showTips:[NSString stringWithFormat:@"%d",status] toView:self.contentView];
                if (status != AVAuthorizationStatusDenied) {
                    [self choseImageWithTypeCameraTypePhotoLibrary:UIImagePickerControllerSourceTypeCamera];
                }else{
                    UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"无法使用相机" message:@"请在iPhone的“设置-隐私-相机”中允许访问相机" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
                    [alert show];
                }
            }else{
                [self choseImageWithTypeCameraTypePhotoLibrary:UIImagePickerControllerSourceTypeCamera];
            }

        }else if(buttonIndex == 1){
            [self choseImageWithTypeCameraTypePhotoLibrary:UIImagePickerControllerSourceTypePhotoLibrary];
        }
    }else{
        if(buttonIndex ==0){
            [self quit];
        }
    }

}

-(void)choseImageWithTypeCameraTypePhotoLibrary:(UIImagePickerControllerSourceType)type{
    UIImagePickerController * imagePicker = [[UIImagePickerController alloc] init];

    imagePicker.delegate =self;
    imagePicker.sourceType = type;

    imagePicker.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
    
    imagePicker.allowsEditing =YES;
    [self presentViewController:imagePicker animated:YES completion:^{
        
    }];
    
}

@end
