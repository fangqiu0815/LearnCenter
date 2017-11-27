//
//  PYCalendarView.m
//  Gank
//
//  Created by 谢培艺 on 2017/2/28.
//  Copyright © 2017年 CoderKo1o. All rights reserved.
//

#import "PYCalendarView.h"
#import "NSString+PYExtension.h"
@interface PYCalendarView ()

/** 几号 */
@property (nonatomic, weak) UILabel *dayLabel;

/** 几月 */
@property (nonatomic, weak) UILabel *monthLabel;

/** 星期几 */
@property (nonatomic, weak) UILabel *weakDayLabel;

@end

@implementation PYCalendarView

- (instancetype)init
{
    if (self = [super init]) {
        
        UILabel *dayLabel = [[UILabel alloc] init];
        dayLabel.textColor = [UIColor whiteColor];
        dayLabel.font = [UIFont systemFontOfSize:24];
       
        self.dayLabel = dayLabel;
        [self addSubview:dayLabel];
        
        UILabel *monthLabel = [[UILabel alloc] init];
        monthLabel.textColor = [UIColor colorWithWhite:1.0 alpha:0.5];
        monthLabel.font = [UIFont systemFontOfSize:12];
        self.monthLabel = monthLabel;
        [self addSubview:monthLabel];
        
        UILabel *weakDayLabel = [[UILabel alloc] init];
        weakDayLabel.textColor = monthLabel.textColor;
        weakDayLabel.font = [UIFont systemFontOfSize:12];
        self.weakDayLabel = weakDayLabel;
        [self addSubview:weakDayLabel];
    }
    return self;
}

- (void)setFrame:(CGRect)frame
{
    [super setFrame:frame];
    
    self.dayLabel.frame = CGRectMake(2, 0, frame.size.width, frame.size.height);
    self.monthLabel.frame = CGRectMake(frame.size.width * 0.5, 2.5, frame.size.width * 0.5 + 5, frame.size.height * 0.5 - 2.5);
    self.weakDayLabel.frame = CGRectMake(frame.size.width * 0.5, frame.size.height * 0.5 - 2.5, frame.size.width * 0.5 + 5, frame.size.height * 0.5 - 2.5);
}


- (void)updateCalendarView:(NSString *)dateString
{
    // 解析日期
    NSDateFormatter *dateFmt = [[NSDateFormatter alloc] init];
    // 2017-02-09T11:46:26.70Z
    dateFmt.dateFormat = @"yyyy-MM-dd";
    NSDate *date = [dateFmt dateFromString:[dateString substringToIndex:dateFmt.dateFormat.length]];
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *dateComponents = [calendar components:NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitWeekday fromDate:date];
    // 设置数据
    NSString *dayText = [[dateString substringToIndex:dateFmt.dateFormat.length] dateToNow];
    if (dayText.length == 4) { // 今日推荐/昨日推荐
        self.dayLabel.font = [UIFont preferredFontForTextStyle:UIFontTextStyleHeadline];
        self.dayLabel.text = dayText;
        self.dayLabel.textAlignment = NSTextAlignmentCenter;
        self.weakDayLabel.text = nil;
        self.monthLabel.text = nil;
        return;
    }
    
    self.dayLabel.font = [UIFont systemFontOfSize:24];
    self.dayLabel.textAlignment = NSTextAlignmentLeft;
    self.dayLabel.text = [NSString stringWithFormat:@" %02zd", dateComponents.day];
    self.monthLabel.text = [NSString stringWithFormat:@"%zd月", dateComponents.month];
    // 转换星期文字
    NSString *weakDayString;
    switch (dateComponents.weekday) {
        case 1:
            weakDayString = @"日";
            break;
        case 2:
            weakDayString = @"一";
            break;
        case 3:
            weakDayString = @"二";
            break;
        case 4:
            weakDayString = @"三";
            break;
        case 5:
            weakDayString = @"四";
            break;
        case 6:
            weakDayString = @"五";
            break;
        case 7:
            weakDayString = @"六";
            break;
            
        default:
            break;
    }
    self.weakDayLabel.text = [NSString stringWithFormat:@"星期%@", weakDayString];
}


@end
