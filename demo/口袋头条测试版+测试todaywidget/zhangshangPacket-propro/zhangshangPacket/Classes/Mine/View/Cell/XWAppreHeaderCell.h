//
//  XWAppreHeaderCell.h
//  zhangshangPacket
//
//  Created by apple on 2017/5/20.
//  Copyright © 2017年 apple-fangqiu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XWAppreHeaderCell : UITableViewCell

/**
 * 徒弟数量
 */
@property(nonatomic, strong) UILabel *incomeMoney;

/**
 * lineView
 */
@property(nonatomic, strong)UIView *lineViewOne;

/**
 * 徒弟收益
 */
@property(nonatomic, strong)UILabel *withdrawMoney;


@end
