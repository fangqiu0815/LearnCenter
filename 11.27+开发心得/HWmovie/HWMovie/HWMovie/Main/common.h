//
//  common.h
//  HWMovie
//
//  Created by hyrMac on 15/7/20.
//  Copyright (c) 2015年 hyrMac. All rights reserved.
//

#ifndef HWMovie_common_h
#define HWMovie_common_h

#define kWidth [UIScreen mainScreen].bounds.size.width
#define kHeight [UIScreen mainScreen].bounds.size.height
#define kNavHeight 64
#define kTabBarHeight 49

// json文件名
#define ImageListFile @"image_list.json"
#define DistrictListFile @"district_list.json"
#define CinemaListFile @"cinema_list.json"
#define MovieCommentFile @"movie_comment.json"
#define MovieDetailFile @"movie_detail.json"



#define BaseUrl  @"https://api.douban.com"

#define US_BOX @"/v2/movie/us_box"
#define TOP250 @"/v2/movie/top250"

#endif
