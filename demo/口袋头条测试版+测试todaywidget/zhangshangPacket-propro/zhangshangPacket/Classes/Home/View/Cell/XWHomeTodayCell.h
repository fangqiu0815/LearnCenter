//
//  XWHomeTodayCell.h
//  zhangshangPacket
//
//  Created by apple on 2017/5/27.
//  Copyright © 2017年 apple-fangqiu. All rights reserved.
//

#import "XWCell.h"
#import "XWHomeTodayModel.h"
@interface XWHomeTodayCell : XWMainCell


@property (nonatomic, strong) UILabel *timeLab;

@property (nonatomic, strong) UILabel *titleLab;

@property (nonatomic, strong) TodayData *todayModel;

@property (nonatomic, strong) UIView *circleView;

@property (nonatomic, strong) UIView *topView;

@property (nonatomic, strong) UIView *bottomView;



- (void)setCellWithDict:(NSDictionary *)dic;

@end
