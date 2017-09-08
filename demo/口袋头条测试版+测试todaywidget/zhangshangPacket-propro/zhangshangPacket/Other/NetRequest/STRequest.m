//
//  STRequest.m
//  CrazyPacket
//
//  Created by WuYanZu on 17/2/20.
//  Copyright © 2017年 WuYanZu. All rights reserved.
//



#import "STRequest.h"

@implementation STRequest

+(NSString *)spellUrl:(NSString *)tempUrl
{
    NSString *udid = DeviceInfo_shared->_value();
    
    if ([udid isEqualToString:@"a4d2f177eb466a7d08f8f2b340b77129"]) {
        if (STUserDefaults.shebeiID == nil) {
            //[STUserDefaults.shebeiID isEqualToString:@"(null)"]
            udid = DeviceInfo_shared->_value();
        }else{
            udid = STUserDefaults.shebeiID;
            JLLog(@"udid---%@",udid);
        }
    } else {
        udid = DeviceInfo_shared->_value();
    }
    
    NSString *idfa = DeviceInfo_shared->getIDFA();
    
    NSString *idfv = DeviceInfo_shared->getAPPIDFV();
    
    NSTimeInterval interval = [[NSDate date] timeIntervalSince1970] ;
    
    NSString * urlStr;
    if (STUserDefaults.token == nil)
    {
        STUserDefaults.token = @"";
    }
    if (STUserDefaults.uid == nil)
    {
        STUserDefaults.uid = @"";
    }
    if (SYS_NEWS_VERSION == nil)
    {
        [SYS_NEWS_VERSION  isEqualToString: @""];
    }
    
    
//    STUserDefaults.uid = @"35";
//    STUserDefaults.version = @"1.0.0";
//    STUserDefaults.token = @"28177d8f8f5b94c685d3206ae8749a39";
    
    urlStr =  [NSString stringWithFormat:@"%@udid=%@&idfa=%@&s=%d&idfv=%@&version=%@&uid=%@&token=%@",tempUrl,udid,idfa,(int)interval,idfv,SYS_NEWS_VERSION,STUserDefaults.uid,STUserDefaults.token];
    JLLog(@"urlStr = %@",urlStr);
    
    return urlStr;
}

#pragma mark -------- 配置信息接口--------------
/*------------------  配置信息接口  -------------------*/

//配置信息接口
+ (void)SysInfoDataWithDataBlock:(sendData )sendBlock
{
    STAFNetWorking *networking = [[STAFNetWorking alloc]init];
    
    [networking requsetWithPath:[self spellUrl:@"syscnf.php?"] Withparams:nil withRequestType:NetworkPostType withResult:^(id responseObject, NSError *error) {
        
        if (!error) {
            NSDictionary *dataDic = (NSDictionary *)responseObject;
            sendBlock(dataDic,YES);
        }else{
            sendBlock(error,NO);
        }
    }];
    
}

//系统任务接口
+ (void)SysTaskInfoDataWithDataBlock:(sendData)sendBlock
{
    STAFNetWorking *networking = [[STAFNetWorking alloc]init];
    
    [networking requsetWithPath:[self spellUrl:@"taskcnf.php?"] Withparams:nil withRequestType:NetworkPostType withResult:^(id responseObject, NSError *error) {
        
        if (!error) {
            NSDictionary *dataDic = (NSDictionary *)responseObject;
            sendBlock(dataDic,YES);
        }else{
            sendBlock(error,NO);
        }
    }];
}

//    转盘原始数据加载
+ (void)SysWheelDrawWinWithDataBlock:(sendData)sendBlock
{
    STAFNetWorking *networking = [[STAFNetWorking alloc]init];
    
    [networking requsetWithPath:[self spellUrl:@"wheeldrawcnf.php?"] Withparams:nil withRequestType:NetworkPostType withResult:^(id responseObject, NSError *error) {
        
        if (!error){
            NSDictionary *dataDic = (NSDictionary *)responseObject;
            //NSLog(@"======%@========%@",dataDic,error);
            sendBlock(dataDic,YES);
        }else{
            sendBlock(error,NO);
        }
    }];
}

//    开心转转转数据配置信息
+ (void)SysHappyTurnDataWithDataBlock:(sendData)sendBlock
{
    STAFNetWorking *networking = [[STAFNetWorking alloc]init];
    
    [networking requsetWithPath:[self spellUrl:@"configslotmachines.php?"] Withparams:nil withRequestType:NetworkPostType withResult:^(id responseObject, NSError *error) {
        
        if (!error){
            NSDictionary *dataDic = (NSDictionary *)responseObject;
            //NSLog(@"======%@========%@",dataDic,error);
            sendBlock(dataDic,YES);
        }else{
            sendBlock(error,NO);
        }
    }];

}

//    明细类型描述配置信息
+ (void)SysConfigDetainesDataWithDataBlock:(sendData)sendBlock
{
    STAFNetWorking *networking = [[STAFNetWorking alloc]init];
    
    [networking requsetWithPath:[self spellUrl:@"configdetaindes.php?"] Withparams:nil withRequestType:NetworkPostType withResult:^(id responseObject, NSError *error) {
        
        if (!error){
            NSDictionary *dataDic = (NSDictionary *)responseObject;
            //NSLog(@"======%@========%@",dataDic,error);
            sendBlock(dataDic,YES);
        }else{
            sendBlock(error,NO);
        }
    }];

}

//    反馈问题类型数据
+(void)feedBackTypeDataWithBlock:(sendData)sendBlock
{
    STAFNetWorking *networking = [[STAFNetWorking alloc]init];
    
    [networking requsetWithPath:[self spellUrl:@"feedbacktype.php?"] Withparams:nil withRequestType:NetworkPostType withResult:^(id responseObject, NSError *error) {
        
        if (!error){
            NSDictionary *dataDic = (NSDictionary *)responseObject;
            //NSLog(@"======%@========%@",dataDic,error);
            sendBlock(dataDic,YES);
        }else{
            sendBlock(error,NO);
        }
    }];
}

//    开屏广告
+(void)firstADDataWithBlock:(sendData )sendBlock{
    STAFNetWorking *networking = [[STAFNetWorking alloc]init];
    
    [networking requsetWithPath:[self spellUrl:@"startadv.php?"] Withparams:nil withRequestType:NetworkPostType withResult:^(id responseObject, NSError *error) {
        
        if (!error){
            NSDictionary *dataDic = (NSDictionary *)responseObject;
            //NSLog(@"======%@========%@",dataDic,error);
            sendBlock(dataDic,YES);
        }else{
            sendBlock(error,NO);
        }
    }];
    
}


#pragma mark -------- 系统消息接口--------------
/*------------------  系统消息接口  -------------------*/

//     系统公告
+(void)SysNoticeDataWithDataBlock:(sendData)sendBlock
{
    STAFNetWorking *networking = [[STAFNetWorking alloc]init];
    
    [networking requsetWithPath:[self spellUrl:@"sysnotice.php?"] Withparams:nil withRequestType:NetworkPostType withResult:^(id responseObject, NSError *error) {
        
        if (!error) {
            NSDictionary *dataDic = (NSDictionary *)responseObject;
            //NSLog(@"======%@========%@",dataDic,error);
            sendBlock(dataDic,YES);
        }else{
            sendBlock(error,NO);
        }
    }];
    
}

//     系统提现信息
+(void)SysPersonConverDataWithDataBlock:(sendData)sendBlock
{
    STAFNetWorking *networking = [[STAFNetWorking alloc]init];
    
    [networking requsetWithPath:[self spellUrl:@"conver.php?"] Withparams:nil withRequestType:NetworkPostType withResult:^(id responseObject, NSError *error) {
        
        if (!error) {
            NSDictionary *dataDic = (NSDictionary *)responseObject;
            //NSLog(@"======%@========%@",dataDic,error);
            sendBlock(dataDic,YES);
        }else{
            sendBlock(error,NO);
        }
    }];
}

+ (void)SysClientlogDataWithDataBlock:(sendData)sendBlock
{
    STAFNetWorking *networking = [[STAFNetWorking alloc]init];
    
    [networking requsetWithPath:[self spellUrl:@"conver.php?"] Withparams:nil withRequestType:NetworkPostType withResult:^(id responseObject, NSError *error) {
        
        if (!error) {
            NSDictionary *dataDic = (NSDictionary *)responseObject;
            //NSLog(@"======%@========%@",dataDic,error);
            sendBlock(dataDic,YES);
        }else{
            sendBlock(error,NO);
        }
        
    }];

}

#pragma mark -------- 任务模块接口 --------------
/*------------------  任务模块接口  -------------------*/

//      获取 玩家任务信息
+(void)PlayerTaskInfoDataWithDataBlock:(sendData)sendBlock
{
    STAFNetWorking *networking = [[STAFNetWorking alloc]init];
    
    [networking requsetWithPath:[self spellUrl:@"usertask.php?"] Withparams:nil withRequestType:NetworkPostType withResult:^(id responseObject, NSError *error) {
        
        if (!error) {
            NSDictionary *dataDic = (NSDictionary *)responseObject;
            //NSLog(@"======%@========%@",dataDic,error);
            sendBlock(dataDic,YES);
        }else{
            sendBlock(error,NO);
        }
    }];
}

/**
 *       师徒列表
 */

+(void)GetPlayerTudiListDataAndPageNum:(int)pagenum WithBlock:(sendData)sendBlock{
    
    STAFNetWorking *networking = [[STAFNetWorking alloc]init];
    NSDictionary *param = @{@"pagenum":@(pagenum)};
    [networking requsetWithPath:[self spellUrl:@"disciplelist.php?"] Withparams:param withRequestType:NetworkPostType withResult:^(id responseObject, NSError *error) {
        if (!error) {
            NSDictionary *dataDic = (NSDictionary *)responseObject;
            sendBlock(dataDic,YES);
        }else{
            sendBlock(error,NO);
        }
    }];
    
}


//    用户完成任务个数
+ (void)UserFinishTaskNumberDataBlock:(sendData)sendBlock
{

    STAFNetWorking *networking = [[STAFNetWorking alloc]init];
    [networking requsetWithPath:[self spellUrl:@"usertaskrewardnum.php?"] Withparams:nil withRequestType:NetworkPostType withResult:^(id responseObject, NSError *error) {
        
        if (!error) {
            NSDictionary *dataDic = (NSDictionary *)responseObject;
            //NSLog(@"======%@========%@",dataDic,error);
            sendBlock(dataDic,YES);
        }else{
            sendBlock(error,NO);
        }
    }];

}

//    签到接口
+ (void)SignInNumberDataWithBlock:(sendData)sendBlock
{

    STAFNetWorking *networking = [[STAFNetWorking alloc]init];
    [networking requsetWithPath:[self spellUrl:@"usersign.php?"] Withparams:nil withRequestType:NetworkPostType withResult:^(id responseObject, NSError *error) {
        
        if (!error) {
            NSDictionary *dataDic = (NSDictionary *)responseObject;
            //NSLog(@"======%@========%@",dataDic,error);
            sendBlock(dataDic,YES);
        }else{
            sendBlock(error,NO);
        }
    }];

}

#pragma mark -------- 用户注册登录接口 --------------
/*------------------  用户注册登录接口  -------------------*/

/**
 *        微信登录
 */
+(void)LoginWithParams:(NSDictionary *)params WithDataBlock:(sendData)sendBlock
{
    
    STAFNetWorking *networking = [[STAFNetWorking alloc]init];
   //
    [networking requsetWithPath:[self spellUrl:@"reglogin.php?"] Withparams:params withRequestType:NetworkPostType withResult:^(id responseObject, NSError *error) {
        
        if (!error) {
            NSDictionary *dataDic = (NSDictionary *)responseObject;
//            NSLog(@"======%@========%@",dataDic,error);

            sendBlock(dataDic,YES);
        }else{
            sendBlock(error,NO);
        }
    }];
}

/**
 *    微信登录2
 */
+(void)LoginTwoWithParams:(NSDictionary *)params WithDataBlock:(sendData)sendBlock{

    STAFNetWorking *networking = [[STAFNetWorking alloc]init];
    //
    [networking requsetWithPath:[self spellUrl:@"reglogin2.php?"] Withparams:params withRequestType:NetworkPostType withResult:^(id responseObject, NSError *error) {
        
        if (!error) {
            NSDictionary *dataDic = (NSDictionary *)responseObject;
            //            NSLog(@"======%@========%@",dataDic,error);
            
            sendBlock(dataDic,YES);
        }else{
            sendBlock(error,NO);
        }
    }];

}



/**
 *    获取用户信息2
 */
+(void)downLoadUserDataTwoWithDict:(NSDictionary *)params WithBlock:(sendData)sendBlock{
    STAFNetWorking *networking = [[STAFNetWorking alloc]init];
    
    [networking requsetWithPath:[self spellUrl:@"userinfo2.php?"] Withparams:params withRequestType:NetworkPostType withResult:^(id responseObject, NSError *error) {
        
        if (!error){
            NSDictionary *dataDic = (NSDictionary *)responseObject;
            //NSLog(@"======%@========%@",dataDic,error);
            sendBlock(dataDic,YES);
        }else{
            sendBlock(error,NO);
        }
    }];

}






/**
 *        获取用户信息   根据审核的不同 更改
 */
+(void)downLoadUserDataAndState:(int)ischeck WithBlock:(sendData)sendBlock
{
    
    STAFNetWorking *networking = [[STAFNetWorking alloc]init];
    NSDictionary *param = @{@"ischeck":@(ischeck)};
    
    [networking requsetWithPath:[self spellUrl:@"userinfo.php?"] Withparams:param withRequestType:NetworkPostType withResult:^(id responseObject, NSError *error) {
        
        if (!error){
            NSDictionary *dataDic = (NSDictionary *)responseObject;
            //NSLog(@"======%@========%@",dataDic,error);
            sendBlock(dataDic,YES);
        }else{
            sendBlock(error,NO);
        }
    }];
    
}

/**
 *         获取用户信息   根据审核的不同 更改
 */
+(void)downLoadUserDataWithBlock:(sendData)sendBlock
{
    
    STAFNetWorking *networking = [[STAFNetWorking alloc]init];
    // NSDictionary *param = @{@"ischeck":@(ischeck)};
    
    
    [networking requsetWithPath:[self spellUrl:@"userinfo.php?"] Withparams:nil withRequestType:NetworkPostType withResult:^(id responseObject, NSError *error) {
        
        if (!error){
            NSDictionary *dataDic = (NSDictionary *)responseObject;
            //NSLog(@"======%@========%@",dataDic,error);
            sendBlock(dataDic,YES);
        }else{
            sendBlock(error,NO);
        }
    }];
    
}

/**
 *        获取验证码接口
 */
+(void)sendVerifitionCodeWithParam:(NSDictionary *)params andDataBlock:(sendData)sendBlock
{
    STAFNetWorking *networking = [[STAFNetWorking alloc]init];
    
    [networking requsetWithPath:[self spellUrl:@"getphonecode.php?"] Withparams:params withRequestType:NetworkPostType withResult:^(id responseObject, NSError *error) {
        
        if (!error){
            NSDictionary *dataDic = (NSDictionary *)responseObject;
            //NSLog(@"======%@========%@",dataDic,error);
            sendBlock(dataDic,YES);
        }else{
            sendBlock(error,NO);
        }
    }];

}

///**
// *        验证验证码
// */
//+(void)VerifitionTheCodeWithParam:(NSDictionary *)params andDataBlock:(sendData)sendBlock
//{
//    STAFNetWorking *networking = [[STAFNetWorking alloc]init];
//    
//    [networking requsetWithPath:[self spellUrl:@"regphone.php?"] Withparams:params withRequestType:NetworkPostType withResult:^(id responseObject, NSError *error) {
//        
//        if (!error){
//            NSDictionary *dataDic = (NSDictionary *)responseObject;
//            //NSLog(@"======%@========%@",dataDic,error);
//            sendBlock(dataDic,YES);
//        }else{
//            sendBlock(error,NO);
//        }
//    }];
//
//}

/**
 *         手机注册
 */
+ (void)PhoneRegisterWithParam:(NSDictionary *)params andDataBlock:(sendData)sendBlock
{
    STAFNetWorking *networking = [[STAFNetWorking alloc]init];
    
    [networking requsetWithPath:[self spellUrl:@"regphone.php?"] Withparams:params withRequestType:NetworkPostType withResult:^(id responseObject, NSError *error) {
        
        if (!error){
            NSDictionary *dataDic = (NSDictionary *)responseObject;
            //NSLog(@"======%@========%@",dataDic,error);
            sendBlock(dataDic,YES);
        }else{
            sendBlock(error,NO);
        }
    }];

}

/**
 *        用户历史反馈（有待斟酌）
 */
+ (void)UserHistoryFeedBackDataPagenum:(int )pagenum andDataBlock:(sendData)sendBlock
{
    STAFNetWorking *networking = [[STAFNetWorking alloc]init];
    NSDictionary *param = @{@"pagenum":@(pagenum)};
    [networking requsetWithPath:[self spellUrl:@"hisfeedback.php?"] Withparams:param withRequestType:NetworkPostType withResult:^(id responseObject, NSError *error) {
        
        if (!error){
            NSDictionary *dataDic = (NSDictionary *)responseObject;
            //NSLog(@"======%@========%@",dataDic,error);
            sendBlock(dataDic,YES);
        }else{
            sendBlock(error,NO);
        }
    }];
    
}

/**
 *         用户提交反馈
 */
+ (void)UserFeedBackSubmitData:(NSDictionary *)params andDataBlock:(sendData)sendBlock
{
    STAFNetWorking *networking = [[STAFNetWorking alloc]init];
    [networking requsetWithPath:[self spellUrl:@"userfeedback.php?"] Withparams:params withRequestType:NetworkPostType withResult:^(id responseObject, NSError *error) {
        
        if (!error){
            NSDictionary *dataDic = (NSDictionary *)responseObject;
            //NSLog(@"======%@========%@",dataDic,error);
            sendBlock(dataDic,YES);
        }else{
            sendBlock(error,NO);
        }
    }];

}

/**
 *         存储热搜词汇
 */
+ (void)HotSearchWordData:(NSString *)wordArr andDataBlock:(sendData)sendBlock
{
    STAFNetWorking *networking = [[STAFNetWorking alloc]init];
    
    NSDictionary *params = @{
                             @"word":wordArr
                             };
    
    [networking requsetWithPath:[self spellUrl:@"searchword.php?"] Withparams:params withRequestType:NetworkPostType withResult:^(id responseObject, NSError *error) {
        
        if (!error){
            NSDictionary *dataDic = (NSDictionary *)responseObject;
            //NSLog(@"======%@========%@",dataDic,error);
            sendBlock(dataDic,YES);
        }else{
            sendBlock(error,NO);
        }
    }];

}

/**
 *    热搜词汇
 */
+ (void)GetHotSearchWordWithPageNum:(int)pagenum withDataBlock:(sendData)sendBlock
{

    STAFNetWorking *networking = [[STAFNetWorking alloc]init];
    
    NSDictionary *params = @{
                             @"pagenum":@(pagenum)
                             };
    
    [networking requsetWithPath:[self spellUrl:@"hotwords.php?"] Withparams:params withRequestType:NetworkPostType withResult:^(id responseObject, NSError *error) {
        
        if (!error){
            NSDictionary *dataDic = (NSDictionary *)responseObject;
            //NSLog(@"======%@========%@",dataDic,error);
            sendBlock(dataDic,YES);
        }else{
            sendBlock(error,NO);
        }
    }];

}

/**
 * 支付宝提现
 */
+ (void)AlipayGetMoneyWithDataBlock:(sendData)sendBlock
{
    STAFNetWorking *networking = [[STAFNetWorking alloc]init];
    [networking requsetWithPath:[self spellUrl:@"duibastore.php?"] Withparams:nil withRequestType:NetworkPostType withResult:^(id responseObject, NSError *error) {
        
        if (!error){
            NSDictionary *dataDic = (NSDictionary *)responseObject;
            //NSLog(@"======%@========%@",dataDic,error);
            sendBlock(dataDic,YES);
        }else{
            sendBlock(error,NO);
        }
    }];


}

/**
 * 同步用户数值信息
 */
+ (void)TogetherUserDataWithDataBlock:(sendData)sendBlock
{
    STAFNetWorking *networking = [[STAFNetWorking alloc]init];
    [networking requsetWithPath:[self spellUrl:@"checkuserdata.php?"] Withparams:nil withRequestType:NetworkPostType withResult:^(id responseObject, NSError *error) {
        
        if (!error){
            NSDictionary *dataDic = (NSDictionary *)responseObject;
            //NSLog(@"======%@========%@",dataDic,error);
            sendBlock(dataDic,YES);
        }else{
            sendBlock(error,NO);
        }
        
    }];


}


#pragma mark -------- 宝库模块接口 --------------
/*------------------  宝库模块接口  -------------------*/

//         转盘抽奖奖励数据
+ (void)turnTableWinDataParam:(int )ingot andDataBlock:(sendData)sendBlock
{
    STAFNetWorking *networking = [[STAFNetWorking alloc]init];
    NSDictionary *param = @{@"ingot":@(ingot)};
    [networking requsetWithPath:[self spellUrl:@"wheeldrawinfo.php?"] Withparams:param withRequestType:NetworkPostType withResult:^(id responseObject, NSError *error) {
        
        if (!error){
            NSDictionary *dataDic = (NSDictionary *)responseObject;
            //NSLog(@"======%@========%@",dataDic,error);
            sendBlock(dataDic,YES);
        }else{
            sendBlock(error,NO);
        }
    }];
    
}

//         领取任务奖励
+ (void)getTaskAwardDataWithBlock:(sendData)sendBlock
{

    STAFNetWorking *networking = [[STAFNetWorking alloc]init];
    [networking requsetWithPath:[self spellUrl:@"taskreward.php?"] Withparams:nil withRequestType:NetworkPostType withResult:^(id responseObject, NSError *error) {
        
        if (!error){
            NSDictionary *dataDic = (NSDictionary *)responseObject;
            //NSLog(@"======%@========%@",dataDic,error);
            sendBlock(dataDic,YES);
        }else{
            sendBlock(error,NO);
        }
    }];
}

/**
 *         新闻接口
 */
+(void)NewsInfoDataWithBlock:(sendData)sendBlock{
    STAFNetWorking *networking = [[STAFNetWorking alloc]init];
    
    NSDictionary *params = @{
                             @"artid":@(0)
                             };
    
    [networking requsetWithPath:[self spellUrl:@"cachesysnews.php?"] Withparams:params withRequestType:NetworkPostType withResult:^(id responseObject, NSError *error) {
        if (!error) {
            NSDictionary *dataDic = (NSDictionary *)responseObject;
            sendBlock(dataDic,YES);
        }else{
            sendBlock(error,NO);
        }
    }];

}

/**
 *         新闻新接口
 */
+ (void)NewsInfoNewDataParam:(NSInteger )artid andDireParam:(NSInteger)dire andDataBlock:(sendData)sendBlock{
    STAFNetWorking *networking = [[STAFNetWorking alloc]init];
    
    NSDictionary *params = @{
                             @"dire":@(dire),
                             @"artid":@(artid)
                             };
    
    [networking requsetWithPath:[self spellUrl:@"cachesysnews.php?"] Withparams:params withRequestType:NetworkPostType withResult:^(id responseObject, NSError *error) {
        if (!error) {
            NSDictionary *dataDic = (NSDictionary *)responseObject;
            sendBlock(dataDic,YES);
        }else{
            sendBlock(error,NO);
        }
    }];
    
}


/**
 *    科技新接口
 */
+ (void)TecoInfoNewDataParam:(NSInteger )artid andDireParam:(NSInteger)dire andDataBlock:(sendData)sendBlock
{
    STAFNetWorking *networking = [[STAFNetWorking alloc]init];

    NSDictionary *params = @{
                             @"dire":@(dire),
                             @"artid":@(artid)
                             };
    
    [networking requsetWithPath:[self spellUrl:@"kdtech.php?"] Withparams:params withRequestType:NetworkPostType withResult:^(id responseObject, NSError *error) {
        if (!error) {
            NSDictionary *dataDic = (NSDictionary *)responseObject;
            sendBlock(dataDic,YES);
        }else{
            sendBlock(error,NO);
        }
    }];
}

/**
 *    第一财经资讯新接口
 */
+ (void)FinanceInfoNewDataParam:(NSInteger )artid andDireParam:(NSInteger)dire andDataBlock:(sendData)sendBlock
{
    STAFNetWorking *networking = [[STAFNetWorking alloc]init];
    
    NSDictionary *params = @{
                             @"dire":@(dire),
                             @"artid":@(artid)
                             };
    
    [networking requsetWithPath:[self spellUrl:@"kdfinance.php?"] Withparams:params withRequestType:NetworkPostType withResult:^(id responseObject, NSError *error) {
        if (!error) {
            NSDictionary *dataDic = (NSDictionary *)responseObject;
            sendBlock(dataDic,YES);
        }else{
            sendBlock(error,NO);
        }
    }];
}

+ (void)EnterTainInfoNewDataParam:(NSInteger )artid andDireParam:(NSInteger)dire andDataBlock:(sendData)sendBlock{
    STAFNetWorking *networking = [[STAFNetWorking alloc]init];
    
    NSDictionary *params = @{
                             @"dire":@(dire),
                             @"artid":@(artid)
                             };
    
    [networking requsetWithPath:[self spellUrl:@"kddisport.php?"] Withparams:params withRequestType:NetworkPostType withResult:^(id responseObject, NSError *error) {
        if (!error) {
            NSDictionary *dataDic = (NSDictionary *)responseObject;
            sendBlock(dataDic,YES);
        }else{
            sendBlock(error,NO);
        }
    }];

}


/**
 *         新闻旧接口
 */
+ (void)NewsInfoOldDataParam:(NSInteger )artid andDataBlock:(sendData)sendBlock{
    STAFNetWorking *networking = [[STAFNetWorking alloc]init];
    
    NSDictionary *params = @{
                             @"dire":@(0),
                             @"artid":@(artid)
                             };
    
    [networking requsetWithPath:[self spellUrl:@"cachesysnews.php?"] Withparams:params withRequestType:NetworkPostType withResult:^(id responseObject, NSError *error) {
        if (!error) {
            NSDictionary *dataDic = (NSDictionary *)responseObject;
            sendBlock(dataDic,YES);
        }else{
            sendBlock(error,NO);
        }
    }];
    
}



/*
 *    看完广告回调
 */
+ (void)WatchADBackDataWithParam:(int )articid WithDataBlock:(sendData)sendBlock
{
    STAFNetWorking *networking = [[STAFNetWorking alloc]init];
    
    NSDictionary *params = @{
                             @"articid":@(articid),
                             @"longitude":STUserDefaults.longitude,
                             @"latitude":STUserDefaults.latitude
                            };
    
    [networking requsetWithPath:[self spellUrl:@"advtaskrecover.php?"] Withparams:params withRequestType:NetworkPostType withResult:^(id responseObject, NSError *error) {
        
        if (!error){
            NSDictionary *dataDic = (NSDictionary *)responseObject;
            //NSLog(@"======%@========%@",dataDic,error);
            sendBlock(dataDic,YES);
        }else{
            sendBlock(error,NO);
        }
    }];

}

/*
 *    分享应用回调
 */
+ (void)ShareAppBackDataWithDataBlock:(sendData)sendBlock
{
    STAFNetWorking *networking = [[STAFNetWorking alloc]init];
    
    [networking requsetWithPath:[self spellUrl:@"sharerecover.php?"] Withparams:nil withRequestType:NetworkPostType withResult:^(id responseObject, NSError *error) {
        
        if (!error){
            NSDictionary *dataDic = (NSDictionary *)responseObject;
            //NSLog(@"======%@========%@",dataDic,error);
            sendBlock(dataDic,YES);
        }else{
            sendBlock(error,NO);
        }
    }];


}



///**
// *  看完广告回调
// */
//+(void)LookADAfterDataWithParam:(int)articid andDataBlock:(sendData)sendBlock
//{
//    STAFNetWorking *networking = [[STAFNetWorking alloc]init];
//    NSDictionary *param = @{@"articid":@(articid),
//                            @"longitude":STUserDefaults.longitude,
//                            @"latitude":STUserDefaults.latitude
//                            
//                            };
//    
//    [networking requsetWithPath:[self spellUrl:@"advtaskrecover.php?"] Withparams:param withRequestType:NetworkPostType withResult:^(id responseObject, NSError *error) {
//        
//        if (!error){
//            NSDictionary *dataDic = (NSDictionary *)responseObject;
//            //NSLog(@"======%@========%@",dataDic,error);
//            sendBlock(dataDic,YES);
//        }else{
//            sendBlock(error,NO);
//        }
//    }];
//    
//    
//}


/**
 *    笑话接口
 */
+(void)JokesInfoDataWithBlock:(sendData)sendBlock{
    STAFNetWorking *networking = [[STAFNetWorking alloc]init];
    
    [networking requsetWithPath:[self spellUrl:@"kdjokes.php?"] Withparams:nil withRequestType:NetworkPostType withResult:^(id responseObject, NSError *error) {
        if (!error) {
            NSDictionary *dataDic = (NSDictionary *)responseObject;
            sendBlock(dataDic,YES);
        }else{
            sendBlock(error,NO);
        }
    }];
    
}
/*-----------  明细接口  ------*/
//      元宝
+(void)CoinDetailInfoDataWithParam:(int )pagenum andDataBlock:(sendData)sendBlock
{
    STAFNetWorking *networking = [[STAFNetWorking alloc]init];
    NSDictionary *param = @{
                            @"pagenum":@(pagenum),
                            @"stype":@(0)
                            };
    [networking requsetWithPath:[self spellUrl:@"detainingtofen.php?"] Withparams:param withRequestType:NetworkPostType withResult:^(id responseObject, NSError *error) {
        
        if (!error){
            NSDictionary *dataDic = (NSDictionary *)responseObject;
            //NSLog(@"======%@========%@",dataDic,error);
            sendBlock(dataDic,YES);
        }else{
            sendBlock(error,NO);
        }
        
    }];
    
}

//      现金
+(void)CashDetailInfoDataWithParam:(int )pagenum andDataBlock:(sendData)sendBlock
{
    STAFNetWorking *networking = [[STAFNetWorking alloc]init];
    NSDictionary *param = @{
                            @"pagenum":@(pagenum),
                            @"stype":@(1)
                            };
    [networking requsetWithPath:[self spellUrl:@"detainingtofen.php?"] Withparams:param withRequestType:NetworkPostType withResult:^(id responseObject, NSError *error) {
        
        if (!error){
            NSDictionary *dataDic = (NSDictionary *)responseObject;
            //NSLog(@"======%@========%@",dataDic,error);
            sendBlock(dataDic,YES);
        }else{
            sendBlock(error,NO);
        }
        
    }];
    
}

/**
 *    欢乐转转转
 */
+(void)HappySlotMachinesDataWithCost:(int )cost andDataBlock:(sendData)sendBlock
{
    STAFNetWorking *networking = [[STAFNetWorking alloc]init];
    NSDictionary *param = @{@"cost":@(cost)};
    [networking requsetWithPath:[self spellUrl:@"slotmachines.php?"] Withparams:param withRequestType:NetworkPostType withResult:^(id responseObject, NSError *error) {
        
        if (!error){
            NSDictionary *dataDic = (NSDictionary *)responseObject;
            //NSLog(@"======%@========%@",dataDic,error);
            sendBlock(dataDic,YES);
        }else{
            sendBlock(error,NO);
        }
    }];

}


/**
 *    历史上的今天接口
 */
+(void)TodayInfoDataWithPageNum:(int )pagenum andDataBlock:(sendData)sendBlock{
    STAFNetWorking *networking = [[STAFNetWorking alloc]init];
    NSDictionary *param = @{@"pagenum":@(pagenum)};
    [networking requsetWithPath:[self spellUrl:@"kdtodayhistorylist.php?"] Withparams:param withRequestType:NetworkPostType withResult:^(id responseObject, NSError *error) {
        if (!error) {
            NSDictionary *dataDic = (NSDictionary *)responseObject;
            sendBlock(dataDic,YES);
        }else{
            sendBlock(error,NO);
        }
    }];
    
}

//    商城列表
+(void)ShopListWithParam:(NSDictionary *)params andDataBlock:(sendData)sendBlock
{

    STAFNetWorking *networking = [[STAFNetWorking alloc]init];
    
    [networking requsetWithPath:[self spellUrl:@"goodsList.php?"] Withparams:params withRequestType:NetworkPostType withResult:^(id responseObject, NSError *error) {
        
        if (!error){
            NSDictionary *dataDic = (NSDictionary *)responseObject;
            //NSLog(@"======%@========%@",dataDic,error);
            sendBlock(dataDic,YES);
        }else{
            sendBlock(error,NO);
        }
    }];

}

//    商品详情
+(void)DetailGoodsWithParams:(NSDictionary *)params andDataBlock:(sendData)sendBlock
{
    STAFNetWorking *networking = [[STAFNetWorking alloc]init];
    [networking requsetWithPath:[self spellUrl:@"goodsdetain.php?"] Withparams:params withRequestType:NetworkPostType withResult:^(id responseObject, NSError *error) {
        
        if (!error){
            NSDictionary *dataDic = (NSDictionary *)responseObject;
            //NSLog(@"======%@========%@",dataDic,error);
            sendBlock(dataDic,YES);
        }else{
            sendBlock(error,NO);
        }
    }];

}

//    用户购买记录
+(void)UserGetGoodsRecordListDataWithPage:(int)pageNum andDataBlock:(sendData)sendBlock
{
    STAFNetWorking *networking = [[STAFNetWorking alloc]init];
    NSDictionary *param = @{@"pagenum":@(pageNum)};
    [networking requsetWithPath:[self spellUrl:@"usergoodslist.php?"] Withparams:param withRequestType:NetworkPostType withResult:^(id responseObject, NSError *error) {
        
        if (!error){
            NSDictionary *dataDic = (NSDictionary *)responseObject;
            //NSLog(@"======%@========%@",dataDic,error);
            sendBlock(dataDic,YES);
        }else{
            sendBlock(error,NO);
        }
    }];


}

//    确认订单
+(void)ConfirmOrderWithParam:(NSDictionary *)param andDataBlock:(sendData)sendBlock
{
    STAFNetWorking *networking = [[STAFNetWorking alloc]init];
    [networking requsetWithPath:[self spellUrl:@"goodsbuy.php?"] Withparams:param withRequestType:NetworkPostType withResult:^(id responseObject, NSError *error) {
        
        if (!error){
            NSDictionary *dataDic = (NSDictionary *)responseObject;
            //NSLog(@"======%@========%@",dataDic,error);
            sendBlock(dataDic,YES);
        }else{
            sendBlock(error,NO);
        }
    }];

}

//    地址列表
+(void)AddressListWithDataBlock:(sendData)sendBlock
{
    STAFNetWorking *networking = [[STAFNetWorking alloc]init];
    
    [networking requsetWithPath:[self spellUrl:@"reapaddress.php?"] Withparams:nil withRequestType:NetworkPostType withResult:^(id responseObject, NSError *error) {
        
        if (!error){
            NSDictionary *dataDic = (NSDictionary *)responseObject;
            //NSLog(@"======%@========%@",dataDic,error);
            sendBlock(dataDic,YES);
        }else{
            sendBlock(error,NO);
        }
    }];
}


//    添加地址
+(void)AddAddressWithParams:(NSDictionary *)param andDataBlock:(sendData)sendBlock
{
    STAFNetWorking *networking = [[STAFNetWorking alloc]init];
    
    [networking requsetWithPath:[self spellUrl:@"reapaddressadd.php?"] Withparams:param withRequestType:NetworkPostType withResult:^(id responseObject, NSError *error) {
        if (!error){
            NSDictionary *dataDic = (NSDictionary *)responseObject;
            //NSLog(@"======%@========%@",dataDic,error);
            sendBlock(dataDic,YES);
        }else{
            sendBlock(error,NO);
        }
    }];
}

//    删除地址
+(void)DeleteAddressWithID:(NSString *)reapId andDataBlock:(sendData)sendBlock
{
    STAFNetWorking *networking = [[STAFNetWorking alloc]init];
    NSDictionary *param = @{@"reapId":reapId};
    [networking requsetWithPath:[self spellUrl:@"reapaddressdel.php?"] Withparams:param withRequestType:NetworkPostType withResult:^(id responseObject, NSError *error) {
        if (!error){
            NSDictionary *dataDic = (NSDictionary *)responseObject;
            //NSLog(@"======%@========%@",dataDic,error);
            sendBlock(dataDic,YES);
        }else{
            sendBlock(error,NO);
        }
    }];


}


/**
 *    老虎机抽奖
 */
+(void)TigerMachineInfoDataWithCost:(int )cost andDataBlock:(sendData)sendBlock
{



}

+(void)GetNewsIdDataBlock:(sendData)sendBlock{
    
    STAFNetWorking *networking = [[STAFNetWorking alloc]init];
    [networking requsetWithPath:[self spellUrl:@"funcs.php?"] Withparams:nil withRequestType:NetworkPostType withResult:^(id responseObject, NSError *error) {
        if (!error){
            NSDictionary *dataDic = (NSDictionary *)responseObject;
            //NSLog(@"======%@========%@",dataDic,error);
            sendBlock(dataDic,YES);
        }else{
            sendBlock(error,NO);
        }
    }];
}


+(void)ProjectAddIDDataBlock:(sendData)sendBlock
{
    STAFNetWorking *networking = [[STAFNetWorking alloc]init];
    [networking requsetWithPath:[self spellUrl:@"projectaddudid.php?"] Withparams:nil withRequestType:NetworkPostType withResult:^(id responseObject, NSError *error) {
        if (!error){
            NSDictionary *dataDic = (NSDictionary *)responseObject;
            //NSLog(@"======%@========%@",dataDic,error);
            sendBlock(dataDic,YES);
        }else{
            sendBlock(error,NO);
        }
    }];

}


#pragma mark -------- 发现模块接口 --------------
/*------------------- 发现模块接口  --------------------------*/
/**
 *
 */
+(void)DiscoverInfoDataBlock:(sendData)sendBlock
{
    STAFNetWorking *networking = [[STAFNetWorking alloc]init];
    [networking requsetWithPath:[self spellUrl:@"discover.php?"] Withparams:nil withRequestType:NetworkPostType withResult:^(id responseObject, NSError *error) {
        if (!error){
            NSDictionary *dataDic = (NSDictionary *)responseObject;
            //NSLog(@"======%@========%@",dataDic,error);
            sendBlock(dataDic,YES);
        }else{
            sendBlock(error,NO);
        }
    }];

}

/**
 * 发现小编推荐数据 换一批
 */
+ (void)DiscoverEditRecommendInfoDataBlock:(sendData)sendBlock
{
    STAFNetWorking *networking = [[STAFNetWorking alloc]init];
    [networking requsetWithPath:[self spellUrl:@"editrecommendflush.php?"] Withparams:nil withRequestType:NetworkPostType withResult:^(id responseObject, NSError *error) {
        if (!error){
            NSDictionary *dataDic = (NSDictionary *)responseObject;
            //NSLog(@"======%@========%@",dataDic,error);
            sendBlock(dataDic,YES);
        }else{
            sendBlock(error,NO);
        }
    }];

}

/**
 * 发现上升最快数据 更多
 */
+ (void)DiscoverNewstEnterMoreInfo:(int)pn andDataBlock:(sendData)sendBlock
{
    STAFNetWorking *networking = [[STAFNetWorking alloc]init];
    NSDictionary *params = @{
                             @"pn":@(pn)
                             };
    [networking requsetWithPath:[self spellUrl:@"newestenterlist.php?"] Withparams:params withRequestType:NetworkPostType withResult:^(id responseObject, NSError *error) {
        if (!error){
            NSDictionary *dataDic = (NSDictionary *)responseObject;
            //NSLog(@"======%@========%@",dataDic,error);
            sendBlock(dataDic,YES);
        }else{
            sendBlock(error,NO);
        }
    }];
    
}

/**
 * 发现精选模块数据
 */
+ (void)DiscoverEditSelection:(NSDictionary *)prams andDataBlock:(sendData)sendBlock
{
    STAFNetWorking *networking = [[STAFNetWorking alloc]init];
    [networking requsetWithPath:[self spellUrl:@"editselectionenter.php?"] Withparams:prams withRequestType:NetworkPostType withResult:^(id responseObject, NSError *error) {
        if (!error){
            NSDictionary *dataDic = (NSDictionary *)responseObject;
            //NSLog(@"======%@========%@",dataDic,error);
            sendBlock(dataDic,YES);
        }else{
            sendBlock(error,NO);
        }
    }];
    
}

/**
 * 发现今日热文数据
 */
+ (void)DiscoverTodayHotItem:(NSDictionary *)prams andDataBlock:(sendData)sendBlock
{
    STAFNetWorking *networking = [[STAFNetWorking alloc]init];
    [networking requsetWithPath:[self spellUrl:@"todayhot.php?"] Withparams:prams withRequestType:NetworkPostType withResult:^(id responseObject, NSError *error) {
        if (!error){
            NSDictionary *dataDic = (NSDictionary *)responseObject;
            //NSLog(@"======%@========%@",dataDic,error);
            sendBlock(dataDic,YES);
        }else{
            sendBlock(error,NO);
        }
    }];

}

/**
 * 发现获取推荐详情数据
 */
+ (void)DiscoverGetRecommendDetailItem:(int )artid andDataBlock:(sendData)sendBlock{

    STAFNetWorking *networking = [[STAFNetWorking alloc]init];
    NSDictionary *params = @{
                             @"id":@(artid)
                             };
    
    [networking requsetWithPath:[self spellUrl:@"recommenddetain.php?"] Withparams:params withRequestType:NetworkPostType withResult:^(id responseObject, NSError *error) {
        if (!error){
            NSDictionary *dataDic = (NSDictionary *)responseObject;
            //NSLog(@"======%@========%@",dataDic,error);
            sendBlock(dataDic,YES);
        }else{
            sendBlock(error,NO);
        }
    }];

}


#pragma mark -------- 测试模块接口 --------------
/*------------------- 测试模块接口  --------------------------*/
/**
 *
 */
+(void)NewsTestRichTestWithCheckNewsID:(NSInteger )checkNewsID WithDataBlock:(sendData)sendBlock
{
    
    STAFNetWorking *networking = [[STAFNetWorking alloc]init];
    NSDictionary *param = @{@"id":@(checkNewsID)};
    
    [networking requsetWithPath:[self spellUrl:@"richtext.php?"] Withparams:param withRequestType:NetworkPostType withResult:^(id responseObject, NSError *error) {
        if (!error){
            NSDictionary *dataDic = (NSDictionary *)responseObject;
            //NSLog(@"======%@========%@",dataDic,error);
            sendBlock(dataDic,YES);
        }else{
            sendBlock(error,NO);
        }
    }];
    
    
}









//+ (void)TyrantDownWithParam:(NSDictionary *)params DataBlock:(sendData)sendBlock
//{
//    STAFNetWorking *networking = [[STAFNetWorking alloc]init];
//    [networking requsetWithPath:[self spellUrl:@"prepaidcall/apicomm/rechargelist.php?"] Withparams:params withRequestType:NetworkPostType withResult:^(id responseObject, NSError *error) {
//        
//        if (!error){
//            NSDictionary *dataDic = (NSDictionary *)responseObject;
//            //NSLog(@"======%@========%@",dataDic,error);
//            sendBlock(dataDic,YES);
//        }else{
//            sendBlock(error,NO);
//        }
//    }];
//    
//}
//
//
//
//+ (void)RechargeListWithParam:(NSDictionary *)params DataBlock:(sendData)sendBlock
//{
//    STAFNetWorking *networking = [[STAFNetWorking alloc]init];
//    [networking requsetWithPath:[self spellUrl:@"prepaidcall/apicomm/userscoredetain.php?"] Withparams:params withRequestType:NetworkPostType withResult:^(id responseObject, NSError *error) {
//        
//        if (!error){
//            NSDictionary *dataDic = (NSDictionary *)responseObject;
//            //NSLog(@"======%@========%@",dataDic,error);
//            sendBlock(dataDic,YES);
//        }else{
//            sendBlock(error,NO);
//        }
//    }];
//    
//}
//
//
//
//+ (void)AwardListWithParam:(NSDictionary *)params DataBlock:(sendData)sendBlock
//{
//    STAFNetWorking *networking = [[STAFNetWorking alloc]init];
//    [networking requsetWithPath:[self spellUrl:@"prepaidcall/apicomm/userrewarddetain.php?"] Withparams:params withRequestType:NetworkPostType withResult:^(id responseObject, NSError *error) {
//        
//        if (!error){
//            NSDictionary *dataDic = (NSDictionary *)responseObject;
//            //NSLog(@"======%@========%@",dataDic,error);
//            sendBlock(dataDic,YES);
//        }else{
//            sendBlock(error,NO);
//        }
//    }];
//    
//}
//
//+ (void)OrderListWithParam:(NSDictionary *)params DataBlock:(sendData)sendBlock
//{
//    STAFNetWorking *networking = [[STAFNetWorking alloc]init];
//    [networking requsetWithPath:[self spellUrl:@"prepaidcall/apicomm/usergoodsexchlist.php?"] Withparams:params withRequestType:NetworkPostType withResult:^(id responseObject, NSError *error) {
//        
//        if (!error){
//            NSDictionary *dataDic = (NSDictionary *)responseObject;
//            //NSLog(@"======%@========%@",dataDic,error);
//            sendBlock(dataDic,YES);
//        }else{
//            sendBlock(error,NO);
//        }
//    }];
//    
//}
//
//

//+(void)shareWithDataBlock:(sendData)sendBlock
//{
//    STAFNetWorking *networking = [[STAFNetWorking alloc]init];
//    [networking requsetWithPath:[self spellUrl:@"prepaidcall/apicomm/shareindex.php?"] Withparams:nil withRequestType:NetworkPostType withResult:^(id responseObject, NSError *error) {
//        if (!error){
//            NSDictionary *dataDic = (NSDictionary *)responseObject;
//            //NSLog(@"======%@========%@",dataDic,error);
//            sendBlock(dataDic,YES);
//        }else{
//            sendBlock(error,NO);
//        }
//    }];
//    
//}
//
//+(void)versionUpdateWithParam:(NSDictionary *)params DataBlock:(sendData)sendBlock
//{
//    STAFNetWorking *networking = [[STAFNetWorking alloc]init];
//    [networking requsetWithPath:[self spellUrl:@"prepaidcall/apicomm/appversion.php?"] Withparams:params withRequestType:NetworkPostType withResult:^(id responseObject, NSError *error) {
//        if (!error){
//            NSDictionary *dataDic = (NSDictionary *)responseObject;
//            //NSLog(@"======%@========%@",dataDic,error);
//            sendBlock(dataDic,YES);
//        }else{
//            sendBlock(error,NO);
//        }
//    }];
//    
//}
//
//+(void)ApprenticeListWithParam:(NSDictionary *)params DataBlock:(sendData)sendBlock
//{
//    STAFNetWorking *networking = [[STAFNetWorking alloc]init];
//    [networking requsetWithPath:[self spellUrl:@"prepaidcall/apicomm/userdisciplelist.php?"] Withparams:params withRequestType:NetworkPostType withResult:^(id responseObject, NSError *error) {
//        if (!error){
//            NSDictionary *dataDic = (NSDictionary *)responseObject;
//            //NSLog(@"======%@========%@",dataDic,error);
//            sendBlock(dataDic,YES);
//        }else{
//            sendBlock(error,NO);
//        }
//    }];
//    
//    
//}
//
//
//+(void)DepositWithParams:(NSDictionary *)param andDataBlock:(sendData)sendBlock{
//    STAFNetWorking *networking = [[STAFNetWorking alloc]init];
//    [networking requsetWithPath:[self spellUrl:@"prepaidcall/apicomm/userrech.php?"] Withparams:param withRequestType:NetworkPostType withResult:^(id responseObject, NSError *error) {
//        if (!error) {
//            NSDictionary *dataDic = (NSDictionary *)responseObject;
//            sendBlock(dataDic,YES);
//        }else{
//            sendBlock(error,NO);
//        }
//    }];
//}
//+(void)ConfigWithDataBlcok:(sendData)sendBlock
//{
//    STAFNetWorking *networking = [[STAFNetWorking alloc]init];
//    NSDictionary *param = @{@"channel":@(120)};
//    [networking requsetWithPath:[self spellUrl:@"prepaidcall/apicomm/configdata.php?"] Withparams:param withRequestType:NetworkPostType withResult:^(id responseObject, NSError *error) {
//        if (!error) {
//            NSDictionary *dataDic = (NSDictionary *)responseObject;
//            sendBlock(dataDic,YES);
//        }else{
//            sendBlock(error,NO);
//        }
//    }];
//    STUserDefaults.channel = [NSString stringWithFormat:@"%@",param];
//}
//+(void)BeginAdverWithDataBlock:(sendData)sendBlock
//{
//    STAFNetWorking *networking = [[STAFNetWorking alloc]init];
//    [networking requsetWithPath:[self spellUrl:@"prepaidcall/apicomm/startadv.php?"] Withparams:nil withRequestType:NetworkPostType withResult:^(id responseObject, NSError *error) {
//        if (!error) {
//            NSDictionary *dataDic = (NSDictionary *)responseObject;
//            sendBlock(dataDic,YES);
//        }else{
//            sendBlock(error,NO);
//        }
//    }];
//}
//
////任务列表
//+(void)TaskListWithID:(int)page andDataBlock:(sendData)sendBlock
//{
//    STAFNetWorking *networking = [[STAFNetWorking alloc]init];
//    NSDictionary *param = @{@"pagenum":@(page)};
//    [networking requsetWithPath:[self spellUrl:@"prepaidcall/apicomm/useradvtasklist.php?"] Withparams:param withRequestType:NetworkPostType withResult:^(id responseObject, NSError *error) {
//        if (!error) {
//            NSDictionary *dataDic = (NSDictionary *)responseObject;
//            sendBlock(dataDic,YES);
//        }else{
//            sendBlock(error,NO);
//        }
//    }];
//}
//
////分享成功
//+(void)ShareSuccessWithType:(int)type andDataBlock:(sendData)sendBlock
//{
//    STAFNetWorking *networking = [[STAFNetWorking alloc]init];
//    NSDictionary *param = @{@"from":@(type)};
//    [networking requsetWithPath:[self spellUrl:@"prepaidcall/apicomm/usershareback.php?"] Withparams:param withRequestType:NetworkPostType withResult:^(id responseObject, NSError *error) {
//        if (!error) {
//            NSDictionary *dataDic = (NSDictionary *)responseObject;
//            sendBlock(dataDic,YES);
//        }else{
//            sendBlock(error,NO);
//        }
//    }];
//}
//
//+(void)TestTheOrderWithDataBlock:(sendData)sendBlock
//{
//    STAFNetWorking *networking = [[STAFNetWorking alloc]init];
//    NSDictionary *param = @{@"orderid":STUserDefaults.orderid};
//    [networking requsetWithPath:[self spellUrl:@"prepaidcall/apicomm/rechargecheck.php?"] Withparams:param withRequestType:NetworkPostType withResult:^(id responseObject, NSError *error) {
//        if (!error) {
//            NSDictionary *dataDic = (NSDictionary *)responseObject;
//            sendBlock(dataDic,YES);
//        }else{
//            sendBlock(error,NO);
//        }
//    }];
//}

-(BOOL)isBlankString:(NSString *)string {
    if (string == nil || string == NULL) {
        return YES;
    }
    if ([string isKindOfClass:[NSNull class]]) {
        return YES;
    }
    if ([[string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] length]==0) {
        return YES;
    }
    if ([string isEqualToString:@"(null)"]) {
        return YES;
    }
    if ([string isEqualToString:@"<null>"]) {
        return YES;
    }
    return NO;
}

@end
