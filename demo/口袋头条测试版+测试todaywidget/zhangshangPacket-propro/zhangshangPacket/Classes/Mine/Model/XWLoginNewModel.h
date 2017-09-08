//
//  XWLoginNewModel.h
//  zhangshangPacket
//
//  Created by apple on 2017/7/4.
//  Copyright © 2017年 apple-fangqiu. All rights reserved.
//

#import <UIKit/UIKit.h>

@class LoginDataList,TaskStatus,XWLoginNewModel;

@interface XWLoginNewModel : NSObject

@property (nonatomic, strong) LoginDataList *d;

@property (nonatomic, assign) NSInteger st;

@property (nonatomic, assign) NSInteger c;

@property (nonatomic, copy) NSString *m;



@end

@interface LoginDataList : NSObject

//@property (nonatomic, strong) NSArray<LoginData *> *user;

@property (nonatomic, strong) NSArray<TaskStatus *> *taskstatus;



@end

@interface TaskStatus : NSObject

@property (nonatomic, assign) NSInteger ingot;

@property (nonatomic, assign) NSInteger status;

@property (nonatomic, assign) NSString *desc;

@end


