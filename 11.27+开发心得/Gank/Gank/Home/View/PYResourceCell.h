//
//  PYResourceCell.h
//  Gank
//
//  Created by 谢培艺 on 2017/2/27.
//  Copyright © 2017年 CoderKo1o. All rights reserved.
//

#import <UIKit/UIKit.h>
@class PYResource, PYPhotosView;

@interface PYResourceCell : UITableViewCell
/** 资源标题 */
@property (weak, nonatomic) UILabel *titleLabel;

/** 资源图片 */
@property (weak, nonatomic) PYPhotosView *photosView;

/** 资源模型 */
@property (nonatomic, strong) PYResource *resource;

+ (instancetype)cellWithTableView:(UITableView *)tableView;

@end
