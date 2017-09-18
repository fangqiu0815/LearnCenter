//
//  XWHobbyItemModel.h
//  zhangshangPacket
//
//  Created by apple-gaofangqiu on 2017/9/6.
//  Copyright © 2017年 apple-fangqiu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XWHobbyItemModel : NSObject

/** 新闻频道标识 */
@property (nonatomic, copy) NSString *channel_id;
/** 新闻频道名称 */
@property (nonatomic, copy) NSString *channel_name;
/** 新闻频道是否在最上层 */
@property (nonatomic, assign) BOOL isTop;
/** 新闻频道是否是热门 */
@property (nonatomic, assign) BOOL isHot;
/** 新闻频道是否不可编辑 */
@property (nonatomic, assign) BOOL isEnable;


@end
