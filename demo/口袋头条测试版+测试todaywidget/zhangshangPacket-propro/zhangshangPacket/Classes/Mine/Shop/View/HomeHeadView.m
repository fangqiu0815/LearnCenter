//
//  HomeHeadView.m
//  zhangshangPacket
//
//  Created by zhenhui huang on 2017/6/3.
//  Copyright © 2017年 apple-fangqiu. All rights reserved.
//

#import "HomeHeadView.h"

@interface HomeHeadView ()<SDCycleScrollViewDelegate>

@property(nonatomic,strong)UIView *topView;
@property(nonatomic,strong)UIImageView *bottomView;

@end

@implementation HomeHeadView
-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self addTheView];
    }
    return self;
}
-(void)addTheView{
    [self addSubview:self.bannerScrollView];
    [self addSubview:self.topView];
    [self addSubview:self.bottomView];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(refreshNum) name:@"refreshNumLab" object:nil];
    
    UILabel *firstLab = [[UILabel alloc]init];
    firstLab.text = @"余额：";
    firstLab.textColor = WhiteColor;
    firstLab.textAlignment = NSTextAlignmentLeft;
    firstLab.font = [UIFont systemFontOfSize:15];
    [self.topView addSubview:firstLab];
    [firstLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15);
        make.top.mas_equalTo(0);
        make.height.mas_equalTo(self.topView.mas_height);
    } ];
    
    UILabel *NumLab = [[UILabel alloc]init];
    self.NumLab = NumLab;
    NumLab.textColor = WhiteColor;
    NumLab.font = [UIFont systemFontOfSize:15];
    [self.topView addSubview:NumLab];
    [NumLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(0);
        make.left.mas_equalTo(firstLab.mas_right);
        make.height.mas_equalTo(self.topView.mas_height);
    }];
    
    UIButton *exchangeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.exchangeBtn = exchangeBtn;
    [exchangeBtn setTitle:@"兑换记录" forState:UIControlStateNormal];
    [exchangeBtn setTitleColor:WhiteColor forState:UIControlStateNormal];
    [exchangeBtn.titleLabel setFont:[UIFont systemFontOfSize:15]];
//    [exchangeBtn addTarget:self action:@selector(exchangeAction) forControlEvents:UIControlEventTouchUpInside];
    [self.topView addSubview:exchangeBtn];
    [exchangeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(0);
        make.right.mas_equalTo(self.mas_right).offset(-15);
        make.height.mas_equalTo(self.topView.mas_height);
    }];
    
    [self.bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.bannerScrollView.mas_bottom);
        make.left.right.mas_equalTo(0);
        make.height.mas_equalTo(35);
    }];
    
    
}

-(void)refreshNum{
    self.NumLab.text = [NSString stringWithFormat:@"%f",STUserDefaults.cash];
}
- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}


#pragma mark - SDCycleScrollViewDelegate
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index
{
    if (self.AdClickBlock)
    {
        self.AdClickBlock(index);
    }
    
}

-(SDCycleScrollView *)bannerScrollView
{
    if (_bannerScrollView == nil)
    {
        _bannerScrollView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 45*AdaptiveScale_W, IPHONE_W,200*AdaptiveScale_W) delegate:self placeholderImage:MyImage(@"banner_none")];
        _bannerScrollView.delegate = self;
        _bannerScrollView.pageControlStyle = SDCycleScrollViewPageContolStyleClassic;
        _bannerScrollView.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        _bannerScrollView.autoScrollTimeInterval = 3.5f;
        _bannerScrollView.placeholderImage = MyImage(@"banner_default");
        _bannerScrollView.hidesForSinglePage = YES;
        _bannerScrollView.pageControlDotSize = CGSizeMake(12 *AdaptiveScale_W, 12 *AdaptiveScale_W);
        _bannerScrollView.pageDotImage = MyImage(@"icon_banner");
        _bannerScrollView.currentPageDotImage = MyImage(@"icon_bannerSelect");
    }
    return _bannerScrollView;
}

-(UIView *)topView{
    if (_topView == nil) {
        _topView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, IPHONE_W, 45*AdaptiveScale_W)];
        _topView.backgroundColor = MainRedColor;
    }
    return _topView;
}

-(UIImageView *)bottomView{
    if (_bottomView == nil) {
        _bottomView = [[UIImageView alloc]init];
        _bottomView.backgroundColor = MainBGColor;
        _bottomView.image = MyImage(@"exchange");
//        _bottomView.frame = CGRectMake(0, 245*AdaptiveScale_W, MyImage(@"exchange").size.width, MyImage(@"exchange").size.height);
    }
    return _bottomView;
}
@end
