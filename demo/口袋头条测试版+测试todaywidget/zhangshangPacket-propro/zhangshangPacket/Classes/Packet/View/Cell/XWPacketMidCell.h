//
//  XWPacketMidCell.h
//  zhangshangPacket
//
//  Created by apple on 2017/5/12.
//  Copyright © 2017年 apple-fangqiu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XWSysTaskInfoListModel.h"
#import "XWUserTaskModel.h"

@interface XWPacketMidCell : XWCell
@property (nonatomic, strong) UIImageView *iconImage;

@property (nonatomic, strong) UILabel *titleLab;

@property (nonatomic, strong) UILabel *rightTitleLab;

@property (nonatomic, strong) UILabel *midTitleLab;

@property (nonatomic, strong) UIImageView *rightIcon;

- (void)setCellWithTitleDataStypeOne:(NSArray *)array ;

@property (nonatomic, strong) UserTask *dataModel;

- (void)setCellDataWithDict:(NSDictionary *)dict andArray:(NSMutableArray *)array;




@end
