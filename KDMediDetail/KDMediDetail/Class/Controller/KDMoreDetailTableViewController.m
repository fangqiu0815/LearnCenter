//
//  KDMoreDetailTableViewController.m
//  KDMediDetail
//
//  Created by apple-gaofangqiu on 2018/3/5.
//  Copyright © 2018年 apple-fangqiu. All rights reserved.
//

#import "KDMoreDetailTableViewController.h"

@interface KDMoreDetailTableViewController ()

@end

@implementation KDMoreDetailTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.backgroundColor = DEFAULT_BACKGROUND_COLOR;
    self.tableView.showsVerticalScrollIndicator = NO;
    
    CGFloat headerHeight = SCREEN_HEIGHT / 6 + SEGMENT_HEIGHT;
    // 假的tableview，高度同GameDetailHeadView
    self.tableView.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.yj_width, headerHeight)];
    
    self.tableView.estimatedRowHeight = 0;
    self.tableView.estimatedSectionFooterHeight = 0;
    self.tableView.estimatedSectionHeaderHeight = 0;
}

#pragma mark - tableView dataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 15;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellID = @"cellID";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellID];
    }
    cell.textLabel.text = [@"标题名称" stringByAppendingString:[NSString stringWithFormat:@"%ld", indexPath.row]];
    
    cell.detailTextLabel.text = @"当前共收录：xxx篇";
    cell.imageView.image = [UIImage imageNamed:@"fake_game"];
    return cell;
}

#pragma mark - tableView delegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 50;
}
@end
