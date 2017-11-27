//
//  GoodsDetailViewController.h
//  XDCommonApp
//
//  Created by maboyi on 14-7-29.
//  Copyright (c) 2014年 XD-XY. All rights reserved.
//

#import "XDBaseViewController.h"
#import "XYScrollView.h"
#import "XDShareView.h"
#import "PageScrollView.h"

@interface GoodsDetailViewController : XDBaseViewController<XYScrollViewDelegate,XDShareViewDelegate,PageScrollViewDelegate,UIAlertViewDelegate>
{
    NSMutableDictionary * dataDict;
    UIScrollView * backScrollView;
//    XYScrollView * banner;
    PageScrollView * banner;
    UILabel * nameLB;
    UILabel * vipPriceLB;
    UILabel * normalLB;
    UILabel * lineLabel;
    UILabel * buyersNumLB;
    UILabel * showLB;
    NSString * price;
    NSString * months;
    NSMutableArray * priceArray;
    NSMutableArray * monthArray;
    BOOL isFirst;

    UIView * bottomBg;

    UIView * bg1;
    UIView * bg2;
    UIView * bg3;
    UIView * bg4;

    NSString * guigeStr;
    NSString * yuefuStr;

    NSMutableArray * guigeBtnArray;
    NSMutableArray * monthsBtnArray;

    int index;
    BOOL notFirst;

}
@property (nonatomic,strong)XDShareView * shareView;
@property (nonatomic,copy) NSString * goodsId;
@property (nonatomic,copy) NSString * picStr;
@end
