//
//  MyBillsViewController.h
//  XDCommonApp
//
//  Created by xindao on 14-8-11.
//  Copyright (c) 2014年 XD-XY. All rights reserved.
//

#import "XDBaseViewController.h"

@interface MyBillsViewController : XDBaseViewController<UITableViewDataSource,UITableViewDelegate>
{
    UITableView * myTableView;
    NSMutableDictionary * dataDic;
    UIView * noGoodsView;

    NSString * myMonth;
    NSString * billDate;
}


@end
