//
//  CardSelectedLayout.h
//  DDCardAnimation
//
//  Created by tondyzhang on 16/10/11.
//  Copyright © 2016年 tondy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CardSelectedLayout : UICollectionViewLayout

-(instancetype)initWithIndexPath:(NSIndexPath*)indexPath offsetY:(CGFloat)offsetY ContentSizeHeight:(CGFloat)sizeHeight;

@property(nonatomic, assign)NSIndexPath* selectedIndexPath;
@property(nonatomic, assign)CGFloat contentOffsetY;
@property(nonatomic, assign)CGFloat contentSizeHeight;

@end
