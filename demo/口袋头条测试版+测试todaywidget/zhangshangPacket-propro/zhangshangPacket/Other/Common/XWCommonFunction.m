//
//  XWCommonFunction.m
//  zhangshangnews
//
//  Created by apple on 2017/5/10.
//  Copyright © 2017年 apple-fangqiu. All rights reserved.
//

#import "XWCommonFunction.h"
#import <AVFoundation/AVFoundation.h>
#import <SystemConfiguration/CaptiveNetwork.h>
@implementation XWCommonFunction

#define SOUNDID  1109  //1012 -iphone   1152 ipad  1109 ipad
+ (void)systemVibrate
{
    AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
}

+ (void)systemSound
{
    AudioServicesPlaySystemSound(SOUNDID);
}
+ (UIImage *)createImageWithColor:(UIColor *)color
{
    CGRect rect=CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return theImage;
}
+ (BOOL)isValidateMobileNumber:(NSString *)mobileNum
{
    NSString * MOBILE = @"^1\\d{10}$";
    
    NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", MOBILE];
    
    if ([regextestmobile evaluateWithObject:mobileNum] == YES)
    {
        return YES;
    }
    else
    {
        return NO;
    }
}
+ (NSString *)constellationWithDate:(NSDate *)date
{
    NSString *dayRange[] = {
        @"01-20",
        @"02-19",
        @"03-21",
        @"04-20",
        @"05-21",
        @"06-22",
        @"07-23",
        @"08-23",
        @"09-23",
        @"10-24",
        @"11-23",
        @"12-22",
        @"12-32"
    };
    
    NSString *constellations[] = {
        @"魔羯座",
        @"水瓶座",
        @"双鱼座",
        @"白羊座",
        @"金牛座",
        @"双子座",
        @"巨蟹座",
        @"狮子座",
        @"处女座",
        @"天秤座",
        @"天蝎座",
        @"射手座",
        @"魔羯座",
    };
    
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"MM-dd"];
    NSString *dateString = [dateFormat stringFromDate:date];
    
    for (int i = 0; i < 13; i++)
    {
        if ([dateString compare:dayRange[i]] < 0)
        {
            return constellations[i];
        }
    }
    
    return @"";
}
+ (BOOL)validateEmail:(NSString *)email
{
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:email];
}
+ (BOOL)validatePureInt:(NSString*)string
{
    NSScanner* scan = [NSScanner scannerWithString:string];
    int val;
    
    return [scan scanInt:&val] && [scan isAtEnd];
}
+(NSString *)getDeviceUUid
{
    return  [[[UIDevice currentDevice] identifierForVendor] UUIDString];
}
+(NSString *)getDeviceSystemVersion
{
    UIDevice *device = [[UIDevice alloc] init];
    NSString *systemName = device.systemName;
    return systemName;
}
+(NSString *)getWifiAccount
{
    NSArray *ifs = (__bridge id)CNCopySupportedInterfaces();
    id info = nil;
    for (NSString *ifnam in ifs) {
        info = (__bridge id)CNCopyCurrentNetworkInfo((__bridge CFStringRef)ifnam);
        if (info && [info count]) {
            break;
        }
    }
    NSDictionary *dctySSID = (NSDictionary *)info;
    NSString *ssid = [dctySSID objectForKey:@"SSID"];
    return ssid;
}

+(void)backFromController:(UIViewController *)nowController toController:(Class)toControllerClass
{
    UINavigationController *navVC = nowController.navigationController;
    NSMutableArray *viewControllers = [[NSMutableArray alloc] init];
    for (UIViewController *vc in [navVC viewControllers]) {
        [viewControllers addObject:vc];
        if ([vc isKindOfClass:toControllerClass]) {
            break;
        }
    }
    [navVC setViewControllers:viewControllers animated:YES];
}
+(NSString *)normalDataChangeToStr:(NSDate *)date
{
    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:@"yyyy.MM.dd HH:MM"];
    return [formatter stringFromDate:date];
}
+(NSString *)normalDataStrChangeToStr:(long long)date
{
    NSString *dateStr = [NSString stringWithFormat:@"%lld",date];
    NSInteger num = [dateStr integerValue]/1000;
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:@"yyyy.MM.dd HH:MM"];
    NSDate *confromTimesp = [NSDate dateWithTimeIntervalSince1970:num];
    NSString *confromTimespStr = [formatter stringFromDate:confromTimesp];
    return confromTimespStr;
}

///由时间戳转为时间格式
-(NSString *)timeStampToString:(CGFloat)timeStamp{
    NSString *timeString = [[NSString alloc]init];
    
    //当前时间的时间戳
    NSTimeInterval  timeNow=[[NSDate date] timeIntervalSince1970];
    
    //将传来的时间戳转为标准时间格式
    NSTimeInterval time = timeStamp;
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:time];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSString *tempStr= [dateFormatter stringFromDate:date];
    
    timeString = [NSString stringWithFormat:@"%@年%@月%@日 %@",[tempStr substringWithRange:NSMakeRange(0,4)],[tempStr substringWithRange:NSMakeRange(5,2)],[tempStr substringWithRange:NSMakeRange(8,2)],[tempStr substringWithRange:NSMakeRange(11,8)]];
    
    //当前时间
    NSDate *nowDate = [NSDate date];
    NSString *nowDateStr= [dateFormatter stringFromDate:nowDate];
    
    //时间戳判断逻辑
    if ([[timeString substringWithRange:NSMakeRange(0, 4)] isEqualToString:[nowDateStr substringWithRange:NSMakeRange(0, 4)]]) {
        
        if ([[timeString substringWithRange:NSMakeRange(5,2)] isEqualToString:[nowDateStr substringWithRange:NSMakeRange(5,2)]]) {
            
            float daySubtract = [[nowDateStr substringWithRange:NSMakeRange(8,2)] floatValue] - [[timeString substringWithRange:NSMakeRange(8,2)] floatValue];
            
            if (daySubtract < 3) {
                
                if (daySubtract == 0) {
                    
                    NSString *string = [NSString stringWithFormat:@"今天 %@",[timeString substringWithRange:NSMakeRange(11,6)]];
                    return  string;
                    
                }else if (daySubtract == 1) {
                    
                    NSString *string = [NSString stringWithFormat:@"昨天 %@",[timeString substringWithRange:NSMakeRange(11,6)]];
                    return  string;
                }else {
                    
                    if ((timeNow - time) > 3600*24*2) {
                        
                        return timeString;
                    }else {
                        
                        NSString *string = [NSString stringWithFormat:@"前天 %@",[timeString substringWithRange:NSMakeRange(11,6)]];
                        return  string;
                    }
                    
                }
                
            }else{
                
                return timeString;
            }
            
        }else {
            return timeString;
            
        }
        
    }else {
        
        return timeString;
    }
}


+(NSString*)getCurrentTimestamp
{
    NSDate* data= [NSDate dateWithTimeIntervalSinceNow:0];
    NSTimeInterval interval=[data timeIntervalSince1970];
    NSString *timeString = [NSString stringWithFormat:@"%f", interval];//转为字符型
    return timeString;
}
+(NSString *)stringChangeToNormal:(long long)time
{
    NSDateFormatter *inputFormatter= [[NSDateFormatter alloc] init];
    [inputFormatter setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"en_US"]];
    [inputFormatter setDateFormat:@"yyyyMMddHHmmss"];
    NSDate*inputDate = [inputFormatter dateFromString:[NSString stringWithFormat:@"%lld",time]];
    NSDateFormatter *outputFormatter= [[NSDateFormatter alloc] init];
    [outputFormatter setLocale:[NSLocale currentLocale]];
    [outputFormatter setDateFormat:@"yyyy-MM-dd HH:mm"];
    NSString *str= [outputFormatter stringFromDate:inputDate];
    return str;
}
+(NSString *)getCurrentDataAndTime
{
    NSDate *  timeDate=[NSDate date];
    NSDateFormatter  *dateformatter=[[NSDateFormatter alloc] init];
    [dateformatter setDateFormat:@"HHmmss"];
    NSString *  locationString=[dateformatter stringFromDate:timeDate];
    NSCalendar* cal = [NSCalendar currentCalendar];
    NSUInteger unitFlags = NSCalendarUnitDay|NSCalendarUnitMonth | NSCalendarUnitYear;
    NSDateComponents* conponent = [cal components:unitFlags fromDate:timeDate];
    NSInteger year = [conponent year];
    NSInteger month = [conponent month];
    NSInteger day = [conponent day];
    NSString* nsDateString = [NSString stringWithFormat:@"%4ld%2ld%2ld%@",year,month,day,locationString];
    return nsDateString;
}
+ (CAShapeLayer*)setButtoncornerRadius:(UIRectCorner)corners
                                   Btn:(UIButton*)btn
                          cornerRadius:(float)cornerRadius
{
    [btn.layer setMasksToBounds:YES];
    CAShapeLayer *maskLayer = [CAShapeLayer layer];
    maskLayer.path = [UIBezierPath bezierPathWithRoundedRect:btn.bounds byRoundingCorners: corners cornerRadii: (CGSize){cornerRadius, cornerRadius}].CGPath;
    return maskLayer;
}
+(NSString *)changeToUtf8:(NSString *)normalStr
{
    NSString * encodedString = (NSString *)CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(NULL,(CFStringRef)normalStr,NULL,(CFStringRef)@"!*'();:@&=+$,/?%#[]",
                                                                                                     //The characters you want to replace go here
                                                                                                     kCFStringEncodingUTF8 ));
    return encodedString;
    
}

-(BOOL)isBlankString:(NSString *)string {
    if (string == nil || string == NULL) {
        return YES;
    }
    if ([string isKindOfClass:[NSNull class]]) {
        return YES;
    }
    if ([[string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] length]==0) {
        return YES;
    }
    if ([string isEqualToString:@"(null)"]) {
        return YES;
    }
    if ([string isEqualToString:@"<null>"]) {
        return YES;
    }
    return NO;
}

@end
