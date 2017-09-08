//
//  ToolFontFit.h
//  zhangshangPacket
//
//  Created by apple on 2017/5/17.
//  Copyright © 2017年 apple-fangqiu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger,TGFontType){
    TGFontTypeNomal,
    TGFontTypeOne,
    TGFontTypeTwo,
    TGFontTypeThree,
    TGFontTypeFour,
    TGFontTypeFive,
    TGFontTypeSix,
};
@interface ToolFontFit : NSObject

+ (nullable UIFont *)getFontSizeWithType:(TGFontType)fontType size:(CGFloat)fontSize;

@end
