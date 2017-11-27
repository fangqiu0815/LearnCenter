//
//  PosterCollectionViewCell.m
//  HWMovie
//
//  Created by hyrMac on 15/7/24.
//  Copyright (c) 2015年 hyrMac. All rights reserved.
//

#import "PosterCollectionViewCell.h"
#import "UIViewExt.h"
#import "UIImageView+WebCache.h"

@implementation PosterCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        
        [self _loadSubviews];
    }
    return self;
}

- (void)_loadSubviews {
    _bigPoster = [[UIImageView alloc] initWithFrame:CGRectMake(self.width*0.05,self.height*0.05, self.width*0.9, self.height*0.9)];
    [self.contentView addSubview:_bigPoster];
    
    NSArray *array = [[NSBundle mainBundle] loadNibNamed:@"PosterDetailView" owner:self options:nil];
    _detailView = [array lastObject];
    _detailView.frame = CGRectMake(self.width*0.05,self.height*0.05, self.width*0.9, self.height*0.9);
//    _detailView.hidden = YES;
    [self.contentView addSubview:_detailView];
    
}

//- (void)setImageUrlStr:(NSString *)imageUrlStr {
//    _imageUrlStr = imageUrlStr;
//    [self setNeedsLayout];
//}

- (void)setMovieModal:(MovieModal *)movieModal {
    _movieModal = movieModal;
    _detailView.movieModal = movieModal;
    
    [self setNeedsLayout];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    if (_isBack == YES) {
        _bigPoster.hidden = YES;
        _detailView.hidden = NO;
    } else {
        _bigPoster.hidden = NO;
        _detailView.hidden = YES;
    }
    
    NSString *str = [_movieModal.images objectForKey:@"large"];
    [_bigPoster sd_setImageWithURL:[NSURL URLWithString:str]];
}

- (void)filpCell {
    [self filpAction:self isLeft:_bigPoster.hidden];
    _bigPoster.hidden = !_bigPoster.hidden;
    _detailView.hidden = !_detailView.hidden;
}

#pragma mark - Tools

// 视图切换动画效果设置
- (void)filpAction:(UIView *)view isLeft:(BOOL)isLeft {
    UIViewAnimationOptions option = isLeft ? UIViewAnimationOptionTransitionFlipFromLeft :UIViewAnimationOptionTransitionFlipFromRight;
    [UIView transitionWithView:view duration:0.5 options:option animations:nil completion:nil];
}

@end
