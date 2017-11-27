//
//  PYResource.m
//  Gank
//
//  Created by 谢培艺 on 2017/2/27.
//  Copyright © 2017年 CoderKo1o. All rights reserved.
//

#import "PYResource.h"
#import <UIKit/UIKit.h>
#import <MJExtension/MJExtension.h>
#import "NSString+PYExtension.h"
#import <PYPhotoBrowser/PYPhotoBrowser.h>
#import "PYImage.h"
#import <PYPhotoBrowser.h>

@implementation PYResource

- (void)setDesc:(NSString *)desc
{
    _desc = [desc copy];
    
    self.imageModels = self.imageModels;
}

- (void)setImageModels:(NSArray *)imageModels
{
    _imageModels = imageModels;
    
    // 计算cell高度
    NSString *titleText = [NSString stringWithFormat:@"%@ (@%@)", _desc, self.who];
    // 计算高度
    CGSize titleSize = [titleText sizeWithMaxWidth:[UIScreen mainScreen].bounds.size.width -40 -20 font:[UIFont preferredFontForTextStyle:UIFontTextStyleTitle3]];
    
    // 计算图片高度
    CGFloat imagesViewH = -10;
    for (int i = 0; i < imageModels.count; i++) {
        PYImage *imageModel = imageModels[i];
        if (imageModel.width > 0) { // 取到图片的宽高
            // 取出图片个数
            NSInteger imageCount = imageModels.count;
            if (imageCount == 1) {
                imagesViewH = imageModel.height / imageModel.width * (PYScreenW - 60);
            } else if (imageCount > 1) {
                PYPhotosView *photosView = [[PYPhotosView alloc] init];
                photosView.photoHeight = photosView.photoWidth = (PYScreenW - 60 - (imageCount - 1) * PYPhotoMargin) / imageCount;
                imagesViewH = [photosView sizeWithPhotoCount:imageCount photosState:PYPhotosViewStateDidCompose].height;
            }
        } else { // 未能获取图片大小。默认 宽 == 高
            imagesViewH = (PYScreenW - 60);
        }
    }
    
    self.cellHeight = 20 + titleSize.height + 10 + imagesViewH;
}

@end
