//
//  XWDisAblumCell.h
//  zhangshangPacket
//
//  Created by apple on 2017/8/3.
//  Copyright © 2017年 apple-fangqiu. All rights reserved.
//

#import "XWCell.h"
#import "XWDisBestAblumModel.h"

@interface XWDisAblumCell : UITableViewCell

@property (nonatomic, strong) UIView *whiteView;

@property (nonatomic, strong) UIImageView *iconImageView;

@property (nonatomic, strong) UILabel *titleLab;

@property (nonatomic, strong) UILabel *timeLab;

@property (nonatomic, strong) UILabel *detailLab;

@property (nonatomic, strong) DisBestAblumModel *dataModel;


@end
