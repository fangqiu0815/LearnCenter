//
//  XDBaseViewController.m
//  XDCommonApp
//
//  Created by XD-XY on 2/12/14.
//  Copyright (c) 2014 XD-XY. All rights reserved.
//

#import "XDBaseViewController.h"
#import "XDHeader.h"

#define LEFTBUTTONFRAME(aHeight) CGRectMake(0,0+aHeight,44,44)

@interface XDBaseViewController ()

@end

@implementation XDBaseViewController

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
    
    self.navigationController.navigationBar.hidden =YES;
    aHeight = 0;
    if (IOS7){
        SETSTATUSBARTEXTBLACKCOLORE(NO);
        aHeight =UI_STATUS_BAR_HEIGHT;
        self.navigationBarView = [[UIView alloc] initWithFrame:CGRectMake(0,0,UI_SCREEN_WIDTH, UI_NAVIGATION_BAR_HEIGHT+UI_STATUS_BAR_HEIGHT)];
        _navigationBarBg = [[UIImageView alloc] init];
        _navigationBarBg.frame = CGRectMake(0, 0, UI_SCREEN_WIDTH, UI_NAVIGATION_BAR_HEIGHT+UI_STATUS_BAR_HEIGHT);
        _navigationBarBg.image = [UIImage imageNamed:NAVIGATIONBGIMAGEIOS7];
        [_navigationBarView addSubview:_navigationBarBg];
        [self.view addSubview:_navigationBarView];
        
        self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, UI_STATUS_BAR_HEIGHT, UI_SCREEN_WIDTH, UI_NAVIGATION_BAR_HEIGHT)];
        _titleLabel.textColor = NAVIGATIONTITLECOLORE;
        _titleLabel.backgroundColor = [UIColor clearColor];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.font = [UIFont systemFontOfSize:20.0f];
        [_navigationBarBg addSubview:_titleLabel];
    }else{
        self.navigationBarView = [[UIView alloc] initWithFrame:CGRectMake(0,0,UI_SCREEN_WIDTH, UI_NAVIGATION_BAR_HEIGHT)];
        _navigationBarBg = [[UIImageView alloc] init];
        _navigationBarBg.frame = CGRectMake(0, 0, UI_SCREEN_WIDTH, UI_NAVIGATION_BAR_HEIGHT);
        _navigationBarBg.image = [UIImage imageNamed:NAVIGATIONBGIMAGE];
        [_navigationBarView addSubview:_navigationBarBg];
        [self.view addSubview:_navigationBarView];
        
        self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0,0, UI_SCREEN_WIDTH, UI_NAVIGATION_BAR_HEIGHT)];
        _titleLabel.backgroundColor = [UIColor clearColor];
        _titleLabel.textColor = NAVIGATIONTITLECOLORE;
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.font = NAVIGATIONTITLEFONT;
        [_navigationBarBg addSubview:_titleLabel];
    }
   [self createLeftBtn];
    
    self.contentView= [[UIView alloc] initWithFrame:CGRectMake(0, height_y(_navigationBarView), UI_SCREEN_WIDTH, UI_MAINSCREEN_HEIGHT-UI_NAVIGATION_BAR_HEIGHT)];
    _contentView.backgroundColor = BGCOLOR;
    
    [self.view addSubview:_contentView];
}

-(void)createLeftBtn
{
    self.leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _leftBtn.frame = LEFTBUTTONFRAME(aHeight);
    [_leftBtn setBackgroundImage:[UIImage imageNamed:@"backBtn_image"] forState:UIControlStateNormal];
    [_leftBtn addTarget:self action:@selector(backPrePage) forControlEvents:UIControlEventTouchUpInside];
    _leftBtn.adjustsImageWhenHighlighted =NO;
    [_navigationBarView addSubview:_leftBtn];
}

- (void)backPrePage
{
    DDLOG_CURRENT_METHOD;
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)changeFrameWhenHiddenNavigationBar
{
    self.navigationBarView.hidden=YES;
    if (IOS7){
        UIView * view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, UI_SCREEN_WIDTH, UI_STATUS_BAR_HEIGHT)];
        view.backgroundColor  = [UIColor colorWithPatternImage:[UIImage imageNamed:STATUSBARBG]];
        [self.view addSubview:view];
        _contentView.frame= CGRectMake(0,height_y(view),UI_SCREEN_WIDTH, UI_MAINSCREEN_HEIGHT);
    }else{
        _contentView.frame= CGRectMake(0,0,UI_SCREEN_WIDTH, UI_MAINSCREEN_HEIGHT);
    }

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
