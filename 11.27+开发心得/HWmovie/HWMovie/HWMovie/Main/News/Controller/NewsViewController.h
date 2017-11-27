//
//  NewsViewController.h
//  HWMovie
//
//  Created by hyrMac on 15/7/17.
//  Copyright (c) 2015年 hyrMac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"

@interface NewsViewController : BaseViewController <UITableViewDelegate,UITableViewDataSource>
{
    UITableView *_newsTableView;
    NSMutableArray *_newsMessageArray;
}

@end
