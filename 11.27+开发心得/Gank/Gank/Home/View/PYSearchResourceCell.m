//
//  PYSearchResourceCell.m
//  Gank
//
//  Created by 谢培艺 on 2017/3/7.
//  Copyright © 2017年 CoderKo1o. All rights reserved.
//

#import "PYSearchResourceCell.h"
#import "PYResource.h"
#import "UIColor+PYExtension.h"

@interface PYSearchResourceCell ()

/** 内容标题 */
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

/** 类型 */
@property (weak, nonatomic) IBOutlet UIView *typeView;

/** 相关信息 类型+发布者+时间 */
@property (weak, nonatomic) IBOutlet UILabel *relateLabel;
@property (weak, nonatomic) IBOutlet UIView *indicatorView;

@end

@implementation PYSearchResourceCell

+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *const searchResourceCellID = @"searchResourceCellID";
    // 创建cell
    PYSearchResourceCell *cell = [tableView dequeueReusableCellWithIdentifier:searchResourceCellID];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:0] lastObject];
    }
    return cell;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    
    // 设置相关属性
    self.typeView.layer.cornerRadius = self.typeView.frame.size.width * 0.5;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.indicatorView.layer.backgroundColor = [UIColor py_colorWithHexString:@"6F7179"].CGColor;
}

- (void)setResource:(PYResource *)resource
{
    _resource = resource;
    // 设置数据
    self.titleLabel.text = resource.desc;
    self.relateLabel.text = [NSString stringWithFormat:@"%@    @%@    %@", resource.type, resource.who, [resource.publishedAt substringToIndex:@"yyyy-MM-dd".length]];
}

@end
