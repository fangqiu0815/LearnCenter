//
//  XWController.h
//  zhangshangnews
//
//  Created by apple on 2017/5/10.
//  Copyright © 2017年 apple-fangqiu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XWController : NSObject

@property (nonatomic, copy) NSString *className;
@property (nonatomic, copy) NSString *classTitle;
@property (nonatomic, copy) NSString *navigationTitle;
@property (nonatomic, copy) NSString *tabbarImage;
@property (nonatomic, copy) NSString *tabbarImageSelect;

+ (instancetype)initWithName:(NSString *)name title:(NSString *)title navigationTitle:(NSString *)ntitle tabbarImage:(NSString *)image tabbarImageSelect:(NSString *)simage;


@end
