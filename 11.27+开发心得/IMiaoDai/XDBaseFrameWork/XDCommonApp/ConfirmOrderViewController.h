//
//  ConfirmOrderViewController.h
//  XDCommonApp
//
//  Created by xindao on 14-8-4.
//  Copyright (c) 2014年 XD-XY. All rights reserved.
//

#import "XDBaseViewController.h"
#import "ChooseCityViewController.h"

@interface ConfirmOrderViewController : XDBaseViewController<UITextFieldDelegate,UITextViewDelegate,UIScrollViewDelegate,UITableViewDataSource,UIAlertViewDelegate,UITableViewDelegate,ChooseCityViewControllerDelegate>
{
    UIScrollView * backScrollView;
    UIImageView * headIV;
    UILabel * titleLB;
    UILabel * canshuLB;
    UILabel * payTypeLB;

    UITextField * nameTF;
    UITextField * phoneTF;
    UILabel * cityLB;
    UILabel * schoolLB;
    UIButton * cityBtn;
    UIButton * schoolBtn;
    UITextView * addressTV;
    UITextField * proxyTF;

    UIButton * agreementBtn;
    UIView * chooseAd_BgView;
    UIImageView * city_BgView;

    UITableView * cityTableView;
    UIButton * lastBtn;
    UIButton * nextBtn;

    NSString *  addressLayer;

    NSString * provinceId;
    NSString * cityId;
    NSString * oldCityId;
    NSString * schoolId;

    NSString * lastProvinceId;
    NSString * lastCityId;
    NSString * lastCollegeId;

    NSMutableArray * dataArray;
    NSMutableArray * dataArray2;
    NSMutableArray * dataArray3;
    
    UILabel * cityContentLB;
    UILabel * schoolContentLB;
    UILabel * addressPlaceholderLB;
    
    UIButton * upbtn;
    CGSize bgscrollviewSize;

    NSMutableDictionary * baseInfoDict;
    NSMutableDictionary * baseInfoErrorDict;
    NSMutableDictionary * otherInfoDict;
    NSMutableDictionary * otherInfoErrorDict;
    NSMutableDictionary * picInfoDict;
    NSMutableDictionary * picInfoErrorDict;
    
    UILabel * label2;
    UILabel * label3;



}
@property (nonatomic,copy) NSString * goodsName;
@property (nonatomic,copy) NSString * canshu;
@property (nonatomic,copy) NSString * months;
@property (nonatomic,copy) NSString * price;
@property (nonatomic,copy) NSString * goodsId;
@property (nonatomic,copy) NSString * type;
@property (nonatomic,copy) NSString * picStr;
@property (nonatomic,strong)NSString * sjString;
@property(nonatomic,strong)NSString * gsString;
@property (nonatomic,copy) NSString * bussinessName;
@property (nonatomic,copy) NSString * bussinessPromise;
@end
