//
//  ConfirmOrderViewController.h
//  CrazyPacket
//
//  Created by WuYanZu on 17/3/1.
//  Copyright © 2017年 WuYanZu. All rights reserved.
//

#import "STBaseViewController.h"
#import "GoodsListModel.h"
@interface ConfirmOrderViewController : STBaseViewController
@property (nonatomic, strong) ItemDetail *dataModels;
-(void)reloadData;


@end
