//
//  ConfirmListCell.h
//  CrazyPacket
//
//  Created by WuYanZu on 17/3/1.
//  Copyright © 2017年 WuYanZu. All rights reserved.
//

#import "STBaseCell.h"
#import "AddressModel.h"

@interface ConfirmListCell : STBaseCell
@property (nonatomic, copy) void (^DeLeteBlock)();
@property (nonatomic, copy) void (^SelectedBlock)(AddressList *tempModel);
@property (nonatomic, strong) AddressList * dataModel;


@end
