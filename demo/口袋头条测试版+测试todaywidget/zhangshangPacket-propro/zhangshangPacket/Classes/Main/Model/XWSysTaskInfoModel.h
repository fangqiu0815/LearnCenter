//
//  XWSysTaskInfoModel.h
//  zhangshangPacket
//
//  Created by apple on 2017/5/20.
//  Copyright © 2017年 apple-fangqiu. All rights reserved.
//

#import <Foundation/Foundation.h>

@class  XWTaskInfo;

@interface XWSysTaskInfoModel : NSObject

@property (nonatomic, strong) XWTaskInfo *d;

@property (nonatomic, assign) NSInteger st;

@property (nonatomic, assign) NSInteger c;

@property (nonatomic, copy) NSString *m;




@end

@interface XWTaskInfo : NSObject

@property (nonatomic, assign) NSInteger ID;

@property (nonatomic, assign) NSInteger type;

@property (nonatomic, assign) NSInteger objval;

@property (nonatomic, assign) NSInteger conval;

@property (nonatomic, copy) NSString *rewardingot;



@end

