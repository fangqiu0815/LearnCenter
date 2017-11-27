//
//  AddressCell.m
//  XDLookPic
//
//  Created by XD-XY on 5/27/14.
//  Copyright (c) 2014 XD-XY. All rights reserved.
//

#import "AddressCell.h"
#import "XDHeader.h"
#import "XDTools.h"

@implementation AddressCell

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
    self.selectBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _selectBtn.frame = CGRectMake(21,14.5,23,25);
    [_selectBtn setBackgroundImage:[UIImage imageNamed:@"choose_no_img"] forState:UIControlStateDisabled];
    [_selectBtn setEnabled:NO];
    
    self.titleLB = [[UILabel alloc] initWithFrame:CGRectMake(width_x(_selectBtn)+17, 0, 200, 54)];
    _titleLB.backgroundColor = [UIColor clearColor];
    _titleLB.font = [UIFont systemFontOfSize:15];
    
    [self.contentView addSubview:_selectBtn];
    [self.contentView addSubview:_titleLB];
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
