//
//  HMComposeViewController.m
//  Weibo11
//
//  Created by 刘凡 on 15/12/14.
//  Copyright © 2015年 itheima. All rights reserved.
//

#import "HMComposeViewController.h"
#import "HMUserAccountViewModel.h"
#import "HMTextView.h"
#import "HMPicturePickerView.h"
#import "HMEmoticonKeyboard.h"
#import "UITextView+Emoticon.h"
#import <SVProgressHUD/SVProgressHUD.h>

@interface HMComposeViewController () <UITextViewDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate>
/// 发送按钮
@property (nonatomic, strong) UIButton *sendButton;
/// 标题标签
@property (nonatomic, strong) UILabel *titleLabel;
/// 输入文本视图
@property (nonatomic, strong) HMTextView *textView;
/// 底部工具栏
@property (nonatomic, strong) UIToolbar *toolbar;
/// 工具栏表情按钮
@property (nonatomic, weak) UIButton *toolbarEmoticonButton;
/// 照片选择视图
@property (nonatomic, strong) HMPicturePickerView *pictureView;
/// 表情键盘
@property (nonatomic, strong) HMEmoticonKeyboard *emoticonKeyboard;
@end

@implementation HMComposeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupUI];
    
    // 添加通知监听键盘变化
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardFrameDidChanged:) name:UIKeyboardWillChangeFrameNotification object:nil];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    // 如果没有配图视图，才激活键盘
    if (self.pictureView.hidden) {
        [self.textView becomeFirstResponder];
    }
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark - 键盘处理
- (void)keyboardFrameDidChanged:(NSNotification *)notification {
    
    // 目标位置
    CGRect rect = [notification.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    // 动画曲线
    NSInteger curve = [notification.userInfo[UIKeyboardAnimationCurveUserInfoKey] integerValue];
    // 键盘动画时长
    CGFloat duration = [notification.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    
    // 计算偏移位置
    CGFloat offset = -(self.view.bounds.size.height - rect.origin.y);
    
    // 更新底部约束
    [self.toolbar mas_updateConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.view).offset(offset);
    }];
    
    [UIView animateWithDuration:duration animations:^{
        // 设置动画曲线
        [UIView setAnimationCurve:curve];
        
        [self.view layoutIfNeeded];
    }];
}

#pragma mark - UITextViewDelegate
- (void)textViewDidChange:(UITextView *)textView {
    self.navigationItem.rightBarButtonItem.enabled = self.textView.hasText;
}

#pragma mark - 监听方法
/// 点击关闭按钮
- (void)clickCloseButton {
    [self.textView resignFirstResponder];
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

/// 点击发送按钮
- (void)clickSendButton {
    DDLogInfo(@"点击发送按钮");

    UIImage *image = self.pictureView.pictures.count > 0 ? self.pictureView.pictures[0] : nil;
    
    [[HMNetworkTools sharedTools] postStatus:self.textView.emoticonText image:image finished:^(id result, NSError *error) {
        
        if (error != nil) {
            [SVProgressHUD showInfoWithStatus:@"发布微博出现错误" maskType:SVProgressHUDMaskTypeGradient];
            return;
        }
        
        DDLogInfo(@"%@", result);
        
        [self clickCloseButton];
    }];
}

/// 点击切换表情按钮
- (void)clickEmoticonButton {
    // 切换键盘之前，需要注销第一响应者
    [self.textView resignFirstResponder];
    
    self.textView.inputView = (self.textView.inputView == nil) ? self.emoticonKeyboard : nil;
    
    // 重新激活键盘
    [self.textView becomeFirstResponder];
    
    // 切换键盘按钮图片
    [self switchEmoticonButtonImage];
}

/// 切换表情键盘图像
- (void)switchEmoticonButtonImage {
    
    NSString *type = (self.textView.inputView == nil) ? @"emoticon" : @"keyboard";
    
    NSString *imageName = [NSString stringWithFormat:@"compose_%@button_background", type];
    NSString *imageNameHL = [NSString stringWithFormat:@"%@_highlighted", imageName];
    
    [self.toolbarEmoticonButton setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    [self.toolbarEmoticonButton setImage:[UIImage imageNamed:imageNameHL] forState:UIControlStateHighlighted];
}

/// 选择照片
- (void)clickSelectPhotoButton {
    
    // 判断是否能够访问照片库
    if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]) {
        DDLogWarn(@"无法访问相片库");
        return;
    }
    
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    
    // 设置代理
    picker.delegate = self;
    
    [self presentViewController:picker animated:YES completion:nil];
}

#pragma mark - UIImagePickerControllerDelegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
    
    // 获取图片
    UIImage *image = info[UIImagePickerControllerOriginalImage];
    
    if (image == nil) {
        return;
    }
    
    // 设置图片
    [self.pictureView addImage:image];
    
    // 关闭照片选择控制器
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - 设置界面
/// 设置界面
- (void)setupUI {
    self.view.backgroundColor = [UIColor whiteColor];
    
    // 表情键盘
    _emoticonKeyboard = [[HMEmoticonKeyboard alloc] initWithTextView:self.textView];
    
    [self setupNavigationBar];
    [self setupTextView];
    [self setupToolbar];
}

/// 设置工具栏
- (void)setupToolbar {
    
    // 1. 添加控件
    [self.view addSubview:self.toolbar];
    
    // 2. 自动布局
    [self.toolbar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view);
        make.right.equalTo(self.view);
        make.bottom.equalTo(self.view);
        make.height.mas_equalTo(44);
    }];
    
    // 3. 添加按钮
    NSArray *array = @[@{@"imageName": @"compose_toolbar_picture", @"actionName": @"clickSelectPhotoButton"},
                       @{@"imageName": @"compose_mentionbutton_background"},
                       @{@"imageName": @"compose_trendbutton_background"},
                       @{@"imageName": @"compose_emoticonbutton_background", @"actionName": @"clickEmoticonButton", @"emoticonBtn": @(YES)},
                       @{@"imageName": @"compose_add_background"}];
    NSMutableArray *items = [NSMutableArray array];
    for (NSDictionary *dict in array) {
        
        // 监听方法 - 注意：如果字典键值不存在 sel == nil
        SEL sel = NSSelectorFromString(dict[@"actionName"]);;
        
        // 添加 UIBarButton
        [items addObject:[UIBarButtonItem ff_barButtonWithTitle:nil imageName:dict[@"imageName"] target:nil action:sel]];
        
        // 判断是否是表情按钮，如果是记录
        if ([dict[@"emoticonBtn"] boolValue]) {
            self.toolbarEmoticonButton = (UIButton *)[items.lastObject customView];
        }
        
        // 添加弹簧
        [items addObject:[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil]];
    }
    [items removeLastObject];
    
    self.toolbar.items = items;
}

/// 设置文本视图
- (void)setupTextView {
    // 1. 添加控件
    [self.view addSubview:self.textView];
    
    __weak typeof(self) weakSelf = self;
    _pictureView = [[HMPicturePickerView alloc] initWithAddImageCallBack:^{
        [weakSelf clickSelectPhotoButton];
    }];
    _pictureView.backgroundColor = self.textView.backgroundColor;
    [self.textView addSubview:_pictureView];
    
    // 2. 自动布局
    [self.textView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    
    [_pictureView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(10);
        make.right.equalTo(self.view).offset(-10);
        make.height.equalTo(_pictureView.mas_width);
        make.top.mas_equalTo(100);
    }];
}

/// 设置导航栏
- (void)setupNavigationBar {
    
    // 1. 左右按钮
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem ff_barButtonWithTitle:@"取消" imageName:nil target:self action:@selector(clickCloseButton)];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:self.sendButton];
    [self.sendButton addTarget:self action:@selector(clickSendButton) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem.enabled = false;
    
    // 2. 设置标题
    self.navigationItem.titleView = self.titleLabel;
}

#pragma mark - 发送按钮
/// 发布按钮
- (UIButton *)sendButton {
    if (_sendButton == nil) {
        _sendButton = [[UIButton alloc] init];
        
        // 设置不同状态的背景图
        [_sendButton setBackgroundImage:[UIImage imageNamed:@"common_button_orange"] forState:UIControlStateNormal];
        [_sendButton setBackgroundImage:[UIImage imageNamed:@"common_button_orange_highlighted"] forState:UIControlStateHighlighted];
        [_sendButton setBackgroundImage:[UIImage imageNamed:@"common_button_white_disable"] forState:UIControlStateDisabled];
        
        // 设置不同状态的文字颜色
        [_sendButton setTitleColor:[UIColor darkGrayColor] forState:UIControlStateDisabled];
        [_sendButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        
        // 设置文字以及其大小
        [_sendButton setTitle:@"发送" forState:UIControlStateNormal];
        _sendButton.titleLabel.font = [UIFont systemFontOfSize:15];
        
        // 指定其大小
        _sendButton.frame = (CGRect) {CGPointZero, CGSizeMake(45, 35)};
    }
    return _sendButton;
}

/// 标题标签
- (UILabel *)titleLabel {
    if (_titleLabel == nil) {
        _titleLabel = [[UILabel alloc] init];
        
        NSString *userName = [HMUserAccountViewModel sharedUserAccount].userAccount.screen_name;
        if (userName != nil) {
            _titleLabel.numberOfLines = 0;
            _titleLabel.textAlignment = NSTextAlignmentCenter;
            
            // 标题属性字符串
            NSDictionary *dict1 = @{NSFontAttributeName: [UIFont systemFontOfSize:15],
                                    NSForegroundColorAttributeName: [UIColor darkGrayColor]};
            NSMutableAttributedString *titleStr = [[NSMutableAttributedString alloc] initWithString:@"发微博\n" attributes:dict1];
            
            // 姓名属性字符串
            NSDictionary *dict2 = @{NSFontAttributeName: [UIFont systemFontOfSize:12],
                                    NSForegroundColorAttributeName: [UIColor lightGrayColor]};
            NSAttributedString *nameStr = [[NSAttributedString alloc] initWithString:userName attributes:dict2];
            
            // 拼接属性字符串
            [titleStr appendAttributedString:nameStr];
            
            // 设置属性字符串
            _titleLabel.attributedText = titleStr;
        } else {
            _titleLabel.text = @"发微博";
        }
        
        [_titleLabel sizeToFit];
    }
    return _titleLabel;
}

/// 文本视图
- (HMTextView *)textView {
    if (_textView == nil) {
        _textView = [[HMTextView alloc] init];
        
        _textView.font = [UIFont systemFontOfSize:16];
        _textView.placeholder = @"听说下雨天音乐和辣条更配哟~";
        
        // 允许垂直拖动
        _textView.alwaysBounceVertical = YES;
        // 拖拽关闭键盘
        _textView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
        
        _textView.delegate = self;
    }
    return _textView;
}

/// 底部工具栏
- (UIToolbar *)toolbar {
    if (_toolbar == nil) {
        _toolbar = [[UIToolbar alloc] init];
    }
    return _toolbar;
}

@end
