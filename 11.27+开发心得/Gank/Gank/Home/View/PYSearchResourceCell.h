//
//  PYSearchResourceCell.h
//  Gank
//
//  Created by 谢培艺 on 2017/3/7.
//  Copyright © 2017年 CoderKo1o. All rights reserved.
//

#import <UIKit/UIKit.h>
@class PYResource;

@interface PYSearchResourceCell : UITableViewCell

/** 资源模型 */
@property (nonatomic, strong) PYResource *resource;

/** 快速创建cell */
+ (instancetype)cellWithTableView:(UITableView *)tableView;

@end
