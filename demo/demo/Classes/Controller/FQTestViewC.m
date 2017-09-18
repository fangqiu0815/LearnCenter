//
//  FQTestViewC.m
//  demo
//
//  Created by apple-gaofangqiu on 2017/9/16.
//  Copyright © 2017年 apple-fangqiu. All rights reserved.
//

#import "FQTestViewC.h"

@interface FQTestViewC ()

@end

@implementation FQTestViewC

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = randomColor;
    
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
