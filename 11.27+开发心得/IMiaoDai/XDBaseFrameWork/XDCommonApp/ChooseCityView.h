//
//  ChooseCityView.h
//  XDCommonApp
//
//  Created by XD-XY on 8/29/14.
//  Copyright (c) 2014 XD-XY. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "chooseCityModel.h"

@protocol ChooseCityViewDelegate <NSObject>

-(void)clickBgViewLetViewHidden;
-(void)chooseTheCity:(chooseCityModel *)model;

@end

@interface ChooseCityView : UIView

@property(nonatomic,assign)id<ChooseCityViewDelegate>delegate;
@property(nonatomic,strong)UIView *bgView;
@property(nonatomic,strong)UIView * contentView;

@property(nonatomic,strong)NSMutableArray * dataArray;

@end
