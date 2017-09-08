//
//  XWChooseBtn.h
//  zhangshangPacket
//
//  Created by apple on 2017/6/13.
//  Copyright © 2017年 apple-fangqiu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XWChooseBtn : UIButton

/** xie写一个方法 astr 中间的title*/
- (XWChooseBtn *)buttonWithAbovelabeltitle:(NSString *)astr;
/** 上边的label*/
@property (nonatomic, weak) UILabel *abovel;

@end
