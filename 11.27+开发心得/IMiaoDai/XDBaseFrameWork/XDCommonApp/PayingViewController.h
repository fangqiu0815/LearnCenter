//
//  PayingViewController.h
//  XDCommonApp
//
//  Created by xindao on 14-8-16.
//  Copyright (c) 2014年 XD-XY. All rights reserved.
//

#import "XDBaseViewController.h"

@interface PayingViewController : XDBaseViewController<UITableViewDataSource,UITableViewDelegate,UIWebViewDelegate>
{
    UIWebView * myWebView;
}
@property (nonatomic,copy) NSString * cost;
@property (nonatomic,copy) NSString * month;
@property (nonatomic,copy) NSString * billDate;
@property (nonatomic,copy) NSString * payOrderId;
@property (nonatomic,copy) NSString * urlStr;

@end
