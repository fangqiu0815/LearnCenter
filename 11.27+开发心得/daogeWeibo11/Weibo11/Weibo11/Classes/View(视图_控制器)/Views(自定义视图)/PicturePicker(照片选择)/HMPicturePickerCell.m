//
//  HMPicturePickerCell.m
//  Weibo11
//
//  Created by 刘凡 on 15/12/14.
//  Copyright © 2015年 itheima. All rights reserved.
//

#import "HMPicturePickerCell.h"

@interface HMPicturePickerCell()
/// 图像视图
@property (nonatomic, strong) UIImageView *imageView;
/// 删除按钮
@property (nonatomic, strong) UIButton *deleteButton;
@end

@implementation HMPicturePickerCell

#pragma mark - 设置属性
- (void)setImage:(UIImage *)image {
    _image = image;
    
    self.imageView.image = (image == nil) ? [UIImage imageNamed:@"compose_pic_add"] : image;
    self.imageView.highlightedImage = (image == nil) ? [UIImage imageNamed:@"compose_pic_add_highlighted"] : image;
    
    // 隐藏删除按钮
    self.deleteButton.hidden = (image == nil);
}

#pragma mark - 监听方法
/// 点击删除按钮
- (void)clickDeleteButton {
    if ([self.delegate respondsToSelector:@selector(picturePickerCellDidClickDeleteButton:)]) {
        [self.delegate picturePickerCellDidClickDeleteButton:self];
    }
}

#pragma mark - 构造函数
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    
    if (self) {
        // 1. 图像视图
        _imageView = [[UIImageView alloc] init];
        _imageView.contentMode = UIViewContentModeScaleAspectFill;
        _imageView.clipsToBounds = YES;
        
        [self addSubview:_imageView];
        
        [_imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self);
        }];
        
        // 2. 删除按钮
        _deleteButton = [[UIButton alloc] init];
        [_deleteButton setImage:[UIImage imageNamed:@"compose_photo_close"] forState:UIControlStateNormal];
        
        [self addSubview:_deleteButton];
        
        [_deleteButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self);
            make.right.equalTo(self);
        }];
        
        [_deleteButton addTarget:self action:@selector(clickDeleteButton) forControlEvents:UIControlEventTouchUpInside];
    }
    return self;
}

@end
