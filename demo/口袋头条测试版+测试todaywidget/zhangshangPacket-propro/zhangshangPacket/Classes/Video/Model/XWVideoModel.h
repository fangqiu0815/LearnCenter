//
//  XWVideoModel.h
//  zhangshangPacket
//
//  Created by apple on 2017/8/1.
//  Copyright © 2017年 apple-fangqiu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XWVideoModel : NSObject

@property (nonatomic,assign)NSInteger document_id;
@property (nonatomic,assign)NSInteger display_type;
@property (nonatomic,assign)NSInteger play_time;
@property (nonatomic,strong)NSString *title;
@property (nonatomic,strong)NSString *image;
@property (nonatomic,assign)NSInteger play_count;
@property (nonatomic,assign)NSInteger comment_count;
@property (nonatomic,assign)NSInteger vote_count;
@property (nonatomic,strong)NSString *file_url;
@property (nonatomic,strong)NSString *share_url;
@property (nonatomic,assign)NSInteger publish_time;
@property (nonatomic,strong)NSString *play_count_string;
@property (nonatomic,assign)BOOL voted;
@property (nonatomic,assign)BOOL favorited;

@end
