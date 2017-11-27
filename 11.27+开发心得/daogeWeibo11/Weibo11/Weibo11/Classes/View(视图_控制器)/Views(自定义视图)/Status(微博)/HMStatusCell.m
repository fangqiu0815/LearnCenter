//
//  HMStatusCell.m
//  Weibo11
//
//  Created by 刘凡 on 15/12/9.
//  Copyright © 2015年 itheima. All rights reserved.
//

#import "HMStatusCell.h"
#import "HMStatusOriginalView.h"
#import "HMStatusRetweetedView.h"
#import "HMStatusToolBar.h"
#import "HMStatusCellCommon.h"

@implementation HMStatusCell {
    /// 原创微博视图
    HMStatusOriginalView *_originalView;
    /// 转发微博视图
    HMStatusRetweetedView *_retweetedView;
    /// 底部视图
    HMStatusToolBar *_toolBar;
    /// 底部视图顶部约束
    MASConstraint *_toolBarTopConstraint;
}

#pragma mark - 设置数据
- (void)setViewModel:(HMStatusViewModel *)viewModel {
    _viewModel = viewModel;
    
    _originalView.viewModel = viewModel;
    _toolBar.viewModel = viewModel;
    _retweetedView.viewModel = viewModel;
    
    // 如果没有转发微博，隐藏转发微博视图，并且修改底部视图的约束
    _retweetedView.hidden = !viewModel.hasRetweeted;
    [_toolBarTopConstraint uninstall];
    // 更新底部约束
    if (viewModel.hasRetweeted) {
        [_toolBar mas_makeConstraints:^(MASConstraintMaker *make) {
            _toolBarTopConstraint = make.top.equalTo(_retweetedView.mas_bottom);
        }];
    } else {
        [_toolBar mas_makeConstraints:^(MASConstraintMaker *make) {
            _toolBarTopConstraint = make.top.equalTo(_originalView.mas_bottom);
        }];
    }
}

#pragma mark - 构造函数
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setupUI];
    }
    return self;
}

#pragma mark - 设置界面
- (void)setupUI {
    // 0. 创建控件
    _originalView = [[HMStatusOriginalView alloc] init];
    _retweetedView = [[HMStatusRetweetedView alloc] init];
    _toolBar = [[HMStatusToolBar alloc] init];
    
    // 1. 添加控件
    [self.contentView addSubview:_originalView];
    [self.contentView addSubview:_retweetedView];
    [self.contentView addSubview:_toolBar];
    
    self.contentView.backgroundColor = [UIColor colorWithWhite:0.95 alpha:1.0];
    // 2. 自动布局
    // 1> 原创微博
    [_originalView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView).offset(10);
        make.left.equalTo(self.contentView);
        make.right.equalTo(self.contentView);
    }];
    // 2> 转发微博
    [_retweetedView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_originalView.mas_bottom);
        make.left.equalTo(_originalView);
        make.right.equalTo(_originalView);
    }];
    // 3> 工具栏
    [_toolBar mas_makeConstraints:^(MASConstraintMaker *make) {
        _toolBarTopConstraint = make.top.equalTo(_retweetedView.mas_bottom);
        make.left.equalTo(self.contentView);
        make.right.equalTo(self.contentView);
        make.height.mas_equalTo(40);
    }];
    // 4> 底部约束，非常重要
    [self.contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(_toolBar);
        make.top.equalTo(self);
        make.leading.equalTo(self);
        make.trailing.equalTo(self);
    }];
}

@end
