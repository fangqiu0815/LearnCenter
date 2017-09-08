//
//  XWNoticeModel.h
//  zhangshangPacket
//
//  Created by apple on 2017/5/23.
//  Copyright © 2017年 apple-fangqiu. All rights reserved.
//

#import <Foundation/Foundation.h>

@class XWNoticeData,XWNoticeList;

@interface XWNoticeModel : NSObject

@property (nonatomic, strong) XWNoticeData *d;

@property (nonatomic, assign) NSInteger st;

@property (nonatomic, assign) NSInteger c;

@property (nonatomic, copy) NSString *m;

@end

@interface XWNoticeData : NSObject

@property (nonatomic, strong) NSArray <XWNoticeData *> *notice;


@end

@interface XWNotice : NSObject

@property (nonatomic, copy) NSString *author;

@property (nonatomic, copy) NSString *content;

@property (nonatomic, copy) NSString *date;

@property (nonatomic, copy) NSString *noticeurl;

@property (nonatomic, copy) NSString *title;




@end




