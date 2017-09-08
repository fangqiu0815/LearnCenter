//
//  XWMineNoticeCell.h
//  zhangshangPacket
//
//  Created by apple on 2017/5/23.
//  Copyright © 2017年 apple-fangqiu. All rights reserved.
//

#import "XWCell.h"
#import "XWNoticeModel.h"
@interface XWMineNoticeCell : XWCell

/**
 * titleLab
 */
@property(nonatomic, strong) UILabel *titleLab;

/**
 * content
 */
@property(nonatomic, strong) UILabel *contentLab;

/**
 * time
 */
@property(nonatomic, strong) UILabel *timeLab;

@property (nonatomic, strong) NSString *urlStr;

@property (nonatomic, strong) XWNotice *noticeModel;

- (void)setCell:(NSDictionary *)dic;

@end
