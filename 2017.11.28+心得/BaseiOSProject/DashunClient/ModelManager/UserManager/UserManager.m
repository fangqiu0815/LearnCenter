//
//  UserManager.m
//  RealmDemo
//
//  Created by haigui on 16/7/2.
//  Copyright © 2016年 com.luohaifang. All rights reserved.
//

#import "UserManager.h"

@interface UserManager () {
//    RLMRealm *_rlmRealm;因为这是单线程创建的对象，所以不能跨线程访问，解决方法在下面
    NSString *_filePath;
}

@end

@implementation UserManager

- (instancetype)init
{
    self = [super init];
    if (self) {
        
    }
    return self;
}

+ (instancetype)manager {
    static UserManager *manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[UserManager alloc] init];
    });
    return manager;
}

#pragma mark -- User
//更新用户数据
- (void)updateUser:(User*)user {
    //每次修改的时候都重新获取该线程中的数据库对象，就可以解决多线程访问问题了
    RLMRealm *rLMRealm = [RLMRealm realmWithURL:[NSURL URLWithString:_filePath]];
    [rLMRealm beginWriteTransaction];
    [User createOrUpdateInRealm:rLMRealm withValue:user];
    _user = user;
    [rLMRealm commitWriteTransaction];
}
//通过用户guid加载用户
- (void)loadUserWithNo:(int)userNo {
    //得到用户对应的数据库路径
    NSArray *pathArr = NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES);
    _filePath = pathArr[0];
    _filePath = [_filePath stringByAppendingPathComponent:@(userNo).stringValue];
    //创建数据库
    RLMRealm *rlmRealm = [RLMRealm realmWithURL:[NSURL URLWithString:_filePath]];
    //得到/创建用户数据
    RLMResults *users = [User allObjectsInRealm:rlmRealm];
    if(users.count) {
        _user = [users objectAtIndex:0];
    } else {
        _user = [User new];
    }
}
//创建用户的数据库观察者
- (RBQFetchedResultsController*)createUserFetchedResultsController {
    RLMRealm *rLMRealm = [RLMRealm realmWithURL:[NSURL URLWithString:_filePath]];
    RBQFetchedResultsController *fetchedResultsController = nil;
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"userNo = %d",_user.userNo];
    RBQFetchRequest *fetchRequest = [RBQFetchRequest fetchRequestWithEntityName:@"User" inRealm:rLMRealm predicate:predicate];
    fetchedResultsController = [[RBQFetchedResultsController alloc] initWithFetchRequest:fetchRequest sectionNameKeyPath:nil cacheName:nil];
    [fetchedResultsController performFetch];
    return fetchedResultsController;
}

@end
