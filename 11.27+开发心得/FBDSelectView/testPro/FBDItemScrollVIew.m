//
//  FBDItemScrollVIew.m
//  testPro
//
//  Created by 冯宝东 on 16/1/22.
//  Copyright © 2016年 冯宝东. All rights reserved.
//

#import "FBDItemScrollVIew.h"
@implementation FBDItemScrollVIew

-(instancetype)initWithFrame:(CGRect)frame andItemTitleArray:(NSMutableArray*)titleArray;
{
    self=[super initWithFrame:frame];
    
    [titleArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        UIButton*everyButton=[UIButton buttonWithType:UIButtonTypeCustom];
        everyButton.frame=CGRectMake(idx*60, 0, 60, frame.size.height);
        everyButton.backgroundColor=[self randomColor];
        [everyButton addTarget:self action:@selector(everyButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
        [everyButton setTitle:[NSString stringWithFormat:@"%lu",(unsigned long)idx] forState:UIControlStateNormal];
        
        [self addSubview:everyButton];
        
        self.contentSize=CGSizeMake(60*titleArray.count, 0);
        
        
        
        
        
        
    }];
    


    return self;
}
-(UIColor *) randomColor
{
    CGFloat hue = ( arc4random() % 256 / 256.0 ); //0.0 to 1.0
    CGFloat saturation = ( arc4random() % 128 / 256.0 ) + 0.5; // 0.5 to 1.0,away from white
    CGFloat brightness = ( arc4random() % 128 / 256.0 ) + 0.5; //0.5 to 1.0,away from black
    return [UIColor colorWithHue:hue saturation:saturation brightness:brightness alpha:1];
}

-(void)everyButtonPressed:(UIButton*)sender
{
    NSLog(@" NSStringFromCGRect : %@",NSStringFromCGRect(sender.frame));
    CGFloat originX=sender.frame.origin.x;
    CGFloat standerOffset=originX-ScreenW/2.0+30;
    CGFloat maxOffset=self.contentSize.width-ScreenW;
    
    CGFloat shouldOffset=standerOffset;
    if (standerOffset<0)
    {
        shouldOffset=0;
    }
    if (standerOffset>maxOffset)
    {
        shouldOffset=maxOffset;
    }
     self.contentOffset=CGPointMake(shouldOffset, 0);
    
}




/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
