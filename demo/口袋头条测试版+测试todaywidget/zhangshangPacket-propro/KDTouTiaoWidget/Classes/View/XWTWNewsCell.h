//
//  XWTWNewsCell.h
//  zhangshangPacket
//
//  Created by apple on 2017/8/8.
//  Copyright © 2017年 apple-fangqiu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XWTWNewsModel.h"
@interface XWTWNewsCell : UITableViewCell

@property(nonatomic,strong) XWTWNewsModel *model;
@property (nonatomic, strong) UIImageView *imageTitleView;

@property (nonatomic, strong) UILabel *lblTitle;

@property (nonatomic, strong) UILabel *detailLab;

@property (nonatomic, strong) UILabel *resourceLab;

@property (nonatomic, strong) UILabel *authorLab;

@end
