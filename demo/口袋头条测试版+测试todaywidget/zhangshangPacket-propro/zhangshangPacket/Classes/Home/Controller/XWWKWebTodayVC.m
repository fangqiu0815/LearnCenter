//
//  XWWKWebTodayVC.m
//  zhangshangPacket
//
//  Created by apple on 2017/6/1.
//  Copyright © 2017年 apple-fangqiu. All rights reserved.
//

#import "XWWKWebTodayVC.h"
#import <WebKit/WKWebView.h>
#import <WebKit/WebKit.h>
#import <UMSocialCore/UMSocialCore.h>

#import "XWPublishView.h"
typedef enum{
    loadWebURLString = 0,
    loadWebHTMLString,
    POSTWebURLString,
}wkWebLoadType;

static void *WkwebBrowserContext = &WkwebBrowserContext;

@interface XWWKWebTodayVC ()

<WKNavigationDelegate,WKUIDelegate,WKScriptMessageHandler,UINavigationControllerDelegate,UINavigationBarDelegate,UIScrollViewDelegate,XFPublishViewDelegate>

@property (nonatomic, strong) WKWebView *wkWebView;
//设置加载进度条
@property (nonatomic,strong) UIProgressView *progressView;
//仅当第一次的时候加载本地JS
@property(nonatomic,assign) BOOL needLoadJSPOST;
//网页加载的类型
@property(nonatomic,assign) wkWebLoadType loadType;
//保存的网址链接
@property (nonatomic, copy) NSString *URLString;
//保存POST请求体
@property (nonatomic, copy) NSString *postData;
//保存请求链接
@property (nonatomic)NSMutableArray* snapShotsArray;
//返回按钮
@property (nonatomic)UIBarButtonItem* customBackBarItem;
//关闭按钮
@property (nonatomic)UIBarButtonItem* closeButtonItem;

@property (nonatomic, strong) WKUserContentController * UserContentController;

@property (nonatomic, strong) UIAlertView *WXinstall;

@property (nonatomic, assign) CGFloat newsHeightY;

@property (nonatomic, assign) NSInteger statusTaskFinish;

@property (nonatomic, strong) UILabel *numLab;

@property (nonatomic, strong) UIView *receiveView;
@end

@implementation XWWKWebTodayVC

- (void)viewDidLoad {
    [super viewDidLoad];
    isFirstScrollBottom = YES;
    
    //加载web页面
    [self webViewloadURLType];
    
    //添加到主控制器上
    [self.view addSubview:self.wkWebView];
    
    self.wkWebView.scrollView.bounces = YES;
    self.wkWebView.scrollView.delegate = self;
    //添加进度条
    [self.view addSubview:self.progressView];
    
//    //添加右边分享按钮
//    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamedWithRenderOriginal:@"icon_share"] style:UIBarButtonItemStyleDone target:self action:@selector(shareClick:)];
    
    //创建弹出框
    [self setupAlert];



}

//- (void)scrollViewDidScroll:(UIScrollView *)scrollView
//{
//    CGFloat height = scrollView.frame.size.height;
//    CGFloat contentYoffset = scrollView.contentOffset.y;
//    CGFloat distanceFromBottom = scrollView.contentSize.height - contentYoffset;
//    
//    if (distanceFromBottom <= height) {
//        if (isFirstScrollBottom == YES) {
//            if (isFinishWeb) {
//                
//                [self watchNewsReturnAndId:self.artid];
//                isFirstScrollBottom = NO;
//            }else{
//                
//                JLLog(@"稍等文章加载完");
//                
//            }
//        }
//    }
//    
//}

- (void)watchNewsReturnAndId:(int)newsid
{
    [STRequest WatchADBackDataWithParam:newsid WithDataBlock:^(id ServersData, BOOL isSuccess) {
        if (isSuccess) {
            JLLog(@"serverdata---%@",ServersData);
            if ([ServersData isKindOfClass:[NSDictionary class]]) {
                if ([ServersData[@"c"] intValue] == 1) {
                    [SVProgressHUD dismiss];
                    
                    NSDictionary *dict = [NSDictionary dictionaryWithDictionary:ServersData[@"d"]];
                    
                    if ([dict count] == 0) {
                        
                        JLLog(@"无数据");
                        
                    } else {
                        NSString *ingot = [NSString stringWithFormat:@"%@",dict[@"ingot"]];
                        NSString *status = [NSString stringWithFormat:@"%@",dict[@"status"]];
                        NSMutableArray *readingArr = [NSMutableArray arrayWithArray:dict[@"taskstatus"]];
                        
                        JLLog(@"%@",readingArr);
                        
                        if (_artid < SYS_AD_MINID || _artid > SYS_AD_MAXID) {
                            if ([_newstype intValue] == 0) {//普通文章
                                
                                if ([readingArr count] == 0) {
                                    JLLog(@"无数据");
                                } else {
                                    NSString *readingStatus = [NSString stringWithFormat:@"%@",readingArr[0][@"status"]];
                                    NSString *readingIngot = [NSString stringWithFormat:@"%@",readingArr[0][@"ingot"]];
                                    NSString *readingDesc = [NSString stringWithFormat:@"%@",readingArr[0][@"desc"]];
                                    
                                    JLLog(@"%@---%@---%@",readingStatus,readingIngot,readingDesc);
                                    //判断readingArr 不止完成了一个任务 并可以进行多个任务
                                    
                                    for (int i = 0; i<readingArr.count; i++) {
                                        NSMutableArray *readingStatusArray;
                                        NSMutableArray *readingIngotArray;
                                        NSMutableArray *readingDescArray;
                                        [readingStatusArray addObject:readingArr[i][@"status"]];
                                        [readingIngotArray addObject:readingArr[i][@"ingot"]];
                                        [readingDescArray addObject:readingArr[i][@"desc"]];
                                    }
                                    
                                    
                                    if ([status integerValue] == -1 ) {
                                        //                                            [self setupAlertViewWithTitle:[NSString stringWithFormat:@"+%@",ingot]];
                                        //                                            [SVProgressHUD showSuccessWithStatus:readingDesc];
                                        JLLog(@"当前类型任务已完成");
                                    } else if([status integerValue] == 0){
                                        
                                        if (readingArr.count == 0) {
                                            
                                            JLLog(@"当前任务类型进行中遇到空数组");
                                        } else {
                                            if ([readingStatus integerValue] == 0) {
                                                
                                                //                                                    [self setupAlertViewWithTitle:[NSString stringWithFormat:@"+%@",ingot]];
                                                [SVProgressHUD showSuccessWithStatus:readingDesc];
                                                
                                            } else {
                                                NSString *adnewsStr = [NSString stringWithFormat:@"%ld",(long)[ingot integerValue]+[readingIngot integerValue]];
                                                
                                                //                                                    [self setupAlertViewWithTitle:adnewsStr];
                                                [SVProgressHUD showSuccessWithStatus:readingDesc];
                                                
                                            }
                                            
                                        }
                                        
                                    } else if ([status integerValue] == 1){
                                        
                                        if (readingArr.count == 0) {
                                            
                                            JLLog(@"当前任务类型完成时遇到空数组");
                                        } else {
                                            if ([readingStatus integerValue] == 0) {
                                                
                                                //                                                    [self setupAlertViewWithTitle:[NSString stringWithFormat:@"+%@",ingot]];
                                                //                                                    [SVProgressHUD showSuccessWithStatus:readingDesc];
                                                JLLog(@"当前任务类型已完成");
                                                
                                            } else {
                                                NSString *adnewsStr = [NSString stringWithFormat:@"%ld",(long)[ingot integerValue]+[readingIngot integerValue]];
                                                [self setupAlertViewWithTitle:adnewsStr];
                                                [SVProgressHUD showSuccessWithStatus:readingDesc];
                                                
                                            }
                                            
                                        }
                                        
                                    }
                                }
                                
                            }else if ([_newstype intValue] == 1)
                            {//看文章奖励 分享无奖励
                                NSString *readingStatus = [NSString stringWithFormat:@"%@",readingArr[0][@"status"]];
                                NSString *readingIngot = [NSString stringWithFormat:@"%@",readingArr[0][@"ingot"]];
                                NSString *readingDesc = [NSString stringWithFormat:@"%@",readingArr[0][@"desc"]];
                                
                                JLLog(@"%@---%@---%@",readingStatus,readingIngot,readingDesc);
                                
                                if ([status integerValue] == -1 ) {
                                    //                                        [self setupAlertViewWithTitle:[NSString stringWithFormat:@"+%@",ingot]];
                                    //                                        [SVProgressHUD showSuccessWithStatus:readingDesc];
                                    JLLog(@"当前类型任务已完成");
                                    
                                } else if([status integerValue] == 0){
                                    
                                    if (readingArr.count == 0) {
                                        
                                        JLLog(@"当前任务类型进行中遇到空数组");
                                    } else {
                                        if ([readingStatus integerValue] == 0) {
                                            if ([readingIngot integerValue] == 0) {
                                                JLLog(@"任务进行中----+%@%@",ingot,readingIngot);
                                            } else {
                                                //                                                    [self setupAlertViewWithTitle:[NSString stringWithFormat:@"+%@",ingot]];
                                                JLLog(@"任务有奖励----%@",readingIngot);
                                            }
                                            
                                            [SVProgressHUD showSuccessWithStatus:readingDesc];
                                            
                                        } else {
                                            NSString *adnewsStr = [NSString stringWithFormat:@"%ld",(long)[ingot integerValue]+[readingIngot integerValue]];
                                            [self setupAlertViewWithTitle:adnewsStr];
                                            JLLog(@"任务完成----+%@%@",ingot,readingIngot);
                                            [SVProgressHUD showSuccessWithStatus:readingDesc];
                                            
                                        }
                                        
                                    }
                                    
                                } else if ([status integerValue] == 1){
                                    
                                    if (readingArr.count == 0) {
                                        
                                        JLLog(@"当前任务类型完成时遇到空数组");
                                    } else {
                                        if ([readingStatus integerValue] == 0) {
                                            
                                            if ([readingIngot integerValue] == 0) {
                                                JLLog(@"1当前任务类型已完成----+%@%@",ingot,readingIngot);
                                                [SVProgressHUD showSuccessWithStatus:readingDesc];
                                            } else {
                                                //                                                    [self setupAlertViewWithTitle:[NSString stringWithFormat:@"+%@",ingot]];
                                                //                                                    [SVProgressHUD showSuccessWithStatus:readingDesc];
                                                JLLog(@"1当前任务类型已完成----+%@%@",ingot,readingIngot);
                                                
                                            }
                                            
                                        } else {
                                            NSString *adnewsStr = [NSString stringWithFormat:@"%ld",(long)[ingot integerValue]+[readingIngot integerValue]];
                                            
                                            [self setupAlertViewWithTitle:adnewsStr];
                                            [SVProgressHUD showSuccessWithStatus:readingDesc];
                                            JLLog(@"2当前任务类型已完成----+%@%@",ingot,readingIngot);
                                            
                                        }
                                        
                                        
                                    }
                                    
                                }
                                
                            }else{
                                //分享奖励 看文章无奖励
                                [SVProgressHUD showSuccessWithStatus:@"你阅读的文章需要分享才能获得奖励哦"];
                                
                            }
                            
                        }else{//广告
                            
                            NSString *readingStatus = [NSString stringWithFormat:@"%@",readingArr[0][@"status"]];
                            NSString *readingIngot = [NSString stringWithFormat:@"%@",readingArr[0][@"ingot"]];
                            NSString *readingDesc = [NSString stringWithFormat:@"%@",readingArr[0][@"desc"]];
                            
                            JLLog(@"%@---%@---%@",readingStatus,readingIngot,readingDesc);
                            
                            
                            if ([status integerValue] == -1 ) {
                                //                                    [self setupAlertViewWithTitle:[NSString stringWithFormat:@"+%@",ingot]];
                                //                                    [SVProgressHUD showSuccessWithStatus:readingDesc];
                                JLLog(@"广告-----当前类型任务已完成");
                                
                            } else if([status integerValue] == 0){
                                
                                if (readingArr.count == 0) {
                                    
                                    JLLog(@"当前任务类型进行中遇到空数组");
                                } else {
                                    if ([readingStatus integerValue] == 0) {
                                        //                                            [self setupAlertViewWithTitle:[NSString stringWithFormat:@"+%@",ingot]];
                                        [SVProgressHUD showSuccessWithStatus:readingDesc];
                                        
                                    } else {
                                        NSString *adnewsStr = [NSString stringWithFormat:@"%ld",(long)[ingot integerValue]+[readingIngot integerValue]];
                                        
                                        [self setupAlertViewWithTitle:adnewsStr];
                                        [SVProgressHUD showSuccessWithStatus:readingDesc];
                                        
                                    }
                                    
                                }
                                
                            } else if ([status integerValue] == 1){
                                
                                if (readingArr.count == 0) {
                                    
                                    JLLog(@"当前任务类型完成时遇到空数组");
                                } else {
                                    if ([readingStatus integerValue] == 0) {
                                        //                                            [self setupAlertViewWithTitle:[NSString stringWithFormat:@"+%@",ingot]];
                                        //                                            [SVProgressHUD showSuccessWithStatus:readingDesc];
                                        JLLog(@"当前任务类型已完成");
                                        
                                    } else {
                                        NSString *adnewsStr = [NSString stringWithFormat:@"%ld",(long)[ingot integerValue]+[readingIngot integerValue]];
                                        
                                        [self setupAlertViewWithTitle:adnewsStr];
                                        [SVProgressHUD showSuccessWithStatus:readingDesc];
                                    }
                                    
                                }
                                
                            }
                            
                        }
                        
                    }
                }else{
                    
                    //[SVProgressHUD showErrorWithStatus:ServersData[@"m"]];
                    JLLog(@"%@",ServersData[@"m"]);
                }
            }else{
                [SVProgressHUD showErrorWithStatus:@"服务端数据出错"];
            }
        }else{
            
            [SVProgressHUD showErrorWithStatus:@"网络出错"];
        }
        
    }];
    
    
}


- (void)setupAlert
{
    
    self.WXinstall = [[UIAlertView alloc]initWithTitle:@"奖励领取" message:self.ingotView delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
}

#pragma makr ======================= 分享回调 ===========================
/*
 *********************************************************************************
 分享回调分为 1.分享文章有任务 2.分享文章没任务 3.分享广告有任务 4.分享广告无任务
 5.分享app
 
 *********************************************************************************
 */



- (void)shareClick:(id)sender
{
    
    XWPublishView *publishView = [[XWPublishView alloc]initWithFrame:[UIScreen mainScreen].bounds];
    publishView.delegate = self;
    [publishView  show];
   
}

-(void)didSelectBtnWithBtnTag:(NSInteger)tag
{
    //    NSMutableDictionary *shareParams = [NSMutableDictionary dictionary];
    //    JLLog(@"分享路径：%@",_urlStr);
    //
    //创建网页内容对象
    NSString *urlStringMore = [NSString stringWithFormat:@"%@&uid=%@&name=%@&id=%d&longitude=%@&latitude=%@",_urlStr,STUserDefaults.uid,STUserDefaults.name,_artid,STUserDefaults.longitude,STUserDefaults.latitude];
    JLLog(@"url--%@",urlStringMore);
    //创建分享消息对象
    UMSocialMessageObject *messageObject = [UMSocialMessageObject messageObject];
    
    UMShareWebpageObject *shareObject = [UMShareWebpageObject shareObjectWithTitle:_titleStr descr:nil thumImage:MyImage(@"icon-120*120")];
    //设置网页地址
    shareObject.webpageUrl = urlStringMore;
    
    //分享消息对象设置分享内容对象
    messageObject.shareObject = shareObject;
    
    
    if (tag == 1) {
        //朋友圈
        //分享到微信朋友圈
        if (STUserDefaults.isLogin){
            
            //调用分享接口
            [[UMSocialManager defaultManager] shareToPlatform:UMSocialPlatformType_WechatTimeLine messageObject:messageObject currentViewController:self completion:^(id data, NSError *error) {
                if (error) {
                    UMSocialLogInfo(@"************Share fail with error %@*********",error);
                    [SVProgressHUD showErrorWithStatus:@"分享失败"];
                }else{
                    if ([data isKindOfClass:[UMSocialShareResponse class]]) {
                        UMSocialShareResponse *resp = data;
                        //分享结果消息
                        UMSocialLogInfo(@"response message is %@",resp.message);
                        //第三方原始返回的数据
                        UMSocialLogInfo(@"response originalResponse data is %@",resp.originalResponse);
                        
                        UIAlertController *alert=[UIAlertController alertControllerWithTitle:@"提示" message:@"分享成功" preferredStyle:UIAlertControllerStyleAlert];
                        
                        [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                            if (_artid < SYS_AD_MINID || _artid > SYS_AD_MAXID) {//文章
                                if ([_newstype intValue] == 2) {
                                    //分享奖励
                                    [SVProgressHUD showSuccessWithStatus:@"获得分享奖励"];
                                    
                                }else{
                                    
                                    //分享普通新闻
                                    [SVProgressHUD showSuccessWithStatus:@"无奖励"];
                                    
                                }
                            } else {
                                
                                [SVProgressHUD showSuccessWithStatus:@"获得分享广告奖励"];
                                
                                
                            }

                            
                        }]];
                        
                        
                        [self presentViewController:alert animated:YES completion:nil];
                        
                    }else{
                        UMSocialLogInfo(@"response data is %@",data);
                    }
                }
            }];
            
        }
        else
        {
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"是否前往微信登录?" preferredStyle:UIAlertControllerStyleAlert];
            [alert addAction:[UIAlertAction actionWithTitle:@"是" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                [[NSNotificationCenter defaultCenter] postNotificationName:@"login" object:nil];
                
            }]];
            [alert addAction:[UIAlertAction actionWithTitle:@"否" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                
            }]];
            
            [self presentViewController:alert animated:YES completion:nil];
            
        }
        
    } else if(tag == 2){
        //微信好友
        if (STUserDefaults.isLogin){
            
            //调用分享接口
            [[UMSocialManager defaultManager] shareToPlatform:UMSocialPlatformType_WechatSession messageObject:messageObject currentViewController:self completion:^(id data, NSError *error) {
                if (error) {
                    UMSocialLogInfo(@"************Share fail with error %@*********",error);
                    [SVProgressHUD showErrorWithStatus:@"分享失败"];

                }else{
                    if ([data isKindOfClass:[UMSocialShareResponse class]]) {
                        UMSocialShareResponse *resp = data;
                        //分享结果消息
                        UMSocialLogInfo(@"response message is %@",resp.message);
                        //第三方原始返回的数据
                        UMSocialLogInfo(@"response originalResponse data is %@",resp.originalResponse);
                        
                        UIAlertController *alert=[UIAlertController alertControllerWithTitle:@"提示" message:@"分享成功" preferredStyle:UIAlertControllerStyleAlert];
                        
                        [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                            if (_artid < SYS_AD_MINID || _artid > SYS_AD_MAXID) {//文章
                                if ([_newstype intValue] == 2) {
                                    //分享奖励
                                    [SVProgressHUD showSuccessWithStatus:@"获得分享奖励"];
                                    
                                }else{
                                    
                                    //分享普通新闻
                                    [SVProgressHUD showSuccessWithStatus:@"无奖励"];
                                    
                                }
                            } else {
                                
                                [SVProgressHUD showSuccessWithStatus:@"获得分享广告奖励"];
                                
                                
                            }

                            
                        }]];
                        
                        
                        [self presentViewController:alert animated:YES completion:nil];
                        
                    }else{
                        UMSocialLogInfo(@"response data is %@",data);
                    }
                }
                [SVProgressHUD showErrorWithStatus:@"分享失败"];
            }];
            
        }
        else
        {
            {
                UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"是否前往微信登录?" preferredStyle:UIAlertControllerStyleAlert];
                [alert addAction:[UIAlertAction actionWithTitle:@"是" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                    [[NSNotificationCenter defaultCenter] postNotificationName:@"login" object:nil];
                    
                }]];
                [alert addAction:[UIAlertAction actionWithTitle:@"否" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                    
                }]];
                
                [self presentViewController:alert animated:YES completion:nil];
                
            }
            
        }
        
    }
    
}


//- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
//{
//    if (_isAd == 0) {
//        JLLog(@"无奖励");
//    }else{
//        if (scrollView.contentOffset.y == scrollView.contentSize.height - scrollView.frame.size.height) {
//
//            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//                [STRequest LookADAfterDataWithParam:_docid andDataBlock:^(id ServersData, BOOL isSuccess) {
//                    if (isSuccess) {
//                        if ([ServersData isKindOfClass:[NSDictionary class]]) {
//                            if ([ServersData[@"c"] intValue] == 1) {
//                                [SVProgressHUD dismiss];
//
//                                NSString *ingot = [NSString stringWithFormat:@"%@",ServersData[@"d"][@"ingot"]];
//                                JLLog(@"ingot---%@",ingot);
//
//                            }else{
//
//                                [SVProgressHUD showErrorWithStatus:ServersData[@"m"]];
//                            }
//                        }else{
//                            [SVProgressHUD showErrorWithStatus:@"服务端数据出错"];
//                        }
//                    }else{
//
//                        [SVProgressHUD showErrorWithStatus:@"网络出错"];
//                    }
//
//                }];
//
//            });
//
//        }else{
//
//            [SVProgressHUD showErrorWithStatus:@"请看的多一点时间，不然奖励不给你"];
//        }
//
//    }
//
//}

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

    if (_isNavHidden == YES) {
        self.navigationController.navigationBarHidden = YES;
        //创建一个高20的假状态栏
        UIView *statusBarView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 20)];
        //设置成绿色
        statusBarView.backgroundColor = MainRedColor;
        // 添加到 navigationBar 上
        [self.view addSubview:statusBarView];
    }else{
        self.navigationController.navigationBarHidden = NO;
    }
}

//
//- (void)roadLoadClicked{
//    [self.wkWebView reload];
//}

-(void)customBackItemClicked{
    if (self.wkWebView.goBack) {
        [self.wkWebView goBack];
    }else{
        [self.navigationController popViewControllerAnimated:YES];
    }
}
-(void)closeItemClicked{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark ================ 加载方式 ================

- (void)webViewloadURLType{
    switch (self.loadType) {
        case loadWebURLString:{
            //创建一个NSURLRequest 的对象
            NSURLRequest * Request_zsj = [NSURLRequest requestWithURL:[NSURL URLWithString:self.URLString] cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:10];
            //加载网页
            [self.wkWebView loadRequest:Request_zsj];
            break;
        }
        case loadWebHTMLString:{
            [self loadHostPathURL:self.URLString];
            break;
        }
        case POSTWebURLString:{
            // JS发送POST的Flag，为真的时候会调用JS的POST方法
            self.needLoadJSPOST = YES;
            //POST使用预先加载本地JS方法的html实现，请确认WKJSPOST存在
            [self loadHostPathURL:@"WKJSPOST"];
            break;
        }
    }
}

- (void)loadHostPathURL:(NSString *)url{
    //获取JS所在的路径
    NSString *path = [[NSBundle mainBundle] pathForResource:url ofType:@"html"];
    //获得html内容
    NSString *html = [[NSString alloc] initWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
    //加载js
    [self.wkWebView loadHTMLString:html baseURL:[[NSBundle mainBundle] bundleURL]];
}

// 调用JS发送POST请求
- (void)postRequestWithJS {
    // 拼装成调用JavaScript的字符串
    NSString *jscript = [NSString stringWithFormat:@"post('%@',{%@});", self.URLString, self.postData];
    // 调用JS代码
    [self.wkWebView evaluateJavaScript:jscript completionHandler:^(id object, NSError * _Nullable error) {
    }];
}


- (void)loadWebURLSring:(NSString *)string{
    self.URLString = string;
    self.loadType = loadWebURLString;
}

- (void)loadWebHTMLSring:(NSString *)string{
    self.URLString = string;
    self.loadType = loadWebHTMLString;
}

- (void)POSTWebURLSring:(NSString *)string postData:(NSString *)postData{
    self.URLString = string;
    self.postData = postData;
    self.loadType = POSTWebURLString;
}

//#pragma mark   ============== URL pay 开始支付 ==============
//
//- (void)payWithUrlOrder:(NSString*)urlOrder
//{
//    if (urlOrder.length > 0) {
//        __weak XFWkwebView* wself = self;
//        [[AlipaySDK defaultService] payUrlOrder:urlOrder fromScheme:@"giftcardios" callback:^(NSDictionary* result) {
//            // 处理支付结果
//            NSLog(@"===============%@", result);
//            // isProcessUrlPay 代表 支付宝已经处理该URL
//            if ([result[@"isProcessUrlPay"] boolValue]) {
//                // returnUrl 代表 第三方App需要跳转的成功页URL
//                NSString* urlStr = result[@"returnUrl"];
//                [wself loadWithUrlStr:urlStr];
//            }
//        }];
//    }
//}
//
//- (void)WXPayWithParam:(NSDictionary *)WXparam{
//
//}
////url支付成功回调地址
//- (void)loadWithUrlStr:(NSString*)urlStr
//{
//    if (urlStr.length > 0) {
//        dispatch_async(dispatch_get_main_queue(), ^{
//            NSURLRequest *webRequest = [NSURLRequest requestWithURL:[NSURL URLWithString:urlStr] cachePolicy:NSURLRequestReturnCacheDataElseLoad
//                                                    timeoutInterval:15];
//            [self.wkWebView loadRequest:webRequest];
//        });
//    }
//}

#pragma mark ================ 自定义返回/关闭按钮 ================

-(void)updateNavigationItems{
    if (self.wkWebView.canGoBack) {
        UIBarButtonItem *spaceButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
        spaceButtonItem.width = -6.5;
        
        [self.navigationItem setLeftBarButtonItems:@[spaceButtonItem,self.customBackBarItem,self.closeButtonItem] animated:NO];
    }else{
        self.navigationController.interactivePopGestureRecognizer.enabled = YES;
        [self.navigationItem setLeftBarButtonItems:@[self.customBackBarItem]];
    }
}
//请求链接处理
-(void)pushCurrentSnapshotViewWithRequest:(NSURLRequest*)request{
    //    NSLog(@"push with request %@",request);
    NSURLRequest* lastRequest = (NSURLRequest*)[[self.snapShotsArray lastObject] objectForKey:@"request"];
    
    //如果url是很奇怪的就不push
    if ([request.URL.absoluteString isEqualToString:@"about:blank"]) {
        //        NSLog(@"about blank!! return");
        return;
    }
    //如果url一样就不进行push
    if ([lastRequest.URL.absoluteString isEqualToString:request.URL.absoluteString]) {
        return;
    }
    UIView* currentSnapShotView = [self.wkWebView snapshotViewAfterScreenUpdates:YES];
    [self.snapShotsArray addObject:
     @{@"request":request,@"snapShotView":currentSnapShotView}];
}

#pragma mark ================ WKNavigationDelegate ================

//这个是网页加载完成，导航的变化
-(void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation{
    /*
     主意：这个方法是当网页的内容全部显示（网页内的所有图片必须都正常显示）的时候调用（不是出现的时候就调用），，否则不显示，或则部分显示时这个方法就不调用。
     */
    // 判断是否需要加载（仅在第一次加载）
    if (self.needLoadJSPOST) {
        // 调用使用JS发送POST请求的方法
        [self postRequestWithJS];
        // 将Flag置为NO（后面就不需要加载了）
        self.needLoadJSPOST = NO;
    }
    // 获取加载网页的标题
   // self.title = self.wkWebView.title;
    
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
    [self updateNavigationItems];
    
//    if (_isAd == 0) {
//        JLLog(@"无奖励");
//    }else{
//        
//        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(10 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//            [STRequest WatchADBackDataWithParam:_docid WithDataBlock:^(id ServersData, BOOL isSuccess) {
//                if (isSuccess) {
//                    if ([ServersData isKindOfClass:[NSDictionary class]]) {
//                        if ([ServersData[@"c"] intValue] == 1) {
//                            [SVProgressHUD dismiss];
//                            
//                            NSString *ingot = [NSString stringWithFormat:@"%@",ServersData[@"d"][@"ingot"]];
//                            JLLog(@"ingot---%@",ingot);
//                            
//                        }else{
//                            
//                            [SVProgressHUD showErrorWithStatus:ServersData[@"m"]];
//                        }
//                    }else{
//                        [SVProgressHUD showErrorWithStatus:@"服务端数据出错"];
//                    }
//                }else{
//                    
//                    [SVProgressHUD showErrorWithStatus:@"网络出错"];
//                }
//                
//            }];
//            
//        });
//        
//    }
    
    
}

//开始加载
-(void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation{
    //开始加载的时候，让加载进度条显示
    self.progressView.hidden = NO;

}

//内容返回时调用
-(void)webView:(WKWebView *)webView didCommitNavigation:(WKNavigation *)navigation{}

//服务器请求跳转的时候调用
-(void)webView:(WKWebView *)webView didReceiveServerRedirectForProvisionalNavigation:(WKNavigation *)navigation{}

//服务器开始请求的时候调用
- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler {
    //    NSString* orderInfo = [[AlipaySDK defaultService]fetchOrderInfoFromH5PayUrl:[navigationAction.request.URL absoluteString]];
    //    if (orderInfo.length > 0) {
    //        [self payWithUrlOrder:orderInfo];
    //    }
    //    //拨打电话
    //    //兼容安卓的服务器写法:<a class = "mobile" href = "tel://电话号码"></a>
    //    NSString *mobileUrl = [[navigationAction.request URL] absoluteString];
    //    mobileUrl = [mobileUrl stringByRemovingPercentEncoding];
    //    NSArray *urlComps = [mobileUrl componentsSeparatedByString:@"://"];
    //    if ([urlComps count]){
    //
    //        if ([[urlComps objectAtIndex:0] isEqualToString:@"tel"]) {
    //
    //            UIAlertController *mobileAlert = [UIAlertController alertControllerWithTitle:nil message:[NSString stringWithFormat:@"拨号给 %@ ？",urlComps.lastObject] preferredStyle:UIAlertControllerStyleAlert];
    //            UIAlertAction *suerAction = [UIAlertAction actionWithTitle:@"拨号" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
    //
    //                [[UIApplication sharedApplication] openURL:[NSURL URLWithString:mobileUrl]];
    //            }];
    //            UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
    //                return ;
    //            }];
    //
    //            [mobileAlert addAction:suerAction];
    //            [mobileAlert addAction:cancelAction];
    //
    //            [self presentViewController:mobileAlert animated:YES completion:nil];
    //        }
    //    }
    
    
    
    switch (navigationAction.navigationType) {
        case WKNavigationTypeLinkActivated: {
            [self pushCurrentSnapshotViewWithRequest:navigationAction.request];
            break;
        }
        case WKNavigationTypeFormSubmitted: {
            [self pushCurrentSnapshotViewWithRequest:navigationAction.request];
            break;
        }
        case WKNavigationTypeBackForward: {
            break;
        }
        case WKNavigationTypeReload: {
            break;
        }
        case WKNavigationTypeFormResubmitted: {
            break;
        }
        case WKNavigationTypeOther: {
            [self pushCurrentSnapshotViewWithRequest:navigationAction.request];
            break;
        }
        default: {
            break;
        }
    }
    [self updateNavigationItems];
    decisionHandler(WKNavigationActionPolicyAllow);
}

// 内容加载失败时候调用
-(void)webView:(WKWebView *)webView didFailProvisionalNavigation:(WKNavigation *)navigation withError:(NSError *)error{
    NSLog(@"页面加载超时");
}

//跳转失败的时候调用
-(void)webView:(WKWebView *)webView didFailNavigation:(WKNavigation *)navigation withError:(NSError *)error{}

//进度条  //进程被终止时调用

//-(void)webViewWebContentProcessDidTerminate:(WKWebView *)webView{}

#pragma mark ================ WKUIDelegate ================

// 获取js 里面的提示
-(void)webView:(WKWebView *)webView runJavaScriptAlertPanelWithMessage:(NSString *)message initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(void))completionHandler{
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:message preferredStyle:UIAlertControllerStyleAlert];
    [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        completionHandler();
    }]];
    
    [self presentViewController:alert animated:YES completion:NULL];
}

// js 信息的交流
-(void)webView:(WKWebView *)webView runJavaScriptConfirmPanelWithMessage:(NSString *)message initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(BOOL))completionHandler{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:message preferredStyle:UIAlertControllerStyleAlert];
    [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        completionHandler(YES);
    }]];
    [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        completionHandler(NO);
    }]];
    [self presentViewController:alert animated:YES completion:NULL];
}

// 交互。可输入的文本。
-(void)webView:(WKWebView *)webView runJavaScriptTextInputPanelWithPrompt:(NSString *)prompt defaultText:(NSString *)defaultText initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(NSString * _Nullable))completionHandler{
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"textinput" message:@"JS调用输入框" preferredStyle:UIAlertControllerStyleAlert];
    [alert addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        textField.textColor = MainRedColor;
    }];
    [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        completionHandler([[alert.textFields lastObject] text]);
    }]];
    
    [self presentViewController:alert animated:YES completion:NULL];
    
}

//KVO监听进度条
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    
    if ([keyPath isEqualToString:NSStringFromSelector(@selector(estimatedProgress))] && object == self.wkWebView) {
        [self.progressView setAlpha:1.0f];
        BOOL animated = self.wkWebView.estimatedProgress > self.progressView.progress;
        [self.progressView setProgress:self.wkWebView.estimatedProgress animated:animated];
        
        // Once complete, fade out UIProgressView
        if(self.wkWebView.estimatedProgress >= 1.0f) {
            [UIView animateWithDuration:0.3f delay:0.3f options:UIViewAnimationOptionCurveEaseOut animations:^{
                [self.progressView setAlpha:0.0f];
            } completion:^(BOOL finished) {
                [self.progressView setProgress:0.0f animated:NO];
            }];
        }
    }
    else {
        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
    }

}

#pragma mark ================ WKScriptMessageHandler ================

//拦截执行网页中的JS方法
- (void)userContentController:(WKUserContentController *)userContentController didReceiveScriptMessage:(WKScriptMessage *)message{
    
    //服务器固定格式写法 window.webkit.messageHandlers.名字.postMessage(内容);
    //客户端写法 message.name isEqualToString:@"名字"]
    if ([message.name isEqualToString:@"WXPay"]) {
        NSLog(@"%@", message.body);
        //调用微信支付方法
        //        [self WXPayWithParam:message.body];
    }
}

#pragma mark ================ 懒加载 ================

- (WKWebView *)wkWebView{
    if (!_wkWebView) {
        //设置网页的配置文件
        WKWebViewConfiguration * Configuration = [[WKWebViewConfiguration alloc]init];
        if (iOS9Later) {
            Configuration.allowsAirPlayForMediaPlayback = YES;
        }
        // 允许在线播放
        Configuration.allowsInlineMediaPlayback = YES;
        // 允许可以与网页交互，选择视图
        Configuration.selectionGranularity = YES;
        // web内容处理池
        Configuration.processPool = [[WKProcessPool alloc] init];
        
        NSString *jSString = @"var meta = document.createElement('meta'); meta.setAttribute('name', 'viewport'); meta.setAttribute('content', 'width=device-width'); document.getElementsByTagName('head')[0].appendChild(meta);";
        WKUserScript *wkUserScript = [[WKUserScript alloc] initWithSource:jSString injectionTime:WKUserScriptInjectionTimeAtDocumentEnd forMainFrameOnly:YES];
        
        //自定义配置,一般用于 js调用oc方法(OC拦截URL中的数据做自定义操作)
        WKUserContentController *UserContentController = [[WKUserContentController alloc]init];
        self.UserContentController = UserContentController;
        // 添加消息处理，注意：self指代的对象需要遵守WKScriptMessageHandler协议，结束时需要移除
        [UserContentController addScriptMessageHandler:self name:@"WXPay"];
        // 是否支持记忆读取
        Configuration.suppressesIncrementalRendering = YES;
        // 允许用户更改网页的设置
        Configuration.userContentController = UserContentController;
        [UserContentController addUserScript:wkUserScript];
        _wkWebView = [[WKWebView alloc] initWithFrame:CGRectMake(0, 0, ScreenW, ScreenH-60) configuration:Configuration];
        _wkWebView.backgroundColor = [UIColor colorWithRed:240.0/255 green:240.0/255 blue:240.0/255 alpha:1.0];
        // 设置代理
        _wkWebView.navigationDelegate = self;
        _wkWebView.UIDelegate = self;
        _wkWebView.scrollView.delegate = self;
        //kvo 添加进度监控
        [_wkWebView addObserver:self forKeyPath:NSStringFromSelector(@selector(estimatedProgress)) options:0 context:WkwebBrowserContext];
        //开启手势触摸
        _wkWebView.allowsBackForwardNavigationGestures = YES;
        // 设置 可以前进 和 后退
        //适应你设定的尺寸
        [_wkWebView sizeToFit];
    }
    return _wkWebView;
}

#pragma mark =================== alertView ==========================

- (void)setupAlertViewWithTitle:(NSString *)titleString
{
    UIView *ReceiveBgView = [[UIView alloc]init];
    self.receiveView = ReceiveBgView;
    CGRect frame = ReceiveBgView.frame;
    frame.size.height = IPHONE_H/20*9;
    frame.size.width = IPHONE_W/3*2;
    ReceiveBgView.frame = frame;
    ReceiveBgView.center = self.view.center;
    [self.view addSubview:ReceiveBgView];
    
    UIImageView *imgV = [[UIImageView alloc]initWithFrame:frame];
    imgV.image = [UIImage imageNamed:@"bg_reward_get"];
    [ReceiveBgView addSubview:imgV];
    
    UIImageView *numberV = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"icon_reward_text"]];
    numberV.frame = CGRectMake(ReceiveBgView.frame.size.width/6, ReceiveBgView.frame.size.height/3, ReceiveBgView.frame.size.width/3*2, ReceiveBgView.frame.size.height/4);
    [ReceiveBgView addSubview:numberV];
    
    self.numLab = [[UILabel alloc]initWithFrame:numberV.frame];
    self.numLab.textColor = [UIColor whiteColor];
    self.numLab.text = titleString;
    self.numLab.textAlignment = NSTextAlignmentCenter;
    self.numLab.font = [UIFont systemFontOfSize:23 weight:1];
    [ReceiveBgView addSubview:self.numLab];
    
    UIButton *receiveBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    receiveBtn.frame = CGRectMake(ReceiveBgView.frame.size.width/4, ReceiveBgView.frame.size.height/6*4, ReceiveBgView.frame.size.width/2, ReceiveBgView.frame.size.height/7);
    [receiveBtn setBackgroundImage:[UIImage imageNamed:@"icon_reward_button"] forState:UIControlStateNormal];
    [receiveBtn addTarget:self action:@selector(receivesActive) forControlEvents:UIControlEventTouchUpInside];
    [ReceiveBgView addSubview:receiveBtn];
    [receiveBtn bringSubviewToFront:ReceiveBgView];
    
    TYAlertController *alertController = [TYAlertController alertControllerWithAlertView:ReceiveBgView preferredStyle:TYAlertControllerStyleAlert];
    
    [alertController setBlurEffectWithView:self.view];
    [self presentViewController:alertController animated:YES completion:nil];
    
    //添加通知  提醒任务列表刷新 且 我的界面的元宝个数更新
    
    
    
    
    
    
}

- (void)receivesActive
{
    [self.receiveView hideView];
}

-(UIBarButtonItem*)customBackBarItem{
    if (!_customBackBarItem) {
        UIImage* backItemImage = [UIImage imageNamed:@"btn_back" ];
        UIButton* backButton = [[UIButton alloc] init];
        [backButton setTitle:@"返回" forState:UIControlStateNormal];
        [backButton setTitleColor:WhiteColor forState:UIControlStateNormal];
        
        [backButton.titleLabel setFont:[UIFont systemFontOfSize:17]];
        [backButton setImage:backItemImage forState:UIControlStateNormal];
        [backButton sizeToFit];
        
        [backButton addTarget:self action:@selector(customBackItemClicked) forControlEvents:UIControlEventTouchUpInside];
        _customBackBarItem = [[UIBarButtonItem alloc] initWithCustomView:backButton];
    }
    return _customBackBarItem;
}

- (UIProgressView *)progressView{
    if (!_progressView) {
        _progressView = [[UIProgressView alloc]initWithProgressViewStyle:UIProgressViewStyleDefault];
        if (_isNavHidden == YES) {
            _progressView.frame = CGRectMake(0, 20, self.view.bounds.size.width, 3);
        }else{
            _progressView.frame = CGRectMake(0, 0, self.view.bounds.size.width, 3);
        }
        // 设置进度条的色彩
        [_progressView setTrackTintColor:[UIColor colorWithRed:240.0/255 green:240.0/255 blue:240.0/255 alpha:1.0]];
        _progressView.progressTintColor = [UIColor orangeColor];
    }
    return _progressView;
}

-(UIBarButtonItem*)closeButtonItem{
    if (!_closeButtonItem) {
        _closeButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"关闭" style:UIBarButtonItemStylePlain target:self action:@selector(closeItemClicked)];
        _closeButtonItem.tintColor = WhiteColor;
    }
    return _closeButtonItem;
}

-(NSMutableArray*)snapShotsArray{
    if (!_snapShotsArray) {
        _snapShotsArray = [NSMutableArray array];
    }
    return _snapShotsArray;
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.wkWebView.configuration.userContentController removeScriptMessageHandlerForName:@"WXPay"];
    [self.wkWebView setNavigationDelegate:nil];
    [self.wkWebView setUIDelegate:nil];
    [self.UserContentController removeAllUserScripts];
}

//注意，观察的移除
-(void)dealloc{
    [self.wkWebView removeObserver:self forKeyPath:NSStringFromSelector(@selector(estimatedProgress))];
    [self.wkWebView.configuration.userContentController removeScriptMessageHandlerForName:@"WXPay"];
    [self.wkWebView setNavigationDelegate:nil];
    [self.wkWebView setUIDelegate:nil];
    [self.UserContentController removeAllUserScripts];
    [self.wkWebView.scrollView setDelegate:nil];
    [[NSNotificationCenter defaultCenter] removeObserver: self];
    
}

@end
