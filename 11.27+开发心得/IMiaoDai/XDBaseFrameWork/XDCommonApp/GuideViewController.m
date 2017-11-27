//
//  GuideViewController.m
//  XDCommonApp
//
//  Created by XD-XY on 2/13/14.
//  Copyright (c) 2014 XD-XY. All rights reserved.
//

#import "GuideViewController.h"
#import "XDHeader.h"
#import "XDTools.h"
@interface GuideViewController ()

@end

@implementation GuideViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    self.scrollView = [[UIScrollView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    _scrollView.contentSize = CGSizeMake(UI_SCREEN_WIDTH*GUIDECOUNT, UI_SCREEN_HEIGHT);
    _scrollView.showsHorizontalScrollIndicator =NO;
    _scrollView.pagingEnabled =YES;
    _scrollView.bounces =NO;
    [self.view addSubview:_scrollView];
    
    for (int i=0;i<GUIDECOUNT;i++){
        UIImageView * imageView = [[UIImageView alloc] initWithFrame:CGRectMake(i*UI_SCREEN_WIDTH, 0, UI_SCREEN_WIDTH, UI_SCREEN_HEIGHT)];
        if (iPhone5){
            UIImage * img = [UIImage imageNamed:[NSString stringWithFormat:@"guide_page_%d_i5",i+1]];
            imageView.image = img;
            [_scrollView addSubview:imageView];
        }else{
            UIImage * img = [UIImage imageNamed:[NSString stringWithFormat:@"guide_page_%d",i+1]];
            imageView.image = img;
            [_scrollView addSubview:imageView];
        }
    }
    UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(20+UI_SCREEN_WIDTH*(GUIDECOUNT-1), 400, UI_SCREEN_WIDTH-40, 40);
    button.backgroundColor = [UIColor blackColor];
    [button addTarget:self action:@selector(enter) forControlEvents:UIControlEventTouchUpInside];
    [_scrollView addSubview:button];
    
}

-(void)enter
{
    [[NSUserDefaults standardUserDefaults] setBool:YES forKey:ISFIRSTSTART];
    [[XDTools appDelegate] reSetRootView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
