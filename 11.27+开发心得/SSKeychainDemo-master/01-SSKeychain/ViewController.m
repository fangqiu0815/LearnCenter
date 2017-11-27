//
//  ViewController.m
//  01-SSKeychain
//
//  Created by 吴冕 on 2017/4/11.
//  Copyright © 2017年 wumian. All rights reserved.
//

#import "ViewController.h"
#import "SSKeychain.h"
static NSString *kKeychainService = @"com.WuMian.keychaindemo";
static NSString *kKeychainDeviceId = @"KeychainDeviceId";

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UILabel *uuidLabel;
@property (weak, nonatomic) IBOutlet UITextField *accountTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.uuidLabel.text = [self getDeviceId];
}

#pragma mark
#pragma make - 获取设备号
- (NSString *)getDeviceId{
    NSString *localDeviceId = [SSKeychain passwordForService:kKeychainService account:kKeychainDeviceId];
    if (!localDeviceId) {
        CFUUIDRef deviceID = CFUUIDCreate(NULL);
        assert(deviceID != NULL);
        CFStringRef deviceIdStr = CFUUIDCreateString(NULL, deviceID);
        [SSKeychain setPassword:[NSString stringWithFormat:@"%@",deviceIdStr] forService:kKeychainService account:kKeychainDeviceId];
        localDeviceId = [NSString stringWithFormat:@"%@",deviceIdStr];
    }
    return localDeviceId;
}

#pragma mark
#pragma make - 登录按钮
- (IBAction)loginBtn:(UIButton *)sender {
    if ([self.accountTextField.text isEqualToString:@""]) {
        NSLog(@"用户名信息不全");
        return;
    }else if([self.passwordTextField.text isEqualToString:@""]){
        NSArray *array = [SSKeychain accountsForService:kKeychainService];
        [array enumerateObjectsUsingBlock:^(NSDictionary  *obj, NSUInteger idx, BOOL * _Nonnull stop) {
            NSString *password = [SSKeychain passwordForService:kKeychainService account:obj[@"acct"]];
            if (password == nil) {
                NSLog(@"密码为空");
            }else{
                self.passwordTextField.text = password;
                return;
            }

        }];
    }
    //保存账户
    [SSKeychain setPassword:self.passwordTextField.text forService:kKeychainService account:self.accountTextField.text];
}


#pragma mark
#pragma make - 清除所有的密码
- (IBAction)cleanBtn:(UIButton *)sender {
    if(self.accountTextField.text == NULL){
        return;
    }
    NSArray *accounts = [SSKeychain accountsForService:kKeychainService];
    for (int i = 0; i<accounts.count; i++) {
        NSDictionary *dict = accounts[i];
       [SSKeychain deletePasswordForService:kKeychainService account:dict[@"acct"]];
    }
}

#pragma mark
#pragma make - 查询账号
- (IBAction)searchBtn:(UIButton *)sender {
    NSArray *accounts = [SSKeychain accountsForService:kKeychainService];
    [accounts enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSLog(@"%@",obj);
    }];
}






- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
