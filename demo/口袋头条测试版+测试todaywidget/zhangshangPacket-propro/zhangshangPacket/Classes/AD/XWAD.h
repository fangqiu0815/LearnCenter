//
//  XWAD.h
//  zhangshangPacket
//
//  Created by apple on 2017/5/11.
//  Copyright © 2017年 apple-fangqiu. All rights reserved.
//

#import <Foundation/Foundation.h>
@class openAdData;
@interface XWAD : NSObject

@property (nonatomic, strong) openAdData *d;

@property (nonatomic, assign) NSInteger st;

@property (nonatomic, assign) NSInteger c;

@property (nonatomic, copy) NSString *m;


@end

@interface openAdData : NSObject

@property (nonatomic, assign) NSInteger enable;

@property (nonatomic, copy) NSString *open_img;

@property (nonatomic, copy) NSString *open_click;

@property (nonatomic, copy) NSString *click_title;

@end


