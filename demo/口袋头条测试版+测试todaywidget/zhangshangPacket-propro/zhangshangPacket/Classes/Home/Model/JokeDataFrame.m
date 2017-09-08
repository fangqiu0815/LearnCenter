//
//  JokeDataFrame.m
//  zhangshangPacket
//
//  Created by apple on 2017/5/31.
//  Copyright © 2017年 apple-fangqiu. All rights reserved.
//

#import "JokeDataFrame.h"
#import "XWHomeJokeModel.h"
#define NameFont [UIFont systemFontOfSize:15]
#define TextFont [UIFont systemFontOfSize:16]
@implementation JokeDataFrame

- (void)setJokeData:(JokeData *)jokeData
{
    _jokeData = jokeData;
    
    // 间隙
    CGFloat padding = 10;
    
    // 设置头像的frame
    CGFloat iconViewX = padding;
    CGFloat iconViewY = padding;
    CGFloat iconViewW = 50;
    CGFloat iconViewH = 50;
    self.headerViewF = CGRectMake(iconViewX, iconViewY, iconViewW, iconViewH);
    
    // 设置昵称的frame
    CGFloat nameLabelX = CGRectGetMaxX(self.headerViewF) + padding;
    // 计算文字的宽高
    CGSize nameSize = [self sizeWithString:jokeData.uname font:NameFont maxSize:CGSizeMake(MAXFLOAT, MAXFLOAT)];
    
    CGFloat nameLabelH = nameSize.height;
    CGFloat nameLabelW = nameSize.width;
    CGFloat nameLabelY = iconViewY + (iconViewH - nameLabelH) * 0.5;
    self.nameViewF = CGRectMake(nameLabelX, nameLabelY, nameLabelW, nameLabelH);
    
    // 设置正文的frame
    CGFloat introLabelX = iconViewX;
    CGFloat introLabelY = CGRectGetMaxY(self.headerViewF) + padding;
    CGSize textSize =  [self sizeWithString:_jokeData.content font:TextFont maxSize:CGSizeMake(300, MAXFLOAT)];
    
    CGFloat introLabelW = textSize.width;
    CGFloat introLabelH = textSize.height;
    self.contentViewF = CGRectMake(introLabelX, introLabelY, introLabelW, introLabelH);
    
    CGFloat originX = ScreenW - 100;
    CGFloat originY = CGRectGetMaxY(self.contentViewF)+padding;
    CGFloat originW = 90;
    CGFloat originH = 30;
    self.originViewF = CGRectMake(originX, originY, originW, originH);
    
    // 评论frame
    if (_jokeData.pname) {// 如果有评论
        CGFloat commentNameX = iconViewX;
        CGFloat commentNameY = CGRectGetMaxY(self.originViewF) + padding;
        CGFloat commentNameW = 70;
        CGFloat commentNameH = 30;
        self.commentNameF = CGRectMake(commentNameX, commentNameY, commentNameW, commentNameH);
        
        CGFloat pictureViewX = CGRectGetMaxX(self.commentNameF) + padding;
        CGFloat pictureViewY = CGRectGetMaxY(self.originViewF) + padding;
        CGSize textSize =  [self sizeWithString:_jokeData.pcont font:TextFont maxSize:CGSizeMake(200, MAXFLOAT)];
        CGFloat pictureViewW = textSize.width;
        CGFloat pictureViewH = textSize.height;
        self.commentViewF = CGRectMake(pictureViewX, pictureViewY, pictureViewW, pictureViewH);
        
        // 计算行高
        self.cellHeight = CGRectGetMaxY(self.commentViewF) + padding;
    }else{
        NSLog(@"a");
        // 无评论
        self.cellHeight = CGRectGetMaxY(self.originViewF) + padding;
    }
    
    
}

/**
 *  计算文本的宽高
 *
 *  @param str     需要计算的文本
 *  @param font    文本显示的字体
 *  @param maxSize 文本显示的范围
 *
 *  @return 文本占用的真实宽高
 */
- (CGSize)sizeWithString:(NSString *)str font:(UIFont *)font maxSize:(CGSize)maxSize
{
    NSDictionary *dict = @{NSFontAttributeName : font};
    // 如果将来计算的文字的范围超出了指定的范围,返回的就是指定的范围
    // 如果将来计算的文字的范围小于指定的范围, 返回的就是真实的范围
    CGSize size =  [str boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:dict context:nil].size;
    return size;
}



@end


