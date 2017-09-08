//
//  XWHomeDetailNewsVC.m
//  zhangshangPacket
//
//  Created by apple on 2017/7/24.
//  Copyright © 2017年 apple-fangqiu. All rights reserved.
//

#import "XWHomeDetailNewsVC.h"
#import <TYAttributedLabel/TYAttributedLabel.h>
#import "RegexKitLite.h"
#import "XWWKWebTodayVC.h"
#import "XWHomeModel.h"
#import "XWHomeCheckCollectTool.h"
#define RGB(r,g,b,a)	[UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:a]
@interface XWHomeDetailNewsVC ()<TYAttributedLabelDelegate>
{
    NSString *advimg;
    NSString *advurl;
    NSString *content;
    NSString *desc;
    NSString *resource;
    NSString *title;
    NSString *dataStrImg;
    NSString *dataStrLab;
}
@property (nonatomic, weak) UIScrollView *scrollView;
@property (nonatomic, weak) TYAttributedLabel *label1;
@property (nonatomic, strong) NSMutableArray *imglist;
@property (nonatomic, strong) NSMutableArray *dataArray;
/**
 * bgImageView
 */
@property(nonatomic, strong) UIImageView *adImageView;

@property (nonatomic, strong) UIButton *button;

@end

@implementation XWHomeDetailNewsVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self addScrollView];

    for (NewsListDataModel *model in [XWHomeCheckCollectTool topics]) {
        if (_listModel.id == model.id) {
            
            [self.button setImage:MyImage(@"icon_star_select") forState:UIControlStateSelected];
            [self.button setTitle:@"已收藏" forState:UIControlStateSelected];
            [self.button setTitleColor:CUSTOMCOLOR(255, 202, 10) forState:0];
            [self.button addTarget:self action:@selector(collectClick:) forControlEvents:UIControlEventTouchUpInside];
            UIBarButtonItem *rightBarButtomItem = [[UIBarButtonItem alloc]initWithCustomView:self.button];
            self.navigationItem.rightBarButtonItem = rightBarButtomItem;
            
            break;
        }
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

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self preferredStatusBarStyle];
    [self setStatusBarBackgroundColor:MainRedColor];
    self.navigationController.navigationBar.translucent = NO;
    self.navigationController.navigationBar.dk_barTintColorPicker = DKColorPickerWithColors(MainRedColor,NightMainNaviColor,MainRedColor);

    
}

- (void)addScrollView
{
    if (STUserDefaults.ischeck == 1) {
        UIButton *button = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 100, 40)];
        self.button = button;
        [button setImage:MyImage(@"icon_star_unselect") forState:UIControlStateNormal];
        [button setTitle:@"收藏" forState:UIControlStateNormal];
        button.titleLabel.font = [UIFont systemFontOfSize:RemindFont(14, 15, 16)];
        [button setTitleColor:CUSTOMCOLOR(180, 180, 180) forState:UIControlStateNormal];
        
        [button setImage:MyImage(@"icon_star_select") forState:UIControlStateSelected];
        [button setTitle:@"已收藏" forState:UIControlStateSelected];
        [button setTitleColor:CUSTOMCOLOR(255, 202, 10) forState:UIControlStateSelected];
        [button addTarget:self action:@selector(collectClick:) forControlEvents:UIControlEventTouchUpInside];
        UIBarButtonItem *rightBarButtomItem = [[UIBarButtonItem alloc]initWithCustomView:button];
        self.navigationItem.rightBarButtonItem = rightBarButtomItem;
    } else {
        JLLog(@"无收藏");
    }
    
    UIScrollView *scrollView = [[UIScrollView alloc]initWithFrame:self.view.bounds];
    scrollView.dk_backgroundColorPicker = DKColorPickerWithColors(WhiteColor,NightMainBGColor,MainRedColor);
    
    [self.view addSubview:scrollView];
    _scrollView = scrollView;
    
    [self setupRefresh];
    
}

- (void)collectClick:(UIButton *)sender
{
    sender.selected = !sender.selected;
    if (sender.selected) {
        [SVProgressHUD showSuccessWithStatus:@"收藏成功"];
        
        [XWHomeCheckCollectTool saveTopic:_listModel];

    } else {
        [SVProgressHUD showErrorWithStatus:@"取消收藏"];
        [XWHomeCheckCollectTool deleteDataFromSql:_listModel.id];
    }

}

- (void)setupRefresh
{
    [self loadNewsCheckDataWithParam:[_newsId integerValue]];

}

- (void)loadNewsCheckDataWithParam:(NSInteger)newsId
{
    /*
     advimg = "http://img.jpg ";
     advurl = "http:html";
     content = "文章内容：新華網@#labl1某某某,新華網@#labl2某某某@#KDNL";
     desc = "申明：本文是搜索转码后的内容，仅代表做个跟人观点，亦不构成投资建议。版权归原作者所有....";
     imglist =         (
        {
            imgurl = "http:/img.jgp";
            label = "#label1";
        },
        {
            imgurl = "http:/img.jgp";
            label = "#label2";
        }
     );
     resource = "來源";
     title = "文章标题";
     */
    [SVProgressHUD showWithMaskType:SVProgressHUDMaskTypeBlack];
    [STRequest NewsTestRichTestWithCheckNewsID:newsId WithDataBlock:^(id ServersData, BOOL isSuccess) {
        JLLog(@"serverdata---%@",ServersData);
        if (isSuccess) {
            if ([ServersData isKindOfClass:[NSDictionary class]]) {
                NSString *cStr = [NSString stringWithFormat:@"%@",ServersData[@"c"]];
                [SVProgressHUD dismiss];
                if ([cStr isEqualToString:@"1"]) {
                    NSDictionary *dictemp = [NSDictionary dictionaryWithDictionary:ServersData[@"d"]];
                    
                    advimg = dictemp[@"advimg"];
                    advurl = dictemp[@"advurl"];
                    content = dictemp[@"content"];
                    desc = dictemp[@"desc"];
                    
                    self.imglist = [NSMutableArray arrayWithArray:dictemp[@"imglist"]];
                    if (self.imglist.count == 0) {
                        JLLog(@"无图");
                    } else {
                        for (int i = self.imglist.count - 1 ; i >= 0; i--) {
                            //[NewsListDataModel mj_objectArrayWithKeyValuesArray:arrtemp];
                            [self.dataArray addObject:self.imglist[i]];
                        }
                    }
                    
                    resource = dictemp[@"resource"];
                    title = dictemp[@"title"];
                    
                    // appendAttributedText
                    [self addTextAttributedLabel1];
                    
                }else{
                    JLLog(@"%@",ServersData[@"m"]);
                }
                
            } else {
                [SVProgressHUD showErrorWithStatus:@"网络错误，请重试"];

            }
            
        } else {
            [SVProgressHUD showErrorWithStatus:@"网络错误，请重试"];

        }
        
    }];
    
}

// appendAttributedText
- (void)addTextAttributedLabel1
{
    //标题
    UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 10, ScreenW-20, 50)];
    titleLabel.text = title;
    titleLabel.font = [UIFont systemFontOfSize:RemindFont(17, 18, 19)];
    titleLabel.dk_textColorPicker = DKColorPickerWithColors(BlackColor,WhiteColor,MainRedColor);
    titleLabel.textAlignment = NSTextAlignmentLeft;
    titleLabel.numberOfLines = 2;
    [_scrollView addSubview:titleLabel];
    
    //来源
    UILabel *resourceLab = [[UILabel alloc]initWithFrame:CGRectMake(10, 60, ScreenW-20, 20)];
    resourceLab.text = resource;
    resourceLab.font = [UIFont systemFontOfSize:RemindFont(12, 13, 14)];
    resourceLab.dk_textColorPicker = DKColorPickerWithColors(MainGrayTextColor,MainGrayTextColor,MainRedColor);

    resourceLab.textAlignment = NSTextAlignmentLeft;
    [_scrollView addSubview:resourceLab];
    
    //下划线
    UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(10, 90, ScreenW-20, 1)];
    lineView.dk_backgroundColorPicker = DKColorPickerWithColors(BlackColor,MainGrayTextColor,MainRedColor);
    [_scrollView addSubview:lineView];
    
    //内容
    TYAttributedLabel *label = [[TYAttributedLabel alloc]initWithFrame:CGRectMake(10, 100, CGRectGetWidth(self.view.frame)-20, 0)];
    label.delegate = self;
    [_scrollView addSubview:label];
    _label1 = label;
    
    NSString *text = content;
    NSArray *array = [text componentsSeparatedByString:@"@#KDNL"];
    
    for (int i = 0; i<array.count; i++) {
        NSString *textStr = array[i];
        
        if (i <= _dataArray.count-1) {
            dataStrLab = self.dataArray[i][@"label"];
            NSString *newStr = [textStr stringByReplacingOccurrencesOfString:dataStrLab withString:@""];
            [label appendText:newStr];
            [label appendText:@"\n\t"];
            
            TYImageStorage *imageStorageAlignCenter = [[TYImageStorage alloc]init];
            
            if (self.dataArray.count == 0) {
                imageStorageAlignCenter.image = MyImage(@"bg_default");
            } else {
                NSString *imgLabelUrl = [NSString stringWithFormat:@"%@",self.dataArray[i][@"imgurl"]];
                imageStorageAlignCenter.imageURL = [NSURL URLWithString:imgLabelUrl];
            }
            
            imageStorageAlignCenter.imageAlignment = TYImageAlignmentCenter;
            imageStorageAlignCenter.size = CGSizeMake(CGRectGetWidth(self.view.frame), 220*AdaptiveScale_W);
            [label appendTextStorage:imageStorageAlignCenter];
            [label appendText:@"\n\t"];
            
        }else{
        
            [label appendText:textStr];
            [label appendText:@"\n\t"];
        }
    }
    [label sizeToFit];
    [label appendText:@"\n\t"];
    
    //描述
    UILabel *descLab = [[UILabel alloc]initWithFrame:CGRectMake(10, CGRectGetMaxY(label.frame), ScreenW-20, 60*AdaptiveScale_W)];
    descLab.text = desc;
    descLab.numberOfLines = 0;
    descLab.font = [UIFont systemFontOfSize:RemindFont(12, 13, 14)];
    descLab.textAlignment = NSTextAlignmentLeft;
    descLab.textColor = MainGrayTextColor;
    [_scrollView addSubview:descLab];
    
    //广告
    
    if ([advimg isEqualToString:@""]) {
        _scrollView.contentSize = CGSizeMake(ScreenW, CGRectGetMaxY(descLab.frame)+100);

    }else{
    
        UIImageView *adImageView = [[UIImageView alloc]init];
        adImageView.frame = CGRectMake(10, CGRectGetMaxY(descLab.frame)+10, ScreenW-20, 200*AdaptiveScale_W);
        JLLog(@"advimg---%@",advimg);
        [adImageView sd_setImageWithURL:[NSURL URLWithString:advimg] placeholderImage:MyImage(@"bg_default")options:SDWebImageCacheMemoryOnly|SDWebImageRefreshCached];
        adImageView.userInteractionEnabled = YES;
        UITapGestureRecognizer *tapG = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(adImageViewClick)];
        [adImageView addGestureRecognizer:tapG];
        [_scrollView addSubview:adImageView];
        _scrollView.contentSize = CGSizeMake(ScreenW, CGRectGetMaxY(adImageView.frame)+100);

    }
}

- (void)adImageViewClick
{
    XWWKWebTodayVC *webVC = [[XWWKWebTodayVC alloc]init];
    JLLog(@"url===%@",advurl);
    [webVC loadWebURLSring:advurl];
    [self setHidesBottomBarWhenPushed:YES];//隐藏tabbar
    [self.navigationController pushViewController:webVC animated:YES];
}


- (NSMutableArray *)imglist
{
    if (!_imglist) {
        _imglist = [NSMutableArray array];
    }
    return _imglist;
}

- (NSMutableArray *)dataArray
{
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
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
