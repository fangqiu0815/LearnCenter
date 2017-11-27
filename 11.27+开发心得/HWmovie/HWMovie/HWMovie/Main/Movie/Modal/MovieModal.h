//
//  MovieModal.h
//  HWMovie
//
//  Created by hyrMac on 15/7/20.
//  Copyright (c) 2015年 hyrMac. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MovieModal : NSObject
@property (nonatomic,retain) NSDictionary *images;
@property (nonatomic,assign) float average;
@property (nonatomic,copy) NSString *title;
@property (nonatomic,copy) NSString *year;

@end
