//
//  HMTextView.m
//  Weibo11
//
//  Created by 刘凡 on 15/12/14.
//  Copyright © 2015年 itheima. All rights reserved.
//

#import "HMTextView.h"

@interface HMTextView()
/// 占位标签
@property (nonatomic, strong) UILabel *placeholderLabel;
@end

@implementation HMTextView

#pragma mark - 设置属性
- (void)setPlaceholder:(NSString *)placeholder {
    self.placeholderLabel.text = placeholder;
}

- (void)setFont:(UIFont *)font {
    [super setFont:font];
    
    // 指定占位文字控件的字体大小
    self.placeholderLabel.font = font;
}

#pragma mark - 构造函数
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setupUI];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)coder {
    self = [super initWithCoder:coder];
    if (self) {
        [self setupUI];
    }
    return self;
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark - 设置界面
/// 设置界面
- (void)setupUI {
    // 1. 添加控件
    [self addSubview:self.placeholderLabel];
    
    // 2. 自动布局
    [self.placeholderLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(5);
        make.top.mas_equalTo(8);
        make.width.mas_equalTo(self).offset(-10);
    }];
    
    // 3. 添加通知 - 仅监听当前文本视图发送的文本变化通知事件
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textDidChanged) name:UITextViewTextDidChangeNotification object:self];
}

- (void)textDidChanged {
    self.placeholderLabel.hidden = self.hasText;
}

#pragma mark - 懒加载控件
- (UILabel *)placeholderLabel {
    if (_placeholderLabel == nil) {
        _placeholderLabel = [[UILabel alloc] init];
        _placeholderLabel.numberOfLines = 0;
        _placeholderLabel.text = @"Hello World";
        _placeholderLabel.font = self.font;
        _placeholderLabel.textColor = [UIColor lightGrayColor];
        
        [_placeholderLabel sizeToFit];
    }
    return _placeholderLabel;
}

@end
