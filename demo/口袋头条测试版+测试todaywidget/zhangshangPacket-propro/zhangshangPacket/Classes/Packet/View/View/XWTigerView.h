//
//  XWTigerView.h
//  zhangshangPacket
//
//  Created by apple on 2017/5/29.
//  Copyright © 2017年 apple-fangqiu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AudioToolbox/AudioToolbox.h>

#define STartCount 6
#define MINdelCount 33
#define EndCount 8

@protocol LuckViewDelegate <NSObject>

typedef void (^luckBlock)(NSInteger result);
typedef void (^luckBtnBlock)(UIButton *btn);

- (void)luckViewDidStopWithArrayCount:(NSInteger)count;
- (void)luckSelectBtn:(UIButton *)btn;

@end

@interface XWTigerView : UIView
{

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
@property (strong, nonatomic) NSMutableArray *imageArray;
@property (assign, nonatomic) int stopCount;
@property (assign, nonatomic) id<LuckViewDelegate> delegate;
@property (copy, nonatomic) luckBlock luckResultBlock;
@property (copy, nonatomic) luckBtnBlock luckBtn;


- (void)getLuckResult:(luckBlock)luckResult;
- (void)getLuckBtnSelect:(luckBtnBlock)btnBlock;

///系统提示音
@property (readwrite)	CFURLRef		soundFileURLRef;
@property (readonly)	SystemSoundID	soundFileObject;

@end
