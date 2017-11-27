//
//  XYScrollView.h
//  XDCommonApp
//
//  Created by XD-XY on 2/18/14.
//  Copyright (c) 2014 XD-XY. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol XYScrollViewDelegate <NSObject>
-(void)gestureClick:(UITapGestureRecognizer *)sender;
@end

@interface XYScrollView : UIView<UIScrollViewDelegate>
{
    int pageNumber;
    NSTimer * myTimer;
}

@property(nonatomic,assign)id<XYScrollViewDelegate>delegate;

@property (nonatomic,strong)UIScrollView * myScrollView;
@property (nonatomic,strong)UIPageControl * pageControl;
@property (nonatomic,strong)NSArray * imageUrlArray;
@property (nonatomic,strong)NSArray * imageArray;

-(id)initPageScrollView:(CGRect)sPect pageControllerFrame:(CGRect)pRect backgroudImage:(UIImage *)image pageNumber:(int)number;
-(void)setTheImageArray:(NSArray *)imageArray;
-(void)setTheImageUrlArray:(NSArray *)imageUrlArray andplaceholderImage:(UIImage *)defaultImage;
-(void)openTimerTask;
-(void)closeTimerTask;
@end
