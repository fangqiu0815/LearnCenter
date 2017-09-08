//
//  XWTaskImageCell.h
//  zhangshangPacket
//
//  Created by apple on 2017/5/19.
//  Copyright © 2017年 apple-fangqiu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XWTaskImageCell : XWCell

@property (nonatomic, strong) UIImageView *iconImageView;
@property (nonatomic, strong) UIImageView *iconImg;
@property (nonatomic, strong) UILabel *titleLab;
@property (nonatomic, strong) UIButton *cellBtn;

//@property (nonatomic, copy) void (^taskClickBlock)();


/**
    动态设置当任务是图片类型且要点击跳转的视图
 @param titleStr        cell的标题
 @param titleStrColor   cell的标题颜色
 @param btnTitle        按钮的标题
 @param iconImage       header的icon图标
 @param contentImage    cell内容的图片
 @return nil
 
 */

- (void)setCellTitle:(NSString *)titleStr andTitleStrColor:(UIColor *)titleStrColor andBtnTitle:(NSString *)btnTitle andIconImage:(UIImage *)iconImage andcontentImage:(UIImage *)contentImage;

@end
