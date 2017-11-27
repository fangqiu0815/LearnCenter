//
//  CardLayout.h
//  DDCardAnimation
//
//  Created by tondyzhang on 16/10/10.
//  Copyright © 2016年 tondy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CardLayout : UICollectionViewLayout

@property(nonatomic, assign)CGFloat offsetY;
@property(nonatomic, assign)CGFloat contentSizeHeight;
@property(nonatomic, strong)NSMutableArray* blurList;

-(instancetype)initWithOffsetY:(CGFloat)offsetY;


@end
