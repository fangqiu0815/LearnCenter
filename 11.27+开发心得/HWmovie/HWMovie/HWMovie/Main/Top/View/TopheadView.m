//
//  TopheadView.m
//  HWMovie
//
//  Created by hyrMac on 15/7/27.
//  Copyright (c) 2015年 hyrMac. All rights reserved.
//

#import "TopheadView.h"
#import "common.h"
#import "UIImageView+WebCache.h"

@implementation TopheadView

- (void)setModal:(TopheadModal *)modal {
    _modal = modal;
    [self setNeedsLayout];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    [_imageView sd_setImageWithURL:[NSURL URLWithString:_modal.image]];
    
    _titleCnLabel.text = _modal.titleCn;
    _titleCnLabel.textColor = [UIColor orangeColor];
    _titleCnLabel.font = [UIFont boldSystemFontOfSize:20];
    
    NSMutableString *directorsStr = [NSMutableString stringWithFormat:@"导演："];
    for (NSString *str in _modal.directors) {
//        [directorsStr appendString:str];
        [directorsStr appendFormat:@"%@ ",str];
    }
    _directorsLabel.text = directorsStr;
    _directorsLabel.textColor = [UIColor whiteColor];
    
    NSMutableString *actorsStr = [NSMutableString stringWithFormat:@"主演："];
    for (NSString *str in _modal.actors) {
//        [actorsStr  appendString:str];
        [actorsStr appendFormat:@"%@ ",str];
    }
    _actorsLabel.text = actorsStr;
    _actorsLabel.textColor = [UIColor whiteColor];
    
    NSMutableString *typeStr = [NSMutableString stringWithFormat:@"类型："];
    for (NSString *str in _modal.type) {
//        [typeStr appendString:str];
        [typeStr appendFormat:@"%@ ",str];
    }
    _typeLabel.text = typeStr;
    _typeLabel.textColor = [UIColor whiteColor];
    
    NSString *string1 = _modal.releaseInfo[@"location"];
    NSString *string2 = _modal.releaseInfo[@"date"];
    _releaseLabel.text = [NSString stringWithFormat:@"%@ %@",string1,string2];
    _releaseLabel.textColor = [UIColor whiteColor];
    _releaseLabel.font = [UIFont systemFontOfSize:14];
    // 视频
//    for (NSInteger i = 0; i < _modal.videos.count; i++) {
//        NSString *imgStr = [_modal.videos[i] objectForKey:@"image"];
////        UIImage *img = [UIImage imageNamed:imgStr];
//        UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(5+(110+5)*i, 5, 110, 100)];
//        [imgView sd_setImageWithURL:[NSURL URLWithString:imgStr]];
//        [_videosScroll addSubview:imgView];
//    }
    
}

- (void)awakeFromNib {
    self.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"bg_main"]];
    
    [_videoCollection registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"videoCell"];
    _videoCollection.delegate = self;
    _videoCollection.dataSource = self;
    _videoCollection.frame = CGRectMake(0, 0, 115*4+5, 110);
    
}

#pragma mark - UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return _modal.videos.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"videoCell" forIndexPath:indexPath];
    
    NSString *imgStr = [_modal.videos[indexPath.row] objectForKey:@"image"];
    //        UIImage *img = [UIImage imageNamed:imgStr];
    UIImageView *imgView = [[UIImageView alloc] initWithFrame:cell.bounds];
    [imgView sd_setImageWithURL:[NSURL URLWithString:imgStr]];
    
    imgView.layer.borderWidth = 1;
    imgView.layer.borderColor = [UIColor blackColor].CGColor;
    imgView.layer.cornerRadius = 10;
    imgView.layer.masksToBounds = YES;
    
    [cell.contentView addSubview:imgView];
    return cell;
}

#pragma mark - UICollectionViewDelegateFlowLayout
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake(110, 100);
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(5, 5, 5, 5);
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    /*
     视频播放
     
     // MPMoviePlayerViewController:视频播放控制器,需要导入<MediaPlayer/MediaPlayer.h>框架
     MPMoviePlayerViewController *ctrl = [[MPMoviePlayerViewController alloc] initWithContentURL:[NSURL URLWithString:@"http://vf1.mtime.cn/Video/2012/06/21/mp4/120621104820876931.mp4"]];
     
     //将视频播放器弹出
     
     [self presentMoviePlayerViewControllerAnimated:ctrl];
     */
    // 发送通知 给vc
    NSString *urlStr = [_modal.videos[indexPath.row] objectForKey:@"url"];
    NSDictionary *userInfo = @{@"urlStr" : urlStr};
    [[NSNotificationCenter defaultCenter] postNotificationName:@"MoviePlayer" object:self userInfo:userInfo];
    
//     MPMoviePlayerViewController *ctrl = [[MPMoviePlayerViewController alloc] initWithContentURL:[NSURL URLWithString:urlStr]];
//     [self presentMoviePlayerViewControllerAnimated:ctrl];
}

@end
