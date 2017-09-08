//
//  XWRecommendVideoVC.h
//  zhangshangPacket
//
//  Created by apple on 2017/8/3.
//  Copyright © 2017年 apple-fangqiu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DisplayerDataNums.h"

@interface XWRecommendVideoVC : UITableViewController

//@property (nonatomic,strong)void(^topViewTransform)(CGFloat);
@property (nonatomic,strong)UIButton *(^pulldownRefreh)();
-(void)beginRefresh;
@property (nonatomic,weak)DisplayerDataNums *dataDisplayerView;

@end
