//
//  PersonCenterCell.m
//  XDCommonApp
//
//  Created by xindao on 14-8-14.
//  Copyright (c) 2014年 XD-XY. All rights reserved.
//

#import "PersonCenterCell.h"
#import "XDTools.h"

@implementation PersonCenterCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        self.backgroundColor = [UIColor whiteColor];
        [self makeViews];
    }
    return self;
}

-(void)makeViews
{
    self.titleLB = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, 200, 40)];
    _titleLB.backgroundColor = [UIColor clearColor];
    _titleLB.font = [UIFont systemFontOfSize:15];
    _titleLB.textColor = UIColorFromRGB(0x696969);

    self.rightIV = [[UIImageView alloc] initWithFrame:CGRectMake(UI_SCREEN_WIDTH-15-8, (40-15)/2.0f,8,15)];
    _rightIV.image = [UIImage imageNamed:@"jiantou_r"];
    self.rightLB = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, UI_SCREEN_WIDTH-15-8-15, 40)];
    _rightLB.font = [UIFont systemFontOfSize:12.5];
    _rightLB.textAlignment = NSTextAlignmentRight;
    _rightLB.backgroundColor = [UIColor clearColor];
    _rightLB.textColor = UIColorFromRGB(0x939393);
    _rightLB.hidden = YES;


    self.lineIV = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 320, 0.5)];
    _lineIV.backgroundColor = UIColorFromRGB(0xcbcbcb);
    [self.contentView addSubview:_lineIV];
    
    self.lineIV2 = [[UIImageView alloc] initWithFrame:CGRectMake(0, 39.5,320, 0.5)];
    _lineIV2.backgroundColor = UIColorFromRGB(0xcbcbcb);
    [self.contentView addSubview:_lineIV2];

    [self.contentView addSubview:_titleLB];
    [self.contentView addSubview:_rightIV];
    [self.contentView addSubview:_rightLB];
}

- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
