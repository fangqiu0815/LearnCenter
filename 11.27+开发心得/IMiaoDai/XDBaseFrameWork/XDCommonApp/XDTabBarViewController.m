//
//  XDTabBarViewController.m
//  XDCommonApp
//
//  Created by XD-XY on 2/13/14.
//  Copyright (c) 2014 XD-XY. All rights reserved.
//

#import "XDTabBarViewController.h"
#import "FirstViewController.h"
#import "SecondViewController.h"
#import "ThirdViewController.h"
#import "FourthViewController.h"
#import "FifthViewController.h"
#import "LoginViewController.h"
#import "XDHeader.h"
#import "XDTools.h"
#import "UserInfo.h"

#define btn_tag 10001

@interface XDTabBarViewController ()

@end

@implementation XDTabBarViewController
    DEFINE_SINGLETON_FOR_CLASS(XDTabBarViewController)

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
    
    FirstViewController * vc1 = [[FirstViewController alloc] init];
    SecondViewController * vc2 = [[SecondViewController alloc] init];
    ThirdViewController * vc3 = [[ThirdViewController alloc] init];
    FourthViewController * vc4 = [[FourthViewController alloc] init];
    FifthViewController * vc5 = [[FifthViewController alloc] init];
    
    switch (TABBARCOUNT){
        case 3:
            self.viewControllers = @[vc1,vc2,vc3];
            
            break;
        case 4:
            self.viewControllers = @[vc1,vc2,vc3,vc4];
            break;
        case 5:
            self.viewControllers = @[vc1,vc2,vc3,vc4,vc5];
            break;
        default:
            break;
    }
    
    self.bgView = [[UIView alloc] initWithFrame:CGRectMake(0,0, UI_SCREEN_WIDTH, UI_TAB_BAR_HEIGHT)];
    _bgView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"tab_Bg"]];
    [self.tabBar addSubview:_bgView];

    NSArray * arr = [NSArray arrayWithObjects:@"首页",@"我的",@"更多", nil];
    for (int i = 0; i < TABBARCOUNT; i ++)
	{
		UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
		button.frame = CGRectMake(i*UI_SCREEN_WIDTH/TABBARCOUNT,0,UI_SCREEN_WIDTH/TABBARCOUNT,UI_TAB_BAR_HEIGHT);
		button.enabled = i==DEFAULTSELECTINDEX?NO:YES;
//        [button setTitle:arr[i] forState:UIControlStateNormal];
//        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [button setBackgroundImage:[UIImage imageNamed:[NSString stringWithFormat:@"tab_button%d_notOn",i+1]] forState:UIControlStateNormal];
        [button setBackgroundImage:[UIImage imageNamed:[NSString stringWithFormat:@"tab_button%d_on",i+1]] forState:UIControlStateHighlighted];
        [button setBackgroundImage:[UIImage imageNamed:[NSString stringWithFormat:@"tab_button%d_on",i+1]] forState:UIControlStateDisabled];
        [button addTarget:self action:@selector(chooseTabBar:) forControlEvents:UIControlEventTouchDown];
		button.adjustsImageWhenHighlighted =NO;
        button.tag = btn_tag+i;
        if (!button.enabled){
            [self setSelectedIndex:i];
            _beforeIndex = i;
            _presentIndex = i;
        }
		[_bgView addSubview:button];
	}

    self.reminder_IV = [[UIImageView alloc] initWithFrame:CGRectMake(190,5, 10, 10)];
    _reminder_IV.backgroundColor = [UIColor redColor];
    _reminder_IV.layer.cornerRadius = 5;
    _reminder_IV.layer.masksToBounds = YES;
    [_bgView addSubview:_reminder_IV];
    _reminder_IV.hidden = YES;
}

-(void)chooseTabBar:(UIButton *)sender
{
    _presentIndex = sender.tag-btn_tag;
    [self confirmSelectTabBar:_presentIndex];
    [self setSelectedIndex:_presentIndex];
    _beforeIndex = _presentIndex;
}

-(void)confirmSelectTabBar:(NSInteger)selectIndex
{
    for (UIButton * button in [_bgView subviews]){
        if ([button isKindOfClass:[UIButton class]]){
            button.enabled= button.tag==selectIndex+10001?NO:YES;
        }
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end



@implementation UIViewController (Create_UI_Method)

UITextField *creatXRTextField(NSString *placeTitle,CGRect frame){
    UITextField *textField=[[UITextField alloc]initWithFrame:frame];
    textField.placeholder =placeTitle;
    textField.borderStyle = UITextBorderStyleRoundedRect;
//    textField.clearsOnBeginEditing =YES;
    textField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    return textField;
}

UIButton *creatXRButton(CGRect frame,NSString *title,UIImage*normalImage,UIImage *hightImage){
    UIButton *bnt=[UIButton buttonWithType:UIButtonTypeCustom];
    [bnt setFrame:frame];
    [bnt setTitle:title forState:UIControlStateNormal];
    bnt.titleLabel.text =title;
    [bnt setBackgroundImage:normalImage forState:UIControlStateNormal];
    [bnt setBackgroundImage:hightImage forState:UIControlStateHighlighted];
    [bnt setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    return bnt;
}

UILabel *creatXRLable(NSString *name ,CGRect frame){
    UILabel *lable=[[UILabel alloc]initWithFrame:frame];
    [lable setText:name];
    lable.backgroundColor=[UIColor clearColor];
    lable.lineBreakMode=NSLineBreakByWordWrapping;
    lable.numberOfLines= 0;
    lable.textAlignment=NSTextAlignmentCenter;
    lable.font=[UIFont systemFontOfSize:20.0f];
    return lable;
}
UIImageView *creatXRImageView(CGRect frame,UIImage *image){
    UIImageView *imageView=[[UIImageView alloc]initWithFrame:frame];
    imageView.backgroundColor=[UIColor clearColor];
    imageView.userInteractionEnabled =YES;
    imageView.image=image;
    return imageView;
}

@end
