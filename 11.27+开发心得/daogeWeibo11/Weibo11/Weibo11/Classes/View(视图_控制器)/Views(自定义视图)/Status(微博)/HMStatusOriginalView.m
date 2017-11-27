//
//  HMStatusOriginalView.m
//  Weibo11
//
//  Created by 刘凡 on 15/12/9.
//  Copyright © 2015年 itheima. All rights reserved.
//

#import "HMStatusOriginalView.h"
#import "HMStatusCellCommon.h"
#import "HMStatusPictureView.h"

@implementation HMStatusOriginalView {
    /// 头像视图
    UIImageView *_iconView;
    /// 用户昵称
    UILabel *_nameLabel;
    /// 会员等级图像
    UIImageView *_memberImageView;
    /// 认证图像
    UIImageView *_vipImageView;
    /// 时间标签
    UILabel *_timeLabel;
    /// 来源标签
    UILabel *_sourceLabel;
    /// 内容标签
    UILabel *_contentLabel;
    /// 配图视图
    HMStatusPictureView *_pictureView;
    /// 配图视图底部约束
    MASConstraint *_pictureBottomConstraint;
}

#pragma mark - 设置数据
- (void)setViewModel:(HMStatusViewModel *)viewModel {
    _viewModel = viewModel;
    
    // 1. 设置头像
    [_iconView sd_setImageWithURL:viewModel.userAvatarURL];
    // 2. 设置姓名
    _nameLabel.text = viewModel.status.user.screen_name;
    // 3. 会员图标
    _memberImageView.image = viewModel.memberImage;
    // 4. 认证图标
    _vipImageView.image = viewModel.verifiedImage;
    // 5. 来源
    _sourceLabel.text = viewModel.status.source;
    // 6. 创建时间
    _timeLabel.text = viewModel.status.createdDate.ff_dateDescription;
    
    // 7. 微博正文
    _contentLabel.text = viewModel.status.text;
    
    // 8. 设置配图视图内容
    [self setupPictureViewWithURLs:viewModel.status.pic_urls];
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
    self.backgroundColor = [UIColor whiteColor];
    
    // 0. 创建控件
    _iconView = [UIImageView ff_imageViewWithImageName:@"avatar_default_big"];
    _nameLabel = [UILabel ff_labelWithTitle:@"Hello Weibo" color:[UIColor darkGrayColor] fontSize:14];
    _memberImageView = [UIImageView ff_imageViewWithImageName:@"common_icon_membership_level1"];
    _vipImageView = [UIImageView ff_imageViewWithImageName:@"avatar_vip"];
    _timeLabel = [UILabel ff_labelWithTitle:@"刚刚" color:[UIColor orangeColor] fontSize:10];
    _sourceLabel = [UILabel ff_labelWithTitle:@"来自 sina weibo" color:[UIColor lightGrayColor] fontSize:10];
    _contentLabel = [UILabel ff_labelWithTitle:@"content" color:[UIColor darkGrayColor] fontSize:15 alignment:NSTextAlignmentLeft];
    _pictureView = [[HMStatusPictureView alloc] init];
    _pictureView.backgroundColor = self.backgroundColor;
    
    // 1. 添加控件
    [self addSubview:_iconView];
    [self addSubview:_nameLabel];
    [self addSubview:_memberImageView];
    [self addSubview:_vipImageView];
    [self addSubview:_timeLabel];
    [self addSubview:_sourceLabel];
    [self addSubview:_contentLabel];
    [self addSubview:_pictureView];
    
    // 2. 自动布局
    [_iconView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset(kStatusCellMargin);
        make.left.equalTo(self).offset(kStatusCellMargin);
        make.size.mas_equalTo(CGSizeMake(kStatusCellIconWidth, kStatusCellIconWidth));
    }];
    [_nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_iconView.mas_right).offset(kStatusCellMargin);
        make.top.equalTo(_iconView);
    }];
    [_memberImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_nameLabel.mas_right).offset(kStatusCellMargin);
        make.top.equalTo(_nameLabel);
    }];
    [_vipImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(_iconView.mas_right);
        make.centerY.equalTo(_iconView.mas_bottom);
    }];
    [_timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_iconView.mas_right).offset(kStatusCellMargin);
        make.bottom.equalTo(_iconView);
    }];
    [_sourceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_timeLabel.mas_right).offset(kStatusCellMargin);
        make.bottom.equalTo(_timeLabel);
    }];
    [_contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(kStatusCellMargin);
        make.right.equalTo(self).offset(-kStatusCellMargin);
        make.top.equalTo(_iconView.mas_bottom).offset(kStatusCellMargin);
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
