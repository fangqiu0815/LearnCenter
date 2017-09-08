//
//  XWDisFastRecommendModel.h
//  zhangshangPacket
//
//  Created by apple on 2017/8/4.
//  Copyright © 2017年 apple-fangqiu. All rights reserved.
//

#import <Foundation/Foundation.h>
@class DisFastRecommendList,DisFastRecommendModel;
@interface XWDisFastRecommendModel : NSObject
@property (nonatomic, strong) DisFastRecommendList *d;

@property (nonatomic, assign) NSInteger st;

@property (nonatomic, assign) NSInteger c;

@property (nonatomic, copy) NSString *m;
@end

@interface DisFastRecommendList : NSObject

@property (nonatomic, copy) NSString *id;

@property (nonatomic, copy) NSString *orderread;

@property (nonatomic, copy) NSString *pic;

@property (nonatomic, copy) NSString *source;

@property (nonatomic, copy) NSString *title;

@property (nonatomic, copy) NSString *wechatid;

@property (nonatomic, copy) NSString *content;

@property (nonatomic, strong) NSArray<DisFastRecommendModel *> *artlist;


@end

@interface DisFastRecommendModel : NSObject

@property (nonatomic, copy) NSString *arttitle;

@property (nonatomic, copy) NSString *arturl;

@end
