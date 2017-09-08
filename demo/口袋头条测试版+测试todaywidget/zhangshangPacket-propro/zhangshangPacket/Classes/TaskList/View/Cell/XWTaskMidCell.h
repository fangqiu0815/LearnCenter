//
//  XWTaskMidCell.h
//  zhangshangPacket
//
//  Created by apple on 2017/5/19.
//  Copyright © 2017年 apple-fangqiu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XWTaskMidCell : XWCell

@property (nonatomic, strong) UIImageView *iconImageView;

@property (nonatomic, strong) UILabel *titleLab;

@property (nonatomic, strong) UILabel *detailLab;

@property (nonatomic, strong) UILabel *finishLab;

//@property (nonatomic, copy) void (^CellClickBlock)();

/**
    设置cell
 @param image                 cell的完成任务的图片
 @param titleStr              cell的标题
 @param detailStr             细节的内容
 @param isFinishedStr         是否完成的内容
 @param isFinishedStrColor    是否完成的字体颜色
 
 */

- (void)setCellDataWithImage:(UIImage *)image andTitle:(NSString *)titleStr andDetail:(NSString *)detailStr andIsFinishedStr:(NSString *)isFinishedStr andIsFinishedStrColor:(UIColor *)isFinishedStrColor;






@end
