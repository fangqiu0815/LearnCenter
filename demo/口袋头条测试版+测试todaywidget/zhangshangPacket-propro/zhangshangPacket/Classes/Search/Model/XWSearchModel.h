//
//  XWSearchModel.h
//  zhangshangPacket
//
//  Created by apple on 2017/5/29.
//  Copyright © 2017年 apple-fangqiu. All rights reserved.
//

#import <Foundation/Foundation.h>
@class SearchList,SearchData;
@interface XWSearchModel : NSObject
@property (nonatomic, strong) SearchList *d;

@property (nonatomic, assign) NSInteger st;

@property (nonatomic, assign) NSInteger c;

@property (nonatomic, copy) NSString *m;


@end

@interface SearchList : NSObject

@property (nonatomic, strong) NSArray<SearchList *> *pagedata;

@property (nonatomic, assign) int pagenum;

@property (nonatomic, assign) int totalpage;

@end

@interface SearchData : NSObject

@property (nonatomic, strong) NSString *title;

@property (nonatomic, strong) NSString *url;



@end
