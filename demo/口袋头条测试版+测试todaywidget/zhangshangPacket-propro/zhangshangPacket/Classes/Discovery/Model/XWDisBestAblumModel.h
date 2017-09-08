//
//  XWDisBestAblumModel.h
//  zhangshangPacket
//
//  Created by apple on 2017/8/4.
//  Copyright © 2017年 apple-fangqiu. All rights reserved.
//

#import <Foundation/Foundation.h>
@class DisBestAblumList,DisBestAblumModel;
@interface XWDisBestAblumModel : NSObject

@property (nonatomic, strong) DisBestAblumList *d;

@property (nonatomic, assign) NSInteger st;

@property (nonatomic, assign) NSInteger c;

@property (nonatomic, copy) NSString *m;

@end

@interface DisBestAblumList : NSObject

@property (nonatomic, copy) NSString *maxpn;

@property (nonatomic, copy) NSString *pn;

@property (nonatomic, strong) NSArray<DisBestAblumModel *> *selectlist;


@end

@interface DisBestAblumModel : NSObject

@property (nonatomic, copy) NSString *date;

@property (nonatomic, copy) NSString *label;

@property (nonatomic, copy) NSString *labeldesc;

@property (nonatomic, copy) NSMutableArray *piclist;

@property (nonatomic, copy) NSString *pictype;

@property (nonatomic, copy) NSString *url;

@end
