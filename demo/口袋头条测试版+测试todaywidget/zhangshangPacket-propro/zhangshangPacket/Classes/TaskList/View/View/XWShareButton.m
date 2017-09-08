//
//  XWShareButton.m
//  zhangshangPacket
//
//  Created by apple on 2017/5/22.
//  Copyright © 2017年 apple-fangqiu. All rights reserved.
//

#import "XWShareButton.h"

@implementation XWShareButton

+(instancetype)buttonWithImage:(UIImage *)image title:(NSString *)title{
    
    XWShareButton *button = [[XWShareButton alloc] init];
    UIImageView *imgView = [[UIImageView alloc] initWithImage:image];
    [button addSubview:imgView];
    [imgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.equalTo(button);
        make.height.equalTo(button.mas_width);
    }];
    
    UILabel *label = [[UILabel alloc] init];
    label.text = title;
    label.textColor = [UIColor blackColor];
    label.font = [UIFont systemFontOfSize:RemindFont(12, 13, 14)];
    label.textAlignment = NSTextAlignmentCenter;
    [button addSubview:label];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(button);
        make.top.equalTo(imgView.mas_bottom).offset(2);
    }];
   return button;

}

+(instancetype)buttonWithURLImage:(NSString *)imageStr title:(NSString *)titleStr
{
    XWShareButton *button = [[XWShareButton alloc] init];
    UIImageView *imgView = [[UIImageView alloc] init];
    [imgView sd_setImageWithURL:[NSURL URLWithString:imageStr] placeholderImage:MyImage(@"bg_default") options:SDWebImageRefreshCached];
    
    [button addSubview:imgView];
    [imgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.equalTo(button);
        make.height.equalTo(button.mas_width);
    }];
    
    UILabel *label = [[UILabel alloc] init];
    label.text = titleStr;
    label.textColor = [UIColor blackColor];
    label.font = [UIFont systemFontOfSize:RemindFont(12, 13, 14)];
    label.textAlignment = NSTextAlignmentCenter;
    [button addSubview:label];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(button);
        make.top.equalTo(imgView.mas_bottom).offset(5);
    }];
    return button;
}


@end


