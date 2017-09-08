//
//  XWHomeCheckNewsInfoModel.h
//  zhangshangPacket
//
//  Created by apple on 2017/7/28.
//  Copyright © 2017年 apple-fangqiu. All rights reserved.
//

#import <Foundation/Foundation.h>


/*
 
 serverdata---{
 c = 1;
 d =     {
 advimg = "";
 advurl = "";
 content = "@#label1@#KDNL";
 desc = "\U7533\U660e\Uff1a";
 imglist =         (
 {
 imgurl = "http://n.sinaimg.cn/sports/transform/20170718/MFpX-fyiavtv9891287.jpg";
 label = "@#label1";
 }
 );
 resource = "\U7f51\U7edc";
 title = "16.5\U4ebf?\U66dd\U706b\U7bad";
 };
 m = SUCCESS;
 st = 1501211515;
 }
 */
@class NewsCheckList,NewsCheckImgList;
@interface XWHomeCheckNewsInfoModel : NSObject

@property (nonatomic, strong) NewsCheckList *d;

@property (nonatomic, assign) NSInteger st;

@property (nonatomic, assign) NSInteger c;

@property (nonatomic, copy) NSString *m;

@end
@interface NewsCheckList : NSObject

@property (nonatomic, copy) NSString *advimg;

@property (nonatomic, copy) NSString *advurl;

@property (nonatomic, copy) NSString *content;

@property (nonatomic, copy) NSString *desc;

@property (nonatomic, copy) NSString *resource;

@property (nonatomic, copy) NSString *title;

@property (nonatomic, copy) NSArray <NewsCheckImgList*> *imglist;

@property (nonatomic, copy) NSString *id;

@end

@interface NewsCheckImgList : NSObject

@property (nonatomic, copy) NSString *imgurl;

@property (nonatomic, copy) NSString *label;


@end

