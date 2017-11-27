//
//  NewsModal.h
//  HWMovie
//
//  Created by hyrMac on 15/7/21.
//  Copyright (c) 2015年 hyrMac. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NewsModal : NSObject
@property (nonatomic,copy) NSString *title;
@property (nonatomic,copy) NSString *summary;
@property (nonatomic,assign) NSInteger type;
@property (nonatomic,copy) NSString *image;

@end
