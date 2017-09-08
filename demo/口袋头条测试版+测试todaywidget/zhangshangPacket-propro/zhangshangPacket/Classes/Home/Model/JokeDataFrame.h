//
//  JokeDataFrame.h
//  zhangshangPacket
//
//  Created by apple on 2017/5/31.
//  Copyright © 2017年 apple-fangqiu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "XWHomeJokeModel.h"

@interface JokeDataFrame : NSObject

@property (nonatomic, copy) JokeData *jokeData;
//cell顶部
@property (nonatomic, assign) CGRect topContainerViewF;
//头像图片
@property (nonatomic, assign) CGRect headerViewF;

@property (nonatomic, assign) CGRect nameViewF;

//内容
@property (nonatomic, assign) CGRect contentViewF;
//来源
@property (nonatomic, assign) CGRect originViewF;

@property (nonatomic, assign) CGRect commentNameF;
//评论
@property (nonatomic, assign) CGRect commentViewF;

@property (nonatomic, assign) CGFloat cellHeight;



@end



