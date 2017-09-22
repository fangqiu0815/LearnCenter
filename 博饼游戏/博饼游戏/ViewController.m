//
//  ViewController.m
//  博饼游戏
//
//  Created by apple-gaofangqiu on 2017/9/22.
//  Copyright © 2017年 apple-fangqiu. All rights reserved.
//

#import "ViewController.h"
#import <QuartzCore/QuartzCore.h>
#import <AudioToolbox/AudioToolbox.h>
static SystemSoundID shake_sound_male_id = 0;
#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import "BoBingVC.h"



/**
 ======================================================
 ==================     博饼规则   =======================
 1.1个4 ------ 一秀
 2.2个4 ------ 二举
 3.4个2 ------ 四进
 4.3个4 ------ 三红
 5.1-6  ------ 对堂
 6.4个4 ------ 四红 状元
 7.5个2 ------ 五子 状元
 8.5个4 ------ 五红 状元
 9.6个2 ------ 黑六勃 状元
 10.6个1 ----- 遍地锦 状元
 11.6个4 ----- 红六勃 状元
 12.4个4 2个1-----插金花 状元
 ======================================================
 
 **/

@interface ViewController ()<CAAnimationDelegate>
{
    int whichAnimatiom;
    int zeng;
    
    UIImageView *image1,*image2,*image3,*image4,*image5,*image6;
    UIImageView *dong1,*dong2,*dong3,*dong4,*dong5,*dong6;
    
    UILabel *resultLab;
}



@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //添加大碗背景
    UIImageView *background = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"shangpingwan@2x.png"]];
    background.frame = CGRectMake(0.0, 0.0, ScreenW, ScreenW);
    [self.view addSubview:background];
    //逐个添加骰子
    UIImageView *_image1 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"1@2x.png"]];
    _image1.frame = CGRectMake(75.0, 115.0, 45.0, 45.0);
    image1 = _image1;
    [self.view addSubview:_image1];
    UIImageView *_image2 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"2@2x.png"]];
    _image2.frame = CGRectMake(135.0, 115.0, 45.0, 45.0);
    image2 = _image2;
    [self.view addSubview:_image2];
    UIImageView *_image3 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"3@2x.png"]];
    _image3.frame = CGRectMake(195.0, 115.0, 45.0, 45.0);
    image3 = _image3;
    [self.view addSubview:_image3];
    UIImageView *_image4 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"4@2x.png"]];
    _image4.frame = CGRectMake(80.0, 180.0, 45.0, 45.0);
    image4 = _image4;
    [self.view addSubview:_image4];
    UIImageView *_image5 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"5@2x.png"]];
    _image5.frame = CGRectMake(140.0, 180.0, 45.0, 45.0);
    image5 = _image5;
    [self.view addSubview:_image5];
    UIImageView *_image6 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"6@2x.png"]];
    _image6.frame = CGRectMake(200.0, 180.0, 45.0, 45.0);
    image6 = _image6;
    [self.view addSubview:_image6];
    //添加按钮
    UIButton *btn_bobing = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [btn_bobing setTitle:@"开始博饼" forState:UIControlStateNormal];
    [btn_bobing addTarget:self action:@selector(bobing)  forControlEvents:UIControlEventTouchUpInside];
    [btn_bobing setTitleColor:[UIColor redColor] forState:0];
    btn_bobing.frame = CGRectMake((ScreenW-80)/2, 340, 80.0, 50.0);
    [self.view addSubview:btn_bobing];
    
    resultLab = [[UILabel alloc]initWithFrame:CGRectMake((ScreenW-80)/2, 400, 120.0, 50.0)];
    resultLab.text = @"祝你好运";
    resultLab.textColor = [UIColor blackColor];
    resultLab.font = [UIFont systemFontOfSize:18];
    [self.view addSubview:resultLab];
    
    UIButton *button = [[UIButton alloc]initWithFrame:CGRectMake((ScreenW-80)/2, 480, 80, 50)];
    [button setTitle:@"博饼规则" forState:0];
    [button setTitleColor:[UIColor blackColor] forState:0];
    [button addTarget:self action:@selector(buttonClick)  forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];

    
    NSArray *array1 = @[@"1",@"2",@"2",@"4",@"4",@"6"];
    
    NSMutableArray *array = [NSMutableArray arrayWithArray:array1];
    
    NSMutableArray *dateMutablearray = [@[] mutableCopy];
    for (int i = 0; i < array.count; i ++) {
        
        NSString *string = array[i];
        
        NSMutableArray *tempArray = [@[] mutableCopy];
        
        [tempArray addObject:string];
        
        for (int j = i+1; j < array.count; j ++) {
            
            NSString *jstring = array[j];
            
            if([string isEqualToString:jstring]){
                
                [tempArray addObject:jstring];
                
                [array removeObjectAtIndex:j];
                j -= 1;
                
            }
            
        }
        
        [dateMutablearray addObject:tempArray];
        
    }
    
    NSLog(@"dateMutable:%@",dateMutablearray);
    
   
}

- (void)buttonClick
{
    [self presentViewController:[BoBingVC new] animated:YES completion:nil];
}

- (void)bobing
{
    
    static SystemSoundID soundIDTest = 0;
    
    NSString * path = [[NSBundle mainBundle] pathForResource:@"yao" ofType:@"wav"];
    
    if (path) {
        
        AudioServicesCreateSystemSoundID( (__bridge CFURLRef)[NSURL fileURLWithPath:path], &soundIDTest );
        
    }
    
    AudioServicesPlaySystemSound( soundIDTest );
    
    //隐藏初始位置的骰子
    image1.hidden = YES;
    image2.hidden = YES;
    image3.hidden = YES;
    image4.hidden = YES;
    image5.hidden = YES;
    image6.hidden = YES;
    dong1.hidden = YES;
    dong2.hidden = YES;
    dong3.hidden = YES;
    dong4.hidden = YES;
    dong5.hidden = YES;
    dong6.hidden = YES;
    //******************旋转动画的初始化******************
    //转动骰子的载入
    NSArray *myImages = [NSArray arrayWithObjects:
                         [UIImage imageNamed:@"dong1@2x.png"],
                         [UIImage imageNamed:@"dong2@2x.png"],
                         [UIImage imageNamed:@"dong3@2x.png"],nil];
    //骰子1的转动图片切换
    UIImageView *dong11 = [[UIImageView alloc]initWithFrame:CGRectMake(85.0, 115.0, 45.0, 45.0)];
    dong11.animationImages = myImages;
    dong11.animationDuration = 0.5;
    [dong11 startAnimating];
    [self.view addSubview:dong11];
    dong1 = dong11;
    //骰子2的转动图片切换
    UIImageView *dong12 = [[UIImageView alloc]initWithFrame:CGRectMake(135.0, 115.0, 45.0, 45.0)];
    dong12.animationImages = myImages;
    dong12.animationDuration = 0.5;
    [dong12 startAnimating];
    [self.view addSubview:dong12];
    dong2 = dong12;
    //骰子3的转动图片切换
    UIImageView *dong13 = [[UIImageView alloc]initWithFrame:CGRectMake(195.0, 115.0, 45.0, 45.0)];
    dong13.animationImages = myImages;
    dong13.animationDuration = 0.5;
    [dong13 startAnimating];
    [self.view addSubview:dong13];
    dong3 = dong13;
    //骰子4的转动图片切换
    UIImageView *dong14 = [[UIImageView alloc]initWithFrame:CGRectMake(80.0, 180.0, 45.0, 45.0)];
    dong14.animationImages = myImages;
    dong14.animationDuration = 0.5;
    [dong14 startAnimating];
    [self.view addSubview:dong14];
    dong4 = dong14;
    //骰子5的转动图片切换
    UIImageView *dong15 = [[UIImageView alloc]initWithFrame:CGRectMake(140.0, 180.0, 45.0, 45.0)];
    dong15.animationImages = myImages;
    dong15.animationDuration = 0.5;
    [dong15 startAnimating];
    [self.view addSubview:dong15];
    dong5 = dong15;
    //骰子6的转动图片切换
    UIImageView *dong16 = [[UIImageView alloc]initWithFrame:CGRectMake(200.0, 180.0, 45.0, 45.0)];
    dong16.animationImages = myImages;
    dong16.animationDuration = 0.5;
    [dong16 startAnimating];
    [self.view addSubview:dong16];
    dong6 = dong16;
    
    //******************旋转动画******************
    //设置动画
    CABasicAnimation *spin = [CABasicAnimation animationWithKeyPath:@"transform.rotation"];
    [spin setToValue:[NSNumber numberWithFloat:M_PI * 16.0]];
    [spin setDuration:4];
    //******************位置变化******************
    //骰子1的位置变化
    CGPoint p1 = CGPointMake(85.0, 115.0);
    CGPoint p2 = CGPointMake(165.0, 100.0);
    CGPoint p3 = CGPointMake(240.0, 160.0);
    CGPoint p4 = CGPointMake(140.0, 200.0);
    NSArray *keypoint = [[NSArray alloc] initWithObjects:[NSValue valueWithCGPoint:p1],[NSValue valueWithCGPoint:p2],[NSValue valueWithCGPoint:p3],[NSValue valueWithCGPoint:p4], nil];
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    [animation setValues:keypoint];
    [animation setDuration:4.0];
    [animation setDelegate:self];
    [dong11.layer setPosition:CGPointMake(140.0, 200.0)];
    //骰子2的位置变化
    CGPoint p21 = CGPointMake(135.0, 115.0);
    CGPoint p22 = CGPointMake(160.0, 220.0);
    CGPoint p23 = CGPointMake(85.0, 190.0);
    CGPoint p24 = CGPointMake(190.0, 175.0);
    NSArray *keypoint2 = [[NSArray alloc] initWithObjects:[NSValue valueWithCGPoint:p21],[NSValue valueWithCGPoint:p22],[NSValue valueWithCGPoint:p23],[NSValue valueWithCGPoint:p24], nil];
    CAKeyframeAnimation *animation2 = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    [animation2 setValues:keypoint2];
    [animation2 setDuration:4.0];
    [animation2 setDelegate:self];
    [dong12.layer setPosition:CGPointMake(190.0, 175.0)];
    //骰子3的位置变化
    CGPoint p31 = CGPointMake(195.0, 115.0);
    CGPoint p32 = CGPointMake(175.0, 95.0);
    CGPoint p33 = CGPointMake(140.0, 220.0);
    CGPoint p34 = CGPointMake(100.0, 130.0);
    NSArray *keypoint3 = [[NSArray alloc] initWithObjects:[NSValue valueWithCGPoint:p31],[NSValue valueWithCGPoint:p32],[NSValue valueWithCGPoint:p33],[NSValue valueWithCGPoint:p34], nil];
    CAKeyframeAnimation *animation3 = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    [animation3 setValues:keypoint3];
    [animation3 setDuration:4.0];
    [animation3 setDelegate:self];
    [dong13.layer setPosition:CGPointMake(100.0, 130.0)];
    //骰子4的位置变化
    CGPoint p41 = CGPointMake(80.0,  180.0);
    CGPoint p42 = CGPointMake(220.0, 160.0);
    CGPoint p43 = CGPointMake(75.0,  115.0);
    CGPoint p44 = CGPointMake(155.0, 100.0);
    NSArray *keypoint4 = [[NSArray alloc] initWithObjects:[NSValue valueWithCGPoint:p41],[NSValue valueWithCGPoint:p42],[NSValue valueWithCGPoint:p43],[NSValue valueWithCGPoint:p44], nil];
    CAKeyframeAnimation *animation4 = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    [animation4 setValues:keypoint4];
    [animation4 setDuration:4.0];
    [animation4 setDelegate:self];
    [dong14.layer setPosition:CGPointMake(155.0, 100.0)];
    //骰子5的位置变化
    CGPoint p51 = CGPointMake(140.0, 180.0);
    CGPoint p52 = CGPointMake(225.0, 180.0);
    CGPoint p53 = CGPointMake(195.0, 115.0);
    CGPoint p54 = CGPointMake(160.0, 190.0);
    NSArray *keypoint5 = [[NSArray alloc] initWithObjects:[NSValue valueWithCGPoint:p51],[NSValue valueWithCGPoint:p52],[NSValue valueWithCGPoint:p53],[NSValue valueWithCGPoint:p54], nil];
    CAKeyframeAnimation *animation5 = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    [animation5 setValues:keypoint5];
    [animation5 setDuration:4.0];
    [animation5 setDelegate:self];
    [dong15.layer setPosition:CGPointMake(190.0, 220.0)];
    //骰子6的位置变化
    CGPoint p61 = CGPointMake(200.0, 180.0);
    CGPoint p62 = CGPointMake(90.0, 190.0);
    CGPoint p63 = CGPointMake(70.0, 140.0);
    CGPoint p64 = CGPointMake(230.0, 110.0);
    NSArray *keypoint6 = [[NSArray alloc] initWithObjects:[NSValue valueWithCGPoint:p61],[NSValue valueWithCGPoint:p62],[NSValue valueWithCGPoint:p63],[NSValue valueWithCGPoint:p64], nil];
    CAKeyframeAnimation *animation6 = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    [animation6 setValues:keypoint6];
    [animation6 setDuration:4.0];
    [animation6 setDelegate:self];
    [dong16.layer setPosition:CGPointMake(230.0, 110.0)];
    
    //******************动画组合******************
    //骰子1的动画组合
    CAAnimationGroup *animGroup = [CAAnimationGroup animation];
    animGroup.animations = [NSArray arrayWithObjects: animation, spin,nil];
    animGroup.duration = 4;
    [animGroup setDelegate:self];
    [[dong11 layer] addAnimation:animGroup forKey:@"position"];
    //骰子2的动画组合
    CAAnimationGroup *animGroup2 = [CAAnimationGroup animation];
    animGroup2.animations = [NSArray arrayWithObjects: animation2, spin,nil];
    animGroup2.duration = 4;
    [animGroup2 setDelegate:self];
    [[dong12 layer] addAnimation:animGroup2 forKey:@"position"];
    //骰子3的动画组合
    CAAnimationGroup *animGroup3 = [CAAnimationGroup animation];
    animGroup3.animations = [NSArray arrayWithObjects: animation3, spin,nil];
    animGroup3.duration = 4;
    [animGroup3 setDelegate:self];
    [[dong13 layer] addAnimation:animGroup3 forKey:@"position"];
    //骰子4的动画组合
    CAAnimationGroup *animGroup4 = [CAAnimationGroup animation];
    animGroup4.animations = [NSArray arrayWithObjects: animation4, spin,nil];
    animGroup4.duration = 4;
    [animGroup4 setDelegate:self];
    [[dong14 layer] addAnimation:animGroup4 forKey:@"position"];
    //骰子5的动画组合
    CAAnimationGroup *animGroup5 = [CAAnimationGroup animation];
    animGroup5.animations = [NSArray arrayWithObjects: animation5, spin,nil];
    animGroup5.duration = 4;
    [animGroup5 setDelegate:self];
    [[dong15 layer] addAnimation:animGroup5 forKey:@"position"];
    //骰子6的动画组合
    CAAnimationGroup *animGroup6 = [CAAnimationGroup animation];
    animGroup6.animations = [NSArray arrayWithObjects: animation6, spin,nil];
    animGroup6.duration = 4;
    [animGroup6 setDelegate:self];
    [[dong16 layer] addAnimation:animGroup6 forKey:@"position"];
    
}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag
{
    //停止骰子自身的转动
    [dong1 stopAnimating];
    [dong2 stopAnimating];
    [dong3 stopAnimating];
    [dong4 stopAnimating];
    [dong5 stopAnimating];
    [dong6 stopAnimating];
    
    //*************产生随机数，真正博饼**************
    srand((unsigned)time(0));  //不加这句每次产生的随机数不变
    //骰子1的结果
    int result1 = (rand() % 5) +1 ;  //产生1～6的数
    switch (result1) {
        case 1:dong1.image = [UIImage imageNamed:@"1@2x.png"];break;
        case 2:dong1.image = [UIImage imageNamed:@"2@2x.png"];break;
        case 3:dong1.image = [UIImage imageNamed:@"3@2x.png"];break;
        case 4:dong1.image = [UIImage imageNamed:@"4@2x.png"];break;
        case 5:dong1.image = [UIImage imageNamed:@"5@2x.png"];break;
        case 6:dong1.image = [UIImage imageNamed:@"6@2x.png"];break;
    }
    //骰子2的结果
    int result2 = (rand() % 5) +1 ;  //产生1～6的数
    switch (result2) {
        case 1:dong2.image = [UIImage imageNamed:@"1@2x.png"];break;
        case 2:dong2.image = [UIImage imageNamed:@"2@2x.png"];break;
        case 3:dong2.image = [UIImage imageNamed:@"3@2x.png"];break;
        case 4:dong2.image = [UIImage imageNamed:@"4@2x.png"];break;
        case 5:dong2.image = [UIImage imageNamed:@"5@2x.png"];break;
        case 6:dong2.image = [UIImage imageNamed:@"6@2x.png"];break;
    }
    //骰子3的结果
    int result3 = (rand() % 5) +1 ;  //产生1～6的数
    switch (result3) {
        case 1:dong3.image = [UIImage imageNamed:@"1@2x.png"];break;
        case 2:dong3.image = [UIImage imageNamed:@"2@2x.png"];break;
        case 3:dong3.image = [UIImage imageNamed:@"3@2x.png"];break;
        case 4:dong3.image = [UIImage imageNamed:@"4@2x.png"];break;
        case 5:dong3.image = [UIImage imageNamed:@"5@2x.png"];break;
        case 6:dong3.image = [UIImage imageNamed:@"6@2x.png"];break;
    }
    //骰子4的结果
    int result4 = (rand() % 5) +1 ;  //产生1～6的数
    switch (result4) {
        case 1:dong4.image = [UIImage imageNamed:@"1@2x.png"];break;
        case 2:dong4.image = [UIImage imageNamed:@"2@2x.png"];break;
        case 3:dong4.image = [UIImage imageNamed:@"3@2x.png"];break;
        case 4:dong4.image = [UIImage imageNamed:@"4@2x.png"];break;
        case 5:dong4.image = [UIImage imageNamed:@"5@2x.png"];break;
        case 6:dong4.image = [UIImage imageNamed:@"6@2x.png"];break;
    }
    //骰子5的结果
    int result5 = (rand() % 5) +1 ;  //产生1～6的数
    switch (result5) {
        case 1:dong5.image = [UIImage imageNamed:@"1@2x.png"];break;
        case 2:dong5.image = [UIImage imageNamed:@"2@2x.png"];break;
        case 3:dong5.image = [UIImage imageNamed:@"3@2x.png"];break;
        case 4:dong5.image = [UIImage imageNamed:@"4@2x.png"];break;
        case 5:dong5.image = [UIImage imageNamed:@"5@2x.png"];break;
        case 6:dong5.image = [UIImage imageNamed:@"6@2x.png"];break;
    }
    //骰子6的结果
    int result6 = (rand() % 5) +1 ;  //产生1～6的数
    switch (result6) {
        case 1:dong6.image = [UIImage imageNamed:@"1@2x.png"];break;
        case 2:dong6.image = [UIImage imageNamed:@"2@2x.png"];break;
        case 3:dong6.image = [UIImage imageNamed:@"3@2x.png"];break;
        case 4:dong6.image = [UIImage imageNamed:@"4@2x.png"];break;
        case 5:dong6.image = [UIImage imageNamed:@"5@2x.png"];break;
        case 6:dong6.image = [UIImage imageNamed:@"6@2x.png"];break;
    }
    
    NSLog(@"res1---%d,res2---%d,res3---%d,res4---%d,res5---%d,res6---%d",result1,result2,result3,result4,result5,result6);
    
    NSString *str1 = [NSString stringWithFormat:@"%d",result1];
    NSString *str2 = [NSString stringWithFormat:@"%d",result2];
    NSString *str3 = [NSString stringWithFormat:@"%d",result3];
    NSString *str4 = [NSString stringWithFormat:@"%d",result4];
    NSString *str5 = [NSString stringWithFormat:@"%d",result5];
    NSString *str6 = [NSString stringWithFormat:@"%d",result6];

    
    
    
}

- (void)judgeAwardResult:(NSArray *)array
{
    NSMutableArray *array1 = [NSMutableArray arrayWithArray:array];
    
    NSMutableArray *dateMutablearray = [@[] mutableCopy];
    for (int i = 0; i < array.count; i ++) {
        
        NSString *string = array[i];
        
        NSMutableArray *tempArray = [@[] mutableCopy];
        
        [tempArray addObject:string];
        
        for (int j = i+1; j < array.count; j ++) {
            
            NSString *jstring = array[j];
            
            if([string isEqualToString:jstring]){
                
                [tempArray addObject:jstring];
                
                [array1 removeObjectAtIndex:j];
                j -= 1;
                
            }
            
        }
        
        [dateMutablearray addObject:tempArray];
        
    }
    
    NSLog(@"dateMutable:%@",dateMutablearray);
    
    
    
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
