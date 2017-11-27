//
//  LaunchViewController.m
//  HWMovie
//
//  Created by hyrMac on 15/7/27.
//  Copyright (c) 2015年 hyrMac. All rights reserved.
//

#import "LaunchViewController.h"
#import "common.h"
#import "MainTabBarController.h"

@interface LaunchViewController ()
{
//    UIImageView *imageView;
    NSInteger index;
    NSMutableArray *imageArray;
}

@end

@implementation LaunchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self _createImageView];
}

- (void)_createImageView {
    UIImageView *backImageView = [[UIImageView alloc] initWithFrame:self.view.bounds];
    backImageView.image = [UIImage imageNamed:@"Default-568h@2x.png"];
    [self.view addSubview:backImageView];
    
    index = 0;
    NSInteger count = 24;
    CGFloat width = kWidth/4;
    CGFloat height = kHeight/6;
    
    CGFloat x = 0;
    CGFloat y = 0;
    
//    NSInteger i = 0;
    
    imageArray = [NSMutableArray array];
    for (NSInteger i = 0; i < count; i++) {
        
        if (i < 4) {
            x = (i%4)*width;
            y = (i/4)*height;
        } else if (i <= 8) {
            x = 3*width;
            y = (i-3)*height;
        } else if (i <= 11) {
            x = (11-i)*width;
            y = 5*height;
        } else if (i <= 15) {
            x = 0;
            y = (16-i)*height;
        } else if (i <= 17) {
            x = width*(i-15);
            y = height;
        } else if (i <= 20) {
            x = 2*width;
            y = (i-16)*height;
        } else if (i <= 23) {
            x = width;
            y = (25-i)*height;
        }
        
//        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake((i%4)*width, (i/4)*height, width, height)];
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(x, y, width, height)];
        NSString *imageName = [NSString stringWithFormat:@"%ld@2x.png",i+1];
        imageView.image = [UIImage imageNamed:imageName];
        imageView.alpha = 0;
        [self.view addSubview:imageView];
        
        [imageArray addObject:imageView];
        
//        x = (i%4)*width;
//        y = (i/4)*height;
    }
    
    [self startAnimation1];
}

- (void)startAnimation1 {
    if (index >= imageArray.count) {
        // 进入主界面
        MainTabBarController *mainTabBarController = [[MainTabBarController alloc] init];
        self.view.window.rootViewController = mainTabBarController;
        return;
    }
    UIImageView *imageView = imageArray[index];
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.3];  // 0.3
    imageView.alpha = 1;
    [UIView commitAnimations];
    index++;
    [self performSelector:@selector(startAnimation1) withObject:self afterDelay:0.3]; // 0.3
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
