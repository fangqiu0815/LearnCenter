//
//  XRSetCell.m
//  XDLookPic
//
//  Created by xiaorui on 14-4-23.
//  Copyright (c) 2014年 XD-XY. All rights reserved.
//

#import "XRSetCell.h"
#import "XDHeader.h"

@implementation XRSetCell
@synthesize contentLabel =_contentLabel;
@synthesize bgImageView =_bgImageView;
@synthesize upImageView = _upImageView;
@synthesize downImageView =_downImageView;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self creatCell];
    }
    return self;
}
-(void)creatCell{
    _bgImageView =[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, UI_SCREEN_WIDTH, 44)];
    _bgImageView.backgroundColor =[UIColor clearColor];
//    _bgImageView.image =[UIImage imageNamed:@"setbackbg.png"];
    [self addSubview:_bgImageView];
    _contentLabel =[[UILabel alloc]initWithFrame:CGRectMake(20, 2, 220, 40)];
    _contentLabel.backgroundColor =[UIColor clearColor];
    [_bgImageView addSubview:_contentLabel];
    
    _upImageView =[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, UI_SCREEN_WIDTH, .5f)];
    _upImageView.backgroundColor =[UIColor clearColor];
    _upImageView.image =[UIImage imageNamed:@"line@2x.png"];
    _upImageView.hidden = YES;
    [self addSubview:_upImageView];
    _downImageView =[[UIImageView alloc]initWithFrame:CGRectMake(0, 43.5, UI_SCREEN_WIDTH, .5)];
    _downImageView.backgroundColor =[UIColor clearColor];
    _downImageView.image =[UIImage imageNamed:@"line@2x.png"];
    [self addSubview:_downImageView];
    
    _imageView1=[[UIImageView alloc]initWithFrame:CGRectMake(UI_SCREEN_WIDTH -54, 11, 17, 14)];
    [self.contentView addSubview:_imageView1];
    
    _imageView2 = [[UIImageView alloc]initWithFrame:CGRectMake(UI_SCREEN_WIDTH -54-23, 11, 23, 23)];
    [self.contentView addSubview:_imageView2];
    
    _mlabel = [XDTools addAlabelForAView:self.contentView withText:@"绑定" frame:CGRectMake(273, 15, 33, 16) font:[UIFont systemFontOfSize:16] textColor:[UIColor blackColor]];
    _mlabel.hidden = YES;
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
