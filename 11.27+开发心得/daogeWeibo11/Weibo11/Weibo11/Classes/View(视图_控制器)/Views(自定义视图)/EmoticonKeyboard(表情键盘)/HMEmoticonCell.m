//
//  HMEmoticonCell.m
//  Weibo11
//
//  Created by 刘凡 on 15/12/15.
//  Copyright © 2015年 itheima. All rights reserved.
//

#import "HMEmoticonCell.h"
#import "HMEmoticonManager.h"
#import "HMEmoticonButton.h"
#import "HMEmoticonTipView.h"

@interface HMEmoticonCell()
/// 表情按钮数组
@property (nonatomic, strong) NSMutableArray *emoticonButtons;
/// 提示视图
@property (nonatomic, strong) HMEmoticonTipView *tipView;
/// 最近分组提示标签
@property (nonatomic) UILabel *recentTipLabel;
@end

@implementation HMEmoticonCell

#pragma mark - 设置数据
- (void)setEmoticons:(NSArray *)emoticons {
    
    // 首先将所有按钮隐藏
    for (UIButton *btn in self.emoticonButtons) {
        btn.hidden = YES;
    }
    
    // 遍历数组设置表情按钮图片
    NSInteger index = 0;
    for (HMEmoticon *em in emoticons) {
        
        HMEmoticonButton *btn = self.emoticonButtons[index++];
        btn.emoticon = em;
    }
}

- (void)setIndexPath:(NSIndexPath *)indexPath {
    self.recentTipLabel.hidden = indexPath.section != 0;
}

#pragma mark - 监听方法
/// 点击表情按钮(包括删除按钮)
- (void)clickEmoticonButton:(HMEmoticonButton *)button {
    // 通知代理选中删除按钮
    if ([self.delegate respondsToSelector:@selector(emoticonCellDidSelectedEmoticon:isDeleted:)]) {
        [self.delegate emoticonCellDidSelectedEmoticon:button.emoticon isDeleted:button.isDeleteButton];
    }
}

- (void)longPressGesture:(UIPanGestureRecognizer *)recognizer {
    
    CGPoint location = [recognizer locationInView:self];
    
    // 根据位置判断用户选中按钮
    HMEmoticonButton *emoticonButton = [self emoticonButtonWithLocation:location];
    
    // 如果没有选中按钮，隐藏提示视图
    self.tipView.hidden = emoticonButton == nil;
    
    // 识别手势状态
    // 提示，如果没有 break，会继续执行后续分支中的代码
    switch (recognizer.state) {
        case UIGestureRecognizerStateBegan:
            [self.window addSubview:self.tipView];
        case UIGestureRecognizerStateChanged:
            self.tipView.center = [self tipViewCenterWithButton:emoticonButton];
            self.tipView.emoticon = emoticonButton.emoticon;
            break;
        case UIGestureRecognizerStateEnded:
            if (emoticonButton != nil) {
                [self clickEmoticonButton:emoticonButton];
            }
        case UIGestureRecognizerStateCancelled:
        case UIGestureRecognizerStateFailed:
            [self.tipView removeFromSuperview];
            break;
            
        default:
            break;
    }
}

/// 根据位置，判断用户选中按钮
- (HMEmoticonButton *)emoticonButtonWithLocation:(CGPoint)location {
    // 遍历所有按钮
    for (HMEmoticonButton *btn in self.emoticonButtons) {
        
        if (CGRectContainsPoint(btn.frame, location)) {
            return btn;
            break;
        }
    }
    return nil;
}

- (CGPoint)tipViewCenterWithButton:(UIButton *)button {
    // 将按钮的中心点转换到 window 坐标系(tipView 是被添加到 window 上的)
    CGPoint center = [self convertPoint:button.center toView:self.window];
    
    // 将中心点 y 值向上移动 (按钮图像视图高度 + tipView高度) * 0.5;
    center.y -= (button.imageView.bounds.size.height + self.tipView.bounds.size.height) * 0.5;
    
    return center;
}

#pragma mark - 构造函数
/// 提示：在构造函数时，视图还没有被添加到 window 中，此时的 window == nil
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setupEmoticonButtons];
        
        // 添加提示标签
        [self addSubview:self.recentTipLabel];
        self.recentTipLabel.center = CGPointMake((NSInteger)self.center.x % (NSInteger)self.bounds.size.width, self.bounds.size.height - 16);
        
        // 添加长按手势
        UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPressGesture:)];
        // 设置长按手势识别时间
        longPress.minimumPressDuration = 0.1;
        [self addGestureRecognizer:longPress];        
    }
    return self;
}

/// 设置表情按钮
- (void)setupEmoticonButtons {
    
    NSInteger rowCount = 3;
    NSInteger colCount = 7;
    // 间距
    CGFloat leftMargin = 8;
    CGFloat bottomMargin = 16;
    
    CGFloat w = (self.bounds.size.width - 2 * leftMargin) / colCount;
    CGFloat h = (self.bounds.size.height - bottomMargin) / rowCount;
    
    for (NSInteger row = 0; row < rowCount; row++) {
        for (NSInteger col = 0; col < colCount; col++) {
            CGRect rect = CGRectMake(col * w + leftMargin, row * h, w, h);
            
            HMEmoticonButton *button = [[HMEmoticonButton alloc] initWithFrame:rect];
            
            [self.contentView addSubview:button];
            [self.emoticonButtons addObject:button];
            
            [button addTarget:self action:@selector(clickEmoticonButton:) forControlEvents:UIControlEventTouchUpInside];
        }
    }
    
    // 设置删除按钮
    HMEmoticonButton *deleteButton = self.emoticonButtons.lastObject;
    // 将删除按钮从表情数组中移除
    [self.emoticonButtons removeLastObject];
    
    deleteButton.isDeleteButton = YES;
}

#pragma mark - 懒加载控件
- (NSMutableArray *)emoticonButtons {
    if (_emoticonButtons == nil) {
        _emoticonButtons = [[NSMutableArray alloc] init];
    }
    return _emoticonButtons;
}

- (HMEmoticonTipView *)tipView {
    if (_tipView == nil) {
        _tipView = [[HMEmoticonTipView alloc] init];
    }
    return _tipView;
}

- (UILabel *)recentTipLabel {
    if (_recentTipLabel == nil) {
        _recentTipLabel = [[UILabel alloc] init];
        
        _recentTipLabel.text = @"最近使用的表情";
        _recentTipLabel.textColor = [UIColor grayColor];
        _recentTipLabel.font = [UIFont systemFontOfSize:12];
        
        [_recentTipLabel sizeToFit];
    }
    return _recentTipLabel;
}

@end
