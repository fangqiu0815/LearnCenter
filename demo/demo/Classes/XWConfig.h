//
//  XWConfig.h
//  demo
//
//  Created by apple on 2017/8/7.
//  Copyright © 2017年 apple-fangqiu. All rights reserved.
//

#ifndef XWConfig_h
#define XWConfig_h

#import "Masonry.h"
#import "UIButton+CustomButtom.h"
#import "UIView+Frame.h"
#import "XWBaseVC.h"
#import "XWUserDefault+XWPropertity.h"
#import "WMPageController.h"



//设备宽
#define IPHONE_W [UIScreen mainScreen].bounds.size.width
//设备高
#define IPHONE_H [UIScreen mainScreen].bounds.size.height

/** 自定义颜色 */
#define CUSTOMCOLOR(r,g,b)  [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:1.0]
#define MainRedColor                CUSTOMCOLOR(244, 75, 80)  //244, 75, 80 主色f44b50
#define NightMainTextColor          CUSTOMCOLOR(117, 118, 119)

#define random(r, g, b, a) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:(a)/255.0]

#define randomColor random(arc4random_uniform(256), arc4random_uniform(256), arc4random_uniform(256), arc4random_uniform(256))

#define MainTextColor ([UIColor colorWithRed:0.45 green:0.45 blue:0.45 alpha:1.00])
/** 弱引用 */
#define WeakType(type) __weak typeof(type) weak##type = type;

#define ScreenW [UIScreen mainScreen].bounds.size.width
#define ScreenH [UIScreen mainScreen].bounds.size.height
/** 适配比例 */
#define AdaptiveScale_W (IPHONE_W/375.0)
#define AdaptiveScale_H (IPHONE_H/667.0)
/** 图片赋值 */
#define MyImage(imageName) [UIImage imageNamed:imageName]

/** 适配字体大小 */
#define RemindFont(x,y,z) (IPHONE_W == 320?(x):IPHONE_W == 375? (y):(z))

/** 白色 */
#define WhiteColor [UIColor whiteColor]
#define BlackColor [UIColor blackColor]



#endif /* XWConfig_h */
