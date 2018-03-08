//
//  KDSectionHeaderView.m
//  KDMediDetail
//
//  Created by apple-gaofangqiu on 2018/3/5.
//  Copyright © 2018年 apple-fangqiu. All rights reserved.
//

#import "KDSectionHeaderView.h"

@interface KDSectionHeaderView ()

@property (nonatomic, strong) UILabel *label;

@end

@implementation KDSectionHeaderView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor grayColor];
        self.label = [[UILabel alloc] initWithFrame:self.bounds];
        [self addSubview:self.label];
        self.label.textAlignment = NSTextAlignmentCenter;
        self.label.textColor = [UIColor whiteColor];
    }
    return self;
}

- (void)setTextStr:(NSString *)textStr {
    self.label.text = textStr;
}




@end
