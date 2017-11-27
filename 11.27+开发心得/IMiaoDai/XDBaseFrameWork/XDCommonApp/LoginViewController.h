//
//  LoginViewController.h
//  XDCommonApp
//
//  Created by XD-WangLong on 2/13/14.
//  Copyright (c) 2014 XD-WangLong. All rights reserved.
//

#import "XDBaseViewController.h"




@interface LoginViewController : XDBaseViewController<UITextFieldDelegate,UIScrollViewDelegate>
{
    UITextField *userNameField;
    UITextField *passWordField;
    UIScrollView *mScrollView;
    
}

@property (nonatomic,strong) NSArray *permissions;
//@property (nonatomic,copy) NSString * type;
@end
