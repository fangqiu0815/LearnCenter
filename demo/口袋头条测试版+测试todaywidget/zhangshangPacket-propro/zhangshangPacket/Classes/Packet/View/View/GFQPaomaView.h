//
//  GFQPaomaView.h
//  zhangshangPacket
//
//  Created by apple on 2017/6/3.
//  Copyright © 2017年 apple-fangqiu. All rights reserved.
//

#import <UIKit/UIKit.h>
@class GFQPaomaView;
@protocol GFQChangeTextViewDelegate <NSObject>

- (void)gfqChangeTextView:(GFQPaomaView *)textView didTapedAtIndex:(NSInteger)index;

@end


@interface GFQPaomaView : UIView

@property (nonatomic, assign) id<GFQChangeTextViewDelegate> delegate;

- (void)animationWithTexts:(NSArray *)textAry;
- (void)reloadAniation;
- (void)stopAnimation;

@end
