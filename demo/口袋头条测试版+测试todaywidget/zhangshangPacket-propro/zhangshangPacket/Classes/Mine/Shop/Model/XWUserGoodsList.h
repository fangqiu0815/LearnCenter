//
//  XWUserGoodsList.h
//  zhangshangPacket
//
//  Created by 高方秋 on 2017/6/7.
//  Copyright © 2017年 apple-fangqiu. All rights reserved.
//

#import <Foundation/Foundation.h>
@class UserGoodsListModel,UserGoodsList;
@interface XWUserGoodsList : NSObject

@property (nonatomic, strong) UserGoodsListModel *d;

@property (nonatomic, assign) NSInteger st;

@property (nonatomic, assign) NSInteger c;

@property (nonatomic, copy) NSString *m;


@end

@interface UserGoodsListModel : NSObject

@property (nonatomic, copy) NSString *totalpage;
@property (nonatomic, copy) NSString *pagenum;

@property (nonatomic, strong) NSArray<UserGoodsList *> *pagedata;


@end

@interface UserGoodsList : NSObject

@property (nonatomic, copy) NSString *name;

@property (nonatomic, copy) NSString *price;

@property (nonatomic, copy) NSString *num;

@property (nonatomic, copy) NSString *reapid;

@property (nonatomic, copy) NSString *date;

// 状态 待定
@property (nonatomic, copy) NSString *sign;

@property (nonatomic, copy) NSString *address;

@end
