//
//  AddressConfirmView.h
//  CrazyPacket
//
//  Created by WuYanZu on 17/3/11.
//  Copyright © 2017年 WuYanZu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AddressConfirmView : UIView
@property (nonatomic, strong) UILabel *receiveTextF;
@property (nonatomic, strong) UILabel *phoneTextF;
@property (nonatomic, strong) UILabel *detailTextF;
@property (nonatomic, copy) void(^CloseBlock) ();
@property (nonatomic, copy) void(^ConfirmBlock) ();

@end
