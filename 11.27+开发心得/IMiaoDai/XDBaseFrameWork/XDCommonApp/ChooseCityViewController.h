//
//  ChooseCityViewController.h
//  XDCommonApp
//
//  Created by XD-XY on 8/20/14.
//  Copyright (c) 2014 XD-XY. All rights reserved.
//

#import "XDBaseViewController.h"

@protocol ChooseCityViewControllerDelegate <NSObject>

-(void)chooseCityOrScholl:(NSDictionary *)dict andTitle:(NSString *)tilte;

@end

@interface ChooseCityViewController : XDBaseViewController<UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate,UIScrollViewDelegate>
{
    UITableView * myTableView;
    NSMutableArray * dataArray;
    UIView * hotCityView;
    
    UITextField * seachTF;
    UIView * noDataViews;
    NSArray * textArray;
}

@property(nonatomic,assign)id<ChooseCityViewControllerDelegate>delegate;
@property(nonatomic,strong)NSString * titleString;
@property(nonatomic,strong)NSString * cityId;
@end
