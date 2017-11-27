//
//  PYWebController.h
//  youzhu
//
//  Created by 谢培艺 on 16/1/27.
//  Copyright © 2016年 iphone5solo. All rights reserved.
//

#import <UIKit/UIKit.h>
@class PYResource;

@interface PYWebController : UIViewController

/** 相关链接*/
@property (nonatomic, copy) NSString *url;

/** 加载标题 */
@property (nonatomic, strong) PYResource *resource;

/** 标题 */
@property (nonatomic, copy) NSString *webTitle;

/** 进度条颜色 */
@property (nonatomic, assign) UIColor *progressColor;

@end
