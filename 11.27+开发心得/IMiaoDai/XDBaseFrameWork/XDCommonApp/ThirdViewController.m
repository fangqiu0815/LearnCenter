//
//  ThirdViewController.m
//  XDCommonApp
//
//  Created by XD-XY on 2/12/14.
//  Copyright (c) 2014 XD-XY. All rights reserved.
//

#import "ThirdViewController.h"
#import "LoginViewController.h"
#import "XDHeader.h"
#import "XDTools.h"
#import "PersonCenterCell.h"
#import "FeedBackProblemViewController.h"
#import "AboutViewController.h"
#import "KeFuViewController.h"

@interface ThirdViewController ()

@end

@implementation ThirdViewController

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
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:YES];
    int size = [self sizeOfFolder:[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) objectAtIndex:0]];
    NSString * lastSize = @"";
    if (size < (1024*1024)) {
        lastSize = [NSString stringWithFormat:@"%.1fKB",size/1024.0f];
    }else if(size > (1024*1024)){
        lastSize = [NSString stringWithFormat:@"%.1fMB",size/1024.0f/1024.0f];
    }
    label.text = lastSize;
}


- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    self.leftBtn.hidden =YES;
    self.titleLabel.text = THIRDVIEWTITLETEXT;

    mytableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, UI_SCREEN_WIDTH, self.contentView.frame.size.height-UI_TAB_BAR_HEIGHT)];
    mytableView.backgroundColor = [UIColor clearColor];
    mytableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    mytableView.delegate = self;
    mytableView.dataSource = self;
    [self.contentView addSubview:mytableView];

    dataArray = @[@[@"版本检查",@"给喵贷点赞",@"清除缓存"],@[@"问题反馈",@"联系喵小贷"],@[@"关于喵贷"]];
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0){
        return 3;
    }else if (section == 1){
        return 2;
    }else{
        return 1;
    }
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 40.0f;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 10.0f;
}


-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView * view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, UI_SCREEN_WIDTH, 10)];
    view.backgroundColor = UIColorFromRGB(0xececec);
    return view;
}

-(UITableViewCell * )tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * cellName = @"cell";
    PersonCenterCell * cell = [tableView dequeueReusableCellWithIdentifier:cellName];
    if (cell == nil){
        cell = [[PersonCenterCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellName];
    }

    cell.titleLB.text = [[dataArray objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
    if (indexPath.row == 0&&indexPath.section == 0){
        cell.rightLB.hidden = NO;
        NSString *oldVerson = [[NSString alloc] initWithString:[[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"]];
        cell.rightLB.text = [NSString stringWithFormat:@"当前版本%@",oldVerson];
    }else{
        cell.rightLB.hidden =YES;
    }
    if (indexPath.section==0){
        if (indexPath.row == 2){
            cell.lineIV2.hidden = NO;
        }else{
            cell.lineIV2.hidden = YES;
        }
    }else if (indexPath.section == 1){
        if (indexPath.row == 1){
            cell.lineIV2.hidden = NO;
        }else{
            cell.lineIV2.hidden = YES;
        }
    }else{
        cell.lineIV2.hidden = NO;
    }
    
    if (indexPath.row == 2&&indexPath.section==0){
//        cell.rightIV.hidden = YES;
        label=creatXRLable(@"", CGRectMake(UI_SCREEN_WIDTH -120,0, 80, 40));
        label.tag =5000;
        label.font =[UIFont systemFontOfSize:12.5];
        label.textColor =UIColorFromRGB(0x939393);
        label.textAlignment = NSTextAlignmentRight;
        [cell.contentView addSubview:label];
    }else{
        cell.rightIV.hidden = NO;
    }
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.section == 0){
        if (indexPath.row == 0){
            //版本检查更新
            [self updateVerson];
        }else if (indexPath.row == 1){
            //用户评价
            NSString * praiseUrlString = [[NSUserDefaults standardUserDefaults] valueForKey:@"ios_praise_url"];
            if (IS_NOT_EMPTY(praiseUrlString)){
                [[UIApplication sharedApplication] openURL:[NSURL URLWithString:praiseUrlString]];
            
            }
        }else{
            //清除缓存
            if([label.text isEqualToString:@"0KB"]){
                [XDTools showTips:@"没有可清理的缓存了" toView:self.contentView];
            }else{
                UIAlertView * al  =[[UIAlertView alloc] initWithTitle:nil message:@"确认清理缓存？" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:@"取消", nil];
                [al show];
            }
        }
    }else if (indexPath.section == 1){
        if (indexPath.row == 0){
            //问题反馈
            FeedBackProblemViewController * feedBackVC = [[FeedBackProblemViewController alloc] init];
            [self.navigationController pushViewController:feedBackVC animated:YES];
        }else{
            KeFuViewController * kefuVC = [[KeFuViewController alloc] init];
            [self.navigationController pushViewController:kefuVC animated:YES];
        }
    }else{
        AboutViewController * aboutVC = [[AboutViewController alloc] init];
        aboutVC.titleString = @"关于喵贷";
        aboutVC.type = @"about";
        [self.navigationController pushViewController:aboutVC animated:YES];
    }
}


//版本更新
-(void)updateVerson{
    
    if(![XDTools NetworkReachable]){
        [XDTools showTips:brokenNetwork toView:mKeyWindow];
        return;
    }
    
    ASIHTTPRequest * request = [XDTools postRequestWithDict:@{} API:API_GETVIESION];
    __weak ASIHTTPRequest * mrequest = request;
    
    [request setCompletionBlock:^{
        [XDTools hideProgress:mKeyWindow];
        NSString *str = [[NSString alloc] initWithData:mrequest.responseData encoding:NSUTF8StringEncoding];
        NSDictionary * tmpDict= [XDTools JSonFromString:str];
        
        if ([[tmpDict valueForKey:@"result"]intValue]==0){
            NSDictionary * dict =[tmpDict valueForKey:@"data"];
            
            NSString *oldVerson = [[NSString alloc] initWithString:[[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"]];
            
            NSString *newVerson = [dict valueForKey:@"ios_version"];
            
            downUrl = [dict objectForKey:@"ios_url"];
            
            cString = [dict objectForKey:@"ios_content"];
            
            if ([newVerson isEqualToString:oldVerson]) {
                
                [XDTools showTips:@"已是最新版本" toView:self.view];
                [[NSUserDefaults standardUserDefaults] setValue:@"0" forKey:@"hasNewVersion"];
                [[NSUserDefaults standardUserDefaults] synchronize];
                
            }else{
                
                [[NSUserDefaults standardUserDefaults] setValue:@"1" forKey:@"hasNewVersion"];
                [[NSUserDefaults standardUserDefaults] synchronize];
                if ([[dict valueForKey:@"ios_force"] intValue]==1){
                    //强制更新
                    [[NSUserDefaults standardUserDefaults] setValue:@"1" forKey:@"mustupdate"];
                    [[NSUserDefaults standardUserDefaults] setValue:dict forKeyPath:@"versioninfo"];
                    [[NSUserDefaults standardUserDefaults] synchronize];
                    UIAlertView *al = [[UIAlertView alloc] initWithTitle:@"提示" message:cString delegate:self cancelButtonTitle:@"立即更新" otherButtonTitles:nil, nil];
                    al.tag = 1000;
                    [al show];
                }else{
                    //不强制更新
                    UIAlertView *al = [[UIAlertView alloc] initWithTitle:@"提示" message:cString delegate:self cancelButtonTitle:@"立即更新" otherButtonTitles:@"忽略本次", nil];
                    al.tag = 1000;
                    [al show];
                }
            }
        }else{
            [XDTools showTips:[tmpDict valueForKey:@"msg"] toView:mKeyWindow];
        }
        
    }];
    
    [request setFailedBlock:^{
        [XDTools hideProgress:mKeyWindow];
        [XDTools showTips:@"网络请求超时" toView:self.view];

    }];
    
    [request startAsynchronous];
    [XDTools showProgress:mKeyWindow];
}


#pragma mark- UIAlertViewDelegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (alertView.tag == 1000){
        if (buttonIndex == 0) {
            NSURL *url = [NSURL URLWithString:downUrl];
            [[UIApplication sharedApplication] openURL:url];
            
        }
    }else{
        if (buttonIndex == 0){
            [XDTools showProgress:self.contentView showText:@"正在清理"];
            NSString *cachPath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) objectAtIndex:0];
            
            NSArray *files = [[NSFileManager defaultManager] subpathsAtPath:cachPath];
            NSLog(@"files :%d",[files count]);
            for (NSString *p in files) {
                NSError *error;
                NSString *path = [cachPath stringByAppendingPathComponent:p];
                if ([[NSFileManager defaultManager] fileExistsAtPath:path]) {
                    [[NSFileManager defaultManager] removeItemAtPath:path error:&error];
                }
            }
            [XDTools hideProgress:self.contentView];
            [XDTools showTips:@"清理成功" toView:self.contentView];
            label.text=@"0KB";
        }
    }
    
}

//计算缓存
- (int)sizeOfFolder:(NSString*)folderPath
{
    NSArray *contents;
    NSEnumerator *enumerator;
    NSString *path;
    contents = [[NSFileManager defaultManager] subpathsAtPath:folderPath];
    enumerator = [contents objectEnumerator];
    int fileSizeInt = 0;
    while (path = [enumerator nextObject]) {
        NSError *error;
        NSDictionary *fattrib = [[NSFileManager defaultManager] attributesOfItemAtPath:[folderPath stringByAppendingPathComponent:path] error:&error];
        fileSizeInt +=[fattrib fileSize];
    }
    return fileSizeInt;
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
