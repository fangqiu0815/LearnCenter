//
//  PYMenuViewController.m
//  Gank
//
//  Created by 谢培艺 on 2017/3/9.
//  Copyright © 2017年 CoderKo1o. All rights reserved.
//

#import "PYMenuViewController.h"
#import <UMSocialCore/UMSocialCore.h>
#import <UMengUShare/UShareUI/UMSocialUIManager.h>
#import "PYWebController.h"
#import <MessageUI/MessageUI.h>
#import <SDWebImage/UIImageView+WebCache.h>
@interface PYMenuViewController () <MFMailComposeViewControllerDelegate>

/** 标题 */
@property (nonatomic, copy) NSArray *menuTitles;

/** 菜单图片名 */
@property (nonatomic, copy) NSArray *menuImageNames;

/** cell高度 */
@property (nonatomic, assign) CGFloat cellHeight;

/** 正在清除 */
@property (nonatomic, assign) BOOL cleaning;

@end

@implementation PYMenuViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView = [[UITableView alloc] initWithFrame:[UIScreen mainScreen].bounds style:UITableViewStyleGrouped];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.backgroundColor = [UIColor clearColor];
    self.cellHeight = 60;
    self.menuTitles = @[@"我要推荐", @"给个好评", @"反馈一下", @"Follow Me", @"清理缓存"];
    self.menuImageNames = @[@"recommend2friend", @"nice", @"feedback", @"follow", @"clean"];
}

- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    self.tableView.contentInset = UIEdgeInsetsMake(0, self.view.frame.size.width * 0.10 / 2 * [UIScreen mainScreen].scale, 0, 0);
    self.tableView.contentSize = CGSizeMake(0, self.tableView.contentSize.height);
}

#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 5;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
    cell.backgroundColor = [UIColor clearColor];
    cell.textLabel.textColor = [UIColor whiteColor];
    cell.imageView.image = [UIImage imageNamed:self.menuImageNames[indexPath.row]];
    cell.textLabel.font = [UIFont fontWithName:UIFontSymbolicTrait size:16];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.textLabel.text = self.menuTitles[indexPath.row];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return self.cellHeight;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return (self.view.frame.size.height - self.cellHeight * self.menuTitles.count) / 2.0;
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.row) {
        case 0: // 推荐给好友
        {
            // 分享
            //显示分享面板
            [UMSocialUIManager showShareMenuViewInWindowWithPlatformSelectionBlock:^(UMSocialPlatformType platformType, NSDictionary *userInfo) {
                //Do Something
                [self shareWebPageToPlatformType:platformType];
            }];
        }
            break;
        case 1: // 给个好评
        {
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://itunes.apple.com/WebObjects/MZStore.woa/wa/viewContentsUserReviews?id=1214308741&pageNumber=0&sortOrdering=2&type=Purple+Software&mt=8"]];
        }
            
            break;
        case 2: // 反馈一下
        {
            if (![MFMailComposeViewController canSendMail]) { // 不能发送邮件
               UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil message:@"反馈邮箱\n499491531@qq.com" preferredStyle:UIAlertControllerStyleAlert];
                UIAlertAction *alertAction = [UIAlertAction actionWithTitle:@"确定" style:0 handler:^(UIAlertAction * _Nonnull action) {
                    [alertController dismissViewControllerAnimated:YES completion:nil];
                }];
                [alertController addAction:alertAction];
                [self presentViewController:alertController animated:YES completion:nil];
                return;
            }
            MFMailComposeViewController *mailVC = [[MFMailComposeViewController alloc] init];
            if (mailVC == nil) return;
            [mailVC setSubject:@"Gank集中营反馈"]; //邮件主题
            [mailVC setToRecipients:[NSArray arrayWithObjects:@"499491531@qq.com", nil]]; //设置发送给谁，参数是NSarray
            mailVC.mailComposeDelegate = self;
            [self presentViewController:mailVC animated:YES completion:nil];
        }
            
            break;
        case 3: // Follow Me
        {
            PYWebController *webVC = [[PYWebController alloc] init];
            webVC.url = @"https://github.com/iphone5solo";
            webVC.webTitle = @"CoderKo1o";
            webVC.progressColor = [UIColor darkGrayColor];
            UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:webVC];
            [self presentViewController:nav animated:YES completion:nil];
        }
            
            break;
        case 4: // 清理缓存
        {
            if (self.cleaning) return;
            // 取出cell
            UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
            // 取出imageView
            UIImageView *imageView = cell.imageView;
            // 清空缓存
            [[SDImageCache sharedImageCache] clearDiskOnCompletion:nil];
            self.cleaning = YES;
            // 旋转
            [UIView animateWithDuration:0.5 delay:0 options:UIViewAnimationOptionRepeat animations:^{
                imageView.transform = CGAffineTransformRotate(imageView.transform, M_PI);
            } completion:^(BOOL finished) {
                imageView.transform = CGAffineTransformIdentity;
            }];
            // 0.25秒后移除动画
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [imageView.layer removeAllAnimations];
                self.cleaning = NO;
            });
        }
            break;
            
        default:
            break;
    }
}

- (void)shareWebPageToPlatformType:(UMSocialPlatformType)platformType
{
    //创建分享消息对象
    UMSocialMessageObject *messageObject = [UMSocialMessageObject messageObject];
    // 取出分类
    NSString *imageName = @"applogo";
    //创建网页内容对象
    UMShareWebpageObject *shareObject = [UMShareWebpageObject shareObjectWithTitle:@"Gank集中营" descr:@"每日分享妹子图 和 技术干货，还有供大家中午休息的休闲视频" thumImage:[UIImage imageNamed:imageName]];
    //设置网页地址
    shareObject.webpageUrl = @"http://itunes.apple.com/cn/app/id1214308741?mt=8";
    //分享消息对象设置分享内容对象
    messageObject.shareObject = shareObject;
    //调用分享接口
    [[UMSocialManager defaultManager] shareToPlatform:platformType messageObject:messageObject currentViewController:[UIApplication sharedApplication].keyWindow.rootViewController completion:nil];
}

#pragma mark - MFMailComposeViewControllerDelegate
- (void)mailComposeController:(MFMailComposeViewController*)controller
          didFinishWithResult:(MFMailComposeResult)result
                        error:(NSError*)error
{
    // 发送完成
    [controller dismissViewControllerAnimated:YES completion:nil];
}

@end
