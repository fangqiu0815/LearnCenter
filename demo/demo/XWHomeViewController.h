//
//  XWHomeViewController.h
//  zhangshangPacket
//
//  Created by apple on 2017/5/25.
//  Copyright © 2017年 apple-fangqiu. All rights reserved.
//

#import "XWBaseVC.h"
@class WMPageController;
@interface XWHomeViewController : WMPageController

@property (nonatomic, assign) NSInteger selectItemIndex;
@property (nonatomic, strong) WMPageController *pagecontroller;


@end
