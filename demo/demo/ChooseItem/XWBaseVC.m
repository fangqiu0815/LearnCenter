//
//  XWBaseVC.m
//  zhangshangnews
//
//  Created by apple on 2017/5/10.
//  Copyright © 2017年 apple-fangqiu. All rights reserved.
//

#import "XWBaseVC.h"

@interface XWBaseVC ()

@end

@implementation XWBaseVC

- (void)viewDidLoad {
    [super viewDidLoad];
//    self.view.backgroundColor = [UIColor whiteColor];
//    //统一返回按钮
//    
//    [self.navigationController.navigationBar setBackIndicatorImage:[UIImage imageNamedWithRenderOriginal:@"btn_back"]];
//    
//    [self.navigationController.navigationBar setBackIndicatorTransitionMaskImage:[UIImage imageNamedWithRenderOriginal:@"btn_back"]];
//    
//    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];
//    
//    self.navigationItem.backBarButtonItem = backItem;
}


- (UITableView *)tableView {
    if (!_tableView) {
        
        CGFloat x = 0.0f;
        CGFloat y = 0.0f;
        CGFloat w = self.view.frame.size.width;
        CGFloat h = self.view.frame.size.height;
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(x, y, w, h) style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.tableFooterView = [[UITableView alloc] init];
        
        
    }
    return _tableView;
}
#pragma mark - UITableViewDelegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0.1f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.1f;
}

@end
