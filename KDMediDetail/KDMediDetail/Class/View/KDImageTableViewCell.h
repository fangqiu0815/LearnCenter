//
//  KDImageTableViewCell.h
//  KDMediDetail
//
//  Created by apple-gaofangqiu on 2018/3/5.
//  Copyright © 2018年 apple-fangqiu. All rights reserved.
//

#import <UIKit/UIKit.h>

static NSString *CollectionViewCellID = @"CollectionViewCellID";

@interface KDImageCollectionView : UICollectionView

// collectionView所在的tableViewCell的indexPath
@property (nonatomic, strong) NSIndexPath *indexPath;

@end


@interface KDImageTableViewCell : UITableViewCell

@property (nonatomic, strong) KDImageCollectionView *collectionView;

- (void)setCollectionViewDataSourceDelegate:(id<UICollectionViewDataSource, UICollectionViewDelegate>)dataSourceDelegate indexPath:(NSIndexPath *)indexPath;

@end
