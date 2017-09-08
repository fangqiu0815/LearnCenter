//
//  ShopCategoryCell.m
//  CrazyPacket
//
//  Created by WuYanZu on 17/2/24.
//  Copyright © 2017年 WuYanZu. All rights reserved.
//

#import "ShopCategoryCell.h"

@interface ShopCategoryCell ()
{
    NSIndexPath *selectIndex;
}
@property (nonatomic, strong) UILabel *categoryLab;
@end

@implementation ShopCategoryCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
        [self addTheView];
    }
    return self;
}
-(void)setTheCellData:(NSString *)tempStr andIndexPath:(NSInteger)indexPath andSelectIndexPath:(NSInteger)selectIndexPath
{
    self.categoryLab.text = tempStr;
    if (indexPath == selectIndexPath)
    {
        self.categoryLab.backgroundColor = WhiteColor;
        self.categoryLab.textColor = [UIColor blackColor];
    }else
    {
        self.categoryLab.backgroundColor = CUSTOMCOLOR(245, 245, 245);
        self.categoryLab.textColor = CUSTOMCOLOR(119 ,119, 119);
    }
}
#pragma mark addTheView
-(void)addTheView
{
    [self addSubview:self.categoryLab];
    [self.categoryLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.mas_equalTo(0);
        make.bottom.mas_equalTo(-1);
    }];
    
    UIView *lineV = [[UIView alloc]init];
    lineV.backgroundColor = WhiteColor;
    [self addSubview:lineV];
    [lineV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(0);
        make.height.mas_equalTo(1);
        make.left.right.mas_equalTo(0);
    }];
}

#pragma mark btnAction

#pragma mark get
-(UILabel *)categoryLab
{
    if (_categoryLab == nil)
    {
        _categoryLab = [[UILabel alloc]init];
        _categoryLab.textColor = CUSTOMCOLOR(119, 119, 119);
        _categoryLab.font = [UIFont systemFontOfSize:RemindFont(12, 14, 16)];
        _categoryLab.backgroundColor = CUSTOMCOLOR(245, 245, 245);
        _categoryLab.textAlignment = NSTextAlignmentCenter;
    }
    return _categoryLab;
}
@end
