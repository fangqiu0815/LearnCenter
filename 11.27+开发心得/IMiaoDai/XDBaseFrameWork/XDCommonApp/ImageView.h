//
//  ImageView.h
//  ScrollViewDome
//
//  Created by zhangqingfeng on 12-9-27.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface ImageView : UIScrollView<UIScrollViewDelegate>{
    
    NSUInteger index;

}
@property ( assign) NSUInteger index;
- (id)initView:(NSString *)urlStr;
-(id)initSuoLueTu:(UIImage *)image;
-(id)initDefault:(NSString *)path;
- (id)initSmallView:(NSString *)urlStr;

@end