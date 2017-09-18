//
//  XWHobbyChannelView.h
//  zhangshangPacket
//
//  Created by apple-gaofangqiu on 2017/9/6.
//  Copyright © 2017年 apple-fangqiu. All rights reserved.
//

#import <UIKit/UIKit.h>

@class XWHobbyItemManager;

@interface XWHobbyChannelView : UIView


@property (nonatomic, assign, readonly) BOOL isEdit;

/** 编辑按钮 */
@property (nonatomic, strong, readonly) UIButton *editBtn;
/** 不建议这样引入,建议在外部控制器定义关闭按钮,直接调用manager里的 */
@property (nonatomic, strong) UIButton *closeBtn;


/**
 *  xwhobbyview构造方法,manager不得为空
 */
+(instancetype)channelViewWithFrame:(CGRect)frame Manager:(XWHobbyItemManager *)manager;


/**
 *  当选择了一个频道时的回调
 */
-(void)chooseChannelCallBack:(void(^)())callBack;

/**
 *  根据XWHobbyItemManager重新配置UI界面
 */
-(void)reloadChannels;

/**
 *  后续计划添加的功能,删除原reloadChannels方法
 */
//-(void)reloadChannelsWithAnimation:(BOOL)animation;


@end
