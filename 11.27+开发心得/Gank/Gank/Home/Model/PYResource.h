//
//  PYResource.h
//  Gank
//
//  Created by 谢培艺 on 2017/2/27.
//  Copyright © 2017年 CoderKo1o. All rights reserved.
//

#import <UIKit/UIKit.h>
/**
 "_id":"58a506ba421aa9662f42972b",
 "createdAt":"2017-02-16T09:56:10.387Z",
 "desc":"iOS 异步绘图工具",
 "images":[
 "http://img.gank.io/bc9ef40a-8ebf-40e4-820e-c79a5928c786",
 "http://img.gank.io/2ef3babf-1509-45e8-8850-4f596b1d23ce"
 ],
 "publishedAt":"2017-02-16T10:07:37.13Z",
 "source":"chrome",
 "type":"iOS",
 "url":"https://github.com/DSKcpp/PPAsyncDrawingKit",
 "used":true,
 "who":"代码家"
 */
@class PYImage;

@interface PYResource : NSObject

/** id */
@property (nonatomic, copy) NSString *_id;

/** publishedAt：发布日期 */
@property (nonatomic, copy) NSString *publishedAt;

/** type：类型 */
@property (nonatomic, copy) NSString *type;

/** images: 图片数组 */
@property (nonatomic, copy) NSArray<PYImage *> *images;

/** 图片模型 */
@property (nonatomic, copy) NSArray *imageModels;

/** url：关联链接 */
@property (nonatomic, copy) NSString *url;

/** who：分享者 */
@property (nonatomic, copy) NSString *who;

/** desc：标题 */
@property (nonatomic, copy) NSString *desc;

/** 计算cell高度 */
@property (nonatomic, assign) CGFloat cellHeight;
@end
