//
//  dataService.h
//  HWMovie
//
//  Created by hyrMac on 15/7/21.
//  Copyright (c) 2015年 hyrMac. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DataService : NSObject
+ (id)getJsonDataFromFile:(NSString *)fileName;
@end
