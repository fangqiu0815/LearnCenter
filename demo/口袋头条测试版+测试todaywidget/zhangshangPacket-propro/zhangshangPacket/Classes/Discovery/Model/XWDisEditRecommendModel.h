//
//  XWDisEditRecommendModel.h
//  zhangshangPacket
//
//  Created by apple on 2017/8/3.
//  Copyright © 2017年 apple-fangqiu. All rights reserved.
//

#import <Foundation/Foundation.h>
@class DisEditRecModelList,DisEditRecModel;
@interface XWDisEditRecommendModel : NSObject
@property (nonatomic, strong) DisEditRecModelList *d;

@property (nonatomic, assign) NSInteger st;

@property (nonatomic, assign) NSInteger c;

@property (nonatomic, copy) NSString *m;
@end

@interface DisEditRecModelList : NSObject

@property (nonatomic, copy) NSArray<DisEditRecModel *> *editrecommend;

@end

@interface DisEditRecModel : NSObject

@property (nonatomic, copy) NSString *istake;

@property (nonatomic, copy) NSString *pic;

@property (nonatomic, copy) NSString *title;

@property (nonatomic, copy) NSString *id;


@end
