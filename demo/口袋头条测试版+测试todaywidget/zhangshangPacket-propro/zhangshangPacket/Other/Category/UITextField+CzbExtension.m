

#import "UITextField+CzbExtension.h"

NSString * const USER_PW_LIMIYSTR = @"1234567890abcdefghijklmnopqrstuvwswzABCDEFGHIJKLMNOPQRSTUVWXYZ/\?.!@#$%^&*:;";

#define kPhoneNumLength     11
#define kPWMaximumLength    16
#define kCaptchaLength      6

@implementation UITextField (CzbExtension)

+ (instancetype)textFieldWithLeftView:(UIView *)leftView
                                 size:(CGSize)size
                         cornerRadius:(CGFloat)cornerRadius{
    
    UITextField *textField = [[UITextField alloc]init];
    leftView.frame = CGRectMake(0, 0, size.width, size.height);
    textField.leftView = leftView;
    textField.leftViewMode = UITextFieldViewModeAlways;
    textField.layer.cornerRadius = cornerRadius;
    textField.layer.masksToBounds = YES;
    textField.clearButtonMode = UITextFieldViewModeWhileEditing;
    textField.backgroundColor = [UIColor whiteColor];
    return textField;
}


+ (instancetype)phoneNumTextfieldWithLeftView:(UIView *)leftView
                                         size:(CGSize)size
                                 cornerRadius:(CGFloat)cornerRadius{

    UITextField *phoneNumTextField = [self textFieldWithLeftView:leftView
                                                            size:size
                                                    cornerRadius:cornerRadius];
    if (STUserDefaults.ischeck == 1) {
        phoneNumTextField.placeholder = @"请输入账号";

    } else {
        phoneNumTextField.placeholder = @"请输入手机号";

    }
    
    phoneNumTextField.textColor = [UIColor colorWithHexString:@"666666"];
    phoneNumTextField.font = [UIFont systemFontOfSize:RemindFont(16, 18, 20)];
    phoneNumTextField.backgroundColor = [UIColor whiteColor];
    phoneNumTextField.keyboardType = UIKeyboardTypeNumberPad;
    phoneNumTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
   
    [phoneNumTextField bk_addEventHandler:^(id sender) {
        phoneNumTextField.text = [phoneNumTextField.text limitStringLengthWithLength:kPhoneNumLength];
    } forControlEvents:UIControlEventEditingChanged];
    
    return phoneNumTextField;
}

+ (instancetype)inviteCodeTextfieldWithLeftView:(UIView *)leftView
                                         size:(CGSize)size
                                 cornerRadius:(CGFloat)cornerRadius{
    
    UITextField *phoneNumTextField = [self textFieldWithLeftView:leftView
                                                            size:size
                                                    cornerRadius:cornerRadius];
    if (STUserDefaults.ischeck == 1) {
        phoneNumTextField.placeholder = @"请输入密码";
        
    } else {
        phoneNumTextField.placeholder = @"请输入邀请码(选填)";
        
    }    phoneNumTextField.textColor = [UIColor colorWithHexString:@"666666"];
    phoneNumTextField.font = [UIFont systemFontOfSize:RemindFont(16, 18, 20)];
    phoneNumTextField.backgroundColor = [UIColor whiteColor];
    phoneNumTextField.keyboardType = UIKeyboardTypeNumberPad;
    phoneNumTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
    
    [phoneNumTextField bk_addEventHandler:^(id sender) {
        phoneNumTextField.text = [phoneNumTextField.text limitStringLengthWithLength:kPhoneNumLength];
    } forControlEvents:UIControlEventEditingChanged];
    
    return phoneNumTextField;
}



+ (instancetype)passwordTextFieldWithLeftView:(UIView *)leftView
                                         size:(CGSize)size
                                 cornerRadius:(CGFloat)cornerRadius{
    
    UITextField *passwordTextField = [self textFieldWithLeftView:leftView
                                                            size:size
                                                    cornerRadius:cornerRadius];
    passwordTextField.placeholder = @"请输入密码";
    passwordTextField.backgroundColor = [UIColor whiteColor];
    passwordTextField.textColor = [UIColor colorWithHexString:@"666666"];
    passwordTextField.font = [UIFont systemFontOfSize:RemindFont(16, 18, 20)];
    passwordTextField.secureTextEntry = YES;
   
    [passwordTextField setBk_shouldChangeCharactersInRangeWithReplacementStringBlock:^BOOL(UITextField *textField, NSRange range , NSString *string){
        
        return [string shouldChangeCharaetersWithLimitString:USER_PW_LIMIYSTR];
    }];
    
    [passwordTextField bk_addEventHandler:^(id sender) {
        
        passwordTextField.text = [passwordTextField.text limitStringLengthWithLength:kPWMaximumLength];
    } forControlEvents:UIControlEventEditingChanged];
   
    return passwordTextField;
}

+ (instancetype)captchaTextFieldWithLeftView:(UIView *)leftView
                                        size:(CGSize)size
                                cornerRadius:(CGFloat)cornerRadius{

    UITextField *captchaTextField = [self textFieldWithLeftView:leftView
                                                           size:size
                                                   cornerRadius:cornerRadius];
    [captchaTextField bk_addEventHandler:^(id sender) {
        
        captchaTextField.text = [captchaTextField.text limitStringLengthWithLength:kCaptchaLength];
    } forControlEvents:UIControlEventEditingChanged];
    
    captchaTextField.textColor = [UIColor colorWithHexString:@"666666"];
    captchaTextField.font = [UIFont systemFontOfSize:RemindFont(16, 18, 20)];
    captchaTextField.backgroundColor = [UIColor whiteColor];
    captchaTextField.keyboardType = UIKeyboardTypeNumberPad;
    captchaTextField.placeholder = @"请输入验证码";
    captchaTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
    
    return captchaTextField;

}

- (void)setPlaceholderColor:(UIColor *)color{

    color = color ? color : [UIColor grayColor];
    [self setValue:color forKeyPath:@"_placeholderLabel.textColor"];
}

- (void)setBorderColor:(UIColor *)borderColor
           borderWidth:(CGFloat)borderWidth
          cornerRadius:(CGFloat)cornerRadius{
    
    borderColor = borderColor?borderColor:[UIColor grayColor];
    [self.layer setBorderColor:borderColor.CGColor];
    [self.layer setBorderWidth:borderWidth];
    [self.layer setCornerRadius:cornerRadius];
}

@end
