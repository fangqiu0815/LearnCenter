//
//  XWShareRecoverModel.h
//  zhangshangPacket
//
//  Created by apple on 2017/6/21.
//  Copyright © 2017年 apple-fangqiu. All rights reserved.
//

#import <Foundation/Foundation.h>

@class ShareRecoverList,ShareRecoverModel;

@interface XWShareRecoverModel : NSObject

@property (nonatomic, strong) ShareRecoverList *d;

@property (nonatomic, assign) NSInteger st;

@property (nonatomic, assign) NSInteger c;

@property (nonatomic, copy) NSString *m;

@end

@interface ShareRecoverList : NSObject

@property (nonatomic, strong) NSArray<ShareRecoverModel *> *taskstatus;

@end

@interface ShareRecoverModel : NSObject

@property (nonatomic, copy) NSString *ingot;

@property (nonatomic, copy) NSString *status;

@property (nonatomic, copy) NSString *desc;

@end
