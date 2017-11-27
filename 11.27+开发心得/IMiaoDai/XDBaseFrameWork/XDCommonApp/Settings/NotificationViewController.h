//
//  NotificationViewController.h
//  XDCommonApp
//
//  Created by wanglong8889@126.com on 14-6-13.
//  Copyright (c) 2014年 XD-XY. All rights reserved.
//

#import "XDBaseViewController.h"
#import "FFCircularProgressView.h"

@interface NotificationViewController : XDBaseViewController
{
    UIImageView *imageView;
    UILabel *prgressLabel;
    NSMutableArray *imageArr;
    UIProgressView *midProfressView;
    
}
@property (nonatomic,strong) FFCircularProgressView *circularPV;
@end
