//
//  XWMineSettingVC.m
//  zhangshangPacket
//
//  Created by apple on 2017/7/17.
//  Copyright © 2017年 apple-fangqiu. All rights reserved.
//

#import "XWMineSettingVC.h"
#import "AppearanceFontObj.h"
#import "MutableLabel.h"
#import "XWMineAboutUsVC.h"
#import "XWCetAndHisVC.h"
#import "XWCollectVC.h"
#import "XWHistoryVC.h"

@interface XWMineSettingVC ()
{
    UIImageView *navBarHairlineImageView;
    NSInteger tag;
}
@property (nonatomic, assign) CGFloat totalCacheSize;
@property (nonatomic, strong) NSArray  *sectionArray; /**< section模型数组*/
@property (nonatomic, weak) UISwitch *switchAction;
@property (nonatomic, weak) UISwitch *notiSwitchAction;
@property (nonatomic, weak) UISwitch *AINoImageSwitch;
@property (nonatomic, weak) UISegmentedControl *segVc;
@property (nonatomic, strong) AppearanceFontObj *appFont;

@end

@implementation XWMineSettingVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // 设置导航栏标题变大
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(self.view.yj_centerY-20, self.view.yj_centerX, 80, 40)];
    label.textAlignment = NSTextAlignmentCenter;
    label.textColor = [UIColor whiteColor];
    label.text = @"设置";
    label.font = [UIFont systemFontOfSize:18];
    self.navigationItem.titleView = label;
    navBarHairlineImageView = [self findHairlineImageViewUnder:self.navigationController.navigationBar];
    [self setupTableView];
    
    //从后台到前台监控是否改变值
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(applicationWillEnterForeground)name:UIApplicationWillEnterForegroundNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(isNighting) name:@"isNighting" object:nil];
    
}

- (DKNightVersionManager *)dk_manager {
    return [DKNightVersionManager sharedManager];
}

-(void)isNighting{
    
    if ([self.dk_manager.themeVersion isEqualToString:DKThemeVersionNight]) {
        
        self.switchAction.on=NO;
        
    } else {
        
        self.switchAction.on=YES;
        
    }
}

- (void)applicationWillEnterForeground
{
    //监控设置中的通知按钮是否打开
    UIUserNotificationSettings *setting = [[UIApplication sharedApplication] currentUserNotificationSettings];
    if (UIUserNotificationTypeNone == setting.types) {
        JLLog(@"推送关闭");
        self.notiSwitchAction.on = NO;
    }else{
        JLLog(@"推送打开");
        self.notiSwitchAction.on = YES;
    }

}

//设置字体颜色
- (UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
}

//设置状态栏颜色
- (void)setStatusBarBackgroundColor:(UIColor *)color {
    
    //    UIView *statusBar = [[[UIApplication sharedApplication] valueForKey:@"statusBarWindow"] valueForKey:@"statusBar"];
    //    if ([statusBar respondsToSelector:@selector(setBackgroundColor:)]) {
    //        statusBar.backgroundColor = color;
    //    }
}

//！！！重点在viewWillAppear方法里调用下面两个方法
-(void)viewWillAppear:(BOOL)animated{
    [self preferredStatusBarStyle];
    [self setStatusBarBackgroundColor:MainRedColor];
    self.navigationController.navigationBar.translucent = NO;
    
    WeakType(self);
    //根据一个文件夹,获取文件夹大小
    [CleanCacheToolClass getCacheSizeWithPath:CachePath complete:^(CGFloat totalCache) {
        //获取缓存长度
        weakself.totalCacheSize = totalCache;
        //局部刷新
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
        [weakself.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
    }];
    
//    
//    [self.navigationController.navigationBar xw_setDayMode:^(UIView *view) {
//        UINavigationBar *bar = (UINavigationBar *)view;
//        bar.barTintColor = MainRedColor;
//    } nightMode:^(UIView *view) {
//        UINavigationBar *bar = (UINavigationBar *)view;
//        bar.barTintColor = NightMainNaviColor;
//    }];
    self.navigationController.navigationBar.dk_barTintColorPicker = DKColorPickerWithColors(MainRedColor,NightMainNaviColor,MainRedColor);
    navBarHairlineImageView.hidden = YES;
    
    NSUserDefaults *def=[NSUserDefaults standardUserDefaults];
    BOOL isNight=[[def valueForKey:@"isNight"] boolValue];
    if(isNight){
        self.switchAction.on=YES;
    }else{
        self.switchAction.on=NO;
    }
    
}

- (UIImageView*)findHairlineImageViewUnder:(UIView*)view {
    if([view isKindOfClass:UIImageView.class] && view.bounds.size.height<=1.0) {
        return(UIImageView*)view;
    }
    for(UIView *subview in view.subviews) {
        UIImageView *imageView = [self findHairlineImageViewUnder:subview];
        if(imageView) {
            return imageView;
        }
    }
    return nil;
}

- (void)setupTableView
{
    self.tableView.dk_backgroundColorPicker = DKColorPickerWithColors(MainBGColor,NightMainColor,MainRedColor);
    self.tableView.dk_separatorColorPicker = DKColorPickerWithColors(MainBGColor,NightMainLineColor,MainRedColor);
    
    self.tableView.delegate = self;
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.top.mas_equalTo(0);
        make.bottom.mas_equalTo(0);
    }];
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return 2;
    } else if(section == 1) {
        return 1;
    } else {
        return 3;
    }

}
static NSString *USERID = @"userid";

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:USERID];
    if(!cell){
        cell = [[UITableViewCell alloc]initWithStyle:1 reuseIdentifier:USERID];
    }
    
    [cell xw_setDayMode:^(UIView *view) {
        UITableViewCell *cell = (UITableViewCell *)view;
        cell.backgroundColor = WhiteColor;
        cell.textLabel.textColor = BlackColor;
    } nightMode:^(UIView *view) {
        UITableViewCell *cell = (UITableViewCell *)view;
        cell.backgroundColor = NightMainCellColor;
        cell.textLabel.textColor = WhiteColor;
    }];
    
    cell.textLabel.font = [UIFont systemFontOfSize:RemindFont(14, 15, 16)];
    cell.detailTextLabel.font = [UIFont systemFontOfSize:RemindFont(14, 15, 16)];
    if (indexPath.section == 0) {
//        if (indexPath.row == 0) {
//            UISegmentedControl *segVc = [[UISegmentedControl alloc]initWithItems:@[@"大",@"中",@"小"]];
//            segVc.selectedSegmentIndex = 1;
//            segVc.tintColor = MainRedColor;
//            self.segVc = segVc;
//            cell.accessoryView = segVc;
//            cell.textLabel.text = @"字体大小";
//            [segVc addTarget:self action:@selector(changeFontSize:) forControlEvents:UIControlEventValueChanged];
//            cell.selectionStyle = UITableViewCellSelectionStyleNone;
//        }else
        if (indexPath.row == 0){
            cell.textLabel.text = @"清除缓存";
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            cell.detailTextLabel.text = [CleanCacheToolClass stringWithTotalSize:self.totalCacheSize];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }else{
            JLLog(@"self.totalCacheSize---%f",self.totalCacheSize);
            cell.textLabel.text = @"夜间模式";
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
            UISwitch *nightSwitch = [UISwitch new];
            self.switchAction = nightSwitch;
            
            NSUserDefaults *def=[NSUserDefaults standardUserDefaults];
            BOOL isNight=[[def valueForKey:@"isNight"] boolValue];
            
            if(isNight){
                nightSwitch.on=YES;
            }else{
                nightSwitch.on=NO;
            }
            nightSwitch.dk_onTintColorPicker=DKColorPickerWithKey(SWITCHCOLOR);
            
            cell.accessoryView = nightSwitch;
            [nightSwitch addTarget:self action:@selector(nightComing:) forControlEvents:UIControlEventValueChanged];

        }
        
    } else if (indexPath.section == 1){
//        if (indexPath.row == 0) {
        cell.textLabel.text = @"要闻推送";
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        UISwitch *notiSwitch = [UISwitch new];
        self.notiSwitchAction = notiSwitch;
        
        UIUserNotificationSettings *setting = [[UIApplication sharedApplication] currentUserNotificationSettings];
        if (UIUserNotificationTypeNone == setting.types) {
            JLLog(@"推送关闭");
            notiSwitch.on = NO;
        }else{
            JLLog(@"推送打开");
            notiSwitch.on = YES;
        }
        
        notiSwitch.dk_onTintColorPicker = DKColorPickerWithKey(SWITCHCOLOR);
        
        [notiSwitch addTarget:self action:@selector(notificationClick) forControlEvents:UIControlEventValueChanged];
        
        cell.accessoryView = notiSwitch;
        
//        }
//        else if (indexPath.row == 1){
//            cell.textLabel.text = @"给我们打分";
//            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
//            cell.selectionStyle = UITableViewCellSelectionStyleNone;
//        }
//        else{
//            cell.textLabel.text=@"智能无图";
//            cell.selectionStyle = UITableViewCellSelectionStyleNone;
//            UISwitch *noImageSwitch = [UISwitch new];
//            self.AINoImageSwitch = noImageSwitch;
//            if (kYLNoImageModeIsAvaliable) {
//                noImageSwitch.on = YES;
//            } else {
//                noImageSwitch.on = NO;
//            }
//            [noImageSwitch xw_setDayMode:^(UIView *view) {
//                UISwitch *nightSwitch1 = (UISwitch *)view;
//                nightSwitch1.onTintColor = MainRedColor;
//            } nightMode:^(UIView *view) {
//                UISwitch *nightSwitch1 = (UISwitch *)view;
//                nightSwitch1.onTintColor = NightMainBlueColor;
//            }];
//            
//            cell.accessoryView = noImageSwitch;
//            [noImageSwitch addTarget:self action:@selector(AINoPicClick:) forControlEvents:UIControlEventValueChanged];
//            
//        }
    } else {
        if (indexPath.row == 0) {
            cell.textLabel.text = @"阅读历史";
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
        }else if (indexPath.row == 1){
            cell.textLabel.text = @"系统设置";
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }else{
            cell.textLabel.text=@"当前版本";
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.accessoryType = UITableViewCellAccessoryNone;
            cell.detailTextLabel.text = [NSString stringWithFormat:@"V%@",SYS_NEWS_VERSION];
        }

    }
    //黑夜模式
    cell.dk_backgroundColorPicker = DKColorPickerWithColors(WhiteColor,NightMainCellColor,MainRedColor);
    cell.textLabel.dk_textColorPicker = DKColorPickerWithColors(BlackColor,WhiteColor,MainRedColor);
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.section == 0){
//        if(indexPath.row == 0){
//            JLLog(@"字体大小");
//
//        }else
        if (indexPath.row == 0){
            JLLog(@"清除缓存");
            [SVProgressHUD showWithStatus:@"正在清除缓存"];
            [CleanCacheToolClass cleanCacheWithPath:CachePath complete:^{
                [SVProgressHUD showSuccessWithStatus:@"清除成功!"];
                self.totalCacheSize = 0;
                [tableView reloadRowsAtIndexPaths:@[indexPath]withRowAnimation:0];
                
            }];

        }else{
            JLLog(@"夜间模式");
        }
        
    }else if(indexPath.section == 1){
        
        if(indexPath.row == 0){
            JLLog(@"要闻推送");

        }
//        else if (indexPath.row == 1){
//            JLLog(@"给我们打分");
//            NSURL *url = [NSURL URLWithString:@"http://itunes.apple.com/WebObjects/MZStore.woa/wa/viewContentsUserReviews?id=1253883280&pageNumber=0&sortOrdering=2&type=Purple+Software&mt=8"];
//            if([[UIApplication sharedApplication] canOpenURL:url]) {
//                [[UIApplication sharedApplication]openURL:url];
//            }
//        }
//        else{
//            JLLog(@"智能无图");
//        }
        
    }else if(indexPath.section == 2){
    
        if(indexPath.row == 0){
            
//            XWCetAndHisVC *infoVC = [[XWCetAndHisVC alloc]init];
//            [self.navigationController pushViewController:infoVC animated:YES];
            XWHistoryVC *hisVC = [[XWHistoryVC alloc]init];
            [self.navigationController pushViewController:hisVC animated:YES];
            
        }else if (indexPath.row == 1){
            JLLog(@"系统设置");
            [self notificationClick];
        }else{
            JLLog(@"当前版本");

        }
        
    }

}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if(section==0){
        return 10;
    }else{
        return 8;
    }
    
}

-(void)changeFontSize:(UISegmentedControl *)seg{
    
    switch (seg.selectedSegmentIndex) {
        case 0:
            [self.appFont changeBeginBigFont];
            break;
        case 1:
            [self.appFont changeBeginMediumFont];
            break;
        case 2:
            [self.appFont changeBeginSmallFont];
            break;
        default:
            break;
    }
    
}

- (void)nightComing:(UISwitch *)sender{
    NSUserDefaults *def=[NSUserDefaults standardUserDefaults];
    
    if ([self.dk_manager.themeVersion isEqualToString:DKThemeVersionNight]) {
        //切换到正常模式
        [self.dk_manager dawnComing];
//        [SGActionView sharedActionView].style = SGActionViewStyleLight;
        [def setBool:NO forKey:@"isNight"];
    } else {
        //切换到夜间模式
        [self.dk_manager nightFalling];
//        [SGActionView sharedActionView].style = SGActionViewStyleDark;
        [def setBool:YES forKey:@"isNight"];
    }
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"HomePageChangeNight" object:nil];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"MineChangeNight" object:nil];

}

- (void)notificationClick{
    NSURL * url = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
    if([[UIApplication sharedApplication] canOpenURL:url]) {
        NSURL *url = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
        [[UIApplication sharedApplication] openURL:url];
    }
    
}

- (void)AINoPicClick:(UISwitch *)sender{
    
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];

    JLLog(@"dealloc");
}


@end
