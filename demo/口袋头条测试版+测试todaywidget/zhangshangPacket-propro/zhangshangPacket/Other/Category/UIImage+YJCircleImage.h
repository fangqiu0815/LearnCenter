//
//  UIImage+YJCircleImage.h
//  BaiSi
//
//  Created by 高方秋 on 16/9/22.
//  Copyright © 2016年 ly. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (YJCircleImage)

/**
 *  圆形图片
 */
-(UIImage *)circleImage;


/**
 *  带二维码的图片切割掉二维码
 */
-(UIImage *)DeleteQRCodeImage;





@end
