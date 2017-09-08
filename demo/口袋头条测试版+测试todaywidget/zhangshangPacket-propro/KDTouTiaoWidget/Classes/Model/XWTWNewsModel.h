//
//  XWTWNewsModel.h
//  zhangshangPacket
//
//  Created by apple on 2017/8/8.
//  Copyright © 2017年 apple-fangqiu. All rights reserved.
//

#import <Foundation/Foundation.h>
@class TWNewsModelist,XWTWNewsModel;
@interface XWTWNewsModel : NSObject

@property (nonatomic, strong) TWNewsModelist *d;

@property (nonatomic, assign) NSInteger st;

@property (nonatomic, assign) NSInteger c;

@property (nonatomic, copy) NSString *m;

@end

@interface TWNewsModelist : NSObject

@property (nonatomic, strong) NSArray<TWNewsModelist *> *newslist;

@end

@interface TWNewsModel : NSObject

@property (nonatomic, copy) NSString *id;

@property (nonatomic, copy) NSString *type;

@property (nonatomic, copy) NSString *hasReward;

@property (nonatomic, copy) NSString *showType;

@property (nonatomic, copy) NSMutableDictionary *imgsUrl;

@property (nonatomic, copy) NSString *title;

@property (nonatomic, copy) NSString *resource;

@property (nonatomic, copy) NSString *content;

@property (nonatomic, copy) NSString *url;

@property (nonatomic, copy) NSString *ingot;

@property (nonatomic, copy) NSString *arttime;

@property (nonatomic, copy) NSString *author;

@property (nonatomic, copy) NSString *tag;

@property (nonatomic, copy) NSString *showurl;


@end



