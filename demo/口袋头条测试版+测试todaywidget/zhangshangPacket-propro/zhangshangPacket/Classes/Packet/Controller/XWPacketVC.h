//
//  XWPacketVC.h
//  zhangshangnews
//
//  Created by apple on 2017/5/8.
//  Copyright © 2017年 apple-fangqiu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QRUtility.h"

typedef void(^intBlock)(NSInteger a);
typedef void(^intBlockb)(NSInteger b);
@interface XWPacketVC : UIViewController
{
    UIImage * EWMImageImage;
}

+ (void)sentValueClick:(intBlock)_sentBlock ;
+ (void)sentValueClickb:(intBlockb)_sentBlock ;

@property (nonatomic, strong) NSString *shareIngot;

@property (nonatomic, strong) NSString *signInIngot;


@end
