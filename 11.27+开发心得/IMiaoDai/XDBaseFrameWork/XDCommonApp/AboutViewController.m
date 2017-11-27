//
//  AboutViewController.m
//  XDCommonApp
//
//  Created by XD-XY on 8/18/14.
//  Copyright (c) 2014 XD-XY. All rights reserved.
//

#import "AboutViewController.h"
#import "XDTools.h"
#import "XDHeader.h"

@interface AboutViewController ()

@end

@implementation AboutViewController

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
    

    if ([_type isEqualToString:@"about"]) {
        UIImageView * iv = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"about"]];
        iv.frame = CGRectMake(0, 53, UI_SCREEN_WIDTH, 391/2.0f);
        [self.contentView addSubview:iv];
    }else{
        if (![XDTools NetworkReachable]){

        }else{
            UIWebView * webView = [[UIWebView alloc] initWithFrame:self.contentView.bounds];
            [webView setBackgroundColor:[UIColor clearColor]];
            [webView setOpaque:NO];
            [self.contentView addSubview:webView];
            NSURL * url =[NSURL URLWithString:[NSString stringWithFormat:@"%@",self.urlString]];
            NSURLRequest *request =[NSURLRequest requestWithURL:url];
            [webView loadRequest:request];
            [webView setUserInteractionEnabled:YES];
        }
    }
    

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
