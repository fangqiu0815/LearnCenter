
#import <UIKit/UIKit.h>

@interface UITextField (CzbExtension)



/**
 带有leftView的textField

 @param leftView leftVeiw
 @param size 大小
 @param cornerRadius 圆角
 @return textField
 */
+ (instancetype)textFieldWithLeftView:(UIView *)leftView
                                 size:(CGSize)size
                         cornerRadius:(CGFloat)cornerRadius;



+ (instancetype)phoneNumTextfieldWithLeftView:(UIView *)leftView
                                         size:(CGSize)size
                                 cornerRadius:(CGFloat)cornerRadius;

+ (instancetype)inviteCodeTextfieldWithLeftView:(UIView *)leftView
                                           size:(CGSize)size
                                   cornerRadius:(CGFloat)cornerRadius;


+ (instancetype)passwordTextFieldWithLeftView:(UIView *)leftView
                                         size:(CGSize)size
                                 cornerRadius:(CGFloat)cornerRadius;

+ (instancetype)captchaTextFieldWithLeftView:(UIView *)leftView
                                        size:(CGSize)size
                                cornerRadius:(CGFloat)cornerRadius;


/**
 设置placeholder颜色

 @param color 颜色
 */
- (void)setPlaceholderColor:(UIColor *)color;


/**
 设置一些属性

 @param borderColor 边框颜色
 @param borderWidth 边框宽度
 @param cornerRadius 圆角
 */
- (void)setBorderColor:(UIColor *)borderColor
           borderWidth:(CGFloat)borderWidth
          cornerRadius:(CGFloat)cornerRadius;
@end
