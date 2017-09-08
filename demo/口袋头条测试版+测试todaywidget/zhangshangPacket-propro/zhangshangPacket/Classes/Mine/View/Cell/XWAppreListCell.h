//
//  XWAppreListCell.h
//  zhangshangPacket
//
//  Created by apple on 2017/5/20.
//  Copyright © 2017年 apple-fangqiu. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "XWMineTudiListModel.h"

@interface XWAppreListCell : XWCell

@property (nonatomic, strong) UIImageView *iconImageView;

@property (nonatomic, strong) UILabel *titleLab;

@property (nonatomic, strong) UILabel *timeLab;

@property (nonatomic, strong) UILabel *moneyLab;

@property (nonatomic, strong) UILabel *incomeLab;


-(void)setcell:(NSDictionary *)dic withindex:(NSInteger )index;

@end
