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
/** 自定义颜色 */
#define CUSTOMCOLOR(r,g,b)  [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:1.0]
#define MainTextColor ([UIColor colorWithRed:0.45 green:0.45 blue:0.45 alpha:1.00])
/** 弱引用 */
#define WeakType(type) __weak typeof(type) weak##type = type;

#define ScreenW [UIScreen mainScreen].bounds.size.width
#define ScreenH [UIScreen mainScreen].bounds.size.height

/** 图片赋值 */
#define MyImage(imageName) [UIImage imageNamed:imageName]





#endif /* XWConfig_h */
