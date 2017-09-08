//
//  XWGetCashView.h
//  zhangshangPacket
//
//  Created by apple on 2017/6/13.
//  Copyright © 2017年 apple-fangqiu. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol XWGetCashViewDelegate <NSObject>

- (void)didSelectBtnWithBtnTag:(NSInteger)tag;

@end

@interface XWGetCashView : UIButton

@property(weak,nonatomic) id<XWGetCashViewDelegate> delegate;

- (void)show;


@end
