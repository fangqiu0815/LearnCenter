//
//  XWMiddleCashCell.h
//  zhangshangPacket
//
//  Created by apple on 2017/6/2.
//  Copyright © 2017年 apple-fangqiu. All rights reserved.
//

#import "XWCell.h"

@interface XWMiddleCashCell : XWCell

@property (nonatomic, strong) UILabel *titleLab;

@property (nonatomic, strong) UILabel *detailLab;

@property (nonatomic, strong) UIImageView *iconImageView;

@property (nonatomic, strong) UIImageView *rightIcon;

- (void)setCellDataWithTitle:(NSString *)titleStr andRightTitle:(NSString *)rightTitle andRightTitleColor:(UIColor *)rightTitleColor andleftImage:(UIImage *)leftImage;

- (void)setCellDataWithTitle:(NSString *)titleStr andLeftImage:(UIImage *)leftImage andRightTitle:(UIImage *)rightIcon;



@end
