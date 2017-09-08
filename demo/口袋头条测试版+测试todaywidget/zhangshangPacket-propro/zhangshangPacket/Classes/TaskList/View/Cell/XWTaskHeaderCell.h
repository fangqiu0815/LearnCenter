//
//  XWTaskHeaderCell.h
//  zhangshangPacket
//
//  Created by apple on 2017/5/19.
//  Copyright © 2017年 apple-fangqiu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XWTaskHeaderCell : XWCell

@property (nonatomic, strong) UIImageView *iconImageView;

@property (nonatomic, strong) UILabel *titleLab;

@property (nonatomic, strong) UIView *lineView;

/**
    设置任务cell的头视图
 @param image            header的图标
 @param titleStr         标题
 @param titleColor       标题字体颜色
 
 @return nil
 
 */

- (void)setCellDataWithImage:(UIImage *)image andTitle:(NSString *)titleStr andTitleColor:(UIColor *)titleColor ;


//@property (nonatomic, copy) void (^ClickMasterBlock)();


@end
