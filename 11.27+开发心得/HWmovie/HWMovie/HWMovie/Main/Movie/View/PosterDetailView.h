//
//  PosterDetailView.h
//  HWMovie
//
//  Created by hyrMac on 15/7/25.
//  Copyright (c) 2015年 hyrMac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "StarView.h"
#import "MovieModal.h"

@interface PosterDetailView : UIView
@property (weak, nonatomic) IBOutlet UIImageView *movieImageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *englishTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *yearLabel;
@property (weak, nonatomic) IBOutlet UILabel *averageLabel;

@property (weak, nonatomic) IBOutlet StarView *starView;

@property (nonatomic, retain) MovieModal *movieModal;
@end
