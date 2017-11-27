//
//  CinemaTableViewCell.h
//  HWMovie
//
//  Created by hyrMac on 15/7/22.
//  Copyright (c) 2015年 hyrMac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "cinemaModal.h"

@interface CinemaTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *addressLabel;
@property (weak, nonatomic) IBOutlet UILabel *gradeLabel;
@property (weak, nonatomic) IBOutlet UILabel *lowPriceLabel;
@property (weak, nonatomic) IBOutlet UIImageView *isSeatSupportImageView;
@property (weak, nonatomic) IBOutlet UIImageView *isCouponSupport;

@property (nonatomic, retain) cinemaModal *cModal;
@end
