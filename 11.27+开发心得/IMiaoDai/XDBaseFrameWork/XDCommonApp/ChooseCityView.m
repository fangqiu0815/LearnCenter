//
//  ChooseCityView.m
//  XDCommonApp
//
//  Created by XD-XY on 8/29/14.
//  Copyright (c) 2014 XD-XY. All rights reserved.
//

#import "ChooseCityView.h"
#import "XDTools.h"
#import "XDHeader.h"

@implementation ChooseCityView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        
        [self makeViews];
    }
    return self;
}

-(void)makeViews
{
    self.backgroundColor = [UIColor clearColor];

    self.bgView = [[UIView alloc] initWithFrame:self.bounds];
    _bgView.userInteractionEnabled = YES;
    _bgView.backgroundColor = [UIColor blackColor];
    _bgView.alpha = 0.7;
    
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(closeChooseCityView)];
    [_bgView addGestureRecognizer:tap];
    
    self.contentView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 116)];
    _contentView.backgroundColor = [UIColor whiteColor];
    
    [self addSubview:_bgView];
    [self addSubview:_contentView];
    
    UILabel * label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 320, 40)];
    label.font = [UIFont systemFontOfSize:14.5];
    label.backgroundColor = [UIColor clearColor];
    label.textAlignment = NSTextAlignmentCenter;
    label.textColor = UIColorFromRGB(0x666666);
    label.text = @"喵~请选择您的学校所在地";
    [_contentView addSubview:label];
}

-(void)setDataArray:(NSMutableArray *)dataArray
{
    if (_dataArray){
        _dataArray = nil;
    }
    _dataArray = dataArray;
    
    for (UIView * view in _contentView.subviews){
        if ([view isKindOfClass:[UIButton class]]){
            [view removeFromSuperview];
        }
    }
    
    for (int i = 0; i <[_dataArray count];i++){
        chooseCityModel * model = (chooseCityModel *)[_dataArray objectAtIndex:i];
        UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(35+(53+15)*(i%4),40+(24+10)*(i/4), 53, 24);
        
        button.titleLabel.font = [UIFont systemFontOfSize:13.5];
        button.titleLabel.textAlignment = NSTextAlignmentCenter;
        [button setTitleColor:UIColorFromRGB(0x656565) forState:UIControlStateNormal];
        [button setTitleColor:UIColorFromRGB(0xef8b02) forState:UIControlStateDisabled];
        [button setTitle:model.cityName forState:UIControlStateNormal];
        [button addTarget:self action:@selector(chooseCity:) forControlEvents:UIControlEventTouchUpInside];
        button.layer.borderWidth = 0.5;
        button.layer.borderColor = [UIColorFromRGB(0xcbcbcb) CGColor];
        if([model.cityName isEqualToString:@"其他"]){
//            button.tag = 999888;
        }else{
            button.tag = [model.cityId intValue];
        }
        [_contentView addSubview:button];
        
//        if ([[[NSUserDefaults standardUserDefaults] valueForKey:@"citymodel"] valueForKey:@"全国"]){
//            button.enabled = NO;
//            button.layer.borderColor = [UIColorFromRGB(0xef8b02) CGColor];
//        }else{
            if ([[[[NSUserDefaults standardUserDefaults] valueForKey:@"citymodel"] valueForKey:@"cityid"] intValue]== button.tag){
                button.enabled = NO;
                button.layer.borderColor = [UIColorFromRGB(0xef8b02) CGColor];
//            }
        }
    }
}

#pragma mark
#pragma mark 选择城市
-(void)chooseCity:(UIButton *)button
{
    for (UIButton * view in _contentView.subviews){
        if ([view isKindOfClass:[UIButton class]]){
            if (button.tag == view.tag){
                button.enabled = NO;
                button.layer.borderColor = [UIColorFromRGB(0xef8b02) CGColor];
            }else{
                view.enabled = YES;
                view.layer.borderColor = [UIColorFromRGB(0xcbcbcb) CGColor];
            }
        }
    }
    for (int i =0;i<[_dataArray count];i++){
        chooseCityModel * model = (chooseCityModel *)[_dataArray objectAtIndex:i];
        if (button.tag == [model.cityId intValue]){
            DDLOG(@"cityName = %@",model.cityName);
            [_delegate chooseTheCity:model];
            break;
        }
    }
    [self closeChooseCityView];
}

#pragma mark
#pragma mark 关闭窗口
-(void)closeChooseCityView
{
    [_delegate clickBgViewLetViewHidden];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
