//
//  HMEmoticonToolbar.m
//  Weibo11
//
//  Created by 刘凡 on 15/12/15.
//  Copyright © 2015年 itheima. All rights reserved.
//

#import "HMEmoticonToolbar.h"

/// 按钮 tag 起始数值
static NSInteger kEmoticonToolbarTagBaseValue = 1000;

@interface HMEmoticonToolbar()
@property (nonatomic, weak) UIButton *selectedButton;
@end

@implementation HMEmoticonToolbar

#pragma mark - 公共方法
- (void)setSelectedButtonWithSection:(NSInteger)section {
    // 如果是选中按钮直接返回
    if (section == self.selectedButton.tag - kEmoticonToolbarTagBaseValue) {
        return;
    }
    
    // 根据 tag 获取目标按钮
    UIButton *button = [self viewWithTag:section + kEmoticonToolbarTagBaseValue];
    
    [self selectedButtonWithButton:button];
}

#pragma mark - 监听方法
/// 点击工具栏按钮
- (void)clickToolbarButton:(UIButton *)button {
    // 判断是否和选中按钮一直
    if (button == self.selectedButton) {
        return;
    }
    
    [self selectedButtonWithButton:button];
    
    // 通知代理选中表情类型
    if ([self.delegate respondsToSelector:@selector(emoticonToolbarDidSelectEmoticonType:)]) {
        [self.delegate emoticonToolbarDidSelectEmoticonType:button.tag - kEmoticonToolbarTagBaseValue];
    }
}

/// 将指定的按钮设置为选中按钮
- (void)selectedButtonWithButton:(UIButton *)button {
    // 设置选中状态
    button.selected = !button.selected;
    // 取消之前按钮的选中状态
    self.selectedButton.selected = !self.selectedButton.selected;
    // 记录选中按钮
    self.selectedButton = button;
}

#pragma mark - 构造函数
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {        
        [self setupUI];
        
        [self clickToolbarButton:self.subviews[1]];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    // 计算分组按钮位置
    CGRect rect = self.bounds;
    CGFloat w = rect.size.width / self.subviews.count;
    rect.size.width = w;
    
    int index = 0;
    for (UIView *v in self.subviews) {
        v.frame = CGRectOffset(rect, index++ * w, 0);
    }
}

#pragma mark - 设置界面
- (void)setupUI {
    [self addChildButton:@"最近" bgImageName:@"left" type:EmoticonToolbarRecent];
    [self addChildButton:@"默认" bgImageName:@"mid" type:EmoticonToolbarNormal];
    [self addChildButton:@"emoji" bgImageName:@"mid" type:EmoticonToolbarEmoji];
    [self addChildButton:@"浪小花" bgImageName:@"right" type:EmoticonToolbarLangXiaohua];
}

- (void)addChildButton:(NSString *)title bgImageName:(NSString *)bgImageName type:(HMEmoticonToolbarType)type {
    UIButton *btn = [[UIButton alloc] init];
    
    btn.tag = type + kEmoticonToolbarTagBaseValue;
    
    [btn setTitle:title forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont systemFontOfSize:14];
    
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor grayColor] forState:UIControlStateSelected];
    
    NSString *imageName = [NSString stringWithFormat:@"compose_emotion_table_%@_normal", bgImageName];
    NSString *imageNameSL = [NSString stringWithFormat:@"compose_emotion_table_%@_selected", bgImageName];
    
    [btn setBackgroundImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    [btn setBackgroundImage:[UIImage imageNamed:imageNameSL] forState:UIControlStateSelected];
    
    [btn addTarget:self action:@selector(clickToolbarButton:) forControlEvents:UIControlEventTouchUpInside];
    
    [self addSubview:btn];
}

@end
