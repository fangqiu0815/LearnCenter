//
//  STRequest.h
//  CrazyPacket
//
//  Created by WuYanZu on 17/2/20.
//  Copyright © 2017年 WuYanZu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "STAFNetWorking.h"


typedef void (^sendData)(id ServersData, BOOL isSuccess);

@interface STRequest : NSObject
#pragma mark -------- 配置信息接口--------------
/*------------------  配置信息接口  -------------------*/

//    配置信息接口
+ (void)SysInfoDataWithDataBlock:(sendData )sendBlock;

//    系统任务接口
+ (void)SysTaskInfoDataWithDataBlock:(sendData)sendBlock;

//    系统转盘数据接口
+ (void)SysWheelDrawWinWithDataBlock:(sendData)sendBlock;

//    开心转转转数据配置信息
+ (void)SysHappyTurnDataWithDataBlock:(sendData)sendBlock;

//    明细类型描述配置信息
+ (void)SysConfigDetainesDataWithDataBlock:(sendData)sendBlock;

//    反馈问题类型数据
+(void)feedBackTypeDataWithBlock:(sendData)sendBlock;

//    开屏广告
+(void)firstADDataWithBlock:(sendData )sendBlock;


#pragma mark -------- 系统消息接口 --------------
/*------------------- 系统消息接口  --------------------------*/

//    系统公告
+ (void)SysNoticeDataWithDataBlock:(sendData)sendBlock;

//    系统提现信息
+ (void)SysPersonConverDataWithDataBlock:(sendData)sendBlock;

//    系统错误日志
+ (void)SysClientlogDataWithDataBlock:(sendData)sendBlock;


#pragma mark -------- 任务模块接口 --------------
/*------------------- 任务模块接口  --------------------------*/


//    获取 玩家任务信息
+ (void)PlayerTaskInfoDataWithDataBlock:(sendData)sendBlock;

//    获取玩家徒弟列表
+ (void)GetPlayerTudiListDataAndPageNum:(int)pagenum WithBlock:(sendData)sendBlock;

//    用户完成任务个数
+ (void)UserFinishTaskNumberDataBlock:(sendData)sendBlock;

//    签到接口
+ (void)SignInNumberDataWithBlock:(sendData)sendBlock;

#pragma mark -------- 用户注册登录接口 --------------
/*------------------- 用户注册登录接口  --------------------------*/

/**
 *    微信登录
 */
+(void)LoginWithParams:(NSDictionary *)params WithDataBlock:(sendData)sendBlock;

/**
 *    微信登录2
 */
+(void)LoginTwoWithParams:(NSDictionary *)params WithDataBlock:(sendData)sendBlock;


/**
 *    获取用户信息 根据审核状态
 */
+(void)downLoadUserDataAndState:(int)ischeck WithBlock:(sendData)sendBlock;

/**
 *    获取用户信息
 */
+(void)downLoadUserDataWithBlock:(sendData)sendBlock;

/**
 *    获取用户信息2
 */
+(void)downLoadUserDataTwoWithDict:(NSDictionary *)params WithBlock:(sendData)sendBlock;





/**
 *    获取验证码接口
 */
+(void)sendVerifitionCodeWithParam:(NSDictionary *)params andDataBlock:(sendData)sendBlock;

/**
 *    手机注册
 */
+ (void)PhoneRegisterWithParam:(NSDictionary *)params andDataBlock:(sendData)sendBlock;

/**
 *    用户历史反馈（有待斟酌）
 */
+ (void)UserHistoryFeedBackDataPagenum:(int )pagenum andDataBlock:(sendData)sendBlock;

/**
 *    用户提交反馈
 */
+ (void)UserFeedBackSubmitData:(NSDictionary *)params andDataBlock:(sendData)sendBlock;

/**
 *    存储热搜词汇
 */
+ (void)HotSearchWordData:(NSString *)wordArr andDataBlock:(sendData)sendBlock;
/**
 *    热搜词汇
 */
+ (void)GetHotSearchWordWithPageNum:(int)pagenum withDataBlock:(sendData)sendBlock;

/**
 * 支付宝提现
 */
+ (void)AlipayGetMoneyWithDataBlock:(sendData)sendBlock;

/**
 * 同步用户数值信息
 */
+ (void)TogetherUserDataWithDataBlock:(sendData)sendBlock;





#pragma mark -------- 宝库模块接口 --------------
/*------------------- 宝库模块接口  --------------------------*/

//    转盘抽奖奖励数据
+ (void)turnTableWinDataParam:(int )ingot andDataBlock:(sendData)sendBlock;

//    领取任务奖励
+ (void)getTaskAwardDataWithBlock:(sendData)sendBlock;

///**
// *    新闻接口
// */
//+ (void)NewsInfoDataWithBlock:(sendData)sendBlock;

/**
 *    新闻新接口
 */
+ (void)NewsInfoNewDataParam:(NSInteger )artid andDireParam:(NSInteger)dire andDataBlock:(sendData)sendBlock;

///**
// *    新闻旧接口
// */
//+ (void)NewsInfoOldDataParam:(NSInteger )artid andDataBlock:(sendData)sendBlock;

/**
 *     科技新接口
 */
+ (void)TecoInfoNewDataParam:(NSInteger )artid andDireParam:(NSInteger)dire andDataBlock:(sendData)sendBlock;

/**
 *    第一财经资讯接口
 */
+ (void)FinanceInfoNewDataParam:(NSInteger )artid andDireParam:(NSInteger)dire andDataBlock:(sendData)sendBlock;

/**
 *    娱乐资讯接口
 */
+ (void)EnterTainInfoNewDataParam:(NSInteger )artid andDireParam:(NSInteger)dire andDataBlock:(sendData)sendBlock;


/*
 *    看完广告回调
 */
+ (void)WatchADBackDataWithParam:(int )articid WithDataBlock:(sendData)sendBlock;

/*
 *    分享应用回调
 */
+ (void)ShareAppBackDataWithDataBlock:(sendData)sendBlock;

/**
 *    笑话接口
 */
+(void)JokesInfoDataWithBlock:(sendData)sendBlock;

/**
 *    元宝明细
 */
+(void)CoinDetailInfoDataWithParam:(int )pagenum andDataBlock:(sendData)sendBlock;

/**
 *    现金明细
 */
+(void)CashDetailInfoDataWithParam:(int )pagenum andDataBlock:(sendData)sendBlock;

/**
 *    欢乐转转转
 */
+(void)HappySlotMachinesDataWithCost:(int )cost andDataBlock:(sendData)sendBlock;

/**
 *    历史上的今天接口
 */
+(void)TodayInfoDataWithPageNum:(int )pagenum andDataBlock:(sendData)sendBlock;

//    商城列表
+(void)ShopListWithParam:(NSDictionary *)params andDataBlock:(sendData)sendBlock;

//    商品详情
+(void)DetailGoodsWithParams:(NSDictionary *)params andDataBlock:(sendData)sendBlock;

//    确认订单
+(void)ConfirmOrderWithParam:(NSDictionary *)param andDataBlock:(sendData)sendBlock;
//    用户购买记录
+(void)UserGetGoodsRecordListDataWithPage:(int)pageNum andDataBlock:(sendData)sendBlock;

//    地址列表
+(void)AddressListWithDataBlock:(sendData)sendBlock;

//    添加地址
+(void)AddAddressWithParams:(NSDictionary *)param andDataBlock:(sendData)sendBlock;

//    删除地址
+(void)DeleteAddressWithID:(NSString *)reapId andDataBlock:(sendData)sendBlock;

/**
 *    老虎机抽奖
 */
+(void)TigerMachineInfoDataWithCost:(int )cost andDataBlock:(sendData)sendBlock;


/**
 
 */
+(void)GetNewsIdDataBlock:(sendData)sendBlock;


/**
 *
 */
+(void)ProjectAddIDDataBlock:(sendData)sendBlock;



#pragma mark -------- 发现模块接口 --------------
/*------------------- 发现模块接口  --------------------------*/
/**
 * 发现总接口
 */
+(void)DiscoverInfoDataBlock:(sendData)sendBlock;
/**
 * 发现小编推荐数据 换一批
 */
+ (void)DiscoverEditRecommendInfoDataBlock:(sendData)sendBlock;

/**
 * 发现上升最快数据 更多
 */
+ (void)DiscoverNewstEnterMoreInfo:(int)pn andDataBlock:(sendData)sendBlock;


/**
 * 发现精选模块数据
 */
+ (void)DiscoverEditSelection:(NSDictionary *)prams andDataBlock:(sendData)sendBlock;


/**
 * 发现今日热文数据
 */
+ (void)DiscoverTodayHotItem:(NSDictionary *)prams andDataBlock:(sendData)sendBlock;

/**
 * 发现获取推荐详情数据
 */
+ (void)DiscoverGetRecommendDetailItem:(int )artid andDataBlock:(sendData)sendBlock;




#pragma mark -------- 测试模块接口 --------------
/*------------------- 测试模块接口  --------------------------*/
/**
 *
 */
+(void)NewsTestRichTestWithCheckNewsID:(NSInteger )checkNewsID WithDataBlock:(sendData)sendBlock;






///**
//*    获取用户信息   根据审核的不同 更改
//*/
//+(void)downLoadUserDataAndState:(int)ischeck WithBlock:(sendData)sendBlock;
//
////转盘原始数据加载
//+(void)turnTableDataWithBlock:(sendData)sendBlock;
//
//+(void)turnTableWinDataWithBlock:(sendData)sendBlock;
//
////签到
//+(void)downLoadSignDataWithBlock:(sendData)sendBlock;
//
////获取用户信息
//+(void)downLoadUserDataWithBlock:(sendData)sendBlock;
//

//
//
//
////拆红包
//+(void)OpenPacketWithDataBlock:(sendData)sendBlock;
//
////获取充值列表
//+(void)ChargeListWithDataBlock:(sendData)sendBlock;
//
//
////商城列表
//+(void)ShopListWithParam:(NSDictionary *)params andDataBlock:(sendData)sendBlock;
//
////商品详情
//+(void)DetailGoodsWithID:(NSString *)goodsID andDataBlock:(sendData)sendBlock;
//
////商品库存
//+(void)InventoryGoodsWithID:(NSString *)goodsID andDataBlock:(sendData)sendBlock;
//
////确认订单
//+(void)ConfirmOrderWithParam:(NSDictionary *)param andDataBlock:(sendData)sendBlock;
//
////地址列表
//+(void)AddressListWithDataBlock:(sendData)sendBlock;
//
////添加地址
//+(void)AddAddressWithParams:(NSDictionary *)param andDataBlock:(sendData)sendBlock;
//
////删除地址
//+(void)DeleteAddressWithID:(NSString *)addressID andDataBlock:(sendData)sendBlock;
//
//
//
////土豪榜
//+(void)TyrantDownWithParam:(NSDictionary *)params DataBlock:(sendData)sendBlock;
//
////充值详情
//+(void)RechargeListWithParam:(NSDictionary *)params DataBlock:(sendData)sendBlock;
//
////抽奖详情
//+(void)AwardListWithParam:(NSDictionary *)params DataBlock:(sendData)sendBlock;
//
////订单详情
//+(void)OrderListWithParam:(NSDictionary *)params DataBlock:(sendData)sendBlock;
//
////分享链接
//+(void)shareWithDataBlock:(sendData)sendBlock;
//
////版本更新
//+(void)versionUpdateWithParam:(NSDictionary *)params DataBlock:(sendData)sendBlock;
//
////我的徒弟
//+(void)ApprenticeListWithParam:(NSDictionary *)params DataBlock:(sendData)sendBlock;
//
//+(void)DepositWithParams:(NSDictionary *)param andDataBlock:(sendData)sendBlock;
//
//+(void)ConfigWithDataBlcok:(sendData)sendBlock;
//
////开屏广告
//+(void)BeginAdverWithDataBlock:(sendData)sendBlock;
//
////任务列表
//+(void)TaskListWithID:(int )page andDataBlock:(sendData)sendBlock;
//
////分享成功
//+(void)ShareSuccessWithType:(int )type andDataBlock:(sendData)sendBlock;
//
////话费充值
//+(void)ChargePhoneWithParams:(NSDictionary *)param andDataBlock:(sendData)sendBlock;
//
////监测订单
//+(void)TestTheOrderWithDataBlock:(sendData)sendBlock;
//
//+(void)ChargeWithMoney:(NSString *)money andDataBlock:(sendData)sendBlock;


@end
