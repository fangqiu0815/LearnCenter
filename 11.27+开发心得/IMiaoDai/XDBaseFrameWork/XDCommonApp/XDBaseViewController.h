//
//  XDBaseViewController.h
//  XDCommonApp
//
//  Created by XD-XY on 2/12/14.
//  Copyright (c) 2014 XD-XY. All rights reserved.
//

#import <UIKit/UIKit.h>
@interface XDBaseViewController : UIViewController
{
    CGFloat aHeight;
}
@property (nonatomic,strong)UIView * navigationBarView;
@property (nonatomic,strong)UIImageView * navigationBarBg;
@property (nonatomic,strong)UIButton * leftBtn;
@property (nonatomic,strong)UIView * contentView;
@property (nonatomic,strong)UILabel * titleLabel;
-(void)changeFrameWhenHiddenNavigationBar;
@end



@interface UIViewController (Create_UI_Method)

UIButton *creatXRButton(CGRect frame,NSString *title,UIImage*normalImage,UIImage *hightImage);
UITextField *creatXRTextField(NSString *placeTitle,CGRect frame);
UILabel *creatXRLable(NSString *name ,CGRect frame);
UIImageView *creatXRImageView(CGRect frame,UIImage *image);

@end