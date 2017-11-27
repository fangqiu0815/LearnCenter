//
//  SchoolInfoViewController.m
//  XDCommonApp
//
//  Created by xindao on 14-8-21.
//  Copyright (c) 2014年 XD-XY. All rights reserved.
//

#import "SchoolInfoViewController.h"

@interface SchoolInfoViewController ()

@end

@implementation SchoolInfoViewController

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

    if ([_type isEqualToString:@"shijian"]) {
        self.titleLabel.text = @"入学时间";
    }else{
        self.titleLabel.text = @"学制";
    }

    UITableView * myTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, UI_SCREEN_WIDTH, UI_MAINSCREEN_HEIGHT - UI_NAVIGATION_BAR_HEIGHT) style:UITableViewStylePlain];
    myTableView.dataSource = self;
    myTableView.delegate = self;
    myTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.contentView addSubview:myTableView];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView * header = [[UIView alloc] init];
    header.backgroundColor = [UIColor clearColor];
    return header;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 10;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if ([_type isEqualToString:@"shijian"]) {
        return 7;
    }else{
        return 5;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 40;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString * cellIde = @"cell";
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellIde];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIde];

        for (int i = 0; i < 2; i++) {
            UIImageView * lineIV = [[UIImageView alloc] initWithFrame:CGRectMake(0, i*39.5f, UI_SCREEN_WIDTH, .5f)];
            lineIV.image = [UIImage imageNamed:@"line"];
            lineIV.tag = 981800 + i;
            [cell.contentView addSubview:lineIV];
        }

        cell.contentView.backgroundColor = [UIColor whiteColor];
        cell.textLabel.font = [UIFont systemFontOfSize:15];
    }

    if (!indexPath.row) {
        UIImageView * line1 = (UIImageView *)[cell.contentView viewWithTag:981800];
        line1.hidden = NO;
    }else{
        UIImageView * line1 = (UIImageView *)[cell.contentView viewWithTag:981800];
        line1.hidden = YES;
    }

    if ([_type isEqualToString:@"shijian"]) {
        cell.textLabel.text = [NSString stringWithFormat:@"%d年",2014-indexPath.row];
    }else{
        cell.textLabel.text = [NSString stringWithFormat:@"%d年",3+indexPath.row];
    }


    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell * cell = [tableView cellForRowAtIndexPath:indexPath];
    [_delegate getSchoolInfo:cell.textLabel.text type:_type];
    [self.navigationController popViewControllerAnimated:YES];

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
