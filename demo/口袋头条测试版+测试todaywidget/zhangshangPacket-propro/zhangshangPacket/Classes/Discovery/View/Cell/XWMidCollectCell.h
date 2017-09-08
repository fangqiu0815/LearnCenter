//
//  XWMidCollectCell.h
//  zhangshangPacket
//
//  Created by apple on 2017/8/5.
//  Copyright © 2017年 apple-fangqiu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XWDisEditRecommendModel.h"
@interface XWMidCollectCell : UICollectionViewCell

@property (nonatomic, strong) UIImageView *iconImageView;

@property (nonatomic, strong) UILabel *titleLab;

@property (nonatomic, strong) DisEditRecModel *dataModel;

-(void)setTheCellDataWithModel:(DisEditRecModel *)dataModel;

@end
