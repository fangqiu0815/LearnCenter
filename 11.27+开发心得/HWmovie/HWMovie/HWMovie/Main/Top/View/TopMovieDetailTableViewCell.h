//
//  TopMovieDetailTableViewCell.h
//  HWMovie
//
//  Created by hyrMac on 15/7/27.
//  Copyright (c) 2015年 hyrMac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TopCommentModal.h"

@interface TopMovieDetailTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *userImageView;
@property (weak, nonatomic) IBOutlet UILabel *nacknameLabel;
@property (weak, nonatomic) IBOutlet UILabel *ratingLabel;
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;

@property (weak, nonatomic) IBOutlet UIView *bgView;


@property (nonatomic, retain) TopCommentModal *topCommentModal;
@end
