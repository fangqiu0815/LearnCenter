//
//  XWSysTaskInfoListModel.h
//  zhangshangPacket
//
//  Created by apple on 2017/6/9.
//  Copyright © 2017年 apple-fangqiu. All rights reserved.
//

#import <Foundation/Foundation.h>

@class SysUserTaskDataList,SysUserTaskData;
@interface XWSysTaskInfoListModel : NSObject

@property (nonatomic, strong) SysUserTaskDataList *d;

@property (nonatomic, assign) NSInteger st;

@property (nonatomic, assign) NSInteger c;

@property (nonatomic, copy) NSString *m;

@end

@interface SysUserTaskDataList : NSObject

@property (nonatomic, copy) NSArray<SysUserTaskData *> *taskinfo;


@end

@interface SysUserTaskData : NSObject

@property (nonatomic, copy) NSString *ID;

@property (nonatomic, copy) NSString *type;

@property (nonatomic, copy) NSString *desc;

@property (nonatomic, copy) NSString *conval;

@property (nonatomic, copy) NSString *objval;

@property (nonatomic, copy) NSString *reward;

@property (nonatomic, copy) NSString *stype;

@end
