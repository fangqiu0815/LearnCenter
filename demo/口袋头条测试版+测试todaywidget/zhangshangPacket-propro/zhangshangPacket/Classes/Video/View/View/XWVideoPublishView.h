//
//  XWVideoPublishView.h
//  zhangshangPacket
//
//  Created by apple on 2017/8/3.
//  Copyright © 2017年 apple-fangqiu. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol XWVideoPublishViewDelegate <NSObject>

- (void)didSelectBtnWithBtnTag:(NSInteger)tag;

@end
@interface XWVideoPublishView : UIButton
@property(weak,nonatomic) id<XWVideoPublishViewDelegate> delegate;

- (void)show;
@end
