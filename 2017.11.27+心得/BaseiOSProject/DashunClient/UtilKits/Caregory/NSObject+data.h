//
//  NSObject+data.h
//  BangBang
//
//  Created by lottak_mac2 on 16/5/20.
//  Copyright © 2016年 Lottak. All rights reserved.
//

#import <Foundation/Foundation.h>
//给所有对象添加data运行时属性
//给一个view赋值data 只需要在view的.m文件中重写dataDidChange方法取得self.data即可进行界面赋值 有点mvvm的感觉
@interface NSObject (data)

@property (nonatomic, strong) id data;

- (void)dataWillChange;

- (void)dataDidChange;

@end
