//
//  XWMineMidCell.h
//  zhangshangPacket
//
//  Created by apple on 2017/5/17.
//  Copyright © 2017年 apple-fangqiu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XWMineMidCell : UITableViewCell

/**
 * 昨日收入元宝
 */
@property(nonatomic, strong) UILabel *yesIncomeLab;

/**
 * lineView
 */
@property(nonatomic, strong) UIView *lineViewOne;

/**
 * 当前可兑换元宝
 */
@property(nonatomic, strong) UILabel *canGetLab;

- (void)setCellDataWithYesCash:(NSString *)yesCash andTodayCoin:(NSString *)todayCoin;


@end
