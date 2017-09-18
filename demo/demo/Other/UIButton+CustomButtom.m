//
//  UIButton+CustomButtom.m
//
//  Created by selfos on 16/12/27.
//  Copyright © 2016年 selfos. All rights reserved.
//

#import "UIButton+CustomButtom.h"
#import <objc/message.h>

@implementation UIButton (CustomButtom)
+(void)load{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        Method oldMehod=class_getInstanceMethod(self, @selector(initWithFrame:));
        Method newMehod=class_getInstanceMethod(self, @selector(xm_initWithFrame:));
        method_exchangeImplementations(oldMehod, newMehod);
    });
}
-(instancetype)xm_initWithFrame:(CGRect)frame{
    [self xm_initWithFrame:frame];
    [self addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    return self;
}
-(void)btnClick:(UIButton *)sender{
    if(self.clickBtn){
        self.clickBtn(sender);
    }
}
//定义关联的key
const char *clickBtnKey = "clickBtn";

- (void)setClickBtn:(BlockClick)clickBtn{
    objc_setAssociatedObject(self, clickBtnKey, clickBtn, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (BlockClick)clickBtn{
    return objc_getAssociatedObject(self, clickBtnKey);
}

@end
