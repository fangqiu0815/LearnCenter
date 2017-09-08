//
//  XWTurnTableView.h
//  zhangshangPacket
//
//  Created by apple on 2017/7/10.
//  Copyright © 2017年 apple-fangqiu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AudioToolbox/AudioToolbox.h>

typedef void(^wheelBlock)(BOOL);



@interface XWTurnTableView : UIView<CAAnimationDelegate>
{
    ///没有转完的情况下退出大转盘
    BOOL noFinish;
    BOOL firstAnim;
    
    CFURLRef		soundFileURLRef;
    SystemSoundID	soundFileObject;
    
    ///开始播放次数
    int startCount;
    ///中间播放次数
    int mindelCount;
    ///结束播放次数
    int endCount;
    ///循环次数
    int count;
    
    
}
/*!
 @property
 @abstract 表示概率为几分制，默认为TurntableProbabilityPercentage
 */
///系统提示音
@property (readwrite)	CFURLRef		soundFileURLRef;
@property (readonly)	SystemSoundID	soundFileObject;

@property (nonatomic, assign) NSInteger btnClickNum;
@property (nonatomic, strong) UIButton *playButton;      // 抽奖按钮

//代理
@property(nonatomic,copy) wheelBlock wBlook;

/*!
 ImageArr:图片的数组
 PrizeArr:奖励的数组
 */
-(instancetype)initWithFrame:(CGRect)frame PrizeArr:(NSArray *)prizeArr;

-(void)startAnimaition;
-(void)endAnimateWithToValue:(CGFloat)valueFloat;
- (void)stop;

-(void)initUIWithPrizeArr:(NSArray *)prizeArr ;


@end
