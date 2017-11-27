//
//  TopheadModal.h
//  HWMovie
//
//  Created by hyrMac on 15/7/27.
//  Copyright (c) 2015年 hyrMac. All rights reserved.
//

#import <Foundation/Foundation.h>
/*
 "image" : "http://img31.mtime.cn/mt/2012/06/28/131128.94272291.jpg",
	"titleCn" : "摩尔庄园2海妖宝藏",
	"titleEn" : "Legend of The Moles-Treasure of Scylla",
	"rating" : "7.7",
	"year" : "2012",
	"content" : "摩尔庄园大电影系列第二部：《摩尔庄园海妖宝藏》继续讲述快乐、勇敢、热爱和平的小摩尔们战胜邪恶",
	"type" : [ "动画", "动作", "奇幻", "冒险" ],
	"url" : "http://movie.mtime.com/157836/",
	"directors" : [ "刘可欣" ],
	"actors" : ["阿黄","阿龟","阿宇","阿红","凤姐"],
	"release" : {
 "location" : "中国",
 "date" : "2012-7-5"
	},
 */
@interface TopheadModal : NSObject
@property (nonatomic, copy) NSString *image;
@property (nonatomic, copy) NSString *titleCn;
@property (nonatomic, retain) NSArray *directors;
@property (nonatomic, retain) NSArray *actors;
@property (nonatomic, retain) NSArray *type;
@property (nonatomic, retain) NSDictionary *releaseInfo;
@property (nonatomic, retain) NSArray *videos;
//@property (nonatomic, copy) NSString *image;

@end
