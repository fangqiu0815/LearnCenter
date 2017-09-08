//
//  XWPacketMidCell.m
//  zhangshangPacket
//
//  Created by apple on 2017/5/12.
//  Copyright © 2017年 apple-fangqiu. All rights reserved.
//

#import "XWPacketMidCell.h"
#import "XWSysTaskInfoTool.h"

@interface XWPacketMidCell ()

@property(nonatomic, copy) NSArray *taskInfoArray;

@property (nonatomic, copy) UILabel *detailInfoLab;
@end

@implementation XWPacketMidCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
        [self.contentView addSubview:self.titleLab];
        [self.contentView addSubview:self.midTitleLab];
        [self.contentView addSubview:self.rightTitleLab];
        [self.contentView addSubview:self.rightIcon];
//        [self.contentView addSubview:self.detailInfoLab];
        
        [self addTheView];
        
    }
    return self;
}

- (void)setCellDataWithDict:(NSDictionary *)dict andArray:(NSMutableArray *)array
{
//    self.detailInfoLab.text = @"撒都爱蝴蝶结款牛仔裤蝴蝶结款牛仔裤蝴蝶结款牛仔裤";

    if (array.count == 0) {
        for (int i = 0; i<STUserDefaults.taskListArr.count; i++) {
            self.midTitleLab.text = [NSString stringWithFormat:@"0/%ld",[dict[@"objval"] integerValue]];
            self.midTitleLab.textColor = MainTextColor;
            self.rightTitleLab.textColor = MainTextColor;
            self.titleLab.text = [NSString stringWithFormat:@"%@",dict[@"desc"]];
            self.rightTitleLab.text = [NSString stringWithFormat:@"+%ld",(long)[dict[@"reward"] integerValue]];
            
        }
        
    } else {
        for (int i = 0; i<array.count; i++) {
            if([dict[@"id"] isEqualToString:array[i][@"id"]]) {
                
                if ([array[i][@"sta"] integerValue] == 1) {
                    self.midTitleLab.text = @"已完成";
                    self.midTitleLab.textColor = MainRedColor;
                    self.midTitleLab.dk_textColorPicker = DKColorPickerWithColors(MainRedColor,MainRedColor,MainRedColor);
                    
                    self.rightTitleLab.textColor = MainRedColor;
                    self.rightTitleLab.dk_textColorPicker = DKColorPickerWithColors(MainRedColor,MainRedColor,MainRedColor);
                    self.rightTitleLab.text = [NSString stringWithFormat:@"+%ld",(long)[dict[@"reward"] integerValue]];
                    self.titleLab.text = [NSString stringWithFormat:@"%@",dict[@"desc"]];
                    self.titleLab.textColor = MainRedColor;
                    self.titleLab.dk_textColorPicker = DKColorPickerWithColors(MainRedColor,MainRedColor,MainRedColor);
                    return;
                }else if ([array[i][@"sta"] integerValue] == 0) {
                    
                    self.midTitleLab.text = [NSString stringWithFormat:@"%@/%ld",array[i][@"ach"] ,(long)[dict[@"objval"] integerValue]];
                    self.midTitleLab.textColor = MainTextColor;
                    self.rightTitleLab.textColor = MainTextColor;
                    self.titleLab.text = [NSString stringWithFormat:@"%@",dict[@"desc"]];
                    self.rightTitleLab.text = [NSString stringWithFormat:@"+%ld",(long)[dict[@"reward"] integerValue]];
                    return;
                }
                else if ([array[i][@"sta"] integerValue] == -1){
                    self.midTitleLab.text = @"已过期";
                    
                    self.midTitleLab.textColor = MainRedColor;
                    self.midTitleLab.dk_textColorPicker = DKColorPickerWithColors(MainRedColor,MainRedColor,MainRedColor);
                    
                    self.rightTitleLab.textColor = MainRedColor;
                    self.rightTitleLab.dk_textColorPicker = DKColorPickerWithColors(MainRedColor,MainRedColor,MainRedColor);

                    self.titleLab.text = [NSString stringWithFormat:@"%@",dict[@"desc"]];
                    self.rightTitleLab.text = [NSString stringWithFormat:@"+%ld",(long)[dict[@"reward"] integerValue]];
                    return;
                }
                
            }else{
                self.midTitleLab.text = [NSString stringWithFormat:@"0/%d",[dict[@"objval"] integerValue]];
                self.midTitleLab.textColor = MainTextColor;
                self.rightTitleLab.textColor = MainTextColor;
                self.titleLab.text = [NSString stringWithFormat:@"%@",dict[@"desc"]];
                self.rightTitleLab.text = [NSString stringWithFormat:@"+%ld",(long)[dict[@"reward"] integerValue]];
                
            }
            
        }

    }
    
}

#pragma mark addTheView
-(void)addTheView
{
    
    [self.titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self);
//        make.top.mas_equalTo(self).offset(5);
        make.left.mas_equalTo(self).offset(15);
        make.width.mas_equalTo(ScreenW*0.5);
        make.height.mas_equalTo(30);
    }];
    
    [self.midTitleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self);
//        make.top.mas_equalTo(self).offset(5);

        make.right.mas_equalTo(self).offset(-0.3*ScreenW);
        make.width.mas_equalTo(100);
        make.height.mas_equalTo(30);
        
    }];
    
    [self.rightIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self);
//        make.top.mas_equalTo(self).offset(5);

        make.right.mas_equalTo(self).offset(-5);
        make.width.mas_equalTo(30);
        make.height.mas_equalTo(30);
    }];
    
    [self.rightTitleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self);
//        make.top.mas_equalTo(self).offset(5);

        make.right.mas_equalTo(self.rightIcon.mas_left).offset(-5);
        make.width.mas_equalTo(40);
        make.height.mas_equalTo(20);
    }];
    
    [self.detailInfoLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.titleLab.mas_bottom);
        make.left.mas_equalTo(self).offset(15);
        make.width.mas_equalTo(ScreenW*0.5);
        make.height.mas_equalTo(40);
    }];
    
}
#pragma mark btnAction

#pragma mark get

//- (NSMutableArray *)dataArr
//{
//    if (!_dataArr) {
//        _dataArr = [NSMutableArray array];
//    }
//    return _dataArr;
//}


-(UILabel *)titleLab
{
    if (_titleLab == nil)
    {
        _titleLab = [[UILabel alloc]init];
        _titleLab.font = [UIFont systemFontOfSize:RemindFont(15, 16, 17)];
        _titleLab.textAlignment = NSTextAlignmentLeft;
        _titleLab.textColor = MainTextColor;
    }
    return _titleLab;
}

- (UILabel *)midTitleLab
{
    if (!_midTitleLab) {
        _midTitleLab = [[UILabel alloc]init];
        _midTitleLab.font = [UIFont systemFontOfSize:RemindFont(15, 16, 17)];
        _midTitleLab.textAlignment = NSTextAlignmentCenter;
    }
    return _midTitleLab;
}

- (UILabel *)rightTitleLab
{
    
    if (!_rightTitleLab) {
        _rightTitleLab = [[UILabel alloc]init];
        //_rightTitleLab.text = @"+1";
        _rightTitleLab.font = [UIFont systemFontOfSize:RemindFont(15, 16, 17)];
        _rightTitleLab.textAlignment = NSTextAlignmentRight;
        
    }
    return _rightTitleLab;
    
}

//- (UILabel *)detailInfoLab
//{
//    if (!_detailInfoLab) {
//        _detailInfoLab = [[UILabel alloc]init];
//        //_rightTitleLab.text = @"+1";
//        _detailInfoLab.font = [UIFont systemFontOfSize:RemindFont(14, 15, 16)];
//        _detailInfoLab.textColor = BlackColor;
//        _detailInfoLab.textAlignment = NSTextAlignmentLeft;
//    }
//    return _detailInfoLab;
//
//}

- (UIImageView *)rightIcon
{
    if (!_rightIcon) {
        _rightIcon = [[UIImageView alloc]init];
        _rightIcon.image = MyImage(@"icon_ingot");
        
    }
    return _rightIcon;
}



@end
