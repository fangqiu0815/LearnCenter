//
//  PersonInfoViewController.h
//  XDCommonApp
//
//  Created by xindao on 14-8-6.
//  Copyright (c) 2014年 XD-XY. All rights reserved.
//

#import "XDBaseViewController.h"
#import "ChooseCityViewController.h"
#import "SchoolInfoViewController.h"
@class MaterialsViewController;
@protocol BaseInfoRefreshStatusDelegate <NSObject>
-(void)refreshStatus:(NSString *)type;
@end

@interface PersonInfoViewController : XDBaseViewController<UITextViewDelegate,UIScrollViewDelegate,UITextFieldDelegate,ChooseCityViewControllerDelegate,ChooseSchoolInfoDelegate>
{
    UIScrollView * backScrollView;

    UIButton * maleBtn;
    UIButton * femaleBtn;
    UIButton * classmateBtn;
    UIButton * familyBtn;
    UIButton * friendBtn;
    UIButton * othersBtn;

    UIButton * saveBtn;

    NSMutableArray * relationBtnArray;

    UITextField * nameTF;
    UITextField * humanCardTF;
    UITextField * QQTF;
    UITextField * weiboTF;
    UITextField * cityTF;
    UITextField * schoolNameTF;
    UITextField * zhuanyeTF;
    UITextField * schoolAddressTF;
    UITextField * roomNumTF;
    UITextField * goSchoolTimeTF;
    UITextField * xuezhiTF;
    UITextField * relationNameTF;
    UITextField * relationPhoneTF;
    UITextView * familyAddressTV;
    UILabel * familyAddressPlaceHolderLB;
    UITextField * familyPhoneTF;

    UILabel * selLabel;

    NSString * oldCityId;
    NSString * cityId;
    NSString * schoolId;

    BOOL isFirstResponse;
}
@property (nonatomic,strong) NSMutableDictionary * infoDict;
@property (nonatomic,strong) NSMutableDictionary * errorDict;
@property (nonatomic,assign)MaterialsViewController * mmmVC;
@property(nonatomic,assign) id <BaseInfoRefreshStatusDelegate> delegate;

@end
