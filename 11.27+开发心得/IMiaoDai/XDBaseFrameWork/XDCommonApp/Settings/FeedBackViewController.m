//
//  FeedBackViewController.m
//  XDCommonApp
//
//  Created by wanglong8889@126.com on 14-6-12.
//  Copyright (c) 2014年 XD-XY. All rights reserved.
//

#import "FeedBackViewController.h"

@interface FeedBackViewController ()

@end

@implementation FeedBackViewController

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
    
    self.titleLabel.text = @"意见反馈";
    
    
    backScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, UI_SCREEN_WIDTH, UI_MAINSCREEN_HEIGHT - UI_NAVIGATION_BAR_HEIGHT)];
    backScrollView.delegate = self;
    backScrollView.contentSize = CGSizeMake(UI_SCREEN_WIDTH, 515);
    backScrollView.pagingEnabled = NO;
    [self.contentView addSubview:backScrollView];
    
    [XDTools addAlabelForAView:backScrollView withText:@"若有任何错误或者改进意见，请您告诉我们，不胜感谢!" frame:CGRectMake(22, 15, 280, 40) font:[UIFont systemFontOfSize:16] textColor:[UIColor blackColor]];
    
    UIView * viewBg = [[UIView alloc] initWithFrame:CGRectMake(20, 65, 280, 200)];
    viewBg.backgroundColor = [UIColor whiteColor];
    viewBg.layer.borderColor = RGBA(214, 214, 217, 1).CGColor;
    viewBg.layer.borderWidth = 1.0f;
    viewBg.layer.masksToBounds = YES;
    viewBg.layer.cornerRadius = 6.0;
    [backScrollView addSubview:viewBg];
    
    
    placeholderLB = [XDTools addAlabelForAView:backScrollView withText:@"请输入您的宝贵意见" frame:CGRectMake(30, 65, 200, 30) font:[UIFont systemFontOfSize:15] textColor:[UIColor grayColor]];
    
    replyTV = [[UITextView alloc] initWithFrame:CGRectMake(20, 65, 280, 200)];
    replyTV.keyboardType = UIReturnKeyDone;
    replyTV.font = [UIFont systemFontOfSize:15];
    replyTV.backgroundColor = [UIColor clearColor];
    replyTV.delegate = self;
    replyTV.layer.borderColor = RGBA(214, 214, 217, 1).CGColor;
    replyTV.layer.borderWidth = 1.0f;
    replyTV.layer.masksToBounds = YES;
    replyTV.layer.cornerRadius = 6.0;
    [backScrollView addSubview:replyTV];
    
    UIButton * btn = [XDTools getAButtonWithFrame:CGRectMake(175/2.0f, 315, 145, 41) nomalTitle:nil hlTitle:nil titleColor:nil bgColor:nil nbgImage:@"getUp_nor" hbgImage:@"getUp_sel" action:@selector(putUp) target:self buttonTpye:UIButtonTypeCustom];
    [backScrollView addSubview:btn];
}

- (void)putUp{
    if (!replyTV.text.length) {
        [XDTools showTips:@"内容不能为空" toView:self.view];
        return;
    }
    if ([XDTools NetworkReachable])
    {
        
        NSDictionary * dic = @{@"deviceType": @"IOS",
                               @"systemVersion":[[UIDevice currentDevice] systemVersion],
                               @"deviceSystem":[self doDevicePlatform],
                               @"back_content":replyTV.text};
        
        
        
        
        __weak ASIHTTPRequest *request =[XDTools postRequestWithDict:dic API:API_FEEDBACK];
        
        [request setCompletionBlock:^{
            
            [XDTools hideProgress:self.view];
            
            NSDictionary *tempDic = [XDTools  JSonFromString:[request responseString]];
            
            if ([[tempDic objectForKey:@"result"] intValue] == 1)
            {
                [XDTools showTips:@"提交成功" toView:self.view];
                
                [self performSelector:@selector(backPrePage) withObject:nil afterDelay:0.5];
            }
            else
            {
                [XDTools showTips:[tempDic objectForKey:@"msg"] toView:self.view];
            }
        }];
        
        [request setFailedBlock:^{
            [XDTools hideProgress:self.view];
            NSError *error = [request error];
            DDLOG_CURRENT_METHOD;
            DDLOG(@"error=%@",error);
        }];
        
        [request startAsynchronous];
        
    }
    else
    {
        [XDTools showTips:brokenNetwork toView:self.view];
    }
    
}

- (NSString*)doDevicePlatform
{
    size_t size;
    int nR = sysctlbyname("hw.machine", NULL, &size, NULL, 0);
    char *machine = (char *)malloc(size);
    nR = sysctlbyname("hw.machine", machine, &size, NULL, 0);
    NSString *platform = [NSString stringWithCString:machine encoding:NSUTF8StringEncoding];
    free(machine);
    
    if ([platform isEqualToString:@"iPhone1,1"]) {
        
        platform = @"iPhone";
        
    } else if ([platform isEqualToString:@"iPhone1,2"]) {
        
        platform = @"iPhone 3G";
        
    } else if ([platform isEqualToString:@"iPhone2,1"]) {
        
        platform = @"iPhone 3GS";
        
    } else if ([platform isEqualToString:@"iPhone3,1"]||[platform isEqualToString:@"iPhone3,2"]||[platform isEqualToString:@"iPhone3,3"]) {
        
        platform = @"iPhone 4";
        
    } else if ([platform isEqualToString:@"iPhone4,1"]) {
        
        platform = @"iPhone 4S";
        
    } else if ([platform isEqualToString:@"iPhone5,1"]||[platform isEqualToString:@"iPhone5,2"]) {
        
        platform = @"iPhone 5";
        
    }else if ([platform isEqualToString:@"iPhone5,3"]||[platform isEqualToString:@"iPhone5,4"]) {
        
        platform = @"iPhone 5C";
        
    }else if ([platform isEqualToString:@"iPhone6,2"]||[platform isEqualToString:@"iPhone6,1"]) {
        
        platform = @"iPhone 5S";
        
    }else if ([platform isEqualToString:@"iPod4,1"]) {
        
        platform = @"iPod touch 4";
        
    }else if ([platform isEqualToString:@"iPod5,1"]) {
        
        platform = @"iPod touch 5";
        
    }else if ([platform isEqualToString:@"iPod3,1"]) {
        
        platform = @"iPod touch 3";
        
    }else if ([platform isEqualToString:@"iPod2,1"]) {
        
        platform = @"iPod touch 2";
        
    }else if ([platform isEqualToString:@"iPod1,1"]) {
        
        platform = @"iPod touch";
        
    } else if ([platform isEqualToString:@"iPad3,2"]||[platform isEqualToString:@"iPad3,1"]) {
        
        platform = @"iPad 3";
        
    } else if ([platform isEqualToString:@"iPad2,2"]||[platform isEqualToString:@"iPad2,1"]||[platform isEqualToString:@"iPad2,3"]||[platform isEqualToString:@"iPad2,4"]) {
        
        platform = @"iPad 2";
        
    }else if ([platform isEqualToString:@"iPad1,1"]) {
        
        platform = @"iPad 1";
        
    }else if ([platform isEqualToString:@"iPad2,5"]||[platform isEqualToString:@"iPad2,6"]||[platform isEqualToString:@"iPad2,7"]) {
        
        platform = @"ipad mini";
        
    } else if ([platform isEqualToString:@"iPad3,3"]||[platform isEqualToString:@"iPad3,4"]||[platform isEqualToString:@"iPad3,5"]||[platform isEqualToString:@"iPad3,6"]) {
        
        platform = @"ipad 3";
        
    }
    
    return platform;
}

#pragma mark - UITextView Delegate
-(BOOL)textViewShouldBeginEditing:(UITextView *)textView
{
    [UIView animateWithDuration:.3 animations:^{
        backScrollView.contentOffset = CGPointMake(0, 70);
    }];
    
    return YES;
}

-(void)textViewDidChange:(UITextView *)textView
{
    if (IS_NOT_EMPTY(textView.text)){
        placeholderLB.hidden = YES;
    }else{
        placeholderLB.hidden = NO;
    }
    
}

-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if (range.length == 1){
        return YES;
    }
    
    if ([@"\n" isEqualToString:text] == YES)
    {
        [textView resignFirstResponder];
        [UIView animateWithDuration:.3 animations:^{
            backScrollView.contentOffset = CGPointMake(0, 0);
        }];
        
        return NO;
    }
    
    if ([textView.text length]<150){
        return YES;
    }
    return NO;
}


-(void)backPrePage{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    [replyTV resignFirstResponder];
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
