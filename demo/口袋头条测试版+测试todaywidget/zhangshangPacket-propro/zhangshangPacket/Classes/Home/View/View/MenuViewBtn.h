//
//  MenuViewBtn.h
//  zhangshangPacket
//
//  Created by apple on 2017/5/20.
//  Copyright © 2017年 apple-fangqiu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MenuViewBtn : UIButton

@property (nonatomic, copy  ) NSString *fontName;
@property (nonatomic, assign) CGFloat  fontSize;
@property (nonatomic, assign) CGFloat  NomrmalSize;
@property (nonatomic, assign) CGFloat  rate;
// normal状态的字体颜色
@property (nonatomic, strong) UIColor  *normalColor;
//selected状态的字体颜色
@property (nonatomic, strong) UIColor  *selectedColor;
@property (nonatomic, strong) UIColor  *titlecolor;

- (instancetype)initWithTitles:(NSArray *)titles AndIndex:(int)index;

- (void)selectedItemWithoutAnimation;
- (void)deselectedItemWithoutAnimation;
- (void)ChangSelectedColorWithRate:(CGFloat)rate;
- (void)ChangSelectedColorAndScalWithRate:(CGFloat)rate;


@end
