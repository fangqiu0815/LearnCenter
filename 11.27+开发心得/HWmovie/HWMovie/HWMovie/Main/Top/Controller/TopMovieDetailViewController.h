//
//  TopMovieDetailViewController.h
//  HWMovie
//
//  Created by hyrMac on 15/7/27.
//  Copyright (c) 2015年 hyrMac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TopheadView.h"
#import <MediaPlayer/MediaPlayer.h>

@class TopheadModal;

@interface TopMovieDetailViewController : UIViewController <UITableViewDelegate,UITableViewDataSource>
{
    UITableView *_commentTableView;
    NSMutableArray *_commentModalArray;
    TopheadView *_topheadView;
    TopheadModal *_modal1;
}
@end
