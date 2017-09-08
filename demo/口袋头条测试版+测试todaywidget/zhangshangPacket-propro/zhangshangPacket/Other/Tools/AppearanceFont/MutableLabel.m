//
//  MutableLabel.m
//  全局字体
//
//  Created by selfos on 16/12/24.
//  Copyright © 2016年 selfos. All rights reserved.
//

#import "MutableLabel.h"
@interface MutableLabel()
{
    UIFont *_xm_font;
}
@end

@implementation MutableLabel
-(void)awakeFromNib{
    [super awakeFromNib];
    //保存默认字体
    _xm_font=self.font;
    [self receptionObj:nil];
}
-(instancetype)initWithFrame:(CGRect)frame{
    self=[super initWithFrame:frame];
    if(self){
        //保存默认字体
        _xm_font=self.font;
        [self receptionObj:nil];
    }
    return self;
}
-(void)receptionObj:(id)receObj{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeBigFont) name:@"bigFontChange" object:receObj];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeMediumFont) name:@"mediumFontChange" object:receObj];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeSmallFont) name:@"smallFontChange" object:receObj];
}

//大号字体
-(void)changeBigFont{
  
//    //当前字体是否大于默认字体大小
//    if(self.font.pointSize>_xm_font.pointSize){
//        return;
//    }
    self.font=[UIFont systemFontOfSize:18];
}

//恢复字体
-(void)changeMediumFont{
  
    self.font=[UIFont systemFontOfSize:15];
}
//小号字体
-(void)changeSmallFont{

    self.font=[UIFont systemFontOfSize:13];
}

-(void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
