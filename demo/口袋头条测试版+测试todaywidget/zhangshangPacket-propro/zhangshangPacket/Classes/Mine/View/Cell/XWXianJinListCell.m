//
//  XWXianJinListCell.m
//  zhangshangPacket
//
//  Created by apple on 2017/6/17.
//  Copyright © 2017年 apple-fangqiu. All rights reserved.
//

#import "XWXianJinListCell.h"
#import "XWIncomeDetailListTool.h"

@interface XWXianJinListCell ()

@property (nonatomic, strong) NSMutableArray *dataArr;

@end

@implementation XWXianJinListCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
        [self addTheView];
    }
    return self;
}

- (void)setDetailModel:(XWPacketInfoDetail *)detailModel
{
    _detailModel = detailModel;
    NSString *timeStr = [NSString stringWithFormat:@"%@",detailModel.addtime];
    self.moneyLab.text = [NSString stringWithFormat:@"%@",detailModel.val];
    
    JLLog(@"---%@---",[XWIncomeDetailListTool topics]);
    
    NSTimeInterval time = [timeStr doubleValue] ;
    NSDate *detaildate = [NSDate dateWithTimeIntervalSince1970:time];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSString *currentDateStr = [dateFormatter stringFromDate:detaildate];
    
    self.timeLab.text = currentDateStr;
    
}

- (void)setCellWithDic:(NSDictionary *)dic
{
    NSString *type = [NSString stringWithFormat:@"%@",dic[@"type"]];
    self.dataArr = [XWIncomeDetailListTool topics];
//    self.dataArr = [NSMutableArray arrayWithContentsOfFile:XWMINE_MONEYDETAIL_CACHE_PATH];
    XWIncomeDetailInfoModel *model = [XWIncomeDetailInfoModel mj_objectWithKeyValues:self.dataArr[[type integerValue] - 1]];
    self.titleLab.text = model.typedesc;
    NSString *timeStr = [NSString stringWithFormat:@"%@",dic[@"addtime"]];
    if ([model.type integerValue] == 1) {
        self.moneyLab.text = [NSString stringWithFormat:@"%.2f",[dic[@"val"] floatValue]/100.0];
        self.moneyLab.textColor = MainRedColor;
    } else {
        self.moneyLab.text = [NSString stringWithFormat:@"-%.2f",[dic[@"val"] floatValue]/100.0];
        self.moneyLab.textColor = MainTextColor;
    }
    
    NSTimeInterval time = [timeStr doubleValue] ;
    NSDate *detaildate = [NSDate dateWithTimeIntervalSince1970:time];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSString *currentDateStr = [dateFormatter stringFromDate:detaildate];
    
    self.timeLab.text = currentDateStr;
    
}

#pragma mark addTheView
-(void)addTheView
{
    
    [self addSubview:self.titleLab];
    [self.titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.mas_equalTo(self).offset(10);
        make.centerY.equalTo(self);
        make.width.mas_equalTo(ScreenW*0.4);
        make.height.mas_equalTo(35);
    }];
    
    [self addSubview:self.timeLab];
    [self.timeLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self).offset(-10);
        make.centerY.equalTo(self);
        make.width.mas_equalTo(ScreenW*0.25);
        make.height.mas_equalTo(25);
    }];
    
    [self addSubview:self.moneyLab];
    [self.moneyLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self);
        make.centerX.mas_equalTo(self);
        make.width.mas_equalTo(70*AdaptiveScale_W);
        make.height.mas_equalTo(35);
    }];
    
    //    [self addSubview:self.iconImage];
    //    [self.iconImage mas_makeConstraints:^(MASConstraintMaker *make) {
    //        make.left.mas_equalTo(self.moneyLab.mas_right);
    //        make.centerY.equalTo(self.titleLab.mas_centerY);
    //        make.size.mas_equalTo(Size(15, 15));
    //    }];
    
    
}

- (NSMutableArray *)dataArr
{
    if (!_dataArr) {
        _dataArr = [NSMutableArray array];
    }
    return _dataArr;
}

#pragma mark get
//-(UIImageView *)iconImage
//{
//    if (_iconImage == nil)
//    {
//        _iconImage = [[UIImageView alloc]init];
//        _iconImage.image = MyImage(@"Icon_Ingot");
//    }
//    return _iconImage;
//}
-(UILabel *)titleLab
{
    if (_titleLab == nil)
    {
        _titleLab = [[UILabel alloc]init];
        _titleLab.font = [ToolFontFit getFontSizeWithType:TGFontTypeThree size:RemindFont(13, 14, 15)];
        // _titleLab.text = @"热搜热搜";
        _titleLab.dk_textColorPicker = DKColorPickerWithColors(BlackColor,WhiteColor,MainRedColor);

    }
    return _titleLab;
}

- (UILabel *)moneyLab
{
    
    if (!_moneyLab) {
        _moneyLab = [[UILabel alloc]init];
        _moneyLab.font = [ToolFontFit getFontSizeWithType:TGFontTypeFour size:RemindFont(16, 17, 18)];
        _moneyLab.textAlignment = NSTextAlignmentCenter;
        _moneyLab.textColor = MainYellowColor;
        //  _moneyLab.text = @"+999999";
        
    }
    return _moneyLab;
    
}

- (UILabel *)timeLab
{
    if (_timeLab == nil)
    {
        _timeLab = [[UILabel alloc]init];
        _timeLab.font = [UIFont systemFontOfSize:RemindFont(12, 14, 16)];
        _timeLab.textAlignment = NSTextAlignmentRight;
        // _timeLab.text = @"123456789";
        _timeLab.textColor = MainTextColor;
    }
    return _timeLab;
    
}



@end
