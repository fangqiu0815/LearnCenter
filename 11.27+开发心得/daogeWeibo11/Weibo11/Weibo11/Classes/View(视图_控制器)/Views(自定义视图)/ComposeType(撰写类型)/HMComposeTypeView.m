//
//  HMComposeTypeView.m
//  Weibo11
//
//  Created by 刘凡 on 15/12/12.
//  Copyright © 2015年 itheima. All rights reserved.
//

#import "HMComposeTypeView.h"
#import <pop/POP.h>
#import "UIImage+ImageEffects.h"
#import "HMComposeTypeButton.h"
#import "HMComposeType.h"

#define kAnimTranslationY ([UIScreen ff_screenSize].height * 0.5)

@interface HMComposeTypeView() <UIScrollViewDelegate, POPAnimationDelegate>
/// 按钮数组
@property (nonatomic, strong) NSMutableArray *menuButtons;
/// 完成回调
@property (nonatomic, copy) void (^completionCallBack)(HMComposeType *);
/// 选中的按钮
@property (nonatomic, strong) HMComposeTypeButton *selectedButton;
@end

@implementation HMComposeTypeView {
    /// 按钮滚动视图图
    UIScrollView *_scrollView;
    /// 按钮容器视图 - 用于自动布局设置 scrollView 的 contentSize
    UIView *_containerView;
    
    /// 底部工具条视图
    UIView *_bottomView;
    /// 关闭按钮
    UIButton *_closeButton;
    /// 返回按钮
    UIButton *_returnButton;
}

#pragma mark - 构造函数
- (instancetype)initWithSelectedComposeType:(void (^)(HMComposeType *type))completed {
    self = [super initWithFrame:CGRectZero];
    if (self) {
        
        [self setupUI];
        
        // 添加手势识别
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(closeView)];
        [self addGestureRecognizer:tap];
        
        // 记录完成回调
        self.completionCallBack = completed;
    }
    return self;
}

- (void)showInView:(UIView *)view {
    [view addSubview:self];
    
    // 自动布局
    [self mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(view);
    }];
    
    // 显示按钮
    [self showButtons];
}

- (void)dealloc {
    NSLog(@"%@ released", self.class);
}

#pragma mark - 监听方法
/// 关闭当前视图
- (void)closeView {
    [self hideButtons];
}

/// 点击返回按钮
- (void)clickReturnButton {
    // 滚动回第一页
    [_scrollView setContentOffset:CGPointZero animated:YES];
    // 禁用滚动
    _scrollView.scrollEnabled = NO;
    
    // 更新按钮约束
    [self updateActionButtonConstraints:NO];
}

/// 点击更多按钮
- (void)clickMoreButton {

    // 允许滚动视图滚动
    _scrollView.scrollEnabled = YES;
    // 滚动到第二页
    [_scrollView setContentOffset:CGPointMake(_scrollView.bounds.size.width, 0) animated:YES];
    
    // 更新按钮约束
    [self updateActionButtonConstraints:YES];
}

/// 更新操作按钮约束
- (void)updateActionButtonConstraints:(BOOL)showReturn {
    _returnButton.hidden = !showReturn;
    [_returnButton mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(_bottomView).multipliedBy(showReturn ? 0.5 : 1);
        make.centerY.equalTo(_bottomView);
    }];
    [_closeButton mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(_bottomView).multipliedBy(showReturn ? 1.5 : 1);
        make.centerY.equalTo(_bottomView);
    }];
    
    [UIView animateWithDuration:0.25 animations:^{
        [self layoutIfNeeded];
    }];
}

/// 点击撰写按钮
- (void)clickComposeButton:(HMComposeTypeButton *)button {

    // 记录选中的按钮
    self.selectedButton = button;
    
    // 遍历所有按钮
    for (UIButton *btn in self.menuButtons) {
    
        POPBasicAnimation *scaleAnim = [POPBasicAnimation animationWithPropertyNamed:kPOPLayerScaleXY];
        
        CGFloat scale = (btn == button) ? 2.0 : 0.3;
        scaleAnim.toValue = [NSValue valueWithCGPoint:CGPointMake(scale, scale)];
        
        POPBasicAnimation *alphaAnim = [POPBasicAnimation animationWithPropertyNamed:kPOPLayerOpacity];
        alphaAnim.toValue = @(0.2);

        [btn.layer pop_addAnimation:scaleAnim forKey:nil];
        [btn.layer pop_addAnimation:alphaAnim forKey:nil];
        
        if (btn == button) {
            alphaAnim.delegate = self;
        }
    }
}

#pragma mark - POPAnimationDelegate
- (void)pop_animationDidStop:(POPAnimation *)anim finished:(BOOL)finished {
    
    // 完成回调
    if (self.completionCallBack != nil) {
        self.completionCallBack(self.selectedButton.composeType);
    }
    
    // 移除当前视图
    [self removeFromSuperview];
}

#pragma mark - UIScrollViewDelegate
/// UIScrollView 停止滚动代理方法
/// 注意：通过 setContentOffset 方法不会触发此代理方法
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    // 如果是首页，禁用滚动并且更新约束
    if (scrollView.contentOffset.x == 0) {
        [self clickReturnButton];
    }
}

#pragma mark - 按钮动画方法
/// 动画显示撰写类型按钮
- (void)showButtons {
    
    int index = 0;
    for (UIButton *btn in self.menuButtons) {
        [self buttonAnimation:btn index:index++ offsetY:-kAnimTranslationY];
    }
    
    [self rotateCloseButton:YES];
}

/// 动画隐藏撰写类型按钮
- (void)hideButtons {
    int index = 0;
    for (UIButton *btn in self.menuButtons.reverseObjectEnumerator) {
        
        [self buttonAnimation:btn index:index++ offsetY:kAnimTranslationY];
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self removeFromSuperview];
        });
    }
    [self rotateCloseButton:NO];
}

/// 按钮动画
///
/// @param button  要动画的按钮
/// @param index   按钮索引，根据索引计算动画延时
/// @param offsetY 中心 Y 值偏移量
///
/// @return 弹力动画
- (POPSpringAnimation *)buttonAnimation:(UIButton *)button index:(NSInteger)index offsetY:(CGFloat)offsetY {
    
    POPSpringAnimation *anim = [POPSpringAnimation animationWithPropertyNamed:kPOPLayerTranslationY];
    
    anim.toValue = @(offsetY);
    
    // 弹力系数，取值范围 0~20，数值越大，弹性越大，默认数值为4
    anim.springBounciness = 8;
    // 弹力速度，取值范围 0~20，数值越大，速度越快，默认数值为12
    anim.springSpeed = 10;
    // 动画起始时间
    anim.beginTime = CACurrentMediaTime() + index * 0.025;
    
    // 添加动画
    [button.layer pop_addAnimation:anim forKey:nil];
    
    return anim;
}

/// 动画旋转关闭按钮
- (void)rotateCloseButton:(BOOL)isShow {
    
    // 提示：如果需要旋转按钮中的图片，需要使用 CATransform3D，同时 x/y 需要指定一个很小的值
    CATransform3D start = CATransform3DMakeRotation(-M_PI_4, 0.001, 0.001, 1);
    CATransform3D end = CATransform3DIdentity;
    
    _closeButton.imageView.layer.transform = isShow ? start : end;
    
    [UIView animateWithDuration:0.25 animations:^{
        _closeButton.imageView.layer.transform = isShow ? end : start;
    }];
}

#pragma mark - 设置界面
/// 设置界面
- (void)setupUI {
    [self setupEffectView];
    
    [self setupComposeButtons];
    
    _scrollView.scrollEnabled = NO;
}

/// 设置撰写按钮
- (void)setupComposeButtons {
    
    // 0. 每页按钮数量
    int pageCount = 6;
    // 1. 按钮大小
    CGSize size = CGSizeMake(80, 110);
    // 2. 水平偏移
    CGFloat offsetX = [UIScreen ff_screenSize].width * 0.3;
    
    int index = 0;
    for (HMComposeType *type in [HMComposeType composeTypeList]) {
        HMComposeTypeButton *button = [[HMComposeTypeButton alloc] init];
        
        button.composeType = type;
        
        if (type.actionName != nil) {
            SEL sel = NSSelectorFromString(type.actionName);
            
            [button addTarget:self action:sel forControlEvents:UIControlEventTouchUpInside];
        } else {
            [button addTarget:self action:@selector(clickComposeButton:) forControlEvents:UIControlEventTouchUpInside];
        }
        
        [self.menuButtons addObject:button];
        [_containerView addSubview:button];
        
        // 页面偏移量
        CGFloat pageOffset = index / pageCount  + 0.5;
        
        // 自动布局
        [button mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(_containerView).multipliedBy(pageOffset).offset((index % 3 - 1) * offsetX);;
            make.bottom.equalTo(_containerView).mas_equalTo((index % pageCount) / 3 * (size.height) + size.height);
            make.size.mas_equalTo(size);
        }];
        
        index++;
    }
}

/// 设置效果视图
- (void)setupEffectView {
    
    // 1. 创建磨砂视图
    // 判断系统版本是否支持 8.0
    UIView *blurEffectView;
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0) {
        // 磨砂效果
        UIBlurEffect *blurEffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleExtraLight];
        // 磨砂视图
        blurEffectView = [[UIVisualEffectView alloc] initWithEffect:blurEffect];
    } else {
        // 屏幕截图 - 调用苹果官方框架实现磨砂效果
        UIImage *screenShot = [UIImage screenShot].applyLightEffect;
        blurEffectView = [[UIImageView alloc] initWithImage:screenShot];
    }
    
    [self addSubview:blurEffectView];
    [blurEffectView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
    
    // 2. 广告图片
    UIImageView *slogan = [UIImageView ff_imageViewWithImageName:@"compose_slogan"];
    
    [self addSubview:slogan];
    [slogan mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.top.equalTo(self.mas_centerY).multipliedBy(0.318);
    }];
    
    // 3. 按钮滚动视图
    _scrollView = [[UIScrollView alloc] init];
    
    _scrollView.backgroundColor = [UIColor clearColor];
    _scrollView.pagingEnabled = YES;
    _scrollView.clipsToBounds = NO;
    _scrollView.delegate = self;
    
    [blurEffectView addSubview:_scrollView];
    [_scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self);
        make.right.equalTo(self);
        make.bottom.equalTo(self);
        make.height.equalTo(self.mas_height).multipliedBy(0.5);
    }];

    // 4. 容器视图
    _containerView = [[UIView alloc] init];
    
    _containerView.backgroundColor = [UIColor clearColor];
    _containerView.clipsToBounds = NO;
    
    [_scrollView addSubview:_containerView];
    [_containerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(_scrollView);
        
        // 设置 contentSize
        make.centerY.equalTo(_scrollView);
        make.width.equalTo(_scrollView).multipliedBy(2);
    }];
    
    // 5. 底部工具视图
    _bottomView = [[UIView alloc] init];
    _bottomView.backgroundColor = [UIColor colorWithWhite:1.0 alpha:1.0];
    
    [blurEffectView addSubview:_bottomView];
    [_bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self);
        make.right.equalTo(self);
        make.bottom.equalTo(self);
        make.height.mas_equalTo(49);
    }];
    
    UIView *lineView = [[UIView alloc] init];
    lineView.backgroundColor = [UIColor lightGrayColor];
    
    [_bottomView addSubview:lineView];
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_bottomView);
        make.right.equalTo(_bottomView);
        make.top.equalTo(_bottomView);
        make.height.mas_equalTo(0.5);
    }];
    
    // 6. 操作按钮
    _closeButton = [UIButton ff_buttonWithTitle:nil imageName:@"tabbar_compose_background_icon_close" target:self action:@selector(closeView)];

    [_bottomView addSubview:_closeButton];
    [_closeButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_bottomView);
        make.centerX.equalTo(_bottomView);
    }];
    
    _returnButton = [UIButton ff_buttonWithTitle:nil imageName:@"tabbar_compose_background_icon_return" target:self action:@selector(clickReturnButton)];
    _returnButton.hidden = YES;
    [_bottomView addSubview:_returnButton];
    [_returnButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_bottomView);
        make.centerX.equalTo(_bottomView);
    }];
}

#pragma mark - 懒加载属性
- (NSMutableArray *)menuButtons {
    if (_menuButtons == nil) {
        _menuButtons = [[NSMutableArray alloc] init];
    }
    return _menuButtons;
}

@end
