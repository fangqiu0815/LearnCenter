//
//  ThirdViewController.h
//  XDCommonApp
//
//  Created by XD-XY on 2/12/14.
//  Copyright (c) 2014 XD-XY. All rights reserved.
//

#import "XDBaseViewController.h"

@interface ThirdViewController : XDBaseViewController<UITableViewDelegate,UITableViewDataSource,UIAlertViewDelegate>
{
    NSString * downUrl;
    NSString * cString;
    UIImageView *tiShiIV;
    UITableView * mytableView;
    NSArray * dataArray;
    UILabel *label;
}
@end
