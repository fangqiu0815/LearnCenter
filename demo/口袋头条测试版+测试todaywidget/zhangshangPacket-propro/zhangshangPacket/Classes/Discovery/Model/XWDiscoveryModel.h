//
//  XWDiscoveryModel.h
//  zhangshangPacket
//
//  Created by apple on 2017/8/1.
//  Copyright © 2017年 apple-fangqiu. All rights reserved.
//

#import <Foundation/Foundation.h>
@class XWDiscoveryDataList,XWEditSelected,XWEditRecommend,XWNewestenter;
@interface XWDiscoveryModel : NSObject

@property (nonatomic, strong) XWDiscoveryDataList *d;

@property (nonatomic, assign) NSInteger st;

@property (nonatomic, assign) NSInteger c;

@property (nonatomic, copy) NSString *m;


@end

@interface XWDiscoveryDataList : NSObject

@property (nonatomic, strong) NSArray<XWEditSelected *> *editselection;

@property (nonatomic, strong) NSArray<XWEditRecommend *> *editrecommend;

@property (nonatomic, strong) NSArray<XWNewestenter *> *newestenter;


@end

@interface XWEditSelected : NSObject

@property (nonatomic, copy) NSString *id;

@property (nonatomic, copy) NSString *pic;

@property (nonatomic, copy) NSString *title;

@property (nonatomic, copy) NSString *type;



@end

@interface XWEditRecommend : NSObject

@property (nonatomic, copy) NSString *istake;

@property (nonatomic, copy) NSString *pic;

@property (nonatomic, copy) NSString *title;

@property (nonatomic, copy) NSString *id;

@end

@interface XWNewestenter : NSObject

@property (nonatomic, copy) NSString *wechatid;

@property (nonatomic, copy) NSString *istake;

@property (nonatomic, copy) NSString *title;

@property (nonatomic, copy) NSString *id;

@property (nonatomic, copy) NSString *pic;

@property (nonatomic, copy) NSString *content;

@end
