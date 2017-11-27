//
//  HMStatusListViewModel.m
//  Weibo11
//
//  Created by 刘凡 on 15/12/9.
//  Copyright © 2015年 itheima. All rights reserved.
//

#import "HMStatusListViewModel.h"
#import "HMStatusViewModel.h"

@interface HMStatusListViewModel()
/// 下拉刷新数据数量
@property (nonatomic, assign) NSInteger pulldownCount;
@end

@implementation HMStatusListViewModel

/// 加载数据
///
/// @param isPullup  是否上拉刷新
/// @param completed 完成回调
- (void)loadStatusWith:(BOOL)isPullup completed:(void (^)(BOOL isSuccessed))completed {
    
    NSAssert(completed != nil, @"完成回调不能为空");
    
    NSString *token = [HMUserAccountViewModel sharedUserAccount].userAccount.access_token;
    
    // 如果是下拉刷新，就取数组的第一个元素
    UInt64 since_id = (!isPullup && self.statusList.count > 0) ? [self.statusList.firstObject status].id : 0;
    // 如果是上拉刷新，就取数组的最后一个元素
    UInt64 max_id = (isPullup && self.statusList.count > 0) ? [self.statusList.lastObject status].id : 0;
    
    DDLogInfo(@"下拉刷新 - %lld | 上拉刷新 - %lld", since_id, max_id);
    [[HMNetworkTools sharedTools] loadStatusWithAccessToken:token since_id:since_id max_id:max_id finished:^(id result, NSError *error) {
        
        // 1. 判断是否有错误
        if (error != nil) {
            DDLogError(@"网络访问错误 %@", error);
            completed(NO);
            
            return;
        }
        
        // 2. 从返回字典中获取 @"statuses" 数组
        NSArray *array = result[@"statuses"];
        if (array == nil) {
            DDLogError(@"数据错误");
            completed(NO);
            
            return;
        }
        
        // 3. 遍历数组，字典转模型
        NSMutableArray *arrayM = [NSMutableArray arrayWithCapacity:array.count];
        for (NSDictionary *dict in array) {
            HMStatus *status = [HMStatus statusWithDict:dict];
            
            [arrayM addObject:[HMStatusViewModel viewModelWithStatus:status]];
        }
        
        DDLogInfo(@"刷新到 %zd 条数据", arrayM.count);
        // 记录下拉刷新获得的数据条数
        self.pulldownCount = since_id > 0 ? arrayM.count : -1;
        
        // 4. 记录属性
        // 如果是上拉刷新，将数据拼接在数组的末尾
        if (max_id > 0) {
            [self.statusList addObjectsFromArray:arrayM];
        } else {
            // 如果是 下拉／默认 刷新，将数据插入到数组的前面
            NSMutableIndexSet *indexes = [NSMutableIndexSet indexSetWithIndexesInRange:NSMakeRange(0, arrayM.count)];
            
            [self.statusList insertObjects:arrayM atIndexes:indexes];
        }
        
        // 5. 完成回调
        completed(YES);
    }];
}

#pragma mark - 计算型属性
/// 下拉提示消息
- (NSString *)pulldownTipMesage {
    
    if (self.pulldownCount < 0) {
        return nil;
    }
    
    NSString *message;
    if (self.pulldownCount == 0) {
        message = @"没有新微博";
    } else {
        message = [NSString stringWithFormat:@"刷新到 %zd 条微博", self.pulldownCount];
    }
    return message;
}

#pragma mark - 懒加载属性
- (NSMutableArray *)statusList {
    if (_statusList == nil) {
        _statusList = [[NSMutableArray alloc] init];
    }
    return _statusList;
}


@end
