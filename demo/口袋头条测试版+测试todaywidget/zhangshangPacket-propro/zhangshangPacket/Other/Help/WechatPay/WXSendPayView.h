//
//  WXSendPayView.h
//  SanWangTong
//
//  Created by 黄裕杰 on 16/6/20.
//  Copyright © 2016年 黄裕杰. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "WXApi.h"

@interface WXSendPayView : UIView

+(void) wxSendPayWithDict:(NSDictionary*)backDict;

@end
