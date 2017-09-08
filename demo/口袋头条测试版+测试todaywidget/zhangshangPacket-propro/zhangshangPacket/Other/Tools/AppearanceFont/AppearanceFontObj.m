//
//  AppearanceFontObj.m
//  全局字体
//
//  Created by selfos on 16/12/24.
//  Copyright © 2016年 selfos. All rights reserved.
//

#import "AppearanceFontObj.h"

@implementation AppearanceFontObj

+(instancetype)appearanceChange{
   return [[self alloc]init];
}

-(void)changeBeginBigFont{
    [[NSNotificationCenter defaultCenter]postNotificationName:@"bigFontChange" object:self.sender_xm];
}
-(void)changeBeginMediumFont{
    [[NSNotificationCenter defaultCenter]postNotificationName:@"mediumFontChange" object:self.sender_xm];
}
-(void)changeBeginSmallFont{
    [[NSNotificationCenter defaultCenter]postNotificationName:@"smallFontChange" object:self.sender_xm];
}

@end
