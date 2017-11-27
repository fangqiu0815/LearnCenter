//
//  UIView+QuickCreateUI.m
//  testPro
//
//  Created by 冯宝东 on 16/1/26.
//  Copyright © 2016年 冯宝东. All rights reserved.
//

#import "UIView+FBDQuickCreateUI.h"

@implementation UIView (FBDQuickCreateUI)
/**
 *  快速创建UIButton
 *
 *  @param frame 位置
 *
 *  @return UIButton 实例
 */
-(UIButton*)fbd_quickCreateUIButtonWithFrame:(CGRect)frame
{
    UIButton*fbdButton=[[UIButton alloc] initWithFrame:frame];
    [fbdButton setTitle:@"默认" forState:UIControlStateNormal];
    [fbdButton setBackgroundColor:[UIColor purpleColor]];
    return fbdButton;
    
}
/**
 *  快速创建UILabel
 *
 *  @param frame 位置
 *
 *  @return UILabel 实例
 */
-(UILabel*)fbd_quickCreateUILabelWithFrame:(CGRect)frame
{
    UILabel*fbdLabel=[[UILabel alloc] initWithFrame:frame];
    fbdLabel.text=@"默认";
    [fbdLabel setBackgroundColor:[UIColor purpleColor]];
    return fbdLabel;

}

/**
 *  快速创建UIView
 *
 *  @param frame 位置
 *
 *  @return UIView 实例
 */
-(UIView*)fbd_quickCreateUIViewWithFrame:(CGRect)frame
{
    UIView*fbdView=[[UILabel alloc] initWithFrame:frame];
    [fbdView setBackgroundColor:[UIColor purpleColor]];
    return fbdView;
}

/**
 *  快速创建UIImageView
 *
 *  @param frame 位置
 *
 *  @return UIImageView 实例
 */
-(UIImageView*)fbd_quickCreateUIImageViewWithFrame:(CGRect)frame withImageName:(NSString*)imageName
{
    UIImageView*fbdImageView=[[UIImageView alloc] initWithFrame:frame];
    [fbdImageView setBackgroundColor:[UIColor purpleColor]];
    fbdImageView.image=[self fbd_quickCreateUIImageWithImageName:imageName];
    return fbdImageView;

}

/**
 *  快速创建UIImage
 *
 *  @param frame 位置
 *
 *  @return UIImageView 实例
 */
-(UIImage*)fbd_quickCreateUIImageWithImageName:(NSString*)imageName
{
//    NSString *file = [[NSBundle bundleWithIdentifier:@"MJRefresh.bundle"] pathForResource:imageName ofType:nil];
//    UIImage *fbdImage = [UIImage imageWithContentsOfFile:file];
    UIImage*fbdImage=[UIImage imageNamed:imageName];
    return fbdImage;

}

#pragma mark  快速获取frame的各个属性
/**
 *  快速获取起点X坐标
 *
 *  @return 起点X坐标
 */
-(CGFloat)view_orignX
{
    return self.frame.origin.x;
}

-(void)setView_orignX:(CGFloat)x
{

    CGRect old_NewCGRect=self.frame;
    old_NewCGRect.origin.x=x;
    self.frame=old_NewCGRect;
    
}


/**
 *  快速获取起点Y坐标
 *
 *  @return 起点Y坐标
 */
-(CGFloat)view_orignY
{
    return self.frame.origin.y;
}
-(void)setView_orignY:(CGFloat)y
{
    CGRect old_NewCGRect=self.frame;
    old_NewCGRect.origin.y=y;
    self.frame=old_NewCGRect;

}
/**
 *  快速获取宽度
 *
 *  @return 获取宽度
 */
-(CGFloat)view_sizeWidth
{
    return self.frame.size.width;
}
-(void)setView_sizeWidth:(CGFloat)width
{
    CGRect old_NewCGRect=self.frame;
    old_NewCGRect.size.width=width;
    self.frame=old_NewCGRect;
}

/**
 *  快速获取高度
 *
 *  @return 获取高度
 */
-(CGFloat)view_sizeHeight
{
    return self.frame.size.height;
}

-(void)setView_sizeHeight:(CGFloat)height
{
    CGRect old_NewCGRect=self.frame;
    old_NewCGRect.size.height=height;
    self.frame=old_NewCGRect;

}


/**
 *  通过所有子视图的遍历获得自身的高度
 *
 *  @return 自身的高度
 */
-(CGFloat)viewHeightByAllSubView
{
    CGFloat maxHeight=0.0;
    if (self.subviews)
    {
//   这种方法只能按照顺序 从上向下一次排列才能就算
//        UIView*lastView=[self.subviews lastObject];
//        NSLog(@"lastView:%@",lastView);
//        return CGRectGetMaxY(lastView.frame);
        
        for (UIView* eveyView in self.subviews)
        {
            CGFloat everyOriginY=[eveyView view_orignY];
            NSLog(@"eveyView:%@  . everyOriginY:%f",eveyView,everyOriginY);
            maxHeight=maxHeight>everyOriginY?maxHeight:everyOriginY;
            
            
        }
        return maxHeight;
        
    }else
    {
        return 0;
    }
    return 0;
}


// 计算 label 内容的高度
- (float) calculateUserDesprationLabelDesprationHeight:(NSString*)desStr withLabel:(UILabel*)placeLabel
{
    
    float totalHeight=0;
    if (desStr) {
        NSMutableParagraphStyle * paragraphStyle1 = [[NSMutableParagraphStyle alloc] init];
        paragraphStyle1.lineSpacing=5;
        NSDictionary *attributeDic = @{NSFontAttributeName:placeLabel.font,NSParagraphStyleAttributeName:paragraphStyle1};
        
        NSMutableAttributedString *attributedStr = [[NSMutableAttributedString alloc]
                                                    initWithString:desStr
                                                    attributes:attributeDic];
        NSStringDrawingOptions options = NSStringDrawingUsesLineFragmentOrigin;
        
        CGRect  ctRect=[attributedStr boundingRectWithSize:CGSizeMake(placeLabel.frame.size.width,MAXFLOAT)
                                                   options:options
                                                   context:nil];
        placeLabel.attributedText=attributedStr;
        
        
        
        
        CGRect placeLabelCGRect= placeLabel.frame;;
        placeLabelCGRect.size.height= ceilf(ctRect.size.height);
        placeLabelCGRect.size.width=ceilf(ctRect.size.width);
        placeLabel.frame=placeLabelCGRect;
        
        totalHeight= ceilf(ctRect.size.height);
        
        
        
    }
    
    
    return totalHeight;
}

// 计算 label 内容的宽度
- (float) calculateLabelWidth:(UILabel*)label comeTextStr:(NSString*)desStr
{
    
    float totalWidth=0;
    if (desStr) {
        
        
        NSDictionary *attributeDic = @{NSFontAttributeName:label.font};
        
        NSMutableAttributedString *attributedStr = [[NSMutableAttributedString alloc]
                                                    initWithString:desStr
                                                    attributes:attributeDic];
        NSStringDrawingOptions options = NSStringDrawingUsesLineFragmentOrigin;
        
        CGRect  ctRect=[attributedStr boundingRectWithSize:CGSizeMake(MAXFLOAT,label.frame.size.height)
                                                   options:options
                                                   context:nil];
        label.attributedText=attributedStr;
        
        
        CGRect placeLabelCGRect= label.frame;;
        placeLabelCGRect.size.width=ceilf(ctRect.size.width);
        //        placeLabelCGRect.size.height=ceilf(ctRect.size.height);
        label.frame=placeLabelCGRect;
        
        totalWidth=ceilf(ctRect.size.width);
    }
    
    return totalWidth;
    
}





@end
