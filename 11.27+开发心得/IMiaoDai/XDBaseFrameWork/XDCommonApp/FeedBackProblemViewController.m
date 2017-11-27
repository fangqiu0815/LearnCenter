//
//  FeedBackProblemViewController.m
//  XDCommonApp
//
//  Created by xindao on 14-8-15.
//  Copyright (c) 2014年 XD-XY. All rights reserved.
//

#import "FeedBackProblemViewController.h"

@interface FeedBackProblemViewController ()

@end

@implementation FeedBackProblemViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillShow:)
                                                 name:UIKeyboardWillShowNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillHide:)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillChangeFrameNotification object:nil];
}

-(void)viewWillDisappear:(BOOL)animated
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    self.titleLabel.text = @"问题反馈";

    [self initViews];
}


-(void)initViews
{
    
    myScrollView  = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, 320, self.contentView.frame.size.height-0.5)];
    myScrollView.backgroundColor  = [UIColor clearColor];
    myScrollView.contentSize = CGSizeMake(320, self.contentView.frame.size.height);
    myScrollView.showsHorizontalScrollIndicator = NO;
    myScrollView.showsVerticalScrollIndicator = NO;
    myScrollView.delegate = self;
    [self.contentView addSubview:myScrollView];
    
//    UILabel * kindLB = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, 300, 32)];
//    kindLB.backgroundColor = [UIColor clearColor];
//    kindLB.font = [UIFont systemFontOfSize:16];
//    kindLB.textColor = UIColorFromRGB(0x6a6a6a);
//    kindLB.text = @"问题类型";
//    [scrollView addSubview:kindLB];
//
//    kindView = [[UIView alloc] initWithFrame:CGRectMake(kindLB.frame.origin.x, height_y(kindLB), 300, 80)];
//    kindView.backgroundColor = [UIColor whiteColor];
//    kindView.layer.borderColor = [UIColorFromRGB(0xcacaca) CGColor];
//    kindView.layer.borderWidth = 0.5;
//    [scrollView addSubview:kindView];

    UILabel * depictLB = [[UILabel alloc] initWithFrame:CGRectMake(10, height_y(kindView), 300, 32)];
    depictLB.backgroundColor = [UIColor clearColor];
    depictLB.font = [UIFont systemFontOfSize:16];
    depictLB.textColor = UIColorFromRGB(0x6a6a6a);
    depictLB.text = @"问题描述（必填）";
    [myScrollView addSubview:depictLB];

    UIView * bgView = [[UIView alloc] initWithFrame:CGRectMake(10, height_y(depictLB), 300, 80)];
    bgView.backgroundColor = [UIColor whiteColor];
    [myScrollView addSubview:bgView];

    placeHolderLB = [XDTools addAlabelForAView:bgView withText:@"请详细描述问题内容" frame:CGRectMake(3,5,200,20) font:[UIFont systemFontOfSize:14] textColor:RGBA(200, 200, 204, 1)];


    inputView = [[UITextView alloc] initWithFrame:CGRectMake(10, height_y(depictLB), 300, 80)];
    inputView.backgroundColor = [UIColor clearColor];
    inputView.layer.borderColor = [UIColorFromRGB(0xcacaca) CGColor];
    inputView.layer.borderWidth = 0.5;
    inputView.delegate =self;
    inputView.font = [UIFont systemFontOfSize:14];
    [myScrollView addSubview:inputView];

    UIButton * okBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    okBtn.frame = CGRectMake(10, height_y(inputView)+20, 300, 40);
    [okBtn setTitle:@"提交反馈" forState:UIControlStateNormal];
    okBtn.titleLabel.font = [UIFont systemFontOfSize:16];
    okBtn.backgroundColor = UIColorFromRGB(0xf28d01);
    [okBtn addTarget:self action:@selector(okBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    okBtn.adjustsImageWhenHighlighted = NO;
    [myScrollView addSubview:okBtn];

    [self initKindsButtons:kindView];
//    [self initInPutTextView:inputView];
    
    topView = [[UIView alloc] initWithFrame:CGRectMake(0, self.contentView.frame.size.height, 320, 50)];
    topView.backgroundColor = RGBA(44, 43, 42, 1.0);
    
    UIButton *canBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    canBtn.frame = CGRectMake(15, 15, 44, 30);
    canBtn.titleLabel.font = [UIFont systemFontOfSize:18.5];
    [canBtn setTitle:@"取消" forState:UIControlStateNormal];
    [canBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [canBtn addTarget:self action:@selector(cancelEditView) forControlEvents:UIControlEventTouchUpInside];
    
    
    [topView addSubview:canBtn];
    
    
    UIButton *sureBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    sureBtn.frame = CGRectMake(topView.frame.size.width-44-15, 15, 44, 30);
    [sureBtn setTitle:@"完成" forState:UIControlStateNormal];
    sureBtn.titleLabel.font = [UIFont systemFontOfSize:18.5];
    [sureBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [sureBtn addTarget:self action:@selector(sureAction) forControlEvents:UIControlEventTouchUpInside];
    [topView addSubview:sureBtn];
    
//    [self.contentView addSubview:topView];
}

-(void)initKindsButtons:(UIView *)view
{
    NSArray * array = @[@"软件问题",@"物流信息",@"商品信息",@"退换货",@"其他问题"];
    for (int i = 0 ;i<5;i++){
        UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(33/2.0f+(81.5+10)*(i%3), 24/2.0f+(22.5+24/2.0f)*(i/3), 81.5, 22.5);

        button.titleLabel.font = [UIFont systemFontOfSize:13.5];
        button.titleLabel.textAlignment = NSTextAlignmentCenter;
        [button setTitleColor:UIColorFromRGB(0x656565) forState:UIControlStateNormal];
        [button setTitleColor:UIColorFromRGB(0xef8b02) forState:UIControlStateDisabled];
        [button setTitle:[array objectAtIndex:i] forState:UIControlStateNormal];
        [button addTarget:self action:@selector(chooseKind:) forControlEvents:UIControlEventTouchUpInside];
        button.layer.borderWidth = 0.5;
        button.layer.borderColor = [UIColorFromRGB(0xcbcbcb) CGColor];
        button.tag = 1000+i;
        [kindView addSubview:button];

    }
}


-(void)chooseKind:(UIButton *)button
{
    isClicked = YES;
    for (UIButton * view in kindView.subviews){
        if ([view isKindOfClass:[UIButton class]]){
            if (button.tag == view.tag){
                button.enabled = NO;
                button.layer.borderColor = [UIColorFromRGB(0xef8b02) CGColor];
            }else{
                view.enabled = YES;
                view.layer.borderColor = [UIColorFromRGB(0xcbcbcb) CGColor];
            }
        }
    }
}


#pragma mark 点击提交按钮
-(void)okBtnClick:(UIButton *)button
{
//    if (!isClicked) {
//        [XDTools showTips:@"请选择反馈类型" toView:self.view];
//        return;
//    }
    [inputView resignFirstResponder];

    if (!inputView.text.length) {
        [XDTools showTips:@"反馈内容不能为空" toView:self.view];
        return;
    }
    if (inputView.text.length < 10) {
        [XDTools showTips:@"最少10个字符哦" toView:self.view];
        return;
    }
    if ([XDTools NetworkReachable])
    {

        NSMutableDictionary * dic = [[NSMutableDictionary alloc] init];
        dic = [NSMutableDictionary dictionaryWithDictionary:@{@"feedback": inputView.text}];

        if (ISLOGING) {
            NSDictionary * infoDic = [[NSUserDefaults standardUserDefaults] objectForKey:kMMyUserInfo];
            [dic setObject:infoDic[@"uid"] forKey:@"uid"];
            [dic setObject:infoDic[@"token"] forKey:@"token"];
            [dic setObject:infoDic[@"userName"] forKey:@"userName"];
        }

        ASIHTTPRequest *request = [XDTools postRequestWithDict:dic API:API_FEEDBACK];
        __weak ASIHTTPRequest * mrequest = request;

        [request setCompletionBlock:^{

            [XDTools hideProgress:self.contentView];

            NSDictionary *tempDic = [XDTools  JSonFromString:[mrequest responseString]];

            if ([[tempDic objectForKey:@"result"] intValue] == 0)
            {
                [XDTools showTips:@"提交成功" toView:self.view];
                [self performSelector:@selector(backPrePage) withObject:nil afterDelay:1];
            }
            else
            {
                [XDTools showTips:[tempDic objectForKey:@"msg"] toView:self.view];
            }
        }];

        [request setFailedBlock:^{
            [XDTools hideProgress:self.contentView];
            NSError *error = [mrequest error];
            DDLOG_CURRENT_METHOD;
            DDLOG(@"error=%@",error);
            if (mrequest.error.code == 2) {
                [XDTools showTips:@"网络请求超时" toView:self.view];
            }
        }];
        [XDTools showProgress:self.contentView];
        [request startAsynchronous];

    }
    else
    {
        [XDTools showTips:brokenNetwork toView:self.view];
    }

}

- (void)textViewDidChange:(UITextView *)textView{
    if (textView.text.length) {
        placeHolderLB.hidden = YES;
    }else{
        placeHolderLB.hidden = NO;
    }
}



-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{

    if (range.length == 1){
        return YES;
    }

    if ([@"\n" isEqualToString:text] == YES)
    {
        //        [textView resignFirstResponder];
        //        [UIView animateWithDuration:.3 animations:^{
        //            backScrollView.contentOffset = CGPointMake(0, 0);
        //        }];
        return NO;
    }

    if ([textView.text length]<200){
        return YES;
    }
    return NO;
}

-(void)cancelEditView
{
    [inputView resignFirstResponder];
}
-(void)sureAction
{
    [self cancelEditView];
    
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if (scrollView == myScrollView) {
        [inputView resignFirstResponder];
    }
}

//键盘的动作处理
-(void) keyboardWillShow:(NSNotification *)note{
    NSLog(@"keyboardWillShow");
    
    NSDictionary * userInfo = [note userInfo];
    NSValue* aValue = [userInfo objectForKey:UIKeyboardFrameEndUserInfoKey];
    CGRect keyboardRect = [aValue CGRectValue];
    
//    scrollView.contentSize = CGSizeMake(320, self.contentView.frame.size.height+100);
//    [UIView animateWithDuration:0.25 animations:^{
//        scrollView.contentOffset = CGPointMake(0, 100);
//        topView.frame = CGRectMake(0, self.contentView.frame.size.height-keyboardRect.size.height-50, UI_SCREEN_WIDTH, 50);
//    }];
}

-(void) keyboardWillHide:(NSNotification *)note{
    NSLog(@"keyboardWillHide");
    
//    scrollView.contentSize = CGSizeMake(320, self.contentView.frame.size.height);
//    [UIView animateWithDuration:0.25 animations:^{
//        scrollView.contentOffset = CGPointMake(0, 0);
//        topView.frame = CGRectMake(0, UI_SCREEN_HEIGHT, UI_SCREEN_WIDTH, 50);
//    }];

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
