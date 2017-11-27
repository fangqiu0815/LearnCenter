//
//  ImageView.m
//  ScrollViewDome
//
//  Created by zhangqingfeng on 12-9-27.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "ImageView.h"
#import "UIImageView+WebCache.h"
#import "XDHeader.h"
@implementation ImageView
@synthesize index;

- (id)initView:(NSString *)urlStr
{
    self = [super init];
    if (self) {
        
       __block UIImageView * myImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 1024,768)];
        urlStr = [urlStr stringByReplacingOccurrencesOfString:@" " withString:@""];
        
        NSRange range = [urlStr rangeOfString:@"Applications"];
        DDLOG(@"============%@",urlStr);
        if (range.location == NSNotFound) {
            [myImageView setImageWithURL:[NSURL URLWithString:urlStr] placeholderImage:[UIImage imageNamed:@"moren_big"] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType) {
                if (image!=nil) {
                    myImageView.frame = CGRectMake(0, 0, 320, 320/image.size.width*image.size.height);
                }
                
            }];
        }else{
            NSData *imageData = [[NSData alloc] initWithContentsOfFile:urlStr];
            myImageView.image = [[UIImage alloc] initWithData:imageData];
            if (myImageView.image!=nil) {
                myImageView.frame = CGRectMake(0, 0, 320, 320/myImageView.image.size.width*myImageView.image.size.height);
            }
            
        }
        
       
        myImageView.userInteractionEnabled = YES;
        [self addSubview:myImageView];
        self.delegate = self;
        self.contentSize = self.frame.size;
        self.minimumZoomScale=1.0f;
        self.maximumZoomScale=3.0f;
        [self setZoomScale:1.0];
		self.showsHorizontalScrollIndicator = NO;
		self.showsVerticalScrollIndicator = NO;
        
		self.decelerationRate = UIScrollViewDecelerationRateFast;
		self.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    }
    return self;
}

- (void)scrollViewDidEndZooming:(UIScrollView *)scrollView withView:(UIView *)view atScale:(float)scale
{
    [scrollView setZoomScale:scale animated:YES];
}


-(UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView{
    //    return _imageViewArr[_currentIndex];
    
    
    for (UIView *v in scrollView.subviews){
        
        return v;
    }
    return nil;
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    [self setZoomScale:1.0];
}

-(id)initSuoLueTu:(UIImage *)image{
    self = [super init];
    if (self) {
        
        UIImageView * myImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 254, 254/image.size.width*image.size.height)];
        myImageView.image = image;
        myImageView.userInteractionEnabled = YES;
        [self addSubview:myImageView];

		self.showsHorizontalScrollIndicator = NO;
		self.showsVerticalScrollIndicator = NO;
		self.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    }
    return self;
}

-(id)initDefault:(NSString *)path{
    self = [super init];
    if (self) {
        
        __block UIImageView * myImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 1024,768)];
        path = [path stringByReplacingOccurrencesOfString:@" " withString:@""];
        NSData *imageData = [[NSData alloc] initWithContentsOfFile:path];
        UIImage *image = [[UIImage alloc] initWithData:imageData];
        myImageView.image = image;
        myImageView.userInteractionEnabled = YES;
        [self addSubview:myImageView];
        
		self.showsHorizontalScrollIndicator = NO;
		self.showsVerticalScrollIndicator = NO;
		self.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    }
    return self;
}

- (id)initSmallView:(NSString *)urlStr
{
    self = [super init];
    if (self) {
        
        __block UIImageView * myImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 254,768)];
        urlStr = [urlStr stringByReplacingOccurrencesOfString:@" " withString:@""];
        
        NSRange range = [urlStr rangeOfString:@"Applications"];
        DDLOG(@"============%@",urlStr);
        if (range.location == NSNotFound) {
            [myImageView setImageWithURL:[NSURL URLWithString:urlStr] placeholderImage:[UIImage imageNamed:@"4"] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType) {
                if (image!=nil) {
                    myImageView.frame = CGRectMake(0, 0, 254, 254/image.size.width*image.size.height);
                }
                
            }];
        }else{
            NSData *imageData = [[NSData alloc] initWithContentsOfFile:urlStr];
            myImageView.image = [[UIImage alloc] initWithData:imageData];
            if (myImageView.image!=nil) {
                myImageView.frame = CGRectMake(0, 0, 254, 254/myImageView.image.size.width*myImageView.image.size.height);
            }
            
        }
        
        
        myImageView.userInteractionEnabled = YES;
        myImageView.contentMode = UIViewContentModeScaleToFill;
        [self addSubview:myImageView];
        self.delegate = self;
       
    }
    return self;
}
@end
