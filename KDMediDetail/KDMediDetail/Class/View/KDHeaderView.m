//
//  KDHeaderView.m
//  KDMediDetail
//
//  Created by apple-gaofangqiu on 2018/3/5.
//  Copyright © 2018年 apple-fangqiu. All rights reserved.
//

#import "KDHeaderView.h"

@implementation KDHeaderView

- (instancetype)initWithFrame:(CGRect)frame title:(NSString *)titleStr discount:(NSString *)dicountStr description:(NSString *)discriptionStr
{
    if(self = [super initWithFrame:frame]){
        self.backgroundColor = [UIColor whiteColor];
        // 图标
        UIImageView *imageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"fake_game"]];
        imageView.frame = CGRectMake(self.yj_height/8, self.yj_height/10, self.yj_height/2, self.yj_height/2);
        imageView.layer.cornerRadius = 10;
        imageView.layer.masksToBounds = YES;
        [self addSubview:imageView];

        // 标题
        UILabel *titleLab = [self labelWithText:titleStr textColor:[UIColor blackColor] fontSize:16];
        [self addSubview:titleLab];
        [titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(imageView.mas_right).offset(10);
            make.top.mas_equalTo(imageView.mas_top);
        }];
        
        // 媒体号
        UILabel *mediaLab = [self labelWithText:dicountStr textColor:[UIColor lightGrayColor] fontSize:14];
        [self addSubview:mediaLab];
        [mediaLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(imageView.mas_centerY);
            make.left.mas_equalTo(titleLab.mas_left);
        }];
        
        // 描述
        UILabel *discripeLab = [self labelWithText:discriptionStr textColor:[UIColor lightGrayColor] fontSize:14];
        [self addSubview:discripeLab];
        [discripeLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.mas_equalTo(imageView.mas_bottom);
            make.left.mas_equalTo(titleLab.mas_left);
        }];
        
        // 分栏内容
        self.segmentedControl = [[UISegmentedControl alloc] initWithItems:@[@"介绍", @"内容"]];
        self.segmentedControl.selectedSegmentIndex = 0;
        self.segmentedControl.selected = YES;
        self.segmentedControl.tintColor = [UIColor grayColor];
        [self addSubview:self.segmentedControl];
        
        CGFloat segmentControlWidthScale = 8 / 10.0;
        [self.segmentedControl mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self);
            make.top.equalTo(imageView.mas_bottom).mas_equalTo(self.yj_height/10);
            make.width.mas_equalTo(self.yj_width*segmentControlWidthScale);
        }];
        
        // 底边线
        CALayer *line = [CALayer layer];
        line.frame = CGRectMake(0, self.yj_height-1, self.yj_width, 1);
        line.backgroundColor = [UIColor grayColor].CGColor;
        [self.layer addSublayer:line];
        
        
    }
    
    return self;
}

/// 初始化一个UILabel
- (UILabel *)labelWithText:(NSString *)text textColor:(UIColor *)textColor fontSize:(CGFloat)fontSize {
    UILabel *label = [[UILabel alloc] init];
    label.text = text;
    label.textColor = textColor;
    label.font = [UIFont systemFontOfSize:fontSize];
    [label sizeToFit];
    return label;
}


@end
