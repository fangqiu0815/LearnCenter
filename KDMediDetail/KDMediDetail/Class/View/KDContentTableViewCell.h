//
//  KDContentTableViewCell.h
//  KDMediDetail
//
//  Created by apple-gaofangqiu on 2018/3/5.
//  Copyright © 2018年 apple-fangqiu. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^ShowMoreContentBlock)(NSIndexPath *indexPath);

@interface KDContentTableViewCell : UITableViewCell

/**
 * 媒体内容
 */
@property (nonatomic, copy) NSString *mediaContentStr;
/**
 * 选中哪个indexpath
 */
@property (nonatomic, strong) NSIndexPath *indexPath;
/**
 * 是否显示更多内容
 */
@property (nonatomic, assign, getter=isShowMoreContent) BOOL showMoreContent;
/**
 * block内容
 */
@property (nonatomic, copy) ShowMoreContentBlock showMoreContentBlock;

/**
 * 内容默认行高
 */
+(CGFloat)cellDefaultHeight;

/**
 * 内容打开的行高
 */
+(CGFloat)cellMoreHeight:(NSString *)cellStr;


@end
