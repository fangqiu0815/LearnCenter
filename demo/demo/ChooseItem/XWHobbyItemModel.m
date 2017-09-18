//
//  XWHobbyItemModel.m
//  zhangshangPacket
//
//  Created by apple-gaofangqiu on 2017/9/6.
//  Copyright © 2017年 apple-fangqiu. All rights reserved.
//

#import "XWHobbyItemModel.h"
#import <objc/runtime.h>

@implementation XWHobbyItemModel

-(void)setIsEnable:(BOOL)isEnable{
    
    if (!_isTop) {
        _isEnable = NO;
    }else{
        _isEnable = isEnable;
    }
    
}

-(NSString *)description{
    unsigned int count = 0;
    Ivar *ivars = class_copyIvarList(self.class, &count);
    NSMutableString *str = [NSMutableString string];
    for (int i = 0; i < count; ++i) {
        Ivar ivar = ivars[i];
        const char *name = ivar_getName(ivar);
        NSString *proName = [NSString stringWithUTF8String:name];
        id value = [self valueForKey:proName];
        
        [str appendFormat:@"<%@ : %@> \n", proName, value];
    }
    free(ivars);
    return str;
}


@end
