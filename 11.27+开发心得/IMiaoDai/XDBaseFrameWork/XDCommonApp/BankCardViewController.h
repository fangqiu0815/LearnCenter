//
//  BankCardViewController.h
//  XDCommonApp
//
//  Created by xindao on 14-8-7.
//  Copyright (c) 2014年 XD-XY. All rights reserved.
//

#import "XDBaseViewController.h"
@class MaterialsViewController;
@protocol BankRefreshStatusDelegate <NSObject>
-(void)refreshStatus:(NSString *)type;
@end

@interface BankCardViewController : XDBaseViewController<UITextFieldDelegate>
{
    UITextField * cardNumberTF;
    UITextField * bankNameTF;
    BOOL isAdd;

    NSString * oldCardNumber;
    NSString * newCardNumber;

    UIButton * saveBtn;
}
@property(nonatomic,assign)MaterialsViewController * mmmVC;
@property (nonatomic,strong) NSMutableDictionary * infoDict;
@property (nonatomic,strong) NSMutableDictionary * errorDict;
@property(nonatomic,assign) id <BankRefreshStatusDelegate> delegate;

@end
