//
//  SchoolInfoViewController.h
//  XDCommonApp
//
//  Created by xindao on 14-8-21.
//  Copyright (c) 2014年 XD-XY. All rights reserved.
//

#import "XDBaseViewController.h"

@protocol ChooseSchoolInfoDelegate <NSObject>
-(void)getSchoolInfo:(NSString *)info type:(NSString *)type;
@end

@interface SchoolInfoViewController : XDBaseViewController<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic,assign) id <ChooseSchoolInfoDelegate> delegate;
@property (nonatomic,copy) NSString * type;
@end
