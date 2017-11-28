//
//  UIView+QuickCreateUI.h
//  testPro
//
//  Created by 冯宝东 on 16/1/26.
//  Copyright © 2016年 冯宝东. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (FBDQuickCreateUI)
#pragma mark  快速实例化响应的UI控件
/**
 *  快速创建UIButton
 *
 *  @param frame 位置
 *
 *  @return UIButton 实例
 */
-(UIButton*)fbd_quickCreateUIButtonWithFrame:(CGRect)frame;
/**
 *  快速创建UILabel
 *
 *  @param frame 位置
 *
 *  @return UILabel 实例
 */
-(UILabel*)fbd_quickCreateUILabelWithFrame:(CGRect)frame;

/**
 *  快速创建UIView
 *
 *  @param frame 位置
 *
 *  @return UIView 实例
 */
-(UIView*)fbd_quickCreateUIViewWithFrame:(CGRect)frame;

/**
 *  快速创建UIImageView
 *
 *  @param frame 位置
 *
 *  @return UIImageView 实例
 */
-(UIImageView*)fbd_quickCreateUIImageViewWithFrame:(CGRect)frame withImageName:(NSString*)imageName;

/**
 *  快速创建UIImage
 *
 *  @param frame 位置
 *
 *  @return UIImageView 实例
 */
-(UIImage*)fbd_quickCreateUIImageWithImageName:(NSString*)imageName;


#pragma mark  快速获取frame的各个属性
/**
 *  快速获取起点X坐标
 *
 *  @return 起点X坐标
 */
-(CGFloat)view_orignX;
-(void)setView_orignX:(CGFloat)x;
/**
 *  快速获取起点Y坐标
 *
 *  @return 起点Y坐标
 */
-(CGFloat)view_orignY;
-(void)setView_orignY:(CGFloat)y;
/**
 *  快速获取宽度
 *
 *  @return 获取宽度
 */
-(CGFloat)view_sizeWidth;
-(void)setView_sizeWidth:(CGFloat)width;

/**
 *  快速获取高度
 *
 *  @return 获取高度
 */
-(CGFloat)view_sizeHeight;
-(void)setView_sizeHeight:(CGFloat)height;

/**
 *  通过所有子视图的遍历获得自身的高度
 *
 *  @return 自身的高度
 */
-(CGFloat)viewHeightByAllSubView;


- (float) calculateUserDesprationLabelDesprationHeight:(NSString*)desStr withLabel:(UILabel*)placeLabel;
- (float) calculateLabelWidth:(UILabel*)label comeTextStr:(NSString*)desStr;

@end
