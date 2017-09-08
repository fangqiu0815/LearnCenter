//
//  XWVideoCell.h
//  zhangshangPacket
//
//  Created by apple on 2017/8/1.
//  Copyright © 2017年 apple-fangqiu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XWVideoModel.h"

typedef void(^readlyPlayVideo)(UIButton *);

@interface XWVideoCell : UITableViewCell

@property (nonatomic,strong)XWVideoModel *model;
@property (nonatomic,strong)void(^readlyPlayVideo)();

@property (weak, nonatomic) IBOutlet UIImageView *videoImage;

/**返回收藏视频所需的id*/
@property (nonatomic,strong)id(^getVideoID)();
@property (weak, nonatomic) IBOutlet UIButton *shareClick;

@property (weak, nonatomic) IBOutlet UILabel *videoContent;

@property (weak, nonatomic) IBOutlet UILabel *playTime;

@end
