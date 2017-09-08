//
//  WheelAnimationView.m
//  zhangshangPacket
//
//  Created by apple on 2017/5/28.
//  Copyright © 2017年 apple-fangqiu. All rights reserved.
//

#import "WheelAnimationView.h"

#define SWidth self.frame.size.width
#define SHeight self.frame.size.height
#define kMAINCOLOR [UIColor colorWithRed:255/255.0 green:80/255.0 blue:1/255.0 alpha:1]

#define STartCount 6
#define MINdelCount 15
#define EndCount 8


@implementation WheelAnimationView

@synthesize soundFileURLRef;
@synthesize soundFileObject;

-(id)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        self.angle = 0;
        self.angleBefore = 0;
        count = 0;
        firstAnim = NO;
        ///背景
        backImagView = [[UIImageView alloc] initWithFrame:CGRectMake(15, 10, SWidth-30, SHeight-30)];
        backImagView.image = [UIImage imageNamed:@"turntable_bg"];
        [self addSubview:backImagView];
        
//        bottomImgView = [[UIImageView alloc]initWithFrame:CGRectMake(ScreenW*0.5-60, 20+SHeight-30+5, 120, 30)];
//        bottomImgView.image = MyImage(@"shadow");
//        [self addSubview:bottomImgView];
        
        //        UIImageView *pointerImage = [[UIImageView alloc] initWithFrame:CGRectMake(SWidth/2 - 10.5, 17, 42/2, 175/2)];
        //        pointerImage.image = [UIImage imageNamed:@"game_wheel_pointer"];
        //        [self addSubview:pointerImage];
        
        
        NSURL *tapSound   = [[NSBundle mainBundle] URLForResource: @"wheel"
                                                    withExtension: @"mp3"];
        
        // Store the URL as a CFURLRef instance
        self.soundFileURLRef = (__bridge CFURLRef)tapSound;
        
        // Create a system sound object representing the sound file.
        AudioServicesCreateSystemSoundID (
                                          
                                          soundFileURLRef,
                                          &soundFileObject
                                          );
        
    }
    return self;
}
#pragma mark 创建转盘
-(void)setwhooleViewWithArray:(NSArray *)aPrizeArray
{
    self.prizeArray = aPrizeArray;
    
    pieChartView = [[PieChartView alloc] initWithFrame:CGRectMake(35, 35, (SWidth - 100), (SWidth - 100))];
    pieChartView.delegate = self;
    pieChartView.datasource = self;
    [backImagView addSubview:pieChartView];
    
    int countt = (int)aPrizeArray.count;
    for (int i = 0; i < countt; i++) {
        UILabel *btn = [[UILabel alloc] init];
        CGFloat btnX = 0;
        CGFloat btnY = 0;
        CGFloat btnW = (SWidth - 80)/2;
        CGFloat btnH = (SWidth - 80)/2;
        
        NSDictionary *dic = [aPrizeArray objectAtIndex:i];
        btn.text = [NSString stringWithFormat:@"     %@",[dic objectForKey:@"desc"]];
        btn.textAlignment = NSTextAlignmentCenter;
        btn.font = [UIFont boldSystemFontOfSize:14.0f];
        btn.numberOfLines = 2;
        
        if (i % 2) {
            btn.textColor = MainRedColor;
        }else
        {
            btn.textColor = WhiteColor;
        }
        
        btn.frame = CGRectMake(btnX, btnY, btnW, btnH);
        btn.layer.anchorPoint = CGPointMake(0, 0.5);
        btn.layer.position = CGPointMake(backImagView.frame.size.width/2, backImagView.frame.size.height/2);
        CGFloat angle = i * (M_PI * 2 / countt);
        btn.transform = CGAffineTransformMakeRotation(angle);
        [backImagView addSubview:btn];
    }
    
    backImagView.transform = CGAffineTransformRotate(backImagView.transform, -M_PI / 2 + M_PI/aPrizeArray.count);
    
    noFinish = NO;
}

#pragma mark -    PieChartViewDelegate
-(CGFloat)centerCircleRadius
{
    return 23;
}
#pragma mark - PieChartViewDataSource
- (int)numberOfSlicesInPieChartView:(PieChartView *)pieChartView
{
    return (int)_prizeArray.count;
}
- (UIColor *)pieChartView:(PieChartView *)pieChartView colorForSliceAtIndex:(NSUInteger)index
{
    return [self colorWithIndex:index];
}
- (double)pieChartView:(PieChartView *)pieChartView valueForSliceAtIndex:(NSUInteger)index
{
    return 100/(int)_prizeArray.count;
}

- (UIColor *)pieChartView:(PieChartView *)pieChartView titleColorForSliceAtIndex:(NSUInteger)index
{
    return [self colorWithTitleIndex:index];
}

//转盘背景颜色
-(UIColor *)colorWithIndex:(NSUInteger)index
{
    if (self.prizeArray.count - 1 == index) {
        return WhiteColor;
    }else
    {
        if (index % 2) {
            return WhiteColor;
        }else
        {
            return MainRedColor;
        }
    }
}

//转盘字体颜色
- (UIColor *)colorWithTitleIndex:(NSUInteger)index
{
    if (self.prizeArray.count - 1 == index) {
        return MainRedColor;
    }else
    {
        if (index % 2) {
            return MainRedColor;
        }else
        {
            return WhiteColor;
        }
    }

}

#pragma mark 动画开始与结束
- (void)stop
{
    startCount = STartCount - 1;
    mindelCount = MINdelCount - 1;
    endCount = EndCount - 1;
    noFinish = YES;
}
-(void)startAnimate
{
    // 禁止交互
    self.userInteractionEnabled = NO;
    
    CABasicAnimation *animation = [CABasicAnimation animation];
    animation.keyPath = @"transform.rotation";
    // 计算核心动画旋转的角度
    animation.toValue = @(M_PI *20);
    animation.duration = 4.1;
    animation.removedOnCompletion = NO;
    animation.fillMode = kCAFillModeForwards;
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
    animation.delegate = self;
    
    [backImagView.layer addAnimation:animation forKey:@"animation1"];
    
}

-(void)endAnimateWithToValue:(CGFloat)valueFloat
{
    self.valueFloat = valueFloat;
    self.angleBefore = self.angle;
    
    // 禁止交互
    self.userInteractionEnabled = NO;
    
    CABasicAnimation *animation = [CABasicAnimation animation];
    animation.keyPath = @"transform.rotation";
    // 计算核心动画旋转的角度
    animation.toValue = @(M_PI *10 + valueFloat);
    animation.duration = 2;
    animation.removedOnCompletion = NO;
    animation.fillMode = kCAFillModeForwards;
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
    animation.delegate = self;
    animation.beginTime=CACurrentMediaTime()+3.6;//延迟到第一个动画结束。
    //firstAnim=YES;
    [backImagView.layer addAnimation:animation forKey:@"animation2"];
}

- (void)animationDidStart:(CAAnimation *)anim
{
    startCount = 0;
    mindelCount = 0;
    endCount = 0;
    //[self playWheelStartMusic];
}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag
{
    if (noFinish){
        return;
    }
    // 将view旋转到顶部
    backImagView.transform = CGAffineTransformMakeRotation(M_PI *40 + _valueFloat);
    self.angle = self.angleBefore;
    
    // 移除核心动画
    if (firstAnim==NO) {
        
        [backImagView.layer removeAnimationForKey:@"animation1"];
        firstAnim=YES;
    }
    else
    {
        [backImagView.layer removeAnimationForKey:@"animation2"];
        firstAnim=NO;
        self.userInteractionEnabled = YES;
        self.wBlook(YES);
    }
    
    
}



/**
 *  把转盘声音分解成 前部分，中部分，后部分
 */
#pragma mark  分解声音
-(void)playWheelStartMusic
{
    if (startCount == STartCount) {
        [self playWheelMiderlMusic];
    }else
    {
        ///单独播放声音
        AudioServicesPlaySystemSound (soundFileObject);
        dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)((0.52 - 0.07 * startCount) * NSEC_PER_SEC));
        dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
            startCount++;
            [self playWheelStartMusic];
        });
    }
}

-(void)playWheelMiderlMusic
{
    if (mindelCount == MINdelCount) {
        [self playWheelEndMusic];
    }else
    {
        AudioServicesPlaySystemSound (soundFileObject);
        dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.09 * NSEC_PER_SEC));
        dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
            mindelCount++;
            [self playWheelMiderlMusic];
        });
    }
}

-(void)playWheelEndMusic
{
    if (endCount == EndCount) {
        
    }else
    {
        AudioServicesPlaySystemSound(soundFileObject);
        dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)((0.1 + 0.08 * endCount) * NSEC_PER_SEC));
        dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
            endCount++;
            [self playWheelEndMusic];
        });
    }
}


@end
