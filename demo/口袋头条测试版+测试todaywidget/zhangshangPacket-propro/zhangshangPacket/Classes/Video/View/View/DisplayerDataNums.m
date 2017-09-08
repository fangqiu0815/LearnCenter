//
//  DisplayerDataNums.m
//  BaoZouDaily
//
//  Created by selfos on 17/1/22.
//  Copyright © 2017年 selfos. All rights reserved.
//

#import "DisplayerDataNums.h"
@interface DisplayerDataNums()
@property (nonatomic,strong)UILabel *mainShowNumsLabel;
@end
@implementation DisplayerDataNums

-(instancetype)initWithFrame:(CGRect)frame{
    if(self=[super initWithFrame:frame]){
        UILabel *mainShowNumsLabel=[[UILabel alloc]init];
        mainShowNumsLabel.font = [UIFont systemFontOfSize:15];
//        mainShowNumsLabel.dk_textColorPicker=DKColorPickerWithColors(WhiteColor,BlackColor,RedColor);
        [mainShowNumsLabel xw_setDayMode:^(UIView *view) {
            UILabel *label = (UILabel *)view;
            label.textColor = BlackColor;
        } nightMode:^(UIView *view) {
            UILabel *label = (UILabel *)view;
            label.textColor = WhiteColor;
        }];
        self.backgroundColor = RGBA(247,44,72,0.6);
        mainShowNumsLabel.textAlignment=NSTextAlignmentCenter;
        self.mainShowNumsLabel=mainShowNumsLabel;
        [self addSubview:mainShowNumsLabel];
    }
    return self;
}
-(void)layoutSubviews{
    [super layoutSubviews];
    self.mainShowNumsLabel.yj_width=self.yj_width;
    self.mainShowNumsLabel.yj_height=self.yj_height;
}

-(void)setUpdateDataNums:(NSString *)updateDataNums{
    _updateDataNums=updateDataNums;
    self.mainShowNumsLabel.text=updateDataNums;
    [self.mainShowNumsLabel sizeToFit];
}

@end
