//
//  HMStatusToolBar.m
//  Weibo11
//
//  Created by 刘凡 on 15/12/9.
//  Copyright © 2015年 itheima. All rights reserved.
//

#import "HMStatusToolBar.h"
#import "HMStatusCellCommon.h"

@implementation HMStatusToolBar {
    /// 转发微博
    UIButton *_retweetedButton;
    /// 评论按钮
    UIButton *_commentButton;
    /// 点赞按钮
    UIButton *_likeButton;
}

#pragma mark - 设置数据
- (void)setViewModel:(HMStatusViewModel *)viewModel {
    _viewModel = viewModel;
    
    [_retweetedButton setTitle:viewModel.repostsCountStr forState:UIControlStateNormal];
    [_commentButton setTitle:viewModel.commentsCountStr forState:UIControlStateNormal];
    [_likeButton setTitle:viewModel.attitudesCountStr forState:UIControlStateNormal];
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
    
    // 背景颜色
    self.backgroundColor = [UIColor colorWithWhite:0.9 alpha:1.0];
    
    // 0. 创建控件
    _retweetedButton = [UIButton ff_buttonWithTitle:@" 转发"
                                              color:[UIColor darkGrayColor]
                                           fontSize:12
                                          imageName:@"timeline_icon_retweet"
                                      backImageName:@"timeline_card_bottom_background"];
    _commentButton = [UIButton ff_buttonWithTitle:@" 评论"
                                            color:[UIColor darkGrayColor]
                                         fontSize:12
                                        imageName:@"timeline_icon_comment"
                                    backImageName:@"timeline_card_bottom_background"];
    _likeButton = [UIButton ff_buttonWithTitle:@" 赞"
                                         color:[UIColor darkGrayColor]
                                      fontSize:12
                                     imageName:@"timeline_icon_unlike"
                                 backImageName:@"timeline_card_bottom_background"];
    
    // 分隔线
    UIImageView *sep1 = [UIImageView ff_imageViewWithImageName:@"timeline_card_bottom_line_highlighted"];
    UIImageView *sep2 = [UIImageView ff_imageViewWithImageName:@"timeline_card_bottom_line_highlighted"];
    
    // 1. 添加控件
    [self addSubview:_retweetedButton];
    [self addSubview:_commentButton];
    [self addSubview:_likeButton];
    [self addSubview:sep1];
    [self addSubview:sep2];
    
    // 2. 自动布局
    [_retweetedButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self);
        make.top.equalTo(self);
        make.bottom.equalTo(self);
    }];
    [_commentButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_retweetedButton.mas_right);
        make.top.equalTo(self);
        make.bottom.equalTo(self);
        make.width.equalTo(_retweetedButton);
    }];
    [_likeButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_commentButton.mas_right);
        make.top.equalTo(self);
        make.bottom.equalTo(self);
        make.width.equalTo(_commentButton);
        
        make.right.equalTo(self);
    }];
    
    [sep1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_retweetedButton.mas_right);
        make.centerY.equalTo(self);
    }];
    [sep2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_commentButton.mas_right);
        make.centerY.equalTo(self);
    }];
}

@end
