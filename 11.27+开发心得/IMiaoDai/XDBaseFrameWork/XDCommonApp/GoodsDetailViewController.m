//
//  GoodsDetailViewController.m
//  XDCommonApp
//
//  Created by maboyi on 14-7-29.
//  Copyright (c) 2014年 XD-XY. All rights reserved.
//

#import "GoodsDetailViewController.h"
#import "GoodsBuyerViewController.h"
#import "ConfirmOrderViewController.h"
#import "LoginViewController.h"
#import "PhotoDetailViewController.h"
#import "TuWenViewController.h"
@interface GoodsDetailViewController ()

@end

@implementation GoodsDetailViewController

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
	
    self.titleLabel.text = @"商品详情";

    index = 999;
    guigeStr = [[NSString alloc] init];
    dataDict = [[NSMutableDictionary alloc] init];
    priceArray = [[NSMutableArray alloc] init];
    monthArray = [[NSMutableArray alloc] init];

    self.shareView = [[XDShareView alloc]initWithFrame:CGRectMake(0, 0, UI_SCREEN_WIDTH, UI_SCREEN_HEIGHT)];
    _shareView.delegate = self;
    [self.view addSubview:_shareView];

    float h = 0;
    if (IOS7) {
        h = 20;
    }
    
    UIImageView * shareIV = [[UIImageView alloc] initWithFrame:CGRectMake(280, h+13, 18, 24)];
    shareIV.image = [UIImage imageNamed:@"shareBtn_img"];
    [self.navigationBarView addSubview:shareIV];

    UIButton * shareBtn = [XDTools getAButtonWithFrame:CGRectMake(270, h, 50, 44) nomalTitle:nil hlTitle:nil titleColor:nil bgColor:[UIColor clearColor] nbgImage:nil hbgImage:nil action:@selector(shareBtnClick) target:self buttonTpye:UIButtonTypeCustom];
    [self.navigationBarView addSubview:shareBtn];


    backScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, UI_SCREEN_WIDTH, UI_MAINSCREEN_HEIGHT-UI_NAVIGATION_BAR_HEIGHT-60)];
    backScrollView.backgroundColor = [UIColor clearColor];
    backScrollView.contentSize = CGSizeMake(UI_SCREEN_WIDTH, 1000);
    [self.contentView addSubview:backScrollView];
    backScrollView.hidden = YES;
    
//    banner = [[XYScrollView alloc] initPageScrollView:CGRectMake(0, 0, UI_SCREEN_WIDTH, 220) pageControllerFrame:CGRectMake(120, 205, 100, 10) backgroudImage:nil pageNumber:PAGESCROLLVIEWNUMBER];
//    banner.delegate = self;
//    [backScrollView addSubview:banner];
    
    banner = [[PageScrollView alloc] initWithFrame:CGRectMake(0, 0, UI_SCREEN_WIDTH, 220) andPageControllRect:CGRectMake(110, 205, 100, 10)];
    banner.delegate = self;
    [backScrollView addSubview:banner];

    [self createViews];

    [self getDataWithPageNum:@"1" api:API_GETDETAILINFO];
    
}

- (void)createViews{
    
    bg1 = [self getBgViewWithFrame:CGRectMake(0, 220, UI_SCREEN_WIDTH, 70)];
    nameLB = [XDTools addAlabelForAView:bg1 withText:@"" frame:CGRectMake(10, 5, 280, 35) font:[UIFont systemFontOfSize:15] textColor:[UIColor blackColor]];
    nameLB.numberOfLines = 0;

    vipPriceLB = [XDTools addAlabelForAView:bg1 withText:@"" frame:CGRectMake(10, height_y(nameLB)+10, 70, 20) font:[UIFont boldSystemFontOfSize:19] textColor:[UIColor orangeColor]];
    normalLB = [XDTools addAlabelForAView:bg1 withText:@"" frame:CGRectMake(90, height_y(nameLB)+12, 60, 16) font:[UIFont systemFontOfSize:14] textColor:[UIColor grayColor]];
    lineLabel = [XDTools addAlabelForAView:bg1 withText:@"" frame:CGRectMake(85, height_y(normalLB)-9.5f, normalLB.frame.size.width+10, 1) font:[UIFont systemFontOfSize:14] textColor:[UIColor blackColor]];
    lineLabel.backgroundColor = [UIColor grayColor];
    buyersNumLB = [XDTools addAlabelForAView:bg1 withText:@"" frame:CGRectMake(190, height_y(nameLB)+10, 120, 20) font:[UIFont systemFontOfSize:14] textColor:[UIColor grayColor]];
    bg1.frame = CGRectMake(0, 220, UI_SCREEN_WIDTH, height_y(vipPriceLB)+3);
    UIImageView * line1 = (UIImageView *)[bg1 viewWithTag:45601];
    line1.frame = CGRectMake(0, bg1.frame.size.height-.5f, UI_SCREEN_WIDTH, .5f);



    //图文详情+购买该商品的人
    bg4 = [self getBgViewWithFrame:CGRectMake(0, height_y(bg1)+10, UI_SCREEN_WIDTH, 88)];
    NSArray * nameArr = @[@"图文详情",@"购买该商品的同学"];
    for (int i = 0; i < 2; i++) {

        [XDTools addAlabelForAView:bg4 withText:nameArr[i] frame:CGRectMake(12, 12+i*44, 200, 20) font:[UIFont systemFontOfSize:16] textColor:[UIColor blackColor]];
        UIImageView * arrowIV = [[UIImageView alloc] initWithFrame:CGRectMake(302, 13+44*i, 15, 18)];
        arrowIV.image = [UIImage imageNamed:@"arrow"];
        [bg4 addSubview:arrowIV];

        UIImageView * rightIV = [[UIImageView alloc] initWithFrame:CGRectMake(303, 14+i*44, 7, 14)];
        rightIV.image = [UIImage imageNamed:@"rightArrow"];
        [bg4 addSubview:rightIV];

        UIButton * btn = [XDTools getAButtonWithFrame:CGRectMake(0, i*44, 320, 44) nomalTitle:nil hlTitle:nil titleColor:nil bgColor:[UIColor clearColor] nbgImage:nil hbgImage:nil action:@selector(cellDidClicked:) target:self buttonTpye:UIButtonTypeCustom];
        btn.tag = 766200 + i;
        [bg4 addSubview:btn];

    }

    UIImageView * line = [[UIImageView alloc] initWithFrame:CGRectMake(0, 44, 320, .5f)];
    line.image = [UIImage imageNamed:@"line"];
    [bg4 addSubview:line];

    backScrollView.contentSize = CGSizeMake(UI_SCREEN_WIDTH, height_y(bg4) + 20);


    //底部view

    bottomBg = [[UIView alloc] initWithFrame:CGRectMake(0, UI_MAINSCREEN_HEIGHT - UI_NAVIGATION_BAR_HEIGHT - 60, UI_SCREEN_WIDTH, 60)];

    bottomBg.backgroundColor = RGBA(236, 236, 236, 1);
    [self.contentView addSubview:bottomBg];

    showLB = [XDTools addAlabelForAView:bottomBg withText:@"0首付" frame:CGRectMake(10, 10, 175, 40) font:[UIFont systemFontOfSize:15] textColor:RGBA(102, 102, 102, 1)];

//    showLB.attributedText = [XDTools getAcolorfulStringWithText1:@"340" Color1:[UIColor orangeColor] Font1:[UIFont systemFontOfSize:15] Text2:nil Color2:nil Font2:nil AllText:showLB.text];
    showLB.backgroundColor = [UIColor clearColor];
    showLB.textAlignment = NSTextAlignmentCenter;
    UIButton * payBtn = [XDTools getAButtonWithFrame:CGRectMake(195, 10, 115, 40) nomalTitle:@"立即购买" hlTitle:@"立即购买" titleColor:[UIColor whiteColor] bgColor:[UIColor orangeColor] nbgImage:nil hbgImage:nil action:@selector(pay) target:self buttonTpye:UIButtonTypeCustom];
    [bottomBg addSubview:payBtn];
    bottomBg.hidden = YES;

}

- (UIView *)getBgViewWithFrame:(CGRect)frame{
    UIView * bgView = [[UIView alloc] initWithFrame:frame];
    bgView.backgroundColor = [UIColor whiteColor];
    for (int i = 0; i < 2; i++) {
        UIImageView * lineIV = [[UIImageView alloc] initWithFrame:CGRectMake(0, i*(frame.size.height-.5f), UI_SCREEN_WIDTH, .5f)];
        lineIV.image = [UIImage imageNamed:@"line"];
        lineIV.tag = 45600+i;
        [bgView addSubview:lineIV];
    }
    [backScrollView addSubview:bgView];
    return bgView;
}

- (float)getGuiGeCellOnView:(UIView *)bg offY:(float)height title:(NSString *)title contentArray:(NSArray *)array type:(int)type{
    if (type == 1) {
        UILabel * lb1 = [XDTools addAlabelForAView:bg withText:title frame:CGRectMake(15, 13+height, 35, 20) font:[UIFont systemFontOfSize:15] textColor:UIColorFromRGB(0x666666)];
        for (int i = 0; i < array.count; i++) {
            UIButton * btn = [XDTools getAButtonWithFrame:CGRectMake(lb1.frame.origin.x+lb1.frame.size.width+20+(i%3)*80, i/3*30+13+height, 60, 20) nomalTitle:array[i] hlTitle:array[i] titleColor:UIColorFromRGB(0x666666) bgColor:[UIColor clearColor] nbgImage:nil hbgImage:nil action:@selector(chooseMonths:) target:self buttonTpye:UIButtonTypeCustom];
            btn.tag = 786600+i;
            btn.titleLabel.font = [UIFont systemFontOfSize:14];
            btn.layer.borderWidth = 1;
            if (i == array.count - 1) {
                btn.layer.borderColor = [UIColor orangeColor].CGColor;
                [btn setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
                btn.enabled = NO;
            }else
            btn.layer.borderColor = UIColorFromRGB(0xcbcbcb).CGColor;
            [bg addSubview:btn];


        }

        UIImageView * lineIV = [[UIImageView alloc] initWithFrame:CGRectMake(0, (array.count-1)/3*30+height+45, UI_SCREEN_WIDTH, .5f)];
        lineIV.image = [UIImage imageNamed:@"line"];
        //    lineIV.backgroundColor = [UIColor redColor];
        [bg addSubview:lineIV];

        CGRect frame = bg.frame;
        bg.frame = CGRectMake(0, frame.origin.y, UI_SCREEN_WIDTH, height_y(lineIV));
        
        return height_y(lineIV);
    }else{
        UILabel * lb1 = [XDTools addAlabelForAView:bg withText:title frame:CGRectMake(15, 17+height, 35, 20) font:[UIFont systemFontOfSize:15] textColor:UIColorFromRGB(0x666666)];
        price = [dataDict[@"payment"] lastObject][@"yuefu"];
        for (int i = 0; i < array.count; i++) {
            UIButton * btn = [XDTools getAButtonWithFrame:CGRectMake(lb1.frame.origin.x+lb1.frame.size.width+20, i*40+13+height, 200, 30) nomalTitle:array[i] hlTitle:array[i] titleColor:UIColorFromRGB(0x666666) bgColor:[UIColor clearColor] nbgImage:nil hbgImage:nil action:@selector(chooseGuiGe:) target:self buttonTpye:UIButtonTypeCustom];
            btn.tag = 786700+i;
            btn.titleLabel.font = [UIFont systemFontOfSize:14];
            btn.layer.borderWidth = 1;

            NSArray * array = dataDict[@"tags"][@"content"];

            if ([dataDict[@"productId"] isEqualToString:array[i][@"productId"]]) {
                index = i;
            }


            if (i == index) {
                btn.layer.borderColor = [UIColor orangeColor].CGColor;
                [btn setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
                btn.enabled = NO;
            }else
            btn.layer.borderColor = UIColorFromRGB(0xcbcbcb).CGColor;
            [bg addSubview:btn];
        }

        UIImageView * lineIV = [[UIImageView alloc] initWithFrame:CGRectMake(0, array.count*40+height+15, UI_SCREEN_WIDTH, .5f)];
        lineIV.image = [UIImage imageNamed:@"line"];
        //    lineIV.backgroundColor = [UIColor redColor];
        [bg addSubview:lineIV];

        CGRect frame = bg.frame;
        bg.frame = CGRectMake(0, frame.origin.y, UI_SCREEN_WIDTH, height_y(lineIV));
        
        return height_y(lineIV);
    }

}

- (void)getDataWithPageNum:(NSString *)page api:(NSString *)api{
    if ([XDTools NetworkReachable])
    {

        NSDictionary * dic = @{@"productId": _goodsId};

        ASIHTTPRequest *request = [XDTools postRequestWithDict:dic API:api];

        __weak ASIHTTPRequest * mrequest = request;

        [request setCompletionBlock:^{

            [XDTools hideProgress:self.contentView];

            NSDictionary *tempDic = [XDTools  JSonFromString:[mrequest responseString]];

            if ([[tempDic objectForKey:@"result"] intValue] == 0)
            {
                backScrollView.hidden =NO;
                bottomBg.hidden =NO;
                dataDict = tempDic[@"data"];

                [self reloadViews];

            }
            else
            {
                [XDTools showTips:[tempDic objectForKey:@"msg"] toView:self.view];

            }
        }];

        [request setFailedBlock:^{
            bottomBg.hidden = YES;
            
            [XDTools hideProgress:self.contentView];
            NSError *error = [mrequest error];
            DDLOG_CURRENT_METHOD;
            DDLOG(@"error=%@",error);
            if (mrequest.error.code == 2) {
                [XDTools showTips:@"网络请求超时" toView:self.view];
            }
        }];
            [XDTools showProgress:self.contentView];

        [request startAsynchronous];

    }
    else
    {
        [XDTools showTips:brokenNetwork toView:self.view];

    }
    
}

- (void)reloadViews{
    {
        banner.placeholderImg = [UIImage imageNamed:@"goodsDetail"];
        NSMutableArray * tArray = [[NSMutableArray alloc] init];
        for (NSString * str in dataDict[@"pic"]){
            NSDictionary * dict  = @{@"image_url":str};
            [tArray addObject:dict];
        }
        banner.imageUrlArray = tArray;
        
//        [banner setTheImageUrlArray:dataDict[@"pic"] andplaceholderImage:[UIImage imageNamed:@"goodsDetail"]];
        
//        [banner setTheImageUrlArray:@[@"http://gtms01.alicdn.com/tps/i1/TB1kw_eFVXXXXXcXVXXBlWxTVXX-490-268.jpg",@"http://gtms03.alicdn.com/tps/i3/TB1od.qFVXXXXcrXpXXIvWY_VXX-240-268.jpg"] andplaceholderImage:[UIImage imageNamed:@"goodsDetail"]];
        banner.pageControl.numberOfPages = [dataDict[@"pic"] count];


        normalLB.frame = CGRectMake(90, height_y(nameLB)+12, 60, 16);

        _picStr = dataDict[@"pic"][0];


        [bg3 removeFromSuperview];

        nameLB.text = dataDict[@"productName"];
        vipPriceLB.text = [NSString stringWithFormat:@"¥%d",[dataDict[@"price"] intValue]/100];
        normalLB.text = [NSString stringWithFormat:@"¥%d",[dataDict[@"marketPrice"] intValue]/100];
//        normalLB.backgroundColor = [UIColor orangeColor];
        [normalLB sizeToFit];
        lineLabel.frame = CGRectMake(85, height_y(normalLB)-8, normalLB.frame.size.width+10, 1);
        buyersNumLB.text = [NSString stringWithFormat:@"%@位同学已购买",dataDict[@"buyCount"]];
        buyersNumLB.textAlignment = NSTextAlignmentRight;
        //规格
        if (!notFirst) {
            bg2 = [self getBgViewWithFrame:CGRectMake(0, height_y(bg1)+10, UI_SCREEN_WIDTH, 90)];
            float height = 0;

            NSMutableArray * arr = [[NSMutableArray alloc] init];
            for (NSDictionary * dic in dataDict[@"tags"][@"content"]) {
                [arr addObject:dic[@"text"]];
                [priceArray addObject:dic[@"productId"]];
            }
            
//            if(IS_NOT_EMPTY(dataDict[@"tags"][@"Name"])){
            [self getGuiGeCellOnView:bg2 offY:height title:[NSString stringWithFormat:@"%@:",dataDict[@"tags"][@"Name"]] contentArray:arr type:2];
            guigeStr = [arr lastObject];
//            }else{
//                [self getGuiGeCellOnView:bg2 offY:height title:dataDict[@"tags"][@"Name"] contentArray:arr type:2];
//            }

            UIImageView * line2 = (UIImageView *)[bg2 viewWithTag:45601];
            line2.frame = CGRectMake(0, bg2.frame.size.height-.5f, UI_SCREEN_WIDTH, .5f);

            notFirst = YES;
        }



        //分期
        bg3 = [self getBgViewWithFrame:CGRectMake(0, height_y(bg2)+10, UI_SCREEN_WIDTH, 90)];
        NSMutableArray * arr2 = [[NSMutableArray alloc] init];
        [monthArray removeAllObjects];
        for (NSDictionary * dic in dataDict[@"payment"]) {
            [arr2 addObject:dic[@"titel"]];
            [monthArray addObject:dic[@"paymentId"]];
        }
        [self getGuiGeCellOnView:bg3 offY:0 title:@"分期:" contentArray:arr2 type:1];
        UIImageView * line3 = (UIImageView *)[bg3 viewWithTag:45601];
        line3.frame = CGRectMake(0, bg3.frame.size.height-.5f, UI_SCREEN_WIDTH, .5f);




        bg4.frame = CGRectMake(0, height_y(bg3)+10, UI_SCREEN_WIDTH, 88);

        backScrollView.contentSize = CGSizeMake(UI_SCREEN_WIDTH, height_y(bg4) + 20);

        months = monthArray.lastObject;
//        price = priceArray[0];


        NSArray * arr1 = dataDict[@"payment"];

        showLB.text = [NSString stringWithFormat:@"%@首付,￥%.2fx%@期",arr1.lastObject[@"shoufu"],[arr1.lastObject[@"yuefu"] floatValue]/100,months];
        showLB.attributedText = [XDTools getAcolorfulStringWithText1:[NSString stringWithFormat:@"%.2f",[arr1.lastObject[@"yuefu"] floatValue]/100] Color1:[UIColor orangeColor] Font1:[UIFont systemFontOfSize:17] Text2:nil Color2:nil Font2:nil AllText:showLB.text];

	}
}


- (void)cellDidClicked:(UIButton *)sender{
    if (sender.tag == 766200) {
        //图文详情
        TuWenViewController * tuwen = [[TuWenViewController alloc] init];
        tuwen.htmlStr = dataDict[@"desc"];
        tuwen.titleString = dataDict[@"productName"];
        [self.navigationController pushViewController:tuwen animated:YES];
    }else if (sender.tag == 766201) {
        //购买该商品的同学
        GoodsBuyerViewController * buyer = [[GoodsBuyerViewController alloc] init];
        buyer.goodsId = dataDict[@"productId"];
        [self.navigationController pushViewController:buyer animated:YES];
    }
}

- (void)chooseGuiGe:(UIButton *)sender{
    index = sender.tag - 786700;
    _goodsId = dataDict[@"tags"][@"content"][sender.tag - 786700][@"productId"];
    [self getDataWithPageNum:@"1" api:API_GETDETAILINFO];

    price = [dataDict[@"payment"] lastObject][@"yuefu"];
    for (UIButton * btn in sender.superview.subviews) {
        if ([btn isKindOfClass:[UIButton class]]) {
            btn.layer.borderWidth = 1;
            btn.layer.borderColor = UIColorFromRGB(0xcbcbcb).CGColor;
            [btn setTitleColor:UIColorFromRGB(0x666666) forState:UIControlStateNormal];
            btn.enabled = YES;
        }
    }
    sender.layer.borderWidth = 1;
    sender.layer.borderColor = [UIColor orangeColor].CGColor;
    [sender setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
    sender.enabled = NO;

    guigeStr = sender.titleLabel.text;

    if (months.length && !price.length) {
        price = dataDict[@"payment"][sender.tag - 786700][@"yuefu"];
        showLB.text = [NSString stringWithFormat:@"%@首付,￥%.2fx%@期",dataDict[@"payment"][sender.tag - 786700][@"shoufu"],[dataDict[@"payment"][sender.tag - 786700][@"yuefu"] floatValue]/100,months];
        showLB.attributedText = [XDTools getAcolorfulStringWithText1:[NSString stringWithFormat:@"%.2f",[dataDict[@"payment"][sender.tag - 786700][@"yuefu"] floatValue]/100] Color1:[UIColor orangeColor] Font1:[UIFont systemFontOfSize:17] Text2:nil Color2:nil Font2:nil AllText:showLB.text];
    }
}


- (void)chooseMonths:(UIButton *)sender{

    months = monthArray[sender.tag - 786600];
    for (UIButton * btn in sender.superview.subviews) {
        if ([btn isKindOfClass:[UIButton class]]) {
            btn.layer.borderWidth = 1;
            btn.layer.borderColor = UIColorFromRGB(0xcbcbcb).CGColor;
            [btn setTitleColor:UIColorFromRGB(0x666666) forState:UIControlStateNormal];
            btn.enabled = YES;
        }
    }
    sender.layer.borderWidth = 1;
    sender.layer.borderColor = [UIColor orangeColor].CGColor;
    [sender setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
    sender.enabled = NO;
    price = [NSString stringWithFormat:@"%.2f",[dataDict[@"payment"][sender.tag - 786600][@"yuefu"] floatValue]];


    if (price.length) {
        showLB.text = [NSString stringWithFormat:@"%@首付,￥%.2fx%@期",dataDict[@"payment"][sender.tag - 786600][@"shoufu"],[dataDict[@"payment"][sender.tag - 786600][@"yuefu"] floatValue]/100,months];
        showLB.attributedText = [XDTools getAcolorfulStringWithText1:[NSString stringWithFormat:@"%.2f",[dataDict[@"payment"][sender.tag - 786600][@"yuefu"] floatValue]/100] Color1:[UIColor orangeColor] Font1:[UIFont systemFontOfSize:17] Text2:nil Color2:nil Font2:nil AllText:showLB.text];
    }
}

- (void)pay{
    if (!ISLOGING) {
        LoginViewController * login = [[LoginViewController alloc] init];
        [self.navigationController pushViewController:login animated:YES];
        return;
    }

    if (!price.length) {
        [XDTools showTips:@"请选择版本类型" toView:self.contentView];
        return;
    }
    if (!months.length) {
        [XDTools showTips:@"请选择分期类型" toView:self.contentView];
        return;
    }

    ConfirmOrderViewController * confirm = [[ConfirmOrderViewController alloc] init];
    confirm.months = months;
    confirm.price = price;
    confirm.goodsId = _goodsId;
    confirm.goodsName = dataDict[@"productName"];
    confirm.canshu = guigeStr;
    confirm.picStr = _picStr;
    confirm.sjString = dataDict[@"supplier"][@"promise"];
    confirm.gsString = dataDict[@"supplier"][@"name"];
    confirm.bussinessName = dataDict[@"supplier"][@"name"];
    confirm.bussinessPromise = dataDict[@"supplier"][@"promise"];
    [self.navigationController pushViewController:confirm animated:YES];
}




#pragma mark -轮播图点击的代理方法
-(void)gestureClick:(UITapGestureRecognizer *)sender andUrl:(NSString *)urlString
{
    DDLOG(@"urlString = %@",urlString);
}

//-(void)gestureClick:(UITapGestureRecognizer *)sender
//{
//    DDLOG_CURRENT_METHOD;
//    UIImageView * imageView =(UIImageView *)[banner.myScrollView viewWithTag:sender.view.tag];
//    
//    //这里就写跳到下一的代码....imageView.tag-image_tag
//    DDLOG(@"imageView.tag = %d",imageView.tag);
//
////
////    PhotoDetailViewController *photoVC = [[PhotoDetailViewController alloc] init];
////    photoVC.myArray = dataDict[@"pic"];
////    photoVC.isDefualt = NO;
////    photoVC.contentOffset = sender.view.tag-10000;
////    [self.navigationController pushViewController:photoVC animated:YES];
//}

#pragma mark ================分享按钮点击===================
-(void)shareBtnClick
{
    [_shareView setViewShow];
    DDLOG_CURRENT_METHOD;
}

#pragma mark ===============xdshareview delegate==========
-(void)shareViewBtnCLick:(UIButton *)button
{
    [self hideenShareView];
//    [UMSocialData defaultData].extConfig.title = @"喵贷";
//    
//    [UMSocialData defaultData].extConfig.wxMessageType = UMSocialWXMessageTypeOther;
//    if(button.tag == 1000){
//        //腾讯微博
//        WXWebpageObject *webObject = [WXWebpageObject object];
//        webObject.webpageUrl = @"http://www.miaodai.cn/m/down.html"; //设置你自己的url地址
//        [UMSocialData defaultData].extConfig.wxMediaObject = webObject;
//        
//        [[UMSocialControllerService defaultControllerService] setShareText:@"喵了个咪，价格这么低，居然还可以分期还款，我确实不是在做梦，喵贷让美梦成真！\nhttp://www.miaodai.cn/m/down.html" shareImage:[UIImage imageNamed:@"Icon"] socialUIDelegate:self];
//        [UMSocialSnsPlatformManager getSocialPlatformWithName:UMShareToTencent].snsClickHandler(self,[UMSocialControllerService defaultControllerService],YES);
//        
//    }else if (button.tag == 1001){
//        //新浪微博
//        
//        [[UMSocialControllerService defaultControllerService] setShareText:@"喵了个咪，价格这么低，居然还可以分期还款，我确实不是在做梦，喵贷让美梦成真！\nhttp://www.miaodai.cn/m/down.html" shareImage:[UIImage imageNamed:@"Icon"] socialUIDelegate:self];
//        [UMSocialSnsPlatformManager getSocialPlatformWithName:UMShareToSina].snsClickHandler(self,[UMSocialControllerService defaultControllerService],YES);
//    }else if(button.tag ==1002){
//        //微信好友
//        
//        WXWebpageObject *webObject = [WXWebpageObject object];
//        webObject.webpageUrl = @"http://www.miaodai.cn/m/down.html"; //设置你自己的url地址
//        [UMSocialData defaultData].extConfig.wxMediaObject = webObject;
//        
//        [[UMSocialControllerService defaultControllerService] setShareText:@"喵了个咪，价格这么低，居然还可以分期还款，我确实不是在做梦，喵贷让美梦成真！" shareImage:[UIImage imageNamed:@"Icon"] socialUIDelegate:self];
//        [UMSocialSnsPlatformManager getSocialPlatformWithName:UMShareToWechatSession].snsClickHandler(self,[UMSocialControllerService defaultControllerService],YES);
//    }else if(button.tag == 1003){
//        //朋友圈分享
//        [UMSocialData defaultData].extConfig.title = @"喵了个咪，价格这么低，居然还可以分期还款，我确实不是在做梦，喵贷让美梦成真！";
//        WXWebpageObject *webObject = [WXWebpageObject object];
//        webObject.webpageUrl = @"http://www.miaodai.cn/m/down.html"; //设置你自己的url地址
//        [UMSocialData defaultData].extConfig.wxMediaObject = webObject;
//        
//        [[UMSocialControllerService defaultControllerService] setShareText:@"喵了个咪，价格这么低，居然还可以分期还款，我确实不是在做梦，喵贷让美梦成真！" shareImage:[UIImage imageNamed:@"Icon"] socialUIDelegate:self];
//        [UMSocialSnsPlatformManager getSocialPlatformWithName:UMShareToWechatTimeline].snsClickHandler(self,[UMSocialControllerService defaultControllerService],YES);
//        
//    }else if (button.tag == 1004){
//        //人人
//        [[UMSocialControllerService defaultControllerService] setShareText:@"喵了个咪，价格这么低，居然还可以分期还款，我确实不是在做梦，喵贷让美梦成真！\nhttp://www.miaodai.cn/m/down.html" shareImage:[UIImage imageNamed:@"icon"] socialUIDelegate:self];     //设置分享内容和回调对象
//        [UMSocialSnsPlatformManager getSocialPlatformWithName:UMShareToRenren].snsClickHandler(self,[UMSocialControllerService defaultControllerService],YES);
//    }else if (button.tag == 1005){
//        //短信
//        [[UMSocialControllerService defaultControllerService] setShareText:@"喵了个咪，价格这么低，居然还可以分期还款，我确实不是在做梦，喵贷让美梦成真！\nhttp://www.miaodai.cn/m/down.html" shareImage:[UIImage imageNamed:@"icon"] socialUIDelegate:self];     //设置分享内容和回调对象
//        [UMSocialSnsPlatformManager getSocialPlatformWithName:UMShareToSms].snsClickHandler(self,[UMSocialControllerService defaultControllerService],YES);
//    }
    
}



-(void)hideenShareView{
    [_shareView setViewHidden];
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
