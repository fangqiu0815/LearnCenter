//
//  XWCollectCell.h
//  zhangshangPacket
//
//  Created by apple on 2017/7/28.
//  Copyright © 2017年 apple-fangqiu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XWHomeCheckNewsInfoModel.h"
@interface XWCollectCell : UITableViewCell
@property (nonatomic, strong) UILabel *titleLab;

@property (nonatomic, strong) UIImageView *imgView;

@property (nonatomic, strong) UILabel *timeLab;

@property (nonatomic, strong) UIView *bottomLine;


@property (nonatomic, strong) NewsCheckList *model;
@end
