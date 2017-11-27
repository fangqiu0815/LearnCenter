//
//  KeFuViewController.m
//  XDCommonApp
//
//  Created by XD-XY on 8/18/14.
//  Copyright (c) 2014 XD-XY. All rights reserved.
//

#import "KeFuViewController.h"
#import "KefuCell.h"
#import "XDHeader.h"
#include "XDTools.h"

@interface KeFuViewController ()

@end

@implementation KeFuViewController

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
    
    self.titleLabel.text = @"联系客服";
    
    UITableView * tableview = [[UITableView alloc] initWithFrame:self.contentView.bounds style:UITableViewStylePlain];
    tableview.backgroundColor = [UIColor clearColor];
    tableview.delegate = self;
    tableview.dataSource = self;
    tableview.showsVerticalScrollIndicator = NO;
    tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.contentView addSubview:tableview];
    
    UIView * view = [[UIView alloc] init];
    view.frame = CGRectMake(0, 0, 320,10);
    view.backgroundColor = BGCOLOR;
    tableview.tableHeaderView = view;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 3;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 40;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * cellName = @"cell";
    KefuCell * cell = [tableView dequeueReusableCellWithIdentifier:cellName];
    if (cell == nil){
        cell = [[KefuCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellName];
    }
    if (indexPath.row == 0){
        cell.headIV.image = [UIImage imageNamed:@"tellphone_ic"];
        cell.titleLB.text = @"客服电话 400-610-6655";
        cell.lineIV1.hidden = NO;
    }else if (indexPath.row == 1){
        cell.headIV.image = [UIImage imageNamed:@"qq_ic"];
        cell.titleLB.text = @"客服QQ 2913977509";
        cell.lineIV1.hidden = YES;
    }else{
        cell.headIV.image = [UIImage imageNamed:@"email_ic"];
        cell.titleLB.text = @"客服邮箱 kefu@miaodai.cn";
        cell.lineIV1.hidden = YES;
    }
    
    
    return cell;
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.row == 1){
        [[UIPasteboard generalPasteboard] setString:[NSString stringWithFormat:@"%@",@"2913977509"]];
        [XDTools showTips:@"QQ已复制到剪切板上" toView:mKeyWindow];
    }else if(indexPath.row == 0){
        UIAlertView * al = [[UIAlertView alloc] initWithTitle:nil message:@"400-610-6655" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"呼叫", nil];
        [al show];
    }else if (indexPath.row == 2){
        [[UIPasteboard generalPasteboard] setString:[NSString stringWithFormat:@"%@",@"kefu@miaodai.cn"]];
        [XDTools showTips:@"邮箱已复制到剪切板上" toView:mKeyWindow];
    }
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex==1){
        NSString * num = [[NSString alloc] initWithFormat:@"tel://%@",@"4006106655"];
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:num]];
    }
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
