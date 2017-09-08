//
//  ShopListCell.h
//  CrazyPacket
//
//  Created by WuYanZu on 17/2/24.
//  Copyright © 2017年 WuYanZu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GoodsListModel.h"

typedef void (^ComeBtnBlock)();
@interface ShopListCell : UICollectionViewCell
@property(nonatomic,copy) ComeBtnBlock  comeBtnBlock;

-(void)setTheCellDataWithModel:(ItemDetail *)dataModel andPhotoPre:(NSString *)preStr;

@end
