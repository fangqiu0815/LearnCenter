//
//  HMStatusRetweetedView.m
//  Weibo11
//
//  Created by 刘凡 on 15/12/9.
//  Copyright © 2015年 itheima. All rights reserved.
//

#import "HMStatusRetweetedView.h"
#import "HMStatusCellCommon.h"
#import "HMStatusPictureView.h"

@implementation HMStatusRetweetedView {
    /// 转发微博标签
    UILabel *_contentLabel;
    /// 配图视图
    HMStatusPictureView *_pictureView;
    /// 配图视图底部约束
    MASConstraint *_pictureBottomConstraint;
}

#pragma mark - 设置数据
- (void)setViewModel:(HMStatusViewModel *)viewModel {
    _viewModel = viewModel;
    
    // 1. 转发微博文字
    _contentLabel.text = viewModel.retweetedText;
    
    // 2. 设置配图视图内容
    [self setupPictureViewWithURLs:viewModel.status.retweeted_status.pic_urls];
}

/// 更新配图视图约束，
/// - 如果有配图，让当前视图参照 配图视图 设置底部约束
/// - 如果没有配图，让当前视图参照 转发标签 设置底部约束
- (void)setupPictureViewWithURLs:(NSArray *)urls {
    
    // 1. 设置配图视图数据
    _pictureView.urls = urls;
    
    // 2. 是否隐藏视图
    BOOL hasPicture = urls.count > 0;
    _pictureView.hidden = !hasPicture;
    
    // 3. 判断是否有配图
    [_pictureBottomConstraint uninstall];
    if (hasPicture) {
        [self mas_makeConstraints:^(MASConstraintMaker *make) {
            _pictureBottomConstraint = make.bottom.equalTo(_pictureView).offset(kStatusCellMargin);
        }];
    } else {
        [self mas_makeConstraints:^(MASConstraintMaker *make) {
            _pictureBottomConstraint = make.bottom.equalTo(_contentLabel).offset(kStatusCellMargin);
        }];
    }
}

#pragma mark - 构造函数
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setupUI];
    }
    return self;
}

#pragma mark - 设置界面
- (void)setupUI {
    self.backgroundColor = [UIColor colorWithWhite:0.9 alpha:1.0];
    
    // 0. 创建控件
    _contentLabel = [UILabel ff_labelWithTitle:@"retweeted retweeted retweeted retweeted retweeted retweeted retweeted" color:[UIColor darkGrayColor] fontSize:15 alignment:NSTextAlignmentLeft];
    _pictureView = [[HMStatusPictureView alloc] init];
    // 设置配图视图的背景颜色和当前视图相同
    _pictureView.backgroundColor = self.backgroundColor;
    
    // 1. 添加控件
    [self addSubview:_contentLabel];
    [self addSubview:_pictureView];
    
    // 2. 自动布局
    [_contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(kStatusCellMargin);
        make.right.equalTo(self).offset(-kStatusCellMargin);
        make.top.equalTo(self).offset(kStatusCellMargin);
    }];
    
    [_pictureView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_contentLabel);
        make.top.equalTo(_contentLabel.mas_bottom).offset(kStatusCellMargin);
        make.size.mas_equalTo(CGSizeMake(90, 90));
    }];
    
    // 3. 设置视图的底部约束
    [self mas_makeConstraints:^(MASConstraintMaker *make) {
        _pictureBottomConstraint = make.bottom.equalTo(_pictureView).offset(kStatusCellMargin);
    }];
}

@end
