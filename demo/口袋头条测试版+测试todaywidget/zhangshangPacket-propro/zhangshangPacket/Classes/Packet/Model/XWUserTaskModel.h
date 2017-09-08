//
//  XWUserTaskModel.h
//  zhangshangPacket
//
//  Created by apple on 2017/6/9.
//  Copyright © 2017年 apple-fangqiu. All rights reserved.
//

#import <Foundation/Foundation.h>
@class UserTaskData,UserTask;
@interface XWUserTaskModel : NSObject

@property (nonatomic, strong) UserTaskData *d;

@property (nonatomic, assign) NSInteger st;

@property (nonatomic, assign) NSInteger c;

@property (nonatomic, copy) NSString *m;

@end

@interface UserTaskData : NSObject

@property (nonatomic, copy) NSArray<UserTaskData *> *usertask;

@end

@interface UserTask : NSObject

@property (nonatomic, copy) NSString *id;

@property (nonatomic, copy) NSString *sta;

@property (nonatomic, copy) NSString *ach;

@property (nonatomic, copy) NSString *rn;

@end



