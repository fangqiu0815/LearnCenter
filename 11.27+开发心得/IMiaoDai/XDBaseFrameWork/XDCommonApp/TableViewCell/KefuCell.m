//
//  KefuCell.m
//  XDCommonApp
//
//  Created by XD-XY on 8/19/14.
//  Copyright (c) 2014 XD-XY. All rights reserved.
//

#import "KefuCell.h"
#import "XDTools.h"
#import "XDHeader.h"

@implementation KefuCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        [self makeViews];
    }
    return self;
}

-(void)makeViews
{
    self.headIV = [[UIImageView alloc] initWithFrame:CGRectMake(10,(40-35/2.0f)/2.0f,35/2.0f,35/2.0f)];
    
    self.titleLB = [[UILabel alloc] initWithFrame:CGRectMake(width_x(_headIV)+11/2.0f,0,200,40)];
    _titleLB.backgroundColor = [UIColor clearColor];
    _titleLB.textColor = UIColorFromRGB(0x696969);
    _titleLB.font = [UIFont systemFontOfSize:15.0f];
    
    self.lineIV1 = [[UIImageView alloc] initWithFrame:CGRectMake(0,0,320,0.5)];
    _lineIV1.backgroundColor = UIColorFromRGB(0xcbcbcb);
    
    self.lineIV2 = [[UIImageView alloc] initWithFrame:CGRectMake(0,39.5,320,0.5)];
    _lineIV2.backgroundColor = UIColorFromRGB(0xcbcbcb);
    
    [self.contentView addSubview:_headIV];
    [self.contentView addSubview:_titleLB];
    [self.contentView addSubview:_lineIV1];
    [self.contentView addSubview:_lineIV2];
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
