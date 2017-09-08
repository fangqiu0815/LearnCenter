//
//  XWHomeTodayModel.h
//  zhangshangPacket
//
//  Created by apple on 2017/5/27.
//  Copyright © 2017年 apple-fangqiu. All rights reserved.
//

#import <Foundation/Foundation.h>
@class TodayDataList,TodayData;
@interface XWHomeTodayModel : NSObject
@property (nonatomic, strong) TodayDataList *d;

@property (nonatomic, assign) NSInteger st;

@property (nonatomic, assign) NSInteger c;

@property (nonatomic, copy) NSString *m;

@end


@interface TodayDataList : NSObject

@property (nonatomic, strong) NSArray<TodayDataList *> *todayhistorylist;

@property (nonatomic, copy) NSString *pagenum;

@property (nonatomic, copy) NSString *totalpage;


@end


@interface TodayData : NSObject

@property (nonatomic, copy) NSString *href;

@property (nonatomic, copy) NSString *day;

@property (nonatomic, copy) NSString *title;




@end

