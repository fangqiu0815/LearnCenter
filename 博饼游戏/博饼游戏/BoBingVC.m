//
//  BoBingVC.m
//  博饼游戏
//
//  Created by apple-gaofangqiu on 2017/9/22.
//  Copyright © 2017年 apple-fangqiu. All rights reserved.
//

#import "BoBingVC.h"

@interface BoBingVC ()

@end

@implementation BoBingVC

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor whiteColor];
    UIButton *button = [[UIButton alloc]initWithFrame:CGRectMake(10, 20, 60, 44)];
    [button setTitle:@"关闭" forState:0];
    [button setTitleColor:[UIColor blackColor] forState:0];
    [button addTarget:self action:@selector(closeClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    

    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 64, ScreenW, ScreenH-64)];
    imageView.image = [UIImage imageNamed:@"timg.jpeg"];
    [self.view addSubview:imageView];
    
    
    
}

- (void)closeClick
{
    [self dismissViewControllerAnimated:YES completion:nil];

}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
