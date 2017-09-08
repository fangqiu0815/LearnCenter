//
//  PieChartView.h
//  zhangshangPacket
//
//  Created by apple on 2017/5/28.
//  Copyright © 2017年 apple-fangqiu. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol PieChartViewDelegate;
@protocol PieChartViewDataSource;

@interface PieChartView : UIView

@property (nonatomic, assign) id <PieChartViewDataSource> datasource;
@property (nonatomic, assign) id <PieChartViewDelegate> delegate;

-(void)reloadData;


@end

@protocol PieChartViewDelegate <NSObject>

- (CGFloat)centerCircleRadius;

@end

@protocol PieChartViewDataSource <NSObject>

@required
- (int)numberOfSlicesInPieChartView:(PieChartView *)pieChartView;
- (double)pieChartView:(PieChartView *)pieChartView valueForSliceAtIndex:(NSUInteger)index;
- (UIColor *)pieChartView:(PieChartView *)pieChartView colorForSliceAtIndex:(NSUInteger)index;
- (NSString*)pieChartView:(PieChartView *)pieChartView titleForSliceAtIndex:(NSUInteger)index;
- (UIColor *)pieChartView:(PieChartView *)pieChartView titleColorForSliceAtIndex:(NSUInteger)index;

@optional

@end

