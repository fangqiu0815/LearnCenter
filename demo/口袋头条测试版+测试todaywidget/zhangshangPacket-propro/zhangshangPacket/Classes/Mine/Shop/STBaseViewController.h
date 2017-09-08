//
//  STBaseViewController.h
//  CrazyPacket
//
//  Created by WuYanZu on 17/2/21.
//  Copyright © 2017年 WuYanZu. All rights reserved.
//

#import "ViewController.h"
#import <UIKit/UIKit.h>

@interface STBaseViewController : UIViewController
<
UITableViewDelegate,
UITableViewDataSource,
UITextFieldDelegate,
UITextViewDelegate
>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *dataArray;
//@property (nonatomic, strong) UIView *headerView;
@property (nonatomic, strong) UIView *footerView;
@property (nonatomic, strong) NSMutableArray *timeZones;

@end
