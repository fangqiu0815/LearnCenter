//
//  HMDiscoverSearchView.m
//  Weibo11
//
//  Created by 刘凡 on 15/12/5.
//  Copyright © 2015年 itheima. All rights reserved.
//

#import "HMDiscoverSearchView.h"

@interface HMDiscoverSearchView() <UITextFieldDelegate>
/// 输入框
@property (nonatomic, strong) UITextField *textField;
/// 取消按钮
@property (nonatomic, strong) UIButton *cancelButton;
@end

@implementation HMDiscoverSearchView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setupUI];
    }
    return self;
}

#pragma mark - 监听方法
/// 点击取消按钮监听方法
- (void)clickCancelButton {
    [self.textField resignFirstResponder];
    
    [self updateTextFieldConstraint:0];
}

#pragma mark - UITextFieldDelegate
/// 文本内容发生变化事件
- (void)textFieldDidBeginEditing:(UITextField *)textField {
    [self updateTextFieldConstraint:self.cancelButton.bounds.size.width];
}

/// 动画更新文本框右侧约束
///
/// @param constraint 约束数值
- (void)updateTextFieldConstraint:(CGFloat)constraint {
    
    [self.textField mas_updateConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsMake(0, 0, 0, constraint));
    }];
    
    [UIView animateWithDuration:0.25 animations:^{
        [self layoutIfNeeded];
    }];
}

#pragma mark - 设置界面
/// 设置类型
- (void)setupUI {
 
    // 添加控件
    [self addSubview:self.cancelButton];
    [self addSubview:self.textField];
    
    // 自动布局
    [self.cancelButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self);
        make.bottom.equalTo(self);
        make.right.equalTo(self);
        make.width.mas_equalTo(45);
    }];
    [self.textField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsZero);
    }];
}

#pragma mark - 懒加载控件
/// 搜索文本框
- (UITextField *)textField {
    if (_textField == nil) {
        _textField = [[UITextField alloc] init];
        
        // 设置图层属性
        _textField.backgroundColor = [UIColor colorWithRed:0.4 green:.8 blue:1.0 alpha:0.5];
        _textField.borderColor = [UIColor darkGrayColor];
        _textField.borderWidth = 1.0;
        _textField.cornerRadius = 5.0;
        
        // 设置左侧视图
        UIImageView *leftView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"searchbar_textfield_search_icon"]];
        leftView.frame = CGRectMake(0, 0, self.bounds.size.height, self.bounds.size.height);
        leftView.contentMode = UIViewContentModeCenter;
        
        _textField.leftView = leftView;
        _textField.leftViewMode = UITextFieldViewModeAlways;
        
        // 占位文本
        _textField.placeholder = @"听说下雨天和辣条更配呦";
        
        // 设置代理
        _textField.delegate = self;
    }
    return _textField;
}

/// 取消按钮
- (UIButton *)cancelButton {
    if (_cancelButton == nil) {
        _cancelButton = [[UIButton alloc] init];
        
        [_cancelButton setTitle:@"取消" forState:UIControlStateNormal];
        [_cancelButton setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
        
        [self addSubview:_cancelButton];
        
        // 监听方法
        [_cancelButton addTarget:self action:@selector(clickCancelButton) forControlEvents:UIControlEventTouchUpInside];
    }
    return _cancelButton;
}

@end
