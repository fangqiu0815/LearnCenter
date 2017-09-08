//
//  XWTaskInfoModel.h
//  zhangshangPacket
//
//  Created by apple on 2017/5/31.
//  Copyright © 2017年 apple-fangqiu. All rights reserved.
//

#import <Foundation/Foundation.h>
@class TaskInfoList,TaskInfo;
@interface XWTaskInfoModel : NSObject

@property (nonatomic, strong) TaskInfoList *d;

@property (nonatomic, assign) NSInteger st;

@property (nonatomic, assign) NSInteger c;

@property (nonatomic, copy) NSString *m;

@end

@interface TaskInfoList : NSObject

@property (nonatomic, copy) NSArray<TaskInfoList *> *taskinfo;


@end

@interface TaskInfo : NSObject

@property (nonatomic, copy) NSString *id;

@property (nonatomic, copy) NSString *desc;


@end

