//
//  XWBaseVC.h
//  zhangshangnews
//
//  Created by apple on 2017/5/10.
//  Copyright © 2017年 apple-fangqiu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XWBaseVC : UIViewController
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
