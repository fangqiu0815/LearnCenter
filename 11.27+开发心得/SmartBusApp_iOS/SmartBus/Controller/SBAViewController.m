//
//  SBViewController.m
//  SmartBus
//
//  Created by 飞瞳凡想 on 14-5-6.
//  Copyright (c) 2014年 飞瞳凡想. All rights reserved.
//

#import "SBAViewController.h"
#import "SBABasicOperator.h"
#import "SBABusOperator.h"
/** 查询操作结果辅助封装 */
@interface SBAFlag : NSObject
/** 操作结果 */
@property (nonatomic,assign) BOOL flag;
@end

@implementation SBAFlag
@synthesize flag;
-(SBAFlag *) initWithBool:(BOOL)result{
    self = [super init];
    if (self) {
        self.flag = result;
    }
    return self;
}
@end

@interface SBAViewController ()

@property (nonatomic,strong) SBABusOperator *busOperator;
@property (nonatomic,strong) SBABasicOperator *basicOperator;
@property (nonatomic,strong) NSArray *trackBuses;
@property (nonatomic,assign) BOOL startListen;
@property (nonatomic,strong) SBAMapView *mapView;
@property (nonatomic,strong) UIImageView *wellCome;
@property (nonatomic,strong) NSThread *listen;

@end

@implementation SBAViewController

@synthesize mapView;

- (void)viewDidLoad
{
    [super viewDidLoad];
    /* 初始化数据操作 */
    _busOperator = [[SBABusOperator alloc]init];
    _basicOperator = [[SBABasicOperator alloc]init];
    /* 获取屏幕尺寸 */
    CGRect app =[UIScreen mainScreen].applicationFrame;
    /* 添加地图view */
    mapView = [[SBAMapView alloc]initWithFrame:app];
    mapView.dataSource = self;
    mapView.delegate = self;
    mapView.dColor = [UIColor whiteColor];
    mapView.shouldHiddenPosition = YES;
    mapView.shouldTouchEvent = YES;
    [self.view addSubview:mapView];
    /* 添加欢迎view */
    _wellCome = [[UIImageView alloc]initWithFrame:app];
    UIImage *image = [UIImage imageNamed:@"wellcome.jpg"];
    _wellCome.image = image;
    [self.view addSubview:_wellCome];
    /* 开启查询线程 */
    [NSThread detachNewThreadSelector:@selector(_checkMapData) toTarget:self withObject:nil];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

/** 查询地图数据 */
-(void) _checkMapData{
    /* 查询超时次数 */
    int count = 0;
    while (count < 3) {
        NSLog(@"Check Map : %d",count);
        if ([_basicOperator requestUpdate:@"0"]) {
            NSLog(@"Check Map Success");
            [self performSelectorOnMainThread:@selector(_reloadMapData) withObject:nil waitUntilDone:YES];
            break;
        }else{
            count++;
        }
    }
    if (count == 3) {
        NSLog(@"Check Map Fail");
         [self performSelectorOnMainThread:@selector(_fadeOut:) withObject:[[SBAFlag alloc] initWithBool:NO] waitUntilDone:YES];
    }
    
}
/** 刷新地图数据 */
-(void) _reloadMapData{
    NSLog(@"ReloadMapData Start");
    mapView.bground = [UIImage imageNamed:@"map.jpeg"];
    [mapView reloadAllData];
    [NSThread detachNewThreadSelector:@selector(_fadeOut:) toTarget:self withObject:[[SBAFlag alloc]initWithBool:YES]];
    NSLog(@"ReloadMapData Over");
}
/** 查询公交数据 */
- (void) _checkBusData:(NSString *)stopId{
    if((_startListen = [_busOperator requestTrackBusesNearStop:stopId])){
        NSLog(@"Reques Track Bus Success");
        NSLog(@"Listen Start");
        _trackBuses = [_busOperator getBuses];
    }else{
        NSLog(@"Reques Track Bus Fail");
    }
    while (_startListen) {
        NSLog(@"Listen ing");
        for (SBABus *bus in _trackBuses)
        if ([_busOperator requestBusData:bus.busId]) {
        [self performSelectorOnMainThread:@selector(reloadBusData:) withObject:[_busOperator getBusById:bus.busId] waitUntilDone:YES];
        }
        [NSThread sleepForTimeInterval:1];
    }
    NSLog(@"Listen Stop");
}
/** 刷新公交数据 */
-(void) reloadBusData:(SBABus *)bus{
    if (_startListen) {
        [mapView reloadBusData:bus];
    }
}
/**
 *显示提示信息
 * @param 需要显示的信息
 */
- (void)_showDialog:(NSString *)title{
    NSLog(@"Show Message : %@",title);
    UIAlertView * alertA= [[UIAlertView alloc] initWithTitle:title message:nil delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
    [alertA show];
}
/**
 * 淡出动画
 * @param 序执行动画view
 */
-(void) _fadeOut: (SBAFlag *)flag
{
    NSLog(@"FadeOut Start");
    CGContextRef context = UIGraphicsGetCurrentContext();
    [UIView beginAnimations:nil context:context];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    [UIView setAnimationDuration:1];
    [_wellCome setAlpha:0.0f];
    [UIView commitAnimations];
    if (!flag.flag) {
        [self performSelector:@selector(_showDialog:) withObject:@"获取地图数据失败，请检查网络连接" afterDelay:1];
    }
    NSLog(@"FadeOut Over");
}
#pragma mark -SBMapVietaSource

-(NSArray *) drawMapData:(SBAMapView *)mapView{
    return [_basicOperator getPositions];
}

-(NSArray *) drawLineData:(SBAMapView *)mapView{
    NSArray *lineData = [_basicOperator getLines];
    return lineData;
}

-(NSArray *) drawStopData:(SBAMapView *)mapView{
    return [_basicOperator getStops];
}

-(NSArray *) drawBusData:(SBAMapView *)mapView{
    return [_busOperator getBuses];
}

#pragma -mark SBMapViewDelegate

-(void) mapView:(SBAMapView *)mapView didSelectStop:(NSString *)stopId{
    NSLog(@"Did Select Stop : %@",stopId);
    [self reloadBusData:nil];
    _startListen = NO;
    [NSThread detachNewThreadSelector:@selector(_checkBusData:) toTarget:self withObject:stopId];

}
-(void) didSelectOutSide:(SBAMapView *)mapView{
    [self reloadBusData:nil];
    _startListen = NO;
}
@end
