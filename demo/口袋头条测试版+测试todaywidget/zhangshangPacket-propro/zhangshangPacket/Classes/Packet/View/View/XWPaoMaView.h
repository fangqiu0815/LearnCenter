//
//  XWPaoMaView.h
//  zhangshangPacket
//
//  Created by apple on 2017/5/17.
//  Copyright © 2017年 apple-fangqiu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TXScrollLabelView.h"
#import "YFRollingLabel.h"
@interface XWPaoMaView : UIView

@property (strong, nonatomic) YFRollingLabel *scrollLabelView;
@property (nonatomic, strong) UIImageView *iconImageView;

@property (nonatomic, strong) NSArray *dataArr;

@end
