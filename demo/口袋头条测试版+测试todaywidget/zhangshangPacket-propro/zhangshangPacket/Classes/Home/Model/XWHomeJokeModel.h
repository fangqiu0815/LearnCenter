//
//  XWHomeJokeModel.h
//  zhangshangPacket
//
//  Created by apple on 2017/5/26.
//  Copyright © 2017年 apple-fangqiu. All rights reserved.
//

#import <Foundation/Foundation.h>
@class JokeDataList,JokeData;
@interface XWHomeJokeModel : NSObject

@property (nonatomic, strong) JokeDataList *d;

@property (nonatomic, assign) NSInteger st;

@property (nonatomic, assign) NSInteger c;

@property (nonatomic, copy) NSString *m;

@end

@interface JokeDataList : NSObject

@property (nonatomic, strong) NSArray<JokeDataList *> *jokeslist;


@end


@interface JokeData : NSObject

@property (nonatomic, copy) NSString *id;

@property (nonatomic, copy) NSString *type;

@property (nonatomic, copy) NSString *hasReward;

@property (nonatomic, copy) NSString *img;

@property (nonatomic, copy) NSString *uname;

@property (nonatomic, copy) NSString *content;

@property (nonatomic, copy) NSString *pname;

@property (nonatomic, copy) NSString *pcont;

@property (nonatomic, copy) NSString *ingot;

@property (nonatomic, copy) NSString *origin;

@property (nonatomic, assign) CGFloat cellComHeight;

@property (nonatomic, assign) CGFloat cellHeight;

@end








