//
//  HMStatusViewModel.h
//  Weibo11
//
//  Created by 刘凡 on 15/12/9.
//  Copyright © 2015年 itheima. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HMStatus.h"

@interface HMStatusViewModel : NSObject
/// 微博模型
@property (nonatomic, strong) HMStatus *status;
/// 用户头像 URL
@property (nonatomic, readonly) NSURL *userAvatarURL;
/// 会员图标
@property (nonatomic, readonly) UIImage *memberImage;
/// 认证图像
@property (nonatomic, readonly) UIImage *verifiedImage;
/// 转发数
@property (nonatomic, readonly) NSString *repostsCountStr;
/// 评论数
@property (nonatomic, readonly) NSString *commentsCountStr;
/// 表态数
@property (nonatomic, readonly) NSString *attitudesCountStr;
/// 是否有转发微博
@property (nonatomic, readonly) BOOL hasRetweeted;
/// 转发微博文本
@property (nonatomic, readonly) NSString *retweetedText;

/// 使用 微博模型实例化视图模型
///
/// @param status 微博模型对象
///
/// @return 视图模型
+ (instancetype)viewModelWithStatus:(HMStatus *)status;

@end
