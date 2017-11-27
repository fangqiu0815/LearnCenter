//
//  PYCardViewController.h
//  Gank
//
//  Created by 谢培艺 on 2017/2/27.
//  Copyright © 2017年 CoderKo1o. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PYCardViewController : UIViewController

/** 资源类型Android | iOS | 休息视频 | 福利 | 拓展资源 | 前端 | 瞎推荐 | App */
@property (nonatomic, copy) NSString *resourceType;

/** 类型颜色 */
@property (nonatomic, strong) UIColor *typeColor;

@end
