//
//  XWPacketHeaderView.h
//  zhangshangPacket
//
//  Created by apple on 2017/5/12.
//  Copyright © 2017年 apple-fangqiu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XWPacketHeaderView : UIView


/**
 * 签到
 */
@property (nonatomic, strong) UIButton *signInBtn;

/**
 * 签到天数
 */
@property (nonatomic, strong) UILabel *signInDayLab;

/*
 * 签到天数字数
 **/
@property (nonatomic, strong) UILabel *signInNumberLab;

/*
 *  天
 **/
@property (nonatomic, strong) UILabel *dayLab;

/**
 * 当前日期
 */
@property (nonatomic, strong) UILabel *nowTimeLab;

/**
 * 签到规则
 */
@property (nonatomic, strong) UIButton *signInRulBtn;





@end
