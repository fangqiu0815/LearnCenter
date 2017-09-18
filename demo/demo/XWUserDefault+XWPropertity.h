//
//  XWUserDefault+XWPropertity.h
//  zhangshangPacket
//
//  Created by apple on 2017/5/15.
//  Copyright © 2017年 apple-fangqiu. All rights reserved.
//

#import "XWUserDefault.h"

#define STUserDefaults [XWUserDefault standardUserDefaults]

@interface XWUserDefault (XWPropertity)

/** 版本号 */
/** 登陆状态 */
@property(nonatomic,assign)BOOL isLogin;
/** uid **/
@property (nonatomic, copy) NSString *uid;

@property (nonatomic, copy) NSString *phonenum;

@property (nonatomic, copy) NSString *img;

@property (nonatomic, assign) NSInteger logtime;

@property (nonatomic, copy) NSString *masname;

@property (nonatomic, copy) NSString *token;

@property (nonatomic, copy) NSString *name;

@property (nonatomic, assign) NSInteger signstate;

@property (nonatomic, assign) NSInteger serialsign;

@property (nonatomic, copy) NSString *advs_pre;//广告地址前缀

@property (nonatomic, copy) NSString *goods_pre;//物品图片地址前缀

@property (nonatomic, copy) NSString *mf_pre;

@property (nonatomic, copy) NSString *partnerid;

@property (nonatomic, copy) NSString *applyid;

@property (nonatomic, copy) NSString *secret;

@property (nonatomic, copy) NSString *discount;

@property (nonatomic, assign) BOOL sharestate;

@property (nonatomic, assign) int prepaidmonth;

@property (nonatomic, copy) NSString *orderid;

@property (nonatomic, strong) NSMutableArray *callArr;

@property (nonatomic, strong) NSMutableArray *funcs;

@property (nonatomic, assign) BOOL hiddenAdSDK;

@property (nonatomic, assign) int adNeedUpdata;

@property (nonatomic, assign) int rewardNeedUpdata;

@property (nonatomic, assign) int rechNeedUpdate;
/**
        提现公告
 */
@property (nonatomic, copy) NSArray *adArr;

@property (nonatomic, copy) NSMutableArray *rewardArr;

@property (nonatomic, copy) NSMutableArray *rechArr;

@property(nonatomic,strong)NSString *pagedesc;

@property (nonatomic, strong) NSString *signImage;

@property (nonatomic, strong) NSString *notSignImage;

@property (nonatomic, copy) NSString *channel;

@property (nonatomic, copy) NSArray *taskListArr;

/**
 * 今日余额

 */
@property(nonatomic, copy)  NSString *cash;
/**
 * 昨日收益
 
 */
@property(nonatomic, copy)  NSString *cashyes;
/**
 * 今日收益
 
 */
@property(nonatomic, copy)  NSString *cashtoday;

/**
 * 累积收益
 
 */
@property(nonatomic, copy)  NSString *cashtotal;


/**
 * 累计提现
 
 */
@property(nonatomic, copy)  NSString *cashconver;
/**
 * 元宝个数
 
 */
@property(nonatomic, assign)  NSInteger ingot;
/**
 * 是否分享
 
 */
@property(nonatomic, assign)  BOOL  isshare;
/**
 * 完成任务数
 
 */
@property(nonatomic, assign)  NSInteger tasknum;
/**
 * 可领取任务奖励
 
 */
@property(nonatomic, assign)  BOOL isreward;
/**
 * 徒弟人数
 
 */
@property(nonatomic, assign)  NSInteger disciple;
/**
 * 收徒收益
 
 */
@property(nonatomic, assign)  NSInteger disciplefee;

/**
 * ischeck
 */
@property(nonatomic, assign) NSInteger ischeck;

/**
 * sysversion
 */
@property(nonatomic, copy) NSString *sysversion;

/**
 * taskversion
 */
@property(nonatomic, copy) NSString *taskversion;

/**
 * wheeldrawversion
 */
@property(nonatomic,copy) NSString *wheeldrawversion;

/**
 * htmlurl
 */
@property(nonatomic,copy)NSString *htmlurl;//URLheader

/**
 * imgurlpre
 */
@property (nonatomic, copy) NSString *imgurlpre;

/**
 * mainfuncs
 */
@property(nonatomic, copy) NSMutableArray *mainfuncs;

/**
 * mainfuncsID
 */
@property(nonatomic, copy) NSMutableArray *mainfuncsID;

/**
 * bottomfunc
 */
@property(nonatomic, copy) NSMutableArray *bottomfunc;

/**
 * bottomfuncID
 */
@property(nonatomic, copy) NSMutableArray *bottomfuncID;

/**
 * treasurefuncs
 */
@property(nonatomic, copy) NSMutableArray *treasurefuncs;

/**
 * costingot
 */
@property(nonatomic, assign) NSInteger costingot;

/**
 * shareurl
 */
@property(nonatomic, copy) NSString *shareurl;

/**
 *  经纬度
 */
@property (nonatomic, copy) NSString *longitude;

@property (nonatomic, copy) NSString *latitude;


//一次老虎机消耗人民币单位分

@property (nonatomic, copy) NSString *slotrmb;

/**
 * slotcnfversion
 */
@property(nonatomic, copy) NSString *slotcnfversion;

/**
 * typedescversion
 */
@property(nonatomic, copy) NSString *typedescversion;

/**
 * 完成任务个数
 */
@property(nonatomic, assign) NSInteger rewardNum;;

/**
 * 签到状态
 */
@property(nonatomic, assign) BOOL issign;

/**
 * 二维码
 */
@property(nonatomic, copy) NSString *inviteCode;

/**
 * 是否加固
 */
@property(nonatomic, assign) NSInteger empudid;

/**
 * 是否弹出通知界面
 */
@property(nonatomic, assign) BOOL boundwx;

/**
 * shebeiweiyiid
 */
@property(nonatomic, copy) NSString *shebeiID;


/**
 * isnight
 */
@property(nonatomic, assign) BOOL isnight;


///**
// * 是否更新系统任务
// */
//@property(nonatomic, assign) BOOL isUpdateSysTask;
//
///**
// * 是否更新转盘数据
// */
//@property(nonatomic, assign) BOOL isUpdateSysWheelInfo;
//
///**
// * 是否更新明细描述信息
// */
//@property(nonatomic, assign) BOOL isUpdateSysDetailConfig;


/**
 * 提现列表
 */
@property(nonatomic, copy) NSMutableArray *converlist;

/**
 * serviceqq
 */
@property(nonatomic, copy) NSString *serviceqq;

/**
 * 二维码分享地址
 */
@property(nonatomic, copy) NSString *codeShareUrl;

@property (nonatomic, copy) NSString *mgString;

@property (nonatomic, assign) NSInteger sendTurnIngotToMine;

/**
 * 版本描述信息
 */
@property(nonatomic, copy) NSString *versiondesc;


/**
 * 红包图标 事件跳转地址 跳转内部浏览器
 */
@property(nonatomic, copy ) NSString *eventurl;

/**
 * 已经加固了
 */
@property(nonatomic, assign) NSInteger isJiagu;

/**
 * 关注移除中间关注view
 */
@property(nonatomic, assign) NSInteger isRemoveView;

/**
 * 用户选择的频道页面
 */
@property(nonatomic, copy) NSMutableArray *userChannels;

/**
 * 第一次选择的频道页面
 */
@property(nonatomic, copy) NSMutableArray *firstChoseChannels;





@end
