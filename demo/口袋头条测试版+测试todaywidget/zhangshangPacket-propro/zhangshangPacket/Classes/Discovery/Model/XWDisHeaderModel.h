//
//  XWDisHeaderModel.h
//  zhangshangPacket
//
//  Created by apple on 2017/8/3.
//  Copyright © 2017年 apple-fangqiu. All rights reserved.
//

#import <Foundation/Foundation.h>
@class DisHeaderList,DisHeaderModel;
@interface XWDisHeaderModel : NSObject

@property (nonatomic, strong) DisHeaderList *d;

@property (nonatomic, assign) NSInteger st;

@property (nonatomic, assign) NSInteger c;

@property (nonatomic, copy) NSString *m;

@end

@interface DisHeaderList : NSObject

@property (nonatomic, copy) NSString *pnmax;

@property (nonatomic, copy) NSString *pn;

@property (nonatomic, strong) NSArray<DisHeaderModel *> *selectlist;

@end

@interface DisHeaderModel : NSObject

@property (nonatomic, copy) NSString *content;

@property (nonatomic, copy) NSString *url;

@property (nonatomic, copy) NSString *note;

@property (nonatomic, copy) NSMutableArray *piclist;

@property (nonatomic, copy) NSString *pictype;

@property (nonatomic, copy) NSString *source;


@end

/*
 content = "\U8fd9\U91cc\U662f\U63cf\U8ff0";
 date = "2017/07/02";
 label = "\U7cbe\U9009\U7206\U6587";
 labeldesc = "\U671d\U9c9c\U5993\U751f\U5fc3\U9178\U7684\U76ae\U8089\U751f\U6d3b";
 note = 11;
 piclist =                 (
 "http://api.kuaileduobao.com/kdplatts/scripts/xignzuo.png",
 "http://api.kuaileduobao.com/kdplatts/scripts/zhuli.jpg",
 "http://api.kuaileduobao.com/kdplatts/scripts/zhouchong.jpg"
 );
 pictype = 1;
 source = "\U6765\U6e90";
 */
