//
//  CardCellCollectionViewCell.m
//  DDCardAnimation
//
//  Created by tondyzhang on 16/10/11.
//  Copyright © 2016年 tondy. All rights reserved.
//

#import "CardCellCollectionViewCell.h"
#import "PYResourceCell.h"
#import "PYResource.h"
#import "PYCalendarView.h"

@interface CardCellCollectionViewCell() <UITableViewDelegate, UITableViewDataSource>

/** 显示日历 */
@property (nonatomic, weak) PYCalendarView *calendarView;

@end

static int cellCount;

@implementation CardCellCollectionViewCell

-(instancetype)init
{
    self = [self initWithFrame:CGRectZero];
    return self;
}

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initUI];
        cellCount++;
    }
    return self;
}
/**
 * 添加日历
 */
- (void)setupCalendarView
{
    CGFloat w = 85;
    CGFloat h = 40;
    PYCalendarView *calendarView = [[PYCalendarView alloc] init];
    calendarView.frame = CGRectMake(self.frame.size.width - w - 10, 10, w, h);
    calendarView.backgroundColor = [UIColor colorWithWhite:0.0 alpha:0.8];
    calendarView.layer.cornerRadius = 5;
    [self addSubview:calendarView];
    self.calendarView = calendarView;
}

-(void)layoutSubviews
{
    self.contentView.frame = self.bounds;
    [self bringSubviewToFront:self.calendarView];
}

-(void)initUI
{
    self.layer.cornerRadius = 6;
    self.layer.masksToBounds = YES;
    [self setupCalendarView];
}

- (UITableView *)tableView
{
    if (!_tableView) {
        UITableView *tableView = [[UITableView alloc] initWithFrame:self.bounds style:UITableViewStylePlain];
        tableView.userInteractionEnabled = NO;
        tableView.showsVerticalScrollIndicator = NO;
        // 取消分割线
        tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        tableView.backgroundColor = [UIColor clearColor];
        tableView.dataSource = self;
        tableView.delegate = self;
        tableView.contentInset = UIEdgeInsetsMake(0, 0, 10, 0);
        _tableView = tableView;
        [self addSubview:tableView];
    }
    return _tableView;
}

- (void)setResouces:(NSArray *)resouces
{
    _resouces = [resouces copy];
    // 刷新ui
    [self.tableView reloadData];
}

-(void)setBgColor:(UIColor *)bgColor
{
    _bgColor = bgColor;
    self.contentView.backgroundColor = bgColor;
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // 设置时间
    if (self.resouces.count > 0) {
        PYResource *resource = self.resouces[0];
        [self.calendarView updateCalendarView:resource.publishedAt];
    }
    return self.resouces.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    // 加载cell
    PYResourceCell *cell = [PYResourceCell cellWithTableView:tableView];
    
    // 设置数据
    cell.resource = self.resouces[indexPath.row];
    
    // 返回cell
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    // 取出模型
    PYResource *resource = self.resouces[indexPath.row];
    // 获取cell高度
    return resource.cellHeight;
}

#pragma mark - UITableDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // 取出模型
    PYResource *resource = self.resouces[indexPath.row];
    // 发出通知
    NSNotificationCenter *notiCenter = [NSNotificationCenter defaultCenter];
    NSDictionary *userInfo = @{ PYCarDeatilViewCellResourceKey : resource,
                                PYCarDeatilViewCellBackgroundKey : self.bgColor,
                                };
    [notiCenter postNotificationName:PYCarDeatilViewCellDidSelectedNotification object:nil userInfo:userInfo];
}


NSNotificationName const PYCarDeatilViewCellDidSelectedNotification = @"PYCarDeatilViewCellDidSelectedNotification";
NSNotificationName const PYCarDeatilViewCellResourceKey = @"PYCarDeatilViewCellResourceKey";
NSNotificationName const PYCarDeatilViewCellBackgroundKey = @"PYCarDeatilViewCellBackgroundKey";

@end
