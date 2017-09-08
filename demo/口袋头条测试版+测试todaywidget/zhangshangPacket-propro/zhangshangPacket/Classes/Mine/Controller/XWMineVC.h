//
//  XWMineVC.h
//  zhangshangnews
//
//  Created by apple on 2017/5/8.
//  Copyright © 2017年 apple-fangqiu. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^intBlock)(NSInteger a);

@interface XWMineVC : XWBaseVC

+(void)sentValueClick:(intBlock)_sentBlock ;
@property (nonatomic,assign)NSInteger b;
@property (nonatomic,assign)NSInteger c;

@property (nonatomic,assign)NSInteger homeIngot;
//首页传过来的钱

@property (nonatomic,assign)NSInteger signIngot;
//签到传过来的钱

@property (nonatomic,assign)NSInteger adIngot;
//广告传过来的钱

@property (nonatomic,assign)NSInteger shareIngot;
//分享传过来的钱
@property (nonatomic,assign)NSInteger turnIngot;

@property (nonatomic,assign)NSInteger allIngot;

@end
