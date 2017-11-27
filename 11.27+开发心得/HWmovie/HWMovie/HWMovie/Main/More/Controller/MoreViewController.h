//
//  MoreViewController.h
//  HWMovie
//
//  Created by hyrMac on 15/7/17.
//  Copyright (c) 2015年 hyrMac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"

@interface MoreViewController : BaseViewController <UITableViewDelegate,UITableViewDataSource,UIAlertViewDelegate>
{
    UITableView *_moreTableView;
    NSMutableArray *_messageArray;
}

@end
