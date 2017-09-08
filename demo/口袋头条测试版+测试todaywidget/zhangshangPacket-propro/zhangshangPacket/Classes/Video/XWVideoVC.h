//
//  XWVideoVC.h
//  zhangshangPacket
//
//  Created by apple on 2017/8/1.
//  Copyright © 2017年 apple-fangqiu. All rights reserved.
//

#import "XWBaseVC.h"
//@class WMPageController;
#import "XWVideoPublishView.h"

@interface XWVideoVC : UITableViewController

//@property (nonatomic, assign) NSInteger selectItemIndex;
//@property (nonatomic, strong) WMPageController *pagecontroller;
@property (nonatomic,strong)UIButton *(^pulldownRefreh)();
-(void)beginRefresh;



@end
