//
//  XWDisMoreDataModel.h
//  zhangshangPacket
//
//  Created by apple on 2017/8/3.
//  Copyright © 2017年 apple-fangqiu. All rights reserved.
//

#import <Foundation/Foundation.h>
@class XWDisMoreDataList,MoreDataListModel;
@interface XWDisMoreDataModel : NSObject
@property (nonatomic, strong) XWDisMoreDataList *d;

@property (nonatomic, assign) NSInteger st;

@property (nonatomic, assign) NSInteger c;

@property (nonatomic, copy) NSString *m;
@end

@interface XWDisMoreDataList : NSObject

@property (nonatomic, copy) NSString *pnmax;

@property (nonatomic, copy) NSString *pn;

@property (nonatomic, strong) NSArray<MoreDataListModel *> *newestenterlist;


@end

@interface MoreDataListModel : NSObject

/*
 content = "\U52a0\U5165\U201c\U6709\U4e66\U5171\U8bfb\U884c\U52a8\U8ba1\U5212\U201d\Uff0c\U548c1000\U4e07\U4e66\U53cb\U4e00\U8d77\Uff0c\U6bcf\U5929\U65e9\U665a\U8bfb\U4e66\U534a\U5c0f\U65f6\Uff0c\U6bcf\U5468\U8bfb\U5b8c1\U672c\U4e66\Uff0c\U4e00\U5e74\U8bfb\U5b8c52\U672c\U7cbe\U9009\U597d\U4e66\Uff0c\U6210\U4e3a\U671f\U5f85\U7684\U81ea\U5df1\U3002";
 desc = "\U8fd9\U4e2a\U4eba\U5f88\U61d2\Uff0c\U4ec0\U4e48\U90fd\U6ca1\U7559\U4e0b";
 id = 5;
 istake = 1;
 pic = "http://open.weixin.qq.com/qr/code/?username=youshucc";
 title = "\U6709\U4e66";
 wechatid = youshucc;

 */

@property (nonatomic, copy) NSString *desc;

@property (nonatomic, copy) NSString *istake;

@property (nonatomic, copy) NSString *title;

@property (nonatomic, copy) NSString *id;

@property (nonatomic, copy) NSString *pic;

@property (nonatomic, copy) NSString *wechatid;

@property (nonatomic, copy) NSString *content;



@end


