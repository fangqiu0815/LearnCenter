//
//  TuWenViewController.m
//  XDCommonApp
//
//  Created by xindao on 14-8-19.
//  Copyright (c) 2014年 XD-XY. All rights reserved.
//

#import "TuWenViewController.h"

@interface TuWenViewController ()

@end

@implementation TuWenViewController

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

    self.titleLabel.text = self.titleString;
    CGRect trect = self.titleLabel.frame;
    trect.origin.x = 50;
    trect.size.width =220;
    self.titleLabel.frame = trect;

    UIWebView * web = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, UI_SCREEN_WIDTH, UI_MAINSCREEN_HEIGHT-UI_NAVIGATION_BAR_HEIGHT)];
    web.delegate = self;
    if (_urlStr.length) {
        [web loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:_urlStr]]];
    }else{
        [web loadHTMLString:_htmlStr baseURL:nil];
    }
    [self.contentView addSubview:web];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
