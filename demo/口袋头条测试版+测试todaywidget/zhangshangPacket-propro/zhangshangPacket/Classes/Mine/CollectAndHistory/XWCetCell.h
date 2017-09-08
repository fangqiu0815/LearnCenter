//
//  XWCetCell.h
//  zhangshangPacket
//
//  Created by apple on 2017/7/21.
//  Copyright © 2017年 apple-fangqiu. All rights reserved.
//

#import "XWCell.h"
#import "XWHomeModel.h"

@interface XWCetCell : UITableViewCell

@property (nonatomic, strong) UILabel *titleLab;

@property (nonatomic, strong) UIImageView *imgView;

@property (nonatomic, strong) UILabel *timeLab;

@property (nonatomic, strong) UIView *bottomLine;


@property (nonatomic, strong) NewsListDataModel *model;

@end
