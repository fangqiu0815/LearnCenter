//
//  XWChooseMoneyView.h
//  zhangshangPacket
//
//  Created by apple on 2017/6/13.
//  Copyright © 2017年 apple-fangqiu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XWChooseBtn.h"
@interface XWChooseMoneyView : UIView

@property (nonatomic, strong) UILabel *titleLab;

@property (nonatomic, strong) UIView *lineView;



- (void)setNowChooseTag:(NSInteger )tag;


@end
