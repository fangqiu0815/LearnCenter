//
//  ZhengJianUploadViewController.h
//  XDCommonApp
//
//  Created by xindao on 14-8-7.
//  Copyright (c) 2014年 XD-XY. All rights reserved.
//

#import "XDBaseViewController.h"
@class MaterialsViewController;
@protocol ZhengjianRefreshStatusDelegate <NSObject>
-(void)refreshStatus:(NSString *)type;
@end

@interface ZhengJianUploadViewController : XDBaseViewController<UINavigationControllerDelegate,UIImagePickerControllerDelegate,UIScrollViewDelegate,UIActionSheetDelegate>
{
    UIScrollView * backScrollView;
    UIImagePickerController * imagePickerView;
    NSString * uploadStr;
    UIView * bg1;
    UIView * bg2;

    int finishNum1;
    int finishNum2;
    int finishNum3;
    int finishNum4;

    BOOL isChanged;
}
@property(nonatomic,assign)MaterialsViewController * mmmVC;
@property (nonatomic,strong) NSMutableDictionary * infoDict;
@property (nonatomic,strong) NSMutableDictionary * errorDict;
@property(nonatomic,assign) id <ZhengjianRefreshStatusDelegate> delegate;

@end
