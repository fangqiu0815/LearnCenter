//
//  FourthViewController.h
//  XDCommonApp
//
//  Created by XD-XY on 2/12/14.
//  Copyright (c) 2014 XD-XY. All rights reserved.
//

#import "XDBaseViewController.h"

@interface FourthViewController : XDBaseViewController<UITableViewDataSource,UITableViewDelegate,UIActionSheetDelegate>

{
    UIImageView *headerView;
    UIActionSheet *sheet;
}
@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic,strong) NSMutableArray *dataArrary;
@end
