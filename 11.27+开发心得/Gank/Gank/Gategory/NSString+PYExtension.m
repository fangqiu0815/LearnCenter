//
//  NSString+Extension.m
//  新浪微博
//
//  Created by 谢培艺 on 15/12/15.
//  Copyright © 2015年 iphone5solo. All rights reserved.
//

#import "NSString+PYExtension.h"

@implementation NSString (PYExtension)

- (CGSize)sizeWithMaxWidth:(CGFloat)maxWidth font:(UIFont *)font
{
    NSMutableDictionary *attr = [NSMutableDictionary dictionary];
    attr[NSFontAttributeName] = font;
    
   return  [self boundingRectWithSize:CGSizeMake(maxWidth, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:attr context:nil].size;
}

// 时间转换 秒 -- > 具体日期
+ (NSString *)intervalToDateWithIntervalString:(NSString *)intervalString
{
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:[intervalString longLongValue]];
    // 格式化时间
    NSDateFormatter *dateF = [[NSDateFormatter alloc] init];
    dateF.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    NSString *dateStr = [dateF stringFromDate:date];
    return dateStr;
}

// 时间转换 具体日期 --> 秒数
+ (NSString *)dateToIntervalWithDate:(NSDate *)date
{
    NSTimeInterval time = [[NSDate date] timeIntervalSince1970];
    long long int dateStr = (long long int)time;
    
    return [NSString stringWithFormat:@"%lld", dateStr];
}

/**
 * 用于首页时间显示（刚刚、几分钟前、昨天...）
 */
- (NSString *)dateToNow
{
    // 转为发表时间
    //    NSDate *time = [NSDate dateWithTimeIntervalSince1970:[self longLongValue]];
    
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    // 如果是真机调试，转换这种欧美时间，需要设置locale
    fmt.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US"];
    
    // 设置日期格式（声明字符串里面每个数字和单词的含义）
    // E:星期几
    // M:月份
    // d:几号(这个月的第几天)
    // H:24小时制的小时
    // m:分钟
    // s:秒
    // y:年
//    fmt.dateFormat = @"EEE MMM dd HH:mm:ss Z yyyy";
    fmt.dateFormat = @"yyyy-MM-dd";
    //    _createAt = @"Tue Sep 30 17:06:25 +0800 2014";
    
    // 微博的创建日期
    NSDate *createDate = [fmt dateFromString:self];
    
    if ([self isThisYear:createDate]) { // 今年
        if ([self isYesterday:createDate]) { // 昨天
            return @"昨日推荐";
        } else if ([self isToday:createDate]) { // 今天
            return @"今日推荐";
        } else { // 今年的其他日子
            return nil;
        }
    } else { // 非今年
        return nil;
    }
}

/**
 * 判断是否为今天
 */

- (BOOL)isToday:(NSDate *)time
{
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    fmt.dateFormat = @"yyyy-MM-dd";
    
    NSString *dateStr = [fmt stringFromDate:time];
    NSString *nowDateStr = [fmt stringFromDate:[NSDate date]];
    
    NSDate *date = [fmt dateFromString:dateStr];
    NSDate *now = [fmt dateFromString:nowDateStr];
    
    // 比较时间差
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSCalendarUnit unit = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay;
    NSDateComponents *cmp = [calendar components:unit fromDate:date toDate:now options:0];
    
    return cmp.year == 0 && cmp.month == 0 && cmp.day == 0;
}

/**
 * 判断是否为今年
 */
- (BOOL)isThisYear:(NSDate *)time
{
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    fmt.dateFormat = @"yyyy";
    
    NSString *dateStr = [fmt stringFromDate:time];
    NSString *nowDateStr = [fmt stringFromDate:[NSDate date]];
    
    NSDate *date = [fmt dateFromString:dateStr];
    NSDate *now = [fmt dateFromString:nowDateStr];
    
    // 比较时间差
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSCalendarUnit unit = NSCalendarUnitYear;
    NSDateComponents *cmp = [calendar components:unit fromDate:date toDate:now options:0];
    
    return cmp.year == 0;
}
/**
 * 判断是否为昨天
 */

- (BOOL)isYesterday:(NSDate *)time
{
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    fmt.dateFormat = @"yyyy-MM-dd";
    
    NSString *dateStr = [fmt stringFromDate:time];
    NSString *nowDateStr = [fmt stringFromDate:[NSDate date]];
    
    NSDate *date = [fmt dateFromString:dateStr];
    NSDate *now = [fmt dateFromString:nowDateStr];
    
    // 比较时间差
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSCalendarUnit unit = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay;
    NSDateComponents *cmp = [calendar components:unit fromDate:date toDate:now options:0];
    
    return cmp.year == 0 && cmp.month == 0 && cmp.day == 1;
    
}


@end
