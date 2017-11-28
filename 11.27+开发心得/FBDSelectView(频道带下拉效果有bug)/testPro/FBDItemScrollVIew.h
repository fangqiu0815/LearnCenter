//
//  FBDItemScrollVIew.h
//  testPro
//
//  Created by 冯宝东 on 16/1/22.
//  Copyright © 2016年 冯宝东. All rights reserved.
//
#define ScreenW     [UIScreen mainScreen].bounds.size.width
#define ScreenH    [UIScreen mainScreen].bounds.size.height
#import <UIKit/UIKit.h>

@interface FBDItemScrollVIew : UIScrollView

@property(nonatomic,strong)UIView* indexView;
/**
 *  初始化构造方法
 *
 *  @param frame      大小位置
 *  @param titleArray 标题数组
 *
 *  @return 实例本身
 */
-(instancetype)initWithFrame:(CGRect)frame andItemTitleArray:(NSMutableArray*)titleArray;

@end
