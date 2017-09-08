//
//  AppearanceFontObj.h
//  全局字体
//
//  Created by selfos on 16/12/24.
//  Copyright © 2016年 selfos. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface AppearanceFontObj : NSObject
+(instancetype)appearanceChange;
/**字体加大一号*/
-(void)changeBeginBigFont;
/**字体默认字体大小*/
-(void)changeBeginMediumFont;
/**字体减小一号*/
-(void)changeBeginSmallFont;
/**设置消息发送者(可选)*/
@property (nonatomic,strong)id sender_xm;

@end

