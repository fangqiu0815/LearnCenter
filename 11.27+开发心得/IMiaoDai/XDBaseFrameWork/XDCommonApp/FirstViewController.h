//
//  FirstViewController.h
//  XDCommonApp
//
//  Created by XD-XY on 2/12/14.
//  Copyright (c) 2014 XD-XY. All rights reserved.
//

#import "XDBaseViewController.h"
#import "ASIHTTPRequest.h"
#import "XYScrollView.h"
#import "MJRefresh.h"
#import "PageScrollView.h"
#import "ChooseCityView.h"

@interface FirstViewController : XDBaseViewController<UITableViewDelegate,UITableViewDataSource,XYScrollViewDelegate,MJRefreshBaseViewDelegate,UIAlertViewDelegate,PageScrollViewDelegate,ChooseCityViewDelegate>
{
    XYScrollView * pageView;
    PageScrollView * pageScrollView;
    NSMutableArray * bannerDataArray;
    NSMutableArray * dataArray;
    UITableView * myTableView;
    
    MJRefreshHeaderView * headerView;
    MJRefreshFooterView * footerView;
    
    int curpage;
    int totalCount;

    BOOL isFirst;

    ChooseCityView * choosecityView;
    
    NSString * downUrl;
    NSMutableString * cString;

    UIView * messageTool;
    UILabel * messageLB;
    UIButton * checkBtn;
    
    UIView * messageTool2;
    UILabel * messageLB2;
    UIButton * checkBtn2;

    UILabel * breakNetLB;
}
@end
