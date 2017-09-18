//
//  UIButton+CustomButtom.h
//
//  Created by selfos on 16/12/27.
//  Copyright © 2016年 selfos. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^BlockClick)(UIButton *);
@interface UIButton (CustomButtom)
@property (nonatomic,strong) BlockClick clickBtn;
-(instancetype)xm_initWithFrame:(CGRect)frame;
@end
