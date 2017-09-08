//
//  XWMidleCell.m
//  zhangshangPacket
//
//  Created by apple on 2017/6/2.
//  Copyright © 2017年 apple-fangqiu. All rights reserved.
//

#import "XWMidleCell.h"

@implementation XWMidleCell

#pragma mark -
#pragma mark - 初始化方法
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        [self.contentView addSubview:self.myApprenticeBtn];
        [self.contentView addSubview:self.foundBtn];
        [self.contentView addSubview:self.cashBtn];
        
        [self setupAutoLayout];
        
    }
    return self;
}


#pragma mark -
#pragma mark - 懒加载
- (XWSquareButton *)myApprenticeBtn
{
    if (!_myApprenticeBtn) {
        _myApprenticeBtn = [[XWSquareButton alloc] init];
        [_myApprenticeBtn setImage:[UIImage imageNamed:@"icon_user_apprentice"] forState:0];
        //   [_myApprenticeBtn layoutButtonWithEdgeInsetsStyle:MKButtonEdgeInsetsStyleTop imageTitleSpace:6];
        [_myApprenticeBtn setTitle:@"推荐" forState:0];
        _myApprenticeBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    }
    return _myApprenticeBtn;
}

- (XWSquareButton *)cashBtn
{
    if (!_cashBtn) {
        _cashBtn = [[XWSquareButton alloc] init];
        [_cashBtn setImage:[UIImage imageNamed:@"icon_user_treasury"]
                         forState:0];
        //  [_orderDetailBtn layoutButtonWithEdgeInsetsStyle:MKButtonEdgeInsetsStyleTop imageTitleSpace:6];
        if (STUserDefaults.ischeck == 1) {
            [_cashBtn setTitle:@"收藏" forState:0];
            
        } else {
            [_cashBtn setTitle:@"钱包" forState:0];
            
        }
        _cashBtn.titleLabel.font = [UIFont systemFontOfSize:15];
        
    }
    return _cashBtn;
}

- (XWSquareButton *)foundBtn
{
    if (!_foundBtn) {
        _foundBtn = [[XWSquareButton alloc] init];
        [_foundBtn setImage:[UIImage imageNamed:@"icon_user_discover"] forState:0];
        // [_richManBtn layoutButtonWithEdgeInsetsStyle:MKButtonEdgeInsetsStyleTop imageTitleSpace:6];
        [_foundBtn setTitle:@"发现" forState:0];
        _foundBtn.titleLabel.font = [UIFont systemFontOfSize:15];
        
    }
    return _foundBtn;
}

#pragma mark -
#pragma mark - 自动适配
- (void)setupAutoLayout
{
    __weak typeof(self)vc = self;
    
    CGFloat only = ScreenW/9;
    CGFloat Padding = only*3/2;
    //我的徒弟
    [_myApprenticeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(vc.mas_centerY);
        make.left.mas_equalTo(vc.mas_left).offset(only);
        make.width.mas_equalTo(only);
        make.height.mas_equalTo(Padding);
    }];
    
    
    //钱包
    [_cashBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(vc);
        make.centerX.mas_equalTo(vc);
        make.width.mas_equalTo(only);
        make.height.mas_equalTo(Padding);
    }];
    
    //发现
    [_foundBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(vc.mas_centerY);
        make.right.equalTo(vc.mas_right).offset(-only);
        make.width.mas_equalTo(only);
        make.height.mas_equalTo(Padding);
    }];
    
   
    
    
}



@end
