//
//  GoodsListModel.h
//  CrazyPacket
//
//  Created by WuYanZu on 17/3/8.
//  Copyright © 2017年 WuYanZu. All rights reserved.
//

#import <Foundation/Foundation.h>

@class GoodsListData,ItemDetail;
@interface GoodsListModel : NSObject

@property (nonatomic, strong) GoodsListData *d;

@property (nonatomic, assign) NSInteger st;

@property (nonatomic, assign) NSInteger c;

@property (nonatomic, copy) NSString *m;

@end

@interface GoodsListData : NSObject

@property (nonatomic, copy) NSString *totalpage;
@property (nonatomic, copy) NSString *pagenum;

@property (nonatomic, strong) NSArray<ItemDetail *> *goods;

@end



@interface ItemDetail : NSObject

@property (nonatomic, copy) NSString *id;

@property (nonatomic, copy) NSString *img;

@property (nonatomic, copy) NSString *cash;

@property (nonatomic, copy) NSString *name;

@property (nonatomic, copy) NSString *num;

//@property (nonatomic, copy) NSString *imgUrl;


@end

