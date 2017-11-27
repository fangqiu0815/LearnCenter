//
//  MovieTableViewCell.h
//  HWMovie
//
//  Created by hyrMac on 15/7/20.
//  Copyright (c) 2015年 hyrMac. All rights reserved.
//

#import <UIKit/UIKit.h>
@class StarView;
@class MovieModal;

@interface MovieTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *yearLabel;
@property (weak, nonatomic) IBOutlet UILabel *averageLabel;
@property (weak, nonatomic) IBOutlet StarView *star;

@property (nonatomic,retain) MovieModal* movieMessage;
@end
