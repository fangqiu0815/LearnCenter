//
//  IndexCollectionViewCell.m
//  HWMovie
//
//  Created by hyrMac on 15/7/25.
//  Copyright (c) 2015年 hyrMac. All rights reserved.
//

#import "IndexCollectionViewCell.h"
#import "UIViewExt.h"
#import "UIImageView+WebCache.h"

@implementation IndexCollectionViewCell
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        
        [self _loadSubviews];
    }
    return self;
}

- (void)_loadSubviews {
    _smallPoster = [[UIImageView alloc] initWithFrame:CGRectMake(self.width*0.05,self.height*0.05, self.width*0.9, self.height*0.9)];
    [self.contentView addSubview:_smallPoster];
    
}

- (void)setMovieModal:(MovieModal *)movieModal {
    _movieModal = movieModal;
    
    [self setNeedsLayout];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    NSString *str = [_movieModal.images objectForKey:@"large"];
    [_smallPoster sd_setImageWithURL:[NSURL URLWithString:str]];
}

@end
