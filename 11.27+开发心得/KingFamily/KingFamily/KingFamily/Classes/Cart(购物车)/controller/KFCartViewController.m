//
//  KFCartViewController.m
//  KingFamily
//
//  Created by 张强 on 16/4/15.
//  Copyright © 2016年 King. All rights reserved.
//

#import "KFCartViewController.h"
#import "UIImage+GIF.h"
#import "KFNavigationController.h"


@interface KFCartViewController ()
@property (weak, nonatomic) IBOutlet UIButton *guangBtn;
@property (weak, nonatomic) IBOutlet UIImageView *guangImageView;
@end

@implementation KFCartViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.navigationItem.title = @"购物车";
    
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    dict[NSForegroundColorAttributeName] = [UIColor whiteColor];
    [self.navigationController.navigationBar setTitleTextAttributes:dict];
    
    // 设置gif图片
    self.guangImageView.image = [UIImage sd_animatedGIFNamed:@"empty_shoppingCart"];
    
    // 设置按钮
    self.guangBtn.layer.borderWidth = 0.9f; // 边框宽度
    self.guangBtn.layer.borderColor = Bar_TintColor.CGColor; // 边框颜色    
    self.guangBtn.layer.cornerRadius = 6.0f; // 边框圆角矩形半径
    self.guangBtn.tintColor = Bar_TintColor; //字体颜色
    
}


- (IBAction)goShoppingBtn:(UIButton *)sender {
    
    self.tabBarController.selectedIndex = 0;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}



@end
