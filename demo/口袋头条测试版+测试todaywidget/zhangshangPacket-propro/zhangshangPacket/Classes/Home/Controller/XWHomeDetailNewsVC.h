//
//  XWHomeDetailNewsVC.h
//  zhangshangPacket
//
//  Created by apple on 2017/7/24.
//  Copyright © 2017年 apple-fangqiu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XWHomeModel.h"
@interface XWHomeDetailNewsVC : UIViewController
{
    BOOL isCollectSuccess;

}
@property (nonatomic, strong) NSString *newsId;

@property (nonatomic, strong) NSString *newstype;

@property (nonatomic, strong) NSString *newsTitle;

@property (nonatomic, strong) NewsListDataModel *listModel;

@property (nonatomic, strong) NSArray *infoArr;

@end
