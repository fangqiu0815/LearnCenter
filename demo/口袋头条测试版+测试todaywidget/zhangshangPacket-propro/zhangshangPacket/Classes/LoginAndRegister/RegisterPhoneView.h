//
//  RegisterPhoneView.h
//  CrazyPacket
//
//  Created by huangyujie on 17/3/6.
//  Copyright © 2017年 WuYanZu. All rights reserved.
//

#import <UIKit/UIKit.h>
@interface RegisterPhoneView : UIView<UITextFieldDelegate>
{
    UIView *mainView;
    UITextField *phoneText;
    UITextField *verificationCode;//验证码
    UIButton *sendCodeBtn;
    UIButton *registerBtn;
    NSInteger index;//计时
    NSTimer *timer;
    BOOL issucressforcode;
}

-(instancetype)initWithFrame:(CGRect)frame;
@end
