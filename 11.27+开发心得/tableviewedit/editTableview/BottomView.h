//
//  BottomView.h
//  pod_test
//
//  Created by YY_ZYQ on 2017/6/23.
//  Copyright © 2017年 YY_ZYQ. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BottomView : UIView

/**
 全选按钮
 */
@property (nonatomic ,strong) UIButton *allBtn;


/**
 标记已读按钮
 */
@property (nonatomic ,strong) UIButton *readBtn;


/**
 删除按钮
 */
@property (nonatomic ,strong) UIButton *deleteBtn;

@end
