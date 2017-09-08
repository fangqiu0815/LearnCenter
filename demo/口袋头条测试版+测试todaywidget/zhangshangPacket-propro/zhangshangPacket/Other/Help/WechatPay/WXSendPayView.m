//
//  WXSendPayView.m
//  SanWangTong
//
//  Created by 黄裕杰 on 16/6/20.
//  Copyright © 2016年 黄裕杰. All rights reserved.
//

#import "WXSendPayView.h"

//商户ID
#define WXDevelopmentMCHID @"1357131402"

@implementation WXSendPayView


+(void) wxSendPayWithDict:(NSDictionary*)backDict{
    
    
    PayReq *request = [[PayReq alloc] init];
    
    request.openID = STUserDefaults.applyid;
    // *** 商户号
    request.partnerId = STUserDefaults.partnerid;
    // *** 单号
    request.prepayId = [backDict objectForKey:@"prepayid"];
    // *** 随机字符
    request.nonceStr = [backDict objectForKey:@"noncestr"];
    // *** 时间戳
    request.timeStamp = [[backDict objectForKey:@"timestamp"] intValue];
    
    request.package = @"Sign=WXPay";
    // *** 签名
    //    request.sign = [WXPaySign getSign:backDict];
    
    NSString *lowerCaseString = [backDict[@"sign"] lowercaseString];
    
    request.sign = lowerCaseString;
    MyLog(@"%@",lowerCaseString);
    [WXApi sendReq:request];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
