//
//  SaveAddressViewController.m
//  CrazyPacket
//
//  Created by WuYanZu on 17/3/1.
//  Copyright © 2017年 WuYanZu. All rights reserved.
//

#import "SaveAddressViewController.h"
#import "GoodsDetailViewController.h"
#import "ConfirmOrderViewController.h"
#import "AddAddressModel.h"
#import "AlertView.h"
#import "AddressConfirmView.h"
#define MAX_LIMIT_NUMS    50 //来限制最大输入只能100个字符
@interface SaveAddressViewController ()<UITextViewDelegate>
{
    NSString *_reapid;
    
}
@property (nonatomic, strong) UITextField *receiveTextF;
@property (nonatomic, strong) UITextField *phoneTextF;
@property (nonatomic, strong) UITextField *provinceTextF;
@property (nonatomic, strong) UITextField *cityTextF;
@property (nonatomic, strong) UITextField *regionTextF;
@property (nonatomic, strong) UITextView *detailTextF;
@property (nonatomic, strong) AlertView *alert;
@property (nonatomic, strong) AddressConfirmView *confirmView;



@end

@implementation SaveAddressViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addTheView];
    
    self.view.backgroundColor = MainBGColor;
//    UIBarButtonItem *saveBtn = [[UIBarButtonItem alloc]initWithTitle:@"保存" style:UIBarButtonItemStyleDone target:self action:@selector(saveBtnAction)];
//    self.navigationItem.rightBarButtonItem = saveBtn;
//    [self.navigationItem.rightBarButtonItem setTintColor:WhiteColor];

    UIBarButtonItem *rightitem = [[UIBarButtonItem alloc] initWithTitle:@"保存" style:(UIBarButtonItemStyleDone) target:self action:@selector(saveBtnAction)];
    NSDictionary *dic = [NSDictionary dictionaryWithObject:WhiteColor forKey:NSForegroundColorAttributeName];
    [rightitem setTitleTextAttributes:dic forState:UIControlStateNormal];
    self.navigationItem.rightBarButtonItem = rightitem;
    
}

//设置字体颜色
- (UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
}

//设置状态栏颜色
- (void)setStatusBarBackgroundColor:(UIColor *)color {
    
//    UIView *statusBar = [[[UIApplication sharedApplication] valueForKey:@"statusBarWindow"] valueForKey:@"statusBar"];
//    if ([statusBar respondsToSelector:@selector(setBackgroundColor:)]) {
//        statusBar.backgroundColor = color;
//    }
}
//！！！重点在viewWillAppear方法里调用下面两个方法
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self preferredStatusBarStyle];
    [self setStatusBarBackgroundColor:MainRedColor];
    self.navigationController.navigationBar.translucent = NO;
    self.tabBarController.hidesBottomBarWhenPushed = YES;
    self.navigationController.navigationBar.barTintColor = MainRedColor;
    
    // 设置导航栏标题变大
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(ScreenW/2, self.view.yj_centerX, 80, 40)];
    label.textColor = [UIColor whiteColor];
    label.textAlignment = NSTextAlignmentCenter;
    label.text = @"添加地址";
    label.font = [UIFont systemFontOfSize:18];
    
    self.navigationItem.titleView = label;
    
}


#pragma mark addTheView
-(void)addTheView
{
    
    
    //收货人
    UIView *firstView = [[UIView alloc]init];
    firstView.backgroundColor = WhiteColor;
    firstView.userInteractionEnabled = YES;
    [self.view addSubview:firstView];
    [firstView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(10);
        make.left.right.mas_equalTo(0);
        make.height.mas_equalTo(60*AdaptiveScale_W);
    }];
    
    UILabel *personLab = [[UILabel alloc]init];
    personLab.text = @"收货人 ";
    // personLab.textAlignment = NSTextAlignmentCenter;
    personLab.font = [UIFont systemFontOfSize:RemindFont(14, 16, 18)];
    [firstView addSubview:personLab];
    [personLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(12*AdaptiveScale_W);
        //make.top.mas_equalTo(10*AdaptiveScale_W);
        make.centerY.equalTo(firstView);
        make.width.mas_equalTo(80);
        make.height.mas_equalTo(20*AdaptiveScale_W);
    }];
    [firstView addSubview:self.receiveTextF];
    [self.receiveTextF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(personLab.mas_centerY);
        make.height.mas_equalTo(20*AdaptiveScale_W);
        make.left.equalTo(personLab.mas_right);
        make.right.mas_equalTo(-13*AdaptiveScale_W);
    }];
    
    UIView *line_F = [[UIView alloc]init];
    line_F.backgroundColor = LineColor;
    [firstView addSubview:line_F];
    [line_F mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.top.mas_equalTo(firstView.mas_bottom);
        make.height.mas_equalTo(1);
    }];
    
    //联系电话
    UIView *secondView = [[UIView alloc]init];
    secondView.backgroundColor = WhiteColor;
    secondView.userInteractionEnabled = YES;
    [self.view addSubview:secondView];
    [secondView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(line_F.mas_bottom);
        make.left.right.mas_equalTo(0);
        make.height.mas_equalTo(60*AdaptiveScale_W);
    }];
    
    UILabel *phoneLab = [[UILabel alloc]init];
    phoneLab.text = @"联系电话 ";
    phoneLab.font = [UIFont systemFontOfSize:RemindFont(14, 16, 18)];
    [secondView addSubview:phoneLab];
    [phoneLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(12*AdaptiveScale_W);
        //        make.top.mas_equalTo(10*AdaptiveScale_W);
        make.centerY.equalTo(secondView.mas_centerY);
        make.width.mas_equalTo(80);
        make.height.mas_equalTo(20*AdaptiveScale_W);
    }];
    
    
    
    [secondView addSubview:self.phoneTextF];
    [self.phoneTextF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(phoneLab.mas_centerY);
        make.height.mas_equalTo(20*AdaptiveScale_W);
        make.left.equalTo(phoneLab.mas_right);
        make.right.mas_equalTo(-13*AdaptiveScale_W);
    }];
    
    UIView *line_S = [[UIView alloc]init];
    line_S.backgroundColor = LineColor;
    [secondView addSubview:line_S];
    [line_S mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.top.equalTo(secondView.mas_bottom);
        make.height.mas_equalTo(1);
    }];
    
    
    //详细地址
    UIView *thirdView = [[UIView alloc]init];
    thirdView.backgroundColor = WhiteColor;
    thirdView.userInteractionEnabled = YES;
    [self.view addSubview:thirdView];
    [thirdView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(line_S.mas_bottom);
        make.left.right.mas_equalTo(0);
        make.height.mas_equalTo(100*AdaptiveScale_W);
    }];
    
    UILabel *addressLab = [[UILabel alloc]init];
    addressLab.text = @"详细地址 ";
    addressLab.font = [UIFont systemFontOfSize:RemindFont(14, 16, 18)];
    [thirdView addSubview:addressLab];
    [addressLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(12*AdaptiveScale_W);
        make.centerY.equalTo(thirdView);
        make.width.mas_equalTo(80);
        make.height.mas_equalTo(100*AdaptiveScale_W);
    }];
    
    [thirdView addSubview:self.detailTextF];
    [self.detailTextF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(addressLab);
        make.height.mas_equalTo(100*AdaptiveScale_W);
        make.left.equalTo(addressLab.mas_right);
        make.right.mas_equalTo(-13*AdaptiveScale_W);
    }];
    
    UILabel *warnLab = [[UILabel alloc]init];
    warnLab.text = @"(最多添加三个地址信息)";
    warnLab.font = [UIFont systemFontOfSize:RemindFont(12, 14, 16)];
    warnLab.textColor = CUSTOMCOLOR(148, 148, 148);
    [self.view addSubview:warnLab];
    [warnLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(thirdView.mas_bottom).offset(2*AdaptiveScale_W);
        //make.left.equalTo(receiveLab);
        make.height.equalTo(phoneLab);
        make.centerX.equalTo(thirdView.mas_centerX);
        //make.right.mas_equalTo(0);
    }];
}
#pragma mark btnAction
-(void)saveBtnAction
{
    
    
    if (self.receiveTextF.text.length == 0)
    {
        [SVProgressHUD showErrorWithStatus:@"请填写收货人"];
        return;
    }
    if (self.phoneTextF.text.length == 0)
    {
        [SVProgressHUD showErrorWithStatus:@"请填写联系电话"];
        return;
    }
    if (self.detailTextF.text.length == 0)
    {
        [SVProgressHUD showErrorWithStatus:@"请填写联系电话"];
        return;
    }
    if (self.detailTextF.text.length == 50)
    {
        
        [SVProgressHUD showErrorWithStatus:@"亲!最多只能输入50个字!请您合理安排内容!"];
        return;
    }
    self.confirmView.receiveTextF.text = self.receiveTextF.text;
    self.confirmView.phoneTextF.text = self.phoneTextF.text;
    self.confirmView.detailTextF.text = self.detailTextF.text;
    
    [self.alert show];
    
    
}
-(void)saveAskForData
{
    NSString *name = self.receiveTextF.text;
    NSString *mobilephone = self.phoneTextF.text;
    NSString *detainaddress = self.detailTextF.text;
    NSDictionary *param = @{@"name":name,
                            @"phone":mobilephone,
                            @"address":detainaddress
                            };
    NSLog(@"%@",param);
    [STRequest AddAddressWithParams:param andDataBlock:^(id ServersData, BOOL isSuccess) {
        AddAddressModel *dataModel = [AddAddressModel mj_objectWithKeyValues:ServersData];
        [self.alert dismissAnimated:NO];
        if (isSuccess)
        {
            if (dataModel.c == 1)
            {
                [SVProgressHUD showSuccessWithStatus:@"添加成功"];
                
                /*
                 从服务器拿到 添加成功的 地址id 并组成新的plist的缓存到本地
                 并从兑换记录 从服务器拿到地址 id 并显示 之前添加成功的地址
                 */
                
                NSDictionary *dictemp = [NSDictionary dictionaryWithDictionary:ServersData[@"d"]];
                _reapid = dictemp[@"reapid"];
                JLLog(@"_reapid---%@",_reapid);
                NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithDictionary:param];
                [dict setValue:_reapid forKey:@"reapid"];
                [dict writeToFile:XWADDRESS_REAPID_CACHE_PATH atomically:YES];
                
                [self performSelector:@selector(delayBack1) withObject:nil afterDelay:1];
                
            }else
            {
                [SVProgressHUD showErrorWithStatus:dataModel.m];
            }
        }else
        {
            [SVProgressHUD showErrorWithStatus:@"网络故障，请重试!"];
        }
    }];
}

-(void)delayBack1
{
    ConfirmOrderViewController *goodsVC = [[ConfirmOrderViewController alloc]init];
    
    [self.navigationController popToViewController:goodsVC animated:YES];
}

#pragma mark get
-(UITextField *)receiveTextF
{
    if (_receiveTextF == nil)
    {
        _receiveTextF = [[UITextField alloc]init];
        _receiveTextF.font = [UIFont systemFontOfSize:RemindFont(12, 14, 16)];
    }
    return _receiveTextF;
}
-(UITextField *)phoneTextF
{
    if (_phoneTextF == nil)
    {
        _phoneTextF = [[UITextField alloc]init];
        _phoneTextF.font = [UIFont systemFontOfSize:RemindFont(12, 14, 16)];
        _phoneTextF.keyboardType = UIKeyboardTypePhonePad;
    }
    return _phoneTextF;
}
-(UITextField *)provinceTextF
{
    if (_provinceTextF == nil)
    {
        _provinceTextF = [[UITextField alloc]init];
        _provinceTextF.backgroundColor = [UIColor colorWithRed:0.96 green:0.96 blue:0.96 alpha:1.00];
        _provinceTextF.layer.cornerRadius = 5;
        _provinceTextF.layer.masksToBounds = YES;
        _provinceTextF.font = [UIFont systemFontOfSize:RemindFont(12, 14, 16)];
    }
    return _provinceTextF;
}
-(UITextField *)cityTextF
{
    if (_cityTextF == nil)
    {
        _cityTextF = [[UITextField alloc]init];
        _cityTextF.backgroundColor = [UIColor colorWithRed:0.96 green:0.96 blue:0.96 alpha:1.00];
        _cityTextF.layer.cornerRadius = 5;
        _cityTextF.layer.masksToBounds = YES;
        _cityTextF.font = [UIFont systemFontOfSize:RemindFont(12, 14, 16)];
    }
    return _cityTextF;
}
-(UITextField *)regionTextF
{
    if (_regionTextF == nil)
    {
        _regionTextF = [[UITextField alloc]init];
        _regionTextF.backgroundColor = [UIColor colorWithRed:0.96 green:0.96 blue:0.96 alpha:1.00];
        _regionTextF.layer.cornerRadius = 5;
        _regionTextF.layer.masksToBounds = YES;
        _regionTextF.font = [UIFont systemFontOfSize:RemindFont(12, 14, 16)];
    }
    return _regionTextF;
}
-(UITextView *)detailTextF
{
    if (_detailTextF == nil)
    {
        _detailTextF = [[UITextView alloc]init];
        //_detailTextF.text = @"请填写详细地址，不少于10个字";
        _detailTextF.textColor = [UIColor grayColor];
        _detailTextF.font = [UIFont systemFontOfSize:RemindFont(14, 16, 18)];
        _detailTextF.delegate = self;
        
        
    }
    return _detailTextF;
}
-(AlertView *)alert
{
    if (_alert == nil)
    {
        WeakType(self);
        self.confirmView.CloseBlock = ^(){
            [weakself.alert dismissAnimated:YES];
        };
        self.confirmView.ConfirmBlock = ^(){
            [weakself saveAskForData];
        };
        _alert = [[AlertView alloc]initWithCustomView:self.confirmView style:CustomAlertViewTransitionStyleBounce];
    }
    return _alert;
}
-(AddressConfirmView *)confirmView
{
    if (_confirmView == nil)
    {
        _confirmView = [[AddressConfirmView alloc]initWithFrame:Frame(0, 0, IPHONE_W, 182*AdaptiveScale_W)];
    }
    return _confirmView;
}
#pragma mark - UITextViewDelegate
- (void)textViewDidEndEditing:(UITextView *)textView
{
    if(textView.text.length < 1){
        textView.text = @"请填写详细地址，不少于6个字";
        textView.textColor = [UIColor grayColor];
    }
}
- (void)textViewDidBeginEditing:(UITextView *)textView
{
    if([textView.text isEqualToString:@"请填写详细地址，不少于6个字"]){
        textView.text=@"";
        textView.textColor=[UIColor blackColor];
    }
}


//- (void)textViewDidChange:(UITextView *)textView
//{
//
//    if (self.detailTextF.text.length >= 50) {
//        //对超出的部分进行剪切
//        self.detailTextF.text = [self.detailTextF.text substringToIndex:10];
//
//    }
//
//    if (self.detailTextF.text.length >= 50) {
//
//        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"温馨提示!" message:@"亲!最多只能输入50个字!请您合理安排内容!" preferredStyle:UIAlertControllerStyleAlert];
//
//        [self presentViewController:alertController animated:YES completion:nil];
//
//        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//
//            [self dismissViewControllerAnimated:YES completion:nil];
//
//        });
//
//    }
//
//
//
//
//
//}
//
//
//#pragma mark - 移除监听方法
//
//- (void)dealloc {
//
//    [[NSNotificationCenter defaultCenter]removeObserver:self];
//
//}


@end
