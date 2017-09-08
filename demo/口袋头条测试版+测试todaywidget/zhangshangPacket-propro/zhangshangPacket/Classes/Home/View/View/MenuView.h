//
//  MenuView.h
//  zhangshangPacket
//
//  Created by apple on 2017/5/20.
//  Copyright © 2017年 apple-fangqiu. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef enum{
    MenuViewStyleDefault,     // 默认
    MenuViewStyleLine,        // 带下划线 (颜色会变化)
    MenuViewStyleFoold,       // 涌入效果 (填充)
    MenuViewStyleFooldHollow, // 涌入效果 (空心的)
    
} MenuViewStyle;
@class MenuView;

@protocol MenuViewDelegate <NSObject>
- (void)MenuViewDelegate:(MenuView*)menuciew WithIndex:(int)index;
@end


@interface MenuView : UIView

@property (nonatomic,weak)id<MenuViewDelegate> delegate;
@property (nonatomic,assign)MenuViewStyle style;

- (void)SelectedBtnMoveToCenterWithIndex:(int)index WithRate:(CGFloat)rate;
- (instancetype)initWithMneuViewStyle:(MenuViewStyle)style AndTitles:(NSArray *)titles;
- (void)selectWithIndex:(int)index AndOtherIndex:(int)tag;

@end
