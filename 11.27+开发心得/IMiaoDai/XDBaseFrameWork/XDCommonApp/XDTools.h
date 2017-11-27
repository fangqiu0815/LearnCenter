//
//  XDTools.h
//  XDCommonApp
//
//  Created by XD-XY on 2/12/14.
//  Copyright (c) 2014 XD-XY. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AppDelegate.h"
#import "XDHeader.h"
#import "ASIHTTPRequest.h"
#import "ASIFormDataRequest.h"
#import "ASINetworkQueue.h"
#import "JSONKit.h"
#import "XDTools.h"
#import "MBProgressHUD.h"
#import "FMDB.h"
#import "NSString+MD5.h"

@interface XDTools : NSObject<UIAlertViewDelegate>

DEFINE_SINGLETON_FOR_HEADER(XDTools)

+ (NSDictionary *) JSonFromString: (NSString*)result;
+ (AppDelegate *)appDelegate;
+ (BOOL)NetworkReachable;

+ (void)showProgress:(UIView *) view;
+ (void)showProgress:(UIView *) view showText:(NSString*)text;
+ (void) showTips:(NSString *)text toView:(UIView *)view;
+ (void)showSuccessTips:(NSString *)text toView:(UIView *)view;
+ (void)showErrorTips:(NSString *)text toView:(UIView *)view;
+ (void)hideProgress:(UIView *)view;      

- (void)checkVersion:(UIViewController *)viewController isShowAlert:(BOOL)isShow;

+ (ASIHTTPRequest*)getRequestWithDict:(NSDictionary *)dict API:(NSString *)api;
+ (ASIFormDataRequest*)postRequestWithDict:(NSDictionary *)dict API:(NSString *)api;
+ (ASIFormDataRequest*)postRequestWithDict:(NSDictionary *)dict Data:(NSData *)data imageKey:(NSString *)imageKey API:(NSString *)api;
//Label自适应大小
+(CGRect )xyAutoSizeOfWidget:(UILabel *)widget andSize:(CGSize)size andtextFont:(CGFloat )sizefont;
+(CGRect )autoSizeOftext:(NSString *)text andSize:(CGSize)size andtextFont:(CGFloat)sizefont;

//图片无损拉伸
+(UIImage *)stretchableImag:(UIImage *)image;
+(UIImage *)stretchableImag2:(UIImage *)image;

//打开数据
+(FMDatabase*)getDb;

+(void)moveFileToDocument:(NSString *)name andType:(NSString *)type;

- (NSString *)intervalSinceNow:(NSString *) theDate;


+(NSString *)documentsPath:(NSString *)fileName;
+(NSArray *)readFileArray;
+(NSString *)documentsPath;
+ (NSString *)intervalSinceNow:(NSString *)theDate sign:(NSString *)sign;
+ (NSArray *)intervalSinceNow:(NSString *)theDate WithDays:(BOOL)haveDays;
+(NSMutableArray *)productCookies;
+ (NSString *)encodedCookieValue:(NSString *)str;

+(void)judgeIsNull:(NSString *)string;

+(NSMutableAttributedString *)getAcolorfulStringWithText1:(NSString *)text1 Color1:(UIColor *)color1 Font1:(UIFont *)font1 Text2:(NSString *)text2 Color2:(UIColor *)color2 Font2:(UIFont *)font2 AllText:(NSString *)allText;
+(NSMutableAttributedString *)getAcolorfulStringWithTextArray:(NSArray *)array Color:(UIColor *)color Font:(UIFont *)font AllText:(NSString *)allText;
+ (UILabel *)addAlabelForAView:(UIView *)aView withText:(NSString *)labelText frame:(CGRect)labelFrame font:(UIFont *)labelFont textColor:(UIColor *)labelColor;

+ (UIButton *)getAButtonWithFrame:(CGRect)frame nomalTitle:(NSString *)title1 hlTitle:(NSString *)title2 titleColor:(UIColor *)tColor bgColor:(UIColor *)BgColor nbgImage:(NSString *)image1 hbgImage:(NSString *)image2 action:(SEL)selector target:(id)delegate buttonTpye:(UIButtonType)theButtonTpye;
+ (void)addLineToView:(UIView *)view frame:(CGRect)frame color:(UIColor *)color;


+ (void)showSuccessTips4:(NSString *)text toView:(UIView *)view;

//计算内存
+ (int)sizeOfFolder:(NSString*)folderPath;

//电话号码校验
+(BOOL)chickIphoneNumberRight:(NSString *)str;

//城市学校名称、编码转换
+ (NSString *)changeStringOrCode:(NSString *)str type:(NSString *)type table:(NSString *)table;

+(void)setPushInfoType:(NSString *)type andValue:(NSString *)value;

+(BOOL)getPushValueWithType:(NSString *)type;

+(BOOL)chickTextIsChinese:(NSString *)str;

+ (BOOL)validateIdentityCard: (NSString *)identityCard;
+ (NSString *)doDevicePlatform;
@end
