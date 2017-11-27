//
//  MaterialsViewController.h
//  XDCommonApp
//
//  Created by xindao on 14-8-6.
//  Copyright (c) 2014年 XD-XY. All rights reserved.
//

#import "XDBaseViewController.h"
#import "PersonInfoViewController.h"
#import "ZhengJianUploadViewController.h"
#import "BankCardViewController.h"
@interface MaterialsViewController : XDBaseViewController<UIAlertViewDelegate,BaseInfoRefreshStatusDelegate,ZhengjianRefreshStatusDelegate,BankRefreshStatusDelegate>
{
    UIImageView * userinfoIV;
    UIImageView * zhengjianUploadIV;
    UIImageView * bankCardInfoIV;

    NSMutableArray * phoneBookArray;
    NSString * phoneBookStr;

}
@property (nonatomic,copy) NSString * type;

@property (nonatomic,strong) NSMutableDictionary * baseInfoDict;
@property (nonatomic,strong) NSMutableDictionary * baseInfoErrorDict;
@property (nonatomic,strong) NSMutableDictionary * otherInfoDict;
@property (nonatomic,strong) NSMutableDictionary * otherInfoErrorDict;
@property (nonatomic,strong) NSMutableDictionary * picInfoDict;
@property (nonatomic,strong) NSMutableDictionary * picInfoErrorDict;
@property (nonatomic,assign) BOOL isreflash;

@end
