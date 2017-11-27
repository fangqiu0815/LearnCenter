//
//  HMStatusListViewModel.h
//  Weibo11
//
//  Created by 刘凡 on 15/12/9.
//  Copyright © 2015年 itheima. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HMStatus.h"

/// 微博列表视图模型
@interface HMStatusListViewModel : NSObject

/// 微博视图模型数组
@property (nonatomic, strong) NSMutableArray *statusList;
/// 下拉提示消息 - 如果不是下拉刷新，返回 `nil`
- (NSString *)pulldownTipMesage;

/// 加载数据
///
/// @param isPullup  是否上拉刷新
/// @param completed 完成回调
- (void)loadStatusWith:(BOOL)isPullup completed:(void (^)(BOOL isSuccessed))completed;

@end
