//
//  XWMidleCell.h
//  zhangshangPacket
//
//  Created by apple on 2017/6/2.
//  Copyright © 2017年 apple-fangqiu. All rights reserved.
//

#import "XWCell.h"
#import "XWSquareButton.h"
@interface XWMidleCell : XWCell

/**
 * 师徒
 */
@property(nonatomic,strong)XWSquareButton *myApprenticeBtn;

/**
 * 钱包
 */
@property(nonatomic,strong)XWSquareButton *cashBtn;

/**
 * 发现
 */
@property(nonatomic,strong)XWSquareButton *foundBtn;




@end
