//
//  MyInfoViewController.h
//  XDCommonApp
//
//  Created by xindao on 14-8-8.
//  Copyright (c) 2014年 XD-XY. All rights reserved.
//

#import "XDBaseViewController.h"

@interface MyInfoViewController : XDBaseViewController<UITableViewDataSource,UITableViewDelegate,UIActionSheetDelegate,UINavigationControllerDelegate,UIImagePickerControllerDelegate>
{
    UITableView * myTableView;
}
@end
