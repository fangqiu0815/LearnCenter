//
//  XWMineTudiListModel.h
//  zhangshangPacket
//
//  Created by apple on 2017/5/20.
//  Copyright © 2017年 apple-fangqiu. All rights reserved.
//

#import <Foundation/Foundation.h>

@class AppreListData,AppreList;

@interface XWMineTudiListModel : NSObject

@property (nonatomic, strong) AppreListData *d;

@property (nonatomic, assign) NSInteger st;

@property (nonatomic, assign) NSInteger c;

@property (nonatomic, copy) NSString *m;


@end

@interface AppreListData : NSObject

@property (nonatomic, copy) NSString *totalpage;

@property (nonatomic, copy) NSString *pagenum;

@property (nonatomic, strong) NSArray<AppreList *> *discs;

@end

@interface AppreList : NSObject

//’name’:’alex’,
//’img’:’http://imgs.png’,
//“dearningsde”:100,
//“addtime”:12345875,

/** id*/
@property (nonatomic, copy) NSString *ID;

@property (nonatomic , copy) NSString *name;

@property (nonatomic, copy) NSString *img;

@property (nonatomic, assign) NSInteger dearningsde;

@property (nonatomic, copy) NSString *addtime;



@end


