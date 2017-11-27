//
//  HMVisitorViewController.h
//  Weibo11
//
//  Created by 刘凡 on 15/12/5.
//  Copyright © 2015年 itheima. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HMVisitorView.h"

@interface HMVisitorViewController : UITableViewController

/// 设置 UI
///
/// @param imageName           访客视图图像名，首页传入 nil
/// @param message             访客视图提示信息
/// @param logonSuccessedBlock 登录成功后的 UI 设置 block
- (void)setupUIWithImageName:(NSString *)imageName message:(NSString *)message logonSuccessedBlock:(void (^)())logonSuccessedBlock;

@end
