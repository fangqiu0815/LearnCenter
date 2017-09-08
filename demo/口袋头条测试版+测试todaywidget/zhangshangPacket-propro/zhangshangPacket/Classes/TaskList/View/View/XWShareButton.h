//
//  XWShareButton.h
//  zhangshangPacket
//
//  Created by apple on 2017/5/22.
//  Copyright © 2017年 apple-fangqiu. All rights reserved.
//

#import <UIKit/UIKit.h>
@interface XWShareButton : UIButton



+(instancetype)buttonWithImage:(UIImage *)image title:(NSString *)title;

+(instancetype)buttonWithURLImage:(NSString *)imageStr title:(NSString *)titleStr;

@end
