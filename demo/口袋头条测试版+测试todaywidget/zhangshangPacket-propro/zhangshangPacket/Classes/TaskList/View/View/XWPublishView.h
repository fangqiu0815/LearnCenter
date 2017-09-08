//
//  XWPublishView.h
//  zhangshangPacket
//
//  Created by apple on 2017/5/22.
//  Copyright © 2017年 apple-fangqiu. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol XFPublishViewDelegate <NSObject>

- (void)didSelectBtnWithBtnTag:(NSInteger)tag;

@end


@interface XWPublishView : UIButton

@property(weak,nonatomic) id<XFPublishViewDelegate> delegate;

- (void)show;


@end
