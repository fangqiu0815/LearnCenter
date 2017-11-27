//
//  SingelBillViewController.h
//  XDCommonApp
//
//  Created by xindao on 14-8-12.
//  Copyright (c) 2014年 XD-XY. All rights reserved.
//

#import "XDBaseViewController.h"

@interface SingelBillViewController : XDBaseViewController<UITableViewDataSource,UITableViewDelegate>
{
    UITableView * myTableView;
}
@property (nonatomic,copy) NSString * picStr;
@property (nonatomic,copy) NSString * titleStr;
@property (nonatomic,copy) NSString * payNum;
@property (nonatomic,copy) NSString * leftDays;
@property (nonatomic,copy) NSString * orderId;
@property (nonatomic,copy) NSString * myMonth;
@property (nonatomic,copy) NSString * billDate;
@property (nonatomic,strong) NSMutableDictionary * dataDic;

@end
