//
//  WKWebViewController.h
//  zhangshangPacket
//
//  Created by apple on 2017/5/24.
//  Copyright © 2017年 apple-fangqiu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WKWebViewController : UIViewController

{
    BOOL isShare;
    //是否滑动到最底部
    BOOL isScrollBottom;
    //是否网页加载完成
    BOOL isFinishWeb;
    BOOL isFinishWatchTask;
    BOOL isRequest;
    NSInteger index;//计时
    NSTimer *timer;
    
}


/** 是否显示Nav */
@property (nonatomic,assign) BOOL isNavHidden;

/**
 加载纯外部链接网页
 
 @param string URL地址
 */
- (void)loadWebURLSring:(NSString *)string;

/**
 加载本地网页
 
 @param string 本地HTML文件名
 */
- (void)loadWebHTMLSring:(NSString *)string;

/**
 加载外部链接POST请求(注意检查 XFWKJSPOST.html 文件是否存在 )
 postData请求块 注意格式：@"\"username\":\"xxxx\",\"password\":\"xxxx\""
 
 @param string 需要POST的URL地址
 @param postData post请求块
 */
- (void)POSTWebURLSring:(NSString *)string postData:(NSString *)postData;



@property (nonatomic, assign) int docid;

@property (nonatomic, assign) int artid;

//@property (nonatomic, assign) int articid;

@property (nonatomic, strong) NSString *titleStr;
@property (nonatomic, strong) NSString *contentStr;

@property (nonatomic, strong) NSString *urlStr;

@property (nonatomic, assign) NSInteger isAd;

@property (nonatomic, strong) NSString *imageStr;

@property (nonatomic, strong) NSString *newstype;

@property (nonatomic, assign) NSInteger hasNewsReward;

@property (nonatomic, assign) NSInteger adIngot;

@property (nonatomic, assign) NSInteger isFinishTask;//判断任务是否完成


@end
