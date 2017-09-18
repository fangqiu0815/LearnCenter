//
//  XWHobbyItemManager.m
//  zhangshangPacket
//
//  Created by apple-gaofangqiu on 2017/9/6.
//  Copyright © 2017年 apple-fangqiu. All rights reserved.
//

#import "XWHobbyItemManager.h"

@implementation XWChannelStyle

- (instancetype)init{
    
    self = [super init];
    if (self) {
        
        self.closeBtnW = 15;
        self.padding = 7;
        self.font = [UIFont systemFontOfSize:14];
        self.normalTextColor = [UIColor blackColor];
        self.selectedTextColor = [UIColor redColor];
        self.closeImage = [UIImage imageNamed:@"icon_editor_close"];
        self.hotImage = [UIImage imageNamed:@"hot"];
        self.coverTopImage = [UIImage imageNamed:@""];
        self.coverBottomImage = [UIImage imageNamed:@""];
        self.hotImageW = 20.f;
        self.isShowBorder = YES;
        self.isShowCover = NO;
        self.isShowHot = YES;
        
        self.isShowBackCover = NO;
        self.isShowPlaceHolderView = NO;
    }
    return self;
}

@end


@implementation XWHobbyItemManager

static XWHobbyItemManager *manager = nil;

+(instancetype)defaultManager{
    
    if (!manager) {
        manager = [[XWHobbyItemManager alloc]init];
    }
    return manager;
    
}

+(instancetype)allocWithZone:(struct _NSZone *)zone{
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [super allocWithZone:zone];
    });
    return manager;
}

+(void)updateChannelCallBack:(updateCallBack)callback{
    
    manager = [XWHobbyItemManager defaultManager];
    
    manager.callBack = callback;
    
}

+(instancetype)updateWithTopArr:(NSArray<XWHobbyItemModel *> *)top BottomArr:(NSArray<XWHobbyItemModel *> *)bottom InitialIndex:(NSUInteger)initialIndex newStyle:(XWChannelStyle *)style{
    
//    NSAssert(initialIndex < top.count, @"选中的initialIndex超过了顶部数组个数");
    
    manager = [XWHobbyItemManager defaultManager];
    manager.topChannelArr = nil;
    manager.bottomChannelArr = nil;
    manager.topChannelArr = [NSMutableArray arrayWithArray:top];
    manager.bottomChannelArr = [NSMutableArray arrayWithArray:bottom];
    manager.initialIndex = initialIndex;
    manager.style = style==nil ? [XWChannelStyle new] : style;
    
    return manager;
}

+(void)setUpdateIfNeeds{
    
    if (!manager.initialModel.isTop && manager.initialIndex < 0) {
        if (manager.callBack) {
            manager.callBack(manager.topChannelArr, manager.bottomChannelArr, manager.topChannelArr.count - 1); //若当前选中的频道被删除,则回调顶部最后一个
        }
    }else{
        if (manager.callBack) {
            manager.callBack(manager.topChannelArr, manager.bottomChannelArr, manager.initialIndex);
        }
    }
}



@end
