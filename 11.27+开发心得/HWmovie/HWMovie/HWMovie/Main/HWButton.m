//
//  HWButton.m
//  HWMovie
//
//  Created by hyrMac on 15/7/17.
//  Copyright (c) 2015年 hyrMac. All rights reserved.
//

#import "HWButton.h"

@implementation HWButton

- (instancetype)initWithFrame:(CGRect)frame withImgName:(NSString *)imgName withTitle:(NSString *)title {
    self = [super initWithFrame:frame];
    if (self) {
        _imgView = [[UIImageView alloc] initWithFrame:CGRectZero];
        _imgView.contentMode = UIViewContentModeScaleAspectFit;
        _imgView.image = [UIImage imageNamed:imgName];
        [self addSubview:_imgView];
        
        _label = [[UILabel alloc] initWithFrame:CGRectZero];
        _label.text = title;
        _label.textAlignment = NSTextAlignmentCenter;
//        _label.font = [UIFont systemFontOfSize:11];
        _label.font = [UIFont boldSystemFontOfSize:11];
        _label.textColor = [UIColor whiteColor];
        [self addSubview:_label];
        
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    _imgView.frame = CGRectMake((self.frame.size.width-20)/2, 5, 20, 20);
    _label.frame = CGRectMake(0, CGRectGetMaxY(_imgView.frame), self.frame.size.width, 20);
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
