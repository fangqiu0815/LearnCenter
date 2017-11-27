//
//  CardCellCollectionViewCell.h
//  DDCardAnimation
//
//  Created by tondyzhang on 16/10/11.
//  Copyright © 2016年 tondy. All rights reserved.
//

#import <UIKit/UIKit.h>

// 点击内容详细
UIKIT_EXTERN NSNotificationName const PYCarDeatilViewCellDidSelectedNotification;
UIKIT_EXTERN NSNotificationName const PYCarDeatilViewCellResourceKey;
UIKIT_EXTERN NSNotificationName const PYCarDeatilViewCellBackgroundKey;

@interface CardCellCollectionViewCell : UICollectionViewCell    

@property(nonatomic, strong)NSString* title;
@property(nonatomic, strong)UIColor* bgColor;
@property(nonatomic, strong)UIImage* image;
@property (nonatomic, weak) UITableView *tableView;

/** 资源数组 */
@property (nonatomic, copy) NSArray *resouces;

@end
