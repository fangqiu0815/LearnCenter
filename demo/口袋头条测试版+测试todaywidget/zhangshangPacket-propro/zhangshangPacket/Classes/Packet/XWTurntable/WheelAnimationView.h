//
//  WheelAnimationView.h
//  zhangshangPacket
//
//  Created by apple on 2017/5/28.
//  Copyright © 2017年 apple-fangqiu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PieChartView.h"
#import <AudioToolbox/AudioToolbox.h>

typedef void(^wheelBlock)(BOOL);

@interface WheelAnimationView : UIView
<PieChartViewDelegate,PieChartViewDataSource,CAAnimationDelegate>
{
    //背景
    UIImageView *backImagView;
//    //底图
//    UIImageView *bottomImgView;
    //转盘
    PieChartView *pieChartView;
    
    ///循环次数
    int count;
    
    ///没有转完的情况下退出大转盘
    BOOL noFinish;
    
    
    CFURLRef		soundFileURLRef;
    SystemSoundID	soundFileObject;
    
    ///开始播放次数
    int startCount;
    ///中间播放次数
    int mindelCount;
    ///结束播放次数
    int endCount;
    
    BOOL firstAnim;
    
}

///系统提示音
@property (readwrite)	CFURLRef		soundFileURLRef;
@property (readonly)	SystemSoundID	soundFileObject;

@property(nonatomic,retain) NSArray *prizeArray;

///旋转到某个位置
@property(nonatomic,assign) CGFloat valueFloat;

///动画前的角度
@property(nonatomic,assign) CGFloat angleBefore;

// 按钮初始化时的角度
@property (nonatomic, assign) CGFloat angle;


@property(nonatomic,copy) wheelBlock wBlook;

-(id)initWithFrame:(CGRect)frame;


- (void)stop;

-(void)setwhooleViewWithArray:(NSArray *)aPrizeArray;
-(void)startAnimate;
-(void)endAnimateWithToValue:(CGFloat)valueFloat;


@end
