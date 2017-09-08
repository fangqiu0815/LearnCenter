//
//  XWController.m
//  zhangshangnews
//
//  Created by apple on 2017/5/10.
//  Copyright © 2017年 apple-fangqiu. All rights reserved.
//

#import "XWController.h"

@implementation XWController

+ (instancetype)initWithName:(NSString *)name title:(NSString *)title navigationTitle:(NSString *)ntitle tabbarImage:(NSString *)image tabbarImageSelect:(NSString *)simage {
    
    XWController *controller = [[XWController alloc] init];
    controller.className = name;
    controller.classTitle = title;
    controller.navigationTitle = ntitle;
    controller.tabbarImage = image;
    controller.tabbarImageSelect = simage;
    
    return controller;
}

@end
