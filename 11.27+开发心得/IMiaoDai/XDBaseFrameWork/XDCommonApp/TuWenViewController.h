//
//  TuWenViewController.h
//  XDCommonApp
//
//  Created by xindao on 14-8-19.
//  Copyright (c) 2014年 XD-XY. All rights reserved.
//

#import "XDBaseViewController.h"

@interface TuWenViewController : XDBaseViewController<UIWebViewDelegate>
@property (nonatomic,copy) NSString * urlStr;
@property (nonatomic,strong)NSString * titleString;
@property (nonatomic,strong) NSString * htmlStr;
@end
