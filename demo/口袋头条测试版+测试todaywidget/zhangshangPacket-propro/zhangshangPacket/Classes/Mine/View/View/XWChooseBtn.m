//
//  XWChooseBtn.m
//  zhangshangPacket
//
//  Created by apple on 2017/6/13.
//  Copyright © 2017年 apple-fangqiu. All rights reserved.
//

#import "XWChooseBtn.h"

@implementation XWChooseBtn

- (instancetype)initWithFrame:(CGRect)frame{
    
    if (self = [super initWithFrame:frame]) {
        self.yj_size = CGSizeMake((ScreenW-60)/3, 80);
        self.layer.borderColor = CUSTOMCOLORA(200, 200, 200, 1).CGColor;
        self.layer.borderWidth = 1;
        self.layer.cornerRadius = 5.0f;
        //self.backgroundColor = [UIColor whiteColor];
        
    }
    
    return self;
}


- (XWChooseBtn *)buttonWithAbovelabeltitle:(NSString *)astr{
    
    UILabel * abovel = [[UILabel alloc] init];
    abovel.text = astr;
    abovel.font = [UIFont systemFontOfSize:16.0f];
    abovel.textColor = [UIColor blackColor];
    abovel.textAlignment = NSTextAlignmentCenter;
    [self addSubview:abovel];
    self.abovel = abovel;
    return self;
    
    
}

- (void)layoutSubviews {
    
    [super layoutSubviews];
    self.abovel.frame = CGRectMake(0, self.yj_height*0.15, self.yj_width, 30);
    
}

- (void)setEnabled:(BOOL)enabled{
    [super setEnabled:enabled];
    if (!enabled) {
        self.abovel.textColor = BlackColor;
        self.layer.borderColor = MainGrayTextColor.CGColor;
        self.layer.cornerRadius = 4.0f;
    }
    
}


- (void)setSelected:(BOOL)selected
{
    
    [super setSelected:selected];
    
    self.abovel.textColor = selected ? WhiteColor : BlackColor;
    self.layer.borderColor = selected ? MainRedColor.CGColor : MainGrayTextColor.CGColor;
    self.backgroundColor = selected ? MainRedColor:WhiteColor;
    self.layer.cornerRadius = 4.0f;
    
    
}



@end
