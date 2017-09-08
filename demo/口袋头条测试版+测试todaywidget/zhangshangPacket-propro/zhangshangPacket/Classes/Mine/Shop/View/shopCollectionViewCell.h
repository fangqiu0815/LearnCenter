//
//  shopCollectionViewCell.h
//  zhangshangPacket
//
//  Created by zhenhui huang on 2017/6/3.
//  Copyright © 2017年 apple-fangqiu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GoodsListModel.h"

@interface shopCollectionViewCell : UICollectionViewCell
-(void)setTheCellDataWithModel:(ItemDetail *)dataModel andPhotoPre:(NSString *)preStr;
@end
