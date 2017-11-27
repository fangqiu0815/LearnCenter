//
//  HMEmoticon.h
//  Weibo11
//
//  Created by 刘凡 on 15/12/15.
//  Copyright © 2015年 itheima. All rights reserved.
//

#import <Foundation/Foundation.h>

/// 表情模型
@interface HMEmoticon : NSObject
/// 表情类型 0 图片/1 emoji
@property (nonatomic, assign) NSInteger type;
/// 是否 emoji
@property (nonatomic, readonly) BOOL isEmoji;
/// 表情描述文字
@property (nonatomic, copy) NSString *chs;
/// 表情图片
@property (nonatomic, copy) NSString *png;
/// 图片所在路径
@property (nonatomic, copy) NSString *dir;
/// 图像完整路径
@property (nonatomic, readonly) NSString *imagePath;
/// emoji 编码
@property (nonatomic, copy) NSString *code;
/// emoji 字符串
@property (nonatomic, copy) NSString *emoji;
/// 使用次数
@property (nonatomic, assign) NSInteger times;

+ (instancetype)emoticonWithDict:(NSDictionary *)dict;

/// 将当前模型转换成字典，以便于保存
- (NSDictionary *)jsonDictionary;

@end
