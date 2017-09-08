//
//  XWTaskDetailInfoModel.h
//  zhangshangPacket
//
//  Created by apple on 2017/6/8.
//  Copyright © 2017年 apple-fangqiu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XWTaskDetailInfoModel : NSObject

@property (nonatomic, assign) NSInteger ID;

@property (nonatomic, assign) NSInteger type;

@property (nonatomic, assign) NSInteger stype;

@property (nonatomic, copy) NSString *desc;

@property (nonatomic, assign) NSInteger conval;

@property (nonatomic, assign) NSInteger objval;

@property (nonatomic, assign) NSInteger reward;


@end
