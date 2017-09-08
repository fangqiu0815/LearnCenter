//
//  XWMinePubView.h
//  zhangshangPacket
//
//  Created by apple on 2017/7/6.
//  Copyright © 2017年 apple-fangqiu. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol XWMinePubViewDelegate <NSObject>

- (void)didSelectBtnWithBtnTag:(NSInteger)tag;

@end

@interface XWMinePubView : UIView
@property(weak,nonatomic) id<XWMinePubViewDelegate> delegate;

- (void)show;
@end
