//
//  HMRefreshControl.m
//  Weibo11
//
//  Created by 刘凡 on 15/12/11.
//  Copyright © 2015年 itheima. All rights reserved.
//

#import "HMRefreshControl.h"

#define kRefreshControlHeight 64

/// 刷新状态枚举
/// - Normal:       默认状态或者松开手就回到默认状态
/// - Pulling:      `将要刷新` - 松开手就进入刷新的状态
/// - Refreshing:   正在刷新
typedef enum : NSUInteger {
    Normal,
    Pulling,
    Refreshing,
} HMRefreshControlState;

@interface HMRefreshControl()

/// 父视图 - 滚动视图
@property (nonatomic, weak) UIScrollView *scrollView;

/// 刷新控件状态
@property (nonatomic, assign) HMRefreshControlState refreshState;

// 之前的状态，用于在设置成 `Normal` 时，判断之前的状态是否是 `Refreshing` 状态
@property (nonatomic, assign) HMRefreshControlState preRefreshState;
@end

@implementation HMRefreshControl {
    
    /// 箭头图标
    UIImageView *_arrowIcon;
    /// 消息标签
    UILabel *_messageLabel;
    /// 加载提示控件
    UIActivityIndicatorView *_indicator;
}

#pragma mark - 设置数据
- (void)setRefreshState:(HMRefreshControlState)refreshState {
    _refreshState = refreshState;
    
    switch (refreshState) {
        case Pulling: {
            _messageLabel.text = @"放开开始刷新";
            
            [UIView animateWithDuration:0.25 animations:^{
                _arrowIcon.transform = CGAffineTransformMakeRotation(M_PI);
            }];
        }
            break;
        case Refreshing: {
            _messageLabel.text = @"正在刷新数据";
            _arrowIcon.hidden = YES;
            [_indicator startAnimating];
            
            // 增加顶部滑动距离
            [self modifyInset:kRefreshControlHeight];
            
            // 发送数值变化事件
            [self sendActionsForControlEvents:UIControlEventValueChanged];
        }
            break;
        case Normal: {
            _messageLabel.text = @"下拉刷新数据";
            _arrowIcon.hidden = NO;
            [_indicator stopAnimating];
            
            // 恢复箭头状态
            [UIView animateWithDuration:0.25 animations:^{
                _arrowIcon.transform = CGAffineTransformIdentity;
            }];
            
            // 从刷新状态切换到默认状态才会执行下面的代码
            if (self.preRefreshState == Refreshing) {
                [self modifyInset:-kRefreshControlHeight];
            }
        }
            
            break;
    }
    
    // 记录状态
    self.preRefreshState = refreshState;
}

/// 动画修改顶部滑动距离
///
/// @param offset 高度偏移量
- (void)modifyInset:(CGFloat)offset {
    // 恢复顶部滑动距离
    UIEdgeInsets inset = self.scrollView.contentInset;
    inset.top += offset;
    
    [UIView animateWithDuration:0.25 animations:^{
        self.scrollView.contentInset = inset;
    }];
}

/// 结束刷新
- (void)endRefreshing {
    // 重置刷新状态
    self.refreshState = Normal;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setupUI];
    }
    return self;
}

#pragma mark - 视图生命周期
- (void)willMoveToSuperview:(UIView *)newSuperview {
    [super willMoveToSuperview:newSuperview];
    
    // 判断父视图类型，如果是 UIScrollView，添加 KVO 监听
    if ([newSuperview isKindOfClass:[UIScrollView class]]) {

        // 添加 KVO 监听
        self.scrollView = (UIScrollView *)newSuperview;
        [self.scrollView addObserver:self forKeyPath:@"contentOffset" options:0 context:nil];
        
        self.frame = CGRectMake(0, -kRefreshControlHeight, self.scrollView.bounds.size.width, kRefreshControlHeight);
    }
}

- (void)dealloc {
    [self.scrollView removeObserver:self forKeyPath:@"contentOffset"];
}

/// KVO 监听方法
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context {
    
    // 1. 判断父视图偏移量
    if (self.scrollView.contentOffset.y > 0) {
        return;
    }
    
    // 2. 计算偏移量
    CGFloat contentInsetTop = self.scrollView.contentInset.top;
    CGFloat conditionValue = -contentInsetTop - kRefreshControlHeight;
    
    // 3. 判断是否正在拖拽 UIScrollView
    if (self.scrollView.dragging) {
        if (self.refreshState == Normal && (self.scrollView.contentOffset.y < conditionValue)) {
            self.refreshState = Pulling;
        } else if (self.refreshState == Pulling && (self.scrollView.contentOffset.y >= conditionValue)) {
            self.refreshState = Normal;
        }
    } else {
        // 用户松手的时候会执行
        if (self.refreshState == Pulling) {
            self.refreshState = Refreshing;
        }
    }
}

#pragma mark - 设置界面
- (void)setupUI {
    
    self.refreshState = Normal;
    
    // 0. 设置背景颜色
    self.backgroundColor = [UIColor whiteColor];
    
    // 1. 创建子控件
    _arrowIcon = [UIImageView ff_imageViewWithImageName:@"tableview_pull_refresh"];
    _messageLabel = [UILabel ff_labelWithTitle:@"下拉刷新" color:[UIColor darkGrayColor] fontSize:14];
    _indicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    
    // 2. 添加控件
    [self addSubview:_arrowIcon];
    [self addSubview:_messageLabel];
    [self addSubview:_indicator];
    
    // 3. 自动布局
    [_messageLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self);
    }];
    [_arrowIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(_messageLabel.mas_left).offset(-8);
        make.centerY.equalTo(_messageLabel);
    }];
    [_indicator mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(_arrowIcon);
    }];
}

@end
