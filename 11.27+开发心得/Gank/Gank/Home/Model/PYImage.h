//
//  PYImage.h
//  Gank
//
//  Created by 谢培艺 on 2017/3/3.
//  Copyright © 2017年 CoderKo1o. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PYImage : NSObject

/** 缩略图 */
@property (nonatomic, copy) NSString *thumbUrl;

/** 原图 */
@property (nonatomic, copy) NSString *url;

/** 宽 */
@property (nonatomic, assign) CGFloat width;

/** 高 */
@property (nonatomic, assign) CGFloat height;

@end
