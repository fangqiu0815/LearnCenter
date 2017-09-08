//
//  XWPacketModel.h
//  zhangshangPacket
//
//  Created by apple on 2017/5/19.
//  Copyright © 2017年 apple-fangqiu. All rights reserved.
//

#import <Foundation/Foundation.h>

@class XWPacketModel,XWPacketInfoData,XWPacketInfo,XWPacketInfoDetail;
@interface XWPacketModel : NSObject

@property (nonatomic, strong) XWPacketInfo *d;

@property (nonatomic, assign) NSInteger st;

@property (nonatomic, assign) NSInteger c;

@property (nonatomic, copy) NSString *m;

@end

@interface XWPacketInfoData : NSObject

@property (nonatomic, strong) NSArray<XWPacketInfo *> *jokeslist;



@end

@interface  XWPacketInfo: NSObject

@property (nonatomic, assign) NSInteger stype;

@property (nonatomic, assign) NSInteger pagenum;

@property (nonatomic, assign) NSInteger totalpage;

@property (nonatomic, strong) NSArray <XWPacketInfoDetail *> *detain ;


@end

@interface XWPacketInfoDetail : NSObject

@property (nonatomic, copy) NSString *type;

@property (nonatomic, copy) NSString *val;

@property (nonatomic, copy) NSString *addtime;

@end


