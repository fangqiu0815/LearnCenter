//
//  TopheadView.h
//  HWMovie
//
//  Created by hyrMac on 15/7/27.
//  Copyright (c) 2015年 hyrMac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TopheadModal.h"


@interface TopheadView : UIView <UICollectionViewDelegateFlowLayout,UICollectionViewDataSource>
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *titleCnLabel;
@property (weak, nonatomic) IBOutlet UILabel *directorsLabel;
@property (weak, nonatomic) IBOutlet UILabel *actorsLabel;
@property (weak, nonatomic) IBOutlet UILabel *typeLabel;
@property (weak, nonatomic) IBOutlet UILabel *releaseLabel;
//@property (weak, nonatomic) IBOutlet UIScrollView *videosScroll;
@property (weak, nonatomic) IBOutlet UICollectionView *videoCollection;

@property (nonatomic, retain) TopheadModal *modal;
@end
