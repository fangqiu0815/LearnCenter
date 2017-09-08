//
//  XWSysInfoModel.h
//  zhangshangPacket
//
//  Created by apple on 2017/5/20.
//  Copyright © 2017年 apple-fangqiu. All rights reserved.
//

#import <Foundation/Foundation.h>

@class  XWSysMainModel,XWMainfuncs,XWTreasurefuncs;
@interface XWSysInfoModel : NSObject

@property (nonatomic, strong) XWSysMainModel *d;

@property (nonatomic, assign) NSInteger st;

@property (nonatomic, assign) NSInteger c;

@property (nonatomic, copy) NSString *m;


@end

@interface XWSysMainModel : NSObject

@property (nonatomic, assign) NSInteger costingot;

@property (nonatomic, copy) NSString *htmlurl;

@property (nonatomic, copy) NSString *imgurlpre;

@property (nonatomic, assign) NSInteger ischeck;

@property (nonatomic, copy) NSString *shareurl;

@property (nonatomic, copy) NSString *sysversion;

@property (nonatomic, copy) NSString *taskversion;

@property (nonatomic, copy) NSString *mainfuncs;

@property (nonatomic, copy) NSString *treasurefuncs;

@property (nonatomic, assign) NSInteger *wheeldrawversion;

@end



