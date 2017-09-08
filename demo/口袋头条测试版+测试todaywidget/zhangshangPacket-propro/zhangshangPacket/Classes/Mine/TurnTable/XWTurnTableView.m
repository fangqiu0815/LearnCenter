//
//  XWTurnTableView.m
//  zhangshangPacket
//
//  Created by apple on 2017/7/10.
//  Copyright © 2017年 apple-fangqiu. All rights reserved.
//

#import "XWTurnTableView.h"
#define turnScale_W self.bounds.size.width/300
#define turnScale_H self.bounds.size.height/300
#define STartCount 6
#define MINdelCount 15
#define EndCount 8
@interface XWTurnTableView ()<CAAnimationDelegate>

@property (nonatomic,assign) NSInteger numberIndex; //抽中的奖励

@property (nonatomic,strong) UIImageView * rotateWheel;  // 转盘背景

@property (nonatomic, retain) NSArray *numberArr; //概率数组

@property (nonatomic, assign) NSInteger turnTableNum;//奖品的个数

@property (nonatomic, assign) CGFloat turnTableAngle;//倾斜角度

///旋转到某个位置
@property(nonatomic,assign) CGFloat valueFloat;
///动画前的角度
@property(nonatomic,assign) CGFloat angleBefore;

// 按钮初始化时的角度
@property (nonatomic, assign) CGFloat angle;
@end

@implementation XWTurnTableView
@synthesize soundFileURLRef;
@synthesize soundFileObject;
-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.angle = 0;
        self.angleBefore = 0;
        count = 0;
        firstAnim = NO;
        
        self.btnClickNum = NSIntegerMax;
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

-(void)initUIWithPrizeArr:(NSArray *)prizeArr {
    
    _turnTableNum = prizeArr.count;
    _turnTableAngle = 360/_turnTableNum;
    
    // 外围装饰背景图
    UIImageView * backImageView = [UIImageView new];
    backImageView.image = [UIImage imageNamed:@"turntable_bg"];
    [self addSubview:backImageView];
//    backImageView.frame = CGRectMake(0, 0, 330*turnScale_W, 365*turnScale_H);
    [backImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self);
        make.centerY.mas_equalTo(self);
        make.width.mas_equalTo(370*turnScale_W);
        make.height.mas_equalTo(370*turnScale_W);
    }];
    
    // 转盘
    self.rotateWheel = [[UIImageView alloc] initWithImage:MyImage(@"turntable_bg2")];
    self.rotateWheel.frame = self.bounds;
    [self addSubview:self.rotateWheel];
    
    // 抽奖按钮
//    [self.playButton addTarget:self action:@selector(startAnimaition) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.playButton];
    [self.playButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self);
        make.centerY.mas_equalTo(self);
        make.width.mas_equalTo(80*AdaptiveScale_W);
        make.height.mas_equalTo(100*AdaptiveScale_W);
    }];
    
    // 在转盘上添加图片和文字
    
    for (int i = 0; i < _turnTableNum; i ++) {
        NSDictionary *dic = [prizeArr objectAtIndex:i];

        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0,M_PI * CGRectGetHeight(self.bounds)/_turnTableNum,               CGRectGetHeight(self.bounds)/2)];
        label.layer.anchorPoint = CGPointMake(0.5, 1);
        label.center = CGPointMake(CGRectGetHeight(self.bounds)/2, CGRectGetHeight(self.bounds)/2);
        label.text = [NSString stringWithFormat:@"%@", [dic objectForKey:@"desc"]];
        CGFloat angle = M_PI * 2 / prizeArr.count * i;
        label.textAlignment = NSTextAlignmentCenter;
        label.numberOfLines = 0;
        if (i%2 == 0) {
            label.textColor = MainRedColor;
        }else{
            label.textColor = WhiteColor;

        }
        
        label.font = [UIFont systemFontOfSize:RemindFont(12, 13, 14)];
        label.transform = CGAffineTransformMakeRotation(angle);
//        label.transform = CGAffineTransformRotate(self.rotateWheel.transform, -M_PI / 2 + M_PI/prizeArr.count);
        [self.rotateWheel addSubview:label];
        
        UIImageView * imageView = [[UIImageView alloc] initWithFrame:CGRectMake(35*turnScale_W, 12, M_PI * CGRectGetHeight(self.bounds)/_turnTableNum - 65*turnScale_W, _turnTableAngle*turnScale_H)];
        imageView.image = [UIImage imageNamed:@"yb.png"];
        if ([[dic objectForKey:@"desc"] isEqualToString:@"再抽一次"]) {
            label.text = [NSString stringWithFormat:@"再抽\n一次\n\n\n"];
            label.font = [UIFont systemFontOfSize:RemindFont(15, 16, 17)];
        } else if([[dic objectForKey:@"desc"] isEqualToString:@"谢谢参与"]){
            label.text = [NSString stringWithFormat:@"谢谢\n参与\n\n\n"];
            label.font = [UIFont systemFontOfSize:RemindFont(15, 16, 17)];
            
        } else {
        
            [label addSubview:imageView];
        }
        
    }
    
    noFinish = NO;

}

#pragma mark 动画开始与结束
- (void)stop
{
    startCount = STartCount - 1;
    mindelCount = MINdelCount - 1;
    endCount = EndCount - 1;
    noFinish = YES;
}

-(void)startAnimaition{
//    if (self.btnClickNum == 0) {
//        if ([self.delegate respondsToSelector:@selector(TurnTableViewDidFinishWithIndex:BtnClickNum:)]) {
//            [self.delegate TurnTableViewDidFinishWithIndex:0 BtnClickNum:0];
//        }
//        return;
//    }else if(self.btnClickNum != NSIntegerMax){
//        self.btnClickNum -- ;
//    }
////     禁止用户交互
//    self.playButton.userInteractionEnabled = NO;
//    NSInteger turnAngle = 0;
//////    NSInteger randomNum = arc4random()%self.probabilityModel;//控制概率
//    NSInteger turnsNum = 10;//控制圈数
//
//    //变换数组，变成所有和的数组，来进行下一步的判断
////    NSArray *arr = [self changeArrWithArr:_numberArr];
////    for (int i=0; i<turnsNum-1; i++) {
////        if(randomNum >=[arr[i] floatValue] && randomNum <[arr[i+1] floatValue]){
////            turnAngle = _turnTableAngle*i;
////            _numberIndex = i;
////        }
////    }
////
////    //设置默认奖品，防止溢出
////    if (randomNum >=[arr[arr.count-1] floatValue]) {
////        turnAngle = 0;
////        _numberIndex = 0;
////    }
//    
//    //调整逆时针计算为顺时针
//    turnAngle = 360-turnAngle;
//    
//    CGFloat perAngle = M_PI/180.0;
//    CABasicAnimation* rotationAnimation;
//    rotationAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
//    rotationAnimation.toValue = [NSNumber numberWithFloat:turnAngle * perAngle + 360 * perAngle * turnsNum];
//    rotationAnimation.duration = 4.1f;
//    rotationAnimation.cumulative = YES;
//    rotationAnimation.delegate = self;
//    
//    //由快变慢
//    rotationAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
//    rotationAnimation.fillMode = kCAFillModeForwards;
//    rotationAnimation.removedOnCompletion = NO;
//    [self.rotateWheel.layer addAnimation:rotationAnimation forKey:@"rotationAnimation"];
//    
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
    [self.rotateWheel.layer addAnimation:animation forKey:@"rotationAnimation"];
}

- (void)endAnimateWithToValue:(CGFloat)valueFloat
{
    self.valueFloat = valueFloat;
    self.angleBefore = self.angle;
    
    // 禁止交互
    self.userInteractionEnabled = NO;
    
    CABasicAnimation *animation = [CABasicAnimation animation];
    animation.keyPath = @"transform.rotation";
    // 计算核心动画旋转的角度
    animation.toValue = @(M_PI*11 + valueFloat);
    animation.duration = 2;
    animation.removedOnCompletion = NO;
    animation.fillMode = kCAFillModeForwards;
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
    animation.delegate = self;
    animation.beginTime = CACurrentMediaTime()+3.6;//延迟到第一个动画结束。
    //firstAnim=YES;
    [self.rotateWheel.layer addAnimation:animation forKey:@"animation2"];

}

//- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag{
//    self.playButton.userInteractionEnabled = YES;
//    
//    if ([self.delegate respondsToSelector:@selector(TurnTableViewDidFinishWithIndex:BtnClickNum:)]) {
//        [self.delegate TurnTableViewDidFinishWithIndex:_numberIndex BtnClickNum:self.btnClickNum];
//    }
//    JLLog(@"_numberindex---%ld",(long)_numberIndex);
//}

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
    self.rotateWheel.transform = CGAffineTransformMakeRotation(M_PI *31 + _valueFloat);
    self.angle = self.angleBefore;
    
    // 移除核心动画
    if (firstAnim==NO) {
        
        [self.rotateWheel.layer removeAnimationForKey:@"rotationAnimation"];
        firstAnim=YES;
    }
    else
    {
        [self.rotateWheel.layer removeAnimationForKey:@"animation2"];
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

- (UIButton *)playButton
{
    if (!_playButton) {
        _playButton = [[UIButton alloc]init];
        [_playButton setImage:MyImage(@"Pointer") forState:0];
        
    }
    return _playButton;

}


@end
