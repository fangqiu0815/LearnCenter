//
//  PageScrollView.h
//  NeedYouPower
//
//  Created by XD-XY on 7/2/14.
//  Copyright (c) 2014 XD-XY. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol PageScrollViewDelegate <NSObject>

-(void)gestureClick:(UITapGestureRecognizer *)sender andUrl:(NSString*)urlString;

@end

@interface PageScrollView : UIView<UIScrollViewDelegate>
{
    int imgCount;
    NSTimer * myTimer;
    BOOL isRunning;
}
@property(nonatomic,assign)id<PageScrollViewDelegate>delegate;
@property(nonatomic,strong)NSMutableArray * imageUrlArray;
@property(nonatomic,strong)UIScrollView * scrollView;
@property(nonatomic,strong)UIPageControl * pageControl;
@property(nonatomic,strong)UIImage * placeholderImg;

- (id)initWithFrame:(CGRect)frame andPageControllRect:(CGRect)rect;

@end
