//
//  XWImageCell.h
//  zhangshangPacket
//
//  Created by apple on 2017/6/2.
//  Copyright © 2017年 apple-fangqiu. All rights reserved.
//

#import "XWCell.h"

@interface XWImageCell : XWCell

@property (nonatomic, strong) UIImageView *imgView;

- (void)setDataCellWithImage:(UIImage *)adImage;

@end
