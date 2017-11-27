//
//  PYPageTitleContentView.h
//  Gank
//
//  Created by 谢培艺 on 2017/2/28.
//  Copyright © 2017年 CoderKo1o. All rights reserved.
//

#import <UIKit/UIKit.h>
@class PYPageTitleContentView;

@protocol PYPageTitleContentViewDelegate <NSObject>
@required
- (void)pageTitleContentView:(PYPageTitleContentView *)pageTitleContentView selectedPageTitleView:(NSInteger)index;

@end

@interface PYPageTitleContentView : UIView

@property (nonatomic, weak) id<PYPageTitleContentViewDelegate> delegate;

@end
