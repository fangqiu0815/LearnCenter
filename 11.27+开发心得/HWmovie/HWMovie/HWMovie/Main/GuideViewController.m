//
//  GuideViewController.m
//  HWMovie
//
//  Created by hyrMac on 15/7/27.
//  Copyright (c) 2015年 hyrMac. All rights reserved.
//

#import "GuideViewController.h"
#import "common.h"
#import "LaunchViewController.h"

@interface GuideViewController ()

@end

@implementation GuideViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self _createViews];
}

- (void)_createViews {
    _enterButton.hidden = YES;
    
    for (NSInteger i = 0; i < 5; i++) {
        NSString *imageName = [NSString stringWithFormat:@"guide%ld@2x.png",i+1];
        NSString *pageImageName = [NSString stringWithFormat:@"guideProgress%ld@2x.png",i+1];
        
        UIImageView *imageView1 = [[UIImageView alloc] initWithFrame:CGRectMake(kWidth*i, 0, kWidth, kHeight)];
        imageView1.image = [UIImage imageNamed:imageName];
        
        [_guideScrollView addSubview:imageView1];
        
        UIImageView *imageView2 = [[UIImageView alloc] initWithFrame:CGRectMake(kWidth*i+(kWidth-173)/2, kHeight-50, 173, 26)];
        imageView2.image = [UIImage imageNamed:pageImageName];
        
        [_guideScrollView addSubview:imageView2];
    }
    
    _guideScrollView.delegate = self;
    _guideScrollView.contentSize = CGSizeMake(kWidth*5, kHeight);
    _guideScrollView.pagingEnabled = YES;
    _guideScrollView.bounces = NO;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    NSInteger index = _guideScrollView.contentOffset.x/kWidth;
    if (index == 4) {
        _enterButton.hidden = NO;
    } else {
        _enterButton.hidden = YES;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)btnAction:(id)sender {
   
    LaunchViewController *lun = [[LaunchViewController alloc] init];
    self.view.window.rootViewController = lun;
    
}
@end
