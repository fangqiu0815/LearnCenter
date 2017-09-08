//
//  XWSearchPostModel.h
//  zhangshangPacket
//
//  Created by apple on 2017/5/29.
//  Copyright © 2017年 apple-fangqiu. All rights reserved.
//

#import <Foundation/Foundation.h>
@class SearchPostList,SearchPostListModel;
@interface XWSearchPostModel : NSObject

@property (nonatomic, strong) SearchPostList *d;

@property (nonatomic, assign) NSInteger st;

@property (nonatomic, assign) NSInteger c;

@property (nonatomic, copy) NSString *m;

@end

@interface SearchPostList : NSObject

@property (nonatomic, strong) NSArray<SearchPostListModel *> *searchlist;

@end

@interface SearchPostListModel : NSObject

@property (nonatomic, copy) NSString *title;

@property (nonatomic, copy) NSString *subtitle;

@property (nonatomic, copy) NSString *author;

@property (nonatomic, copy) NSString *imgsrc;

@property (nonatomic, copy) NSString *weburl;


@end

