//
//  XWTaskListVC.m
//
//  Created by apple on 2017/5/8.
//  Copyright © 2017年 apple-fangqiu. All rights reserved.
//

#import "XWTaskListVC.h"
#import "XWTaskMidCell.h"
#import "XWTaskHeaderCell.h"
#import "XWTaskImageCell.h"

#import "XWPublishView.h"

@interface XWTaskListVC ()<XFPublishViewDelegate>
{
    NSString *url;
    NSString *title1;
}


@end

@implementation XWTaskListVC

- (void)viewDidLoad {
    [super viewDidLoad];
    //设置tableView
    [self setupTableView];
    //分享
    [self loadData];
    
}

- (void)setupTableView
{
    self.tableView.backgroundColor = MainBGColor;
    self.tableView.separatorColor = MainBGColor;
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.top.mas_equalTo(0);
        make.bottom.mas_equalTo(0);
    }];
}

- (void)loadData
{
//    [SVProgressHUD showWithStatus:@"加载中" maskType:SVProgressHUDMaskTypeBlack];
//
//   // [STRequest ];
    
    
}

-(void)didSelectBtnWithBtnTag:(NSInteger)tag
{
 //   NSMutableDictionary *shareParams = [NSMutableDictionary dictionary];
    JLLog(@"分享路径：%@",url );
    
    
    
    
//    [shareParams SSDKSetupShareParamsByText:title1
//                                     images:[UIImage imageNamed:@"120"]
//                                        url:[NSURL URLWithString:url]
//                                      title:title1
//                                       type:SSDKContentTypeAuto];
//    
//    if (tag==1)
//    {
//        //分享到微信朋友圈
//        if (STUserDefaults.isLogin){
//            
//            //2、分享
//            [ShareSDK share:SSDKPlatformSubTypeWechatTimeline parameters:shareParams onStateChanged:^(SSDKResponseState state, NSDictionary *userData, SSDKContentEntity *contentEntity, NSError *error) {
//                
//                if (state==SSDKResponseStateSuccess) {
//                    UIAlertController *alert=[UIAlertController alertControllerWithTitle:@"提示" message:@"分享成功" preferredStyle:UIAlertControllerStyleAlert];
//                    
//                    [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
//                        if (STUserDefaults.sharestate)
//                        {
//                            [STRequest ShareSuccessWithType:2 andDataBlock:^(id ServersData, BOOL isSuccess) {
//                                
//                            }];
//                            STUserDefaults.sharestate = NO;
//                        }
//                        
//                        
//                    }]];
//                    [self presentViewController:alert animated:YES completion:nil];
//                    
//                }
//                
//            }];
//            
//            NSLog(@"分享成功");
//            
//        }
//        else
//        {
//            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"是否前往微信登录?" preferredStyle:UIAlertControllerStyleAlert];
//            [alert addAction:[UIAlertAction actionWithTitle:@"是" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
//                [[NSNotificationCenter defaultCenter] postNotificationName:@"login" object:nil];
//                
//            }]];
//            [alert addAction:[UIAlertAction actionWithTitle:@"否" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
//                
//            }]];
//            
//            [self presentViewController:alert animated:YES completion:nil];
//            
//        }
//        
//    }else if (tag==2)
//    {
//        if (STUserDefaults.isLogin){
//            
//            //2、分享
//            [ShareSDK share:SSDKPlatformSubTypeWechatSession parameters:shareParams onStateChanged:^(SSDKResponseState state, NSDictionary *userData, SSDKContentEntity *contentEntity, NSError *error) {
//                NSLog(@"%lu",(unsigned long)state);
//                if (state==SSDKResponseStateSuccess) {
//                    UIAlertController *alert=[UIAlertController alertControllerWithTitle:@"提示" message:@"分享成功" preferredStyle:UIAlertControllerStyleAlert];
//                    [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
//                        if (STUserDefaults.sharestate)
//                        {
//                            [STRequest ShareSuccessWithType:1 andDataBlock:^(id ServersData, BOOL isSuccess) {
//                                
//                            }];
//                            STUserDefaults.sharestate = NO;
//                        }
//                        
//                    }]];
//                    [self presentViewController:alert animated:YES completion:nil];
//                    
//                    
//                }
//                NSLog(@"%@",error);
//                
//            }];
//            
//            NSLog(@"分享成功");
//            
//        }
//        else
//        {
//            {
//                UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"是否前往微信登录?" preferredStyle:UIAlertControllerStyleAlert];
//                [alert addAction:[UIAlertAction actionWithTitle:@"是" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
//                    [[NSNotificationCenter defaultCenter] postNotificationName:@"login" object:nil];
//                    
//                }]];
//                [alert addAction:[UIAlertAction actionWithTitle:@"否" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
//                    
//                }]];
//                
//                [self presentViewController:alert animated:YES completion:nil];
//                
//            }
//            
//        }
//        
//    }else{
//        NSLog(@"close");
//    }


}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return 1;
    }else if(section == 1){
        return 1;
    }else{
        return 4;
    }
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    WeakType(self);
    if (indexPath.section == 0&& indexPath.row == 0) {
        XWTaskImageCell *cell = [[XWTaskImageCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"XWTaskImageCell"];
        [cell setCellTitle:@"师徒任务" andTitleStrColor:MainRedColor andBtnTitle:@"立即收徒" andIconImage:MyImage(@"Icon_Apprentice") andcontentImage:MyImage(@"enter")];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }else if (indexPath.section == 1 && indexPath.row == 0){
    
        XWTaskMidCell *cell = [[XWTaskMidCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"XWTaskMidCell"];
        [cell setCellDataWithImage:MyImage(@"Icon_Finish") andTitle:@"首次分享" andDetail:@"7天内首次分享APP成功一次" andIsFinishedStr:@"领取40元宝" andIsFinishedStrColor:MainRedColor];
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
        
    }else if(indexPath.section == 2 && indexPath.row == 0){
        XWTaskMidCell *cell = [[XWTaskMidCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"XWTaskMidCell"];
        [cell setCellDataWithImage:MyImage(@"Icon_Finish") andTitle:@"每日分享" andDetail:@"每天分享APP成功一次" andIsFinishedStr:@"已完成" andIsFinishedStrColor:MainMidLineColor];
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }else {
        XWTaskMidCell *cell = [[XWTaskMidCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"XWTaskMidCell"];
        [cell setCellDataWithImage:MyImage(@"Icon_Unfinish") andTitle:@"每日分享" andDetail:@"每天分享APP成功一次" andIsFinishedStr:@"领取40元宝" andIsFinishedStrColor:MainRedColor];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        return cell;
    }
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0&& indexPath.row == 0) {
        JLLog(@" 师徒任务 ");
        
        XWPublishView *publishView = [[XWPublishView alloc]initWithFrame:[UIScreen mainScreen].bounds];
        publishView.delegate = self;
        [publishView  show];
        
    }else if (indexPath.section == 1 && indexPath.row == 0){
        JLLog(@" 分享任务 ");
        
        XWPublishView *publishView = [[XWPublishView alloc]initWithFrame:[UIScreen mainScreen].bounds];
        publishView.delegate = self;
        [publishView  show];
    }else{
        XWPublishView *publishView = [[XWPublishView alloc]initWithFrame:[UIScreen mainScreen].bounds];
        publishView.delegate = self;
        [publishView  show];
        
        
    }
    
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    XWTaskHeaderCell *cellView = [[XWTaskHeaderCell alloc]initWithStyle:0 reuseIdentifier:@"XWTaskHeaderCell"];
    cellView.backgroundColor = WhiteColor;
    if (section == 0) {
        return nil;
    }else if (section == 1){

        [cellView setCellDataWithImage:MyImage(@"Icon_TimeMissions") andTitle:@"限时任务" andTitleColor:MainYingHuangColor ];
        return cellView;
    }else{
        
        [cellView setCellDataWithImage:MyImage(@"Icon_DailyMissions") andTitle:@"日常任务" andTitleColor:MainRedColor ];
        return cellView;
    }

}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0)
    {
        return 100*AdaptiveScale_W;
        
    }else if (indexPath.section == 1)
    {
        return 80*AdaptiveScale_W;
    }else
    {
        return 80*AdaptiveScale_W;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return 15*AdaptiveScale_W;
    }else if(section == 1){
        return 60*AdaptiveScale_W;
    }else{
        return 60*AdaptiveScale_W;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if (section == 0) {
        return 10*AdaptiveScale_W;
    }else if (section == 1){
        return 10*AdaptiveScale_W;
    }else{
        return 10*AdaptiveScale_W;
    }
}


-(BOOL)isBlankString:(NSString *)string {
    if (string == nil || string == NULL) {
        return YES;
    }
    if ([string isKindOfClass:[NSNull class]]) {
        return YES;
    }
    if ([[string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] length]==0) {
        return YES;
    }
    if ([string isEqualToString:@"(null)"]) {
        return YES;
    }
    if ([string isEqualToString:@"<null>"]) {
        return YES;
    }
    return NO;
}

- (void)dealloc
{
    JLLog(@"dealloc");

}



@end
