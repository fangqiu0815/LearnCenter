//
//  UIDevice+DeviceIDByKeychainThisDeviceOnly.h
//  20171212-OC测试
//
//  Created by apple-gaofangqiu on 2017/12/28.
//  Copyright © 2017年 apple-fangqiu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIDevice (DeviceIDByKeychainThisDeviceOnly)

+ (NSString*)identifierByKeychain;


@end
