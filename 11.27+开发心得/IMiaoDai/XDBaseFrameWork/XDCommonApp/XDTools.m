//
//  XDTools.m
//  XDCommonApp
//
//  Created by XD-XY on 2/12/14.
//  Copyright (c) 2014 XD-XY. All rights reserved.
//

#import "XDTools.h"
#import "Reachability.h"
#import "XDHeader.h"
#import "NSString+MD5.h"
#import "SDWebImageDownloader.h"
#define version_tag 1000

@implementation XDTools
DEFINE_SINGLETON_FOR_CLASS(XDTools)

+ (NSDictionary *)JSonFromString:(NSString* )result
{
    NSDictionary *json = [result objectFromJSONStringWithParseOptions:JKParseOptionLooseUnicode];
    return json;
    
}

+ (AppDelegate *)appDelegate
{
    return (AppDelegate *)[[UIApplication sharedApplication] delegate];
}

+(BOOL)NetworkReachable
{
    NetworkStatus wifi = [[Reachability reachabilityForLocalWiFi] currentReachabilityStatus];
    NetworkStatus gprs = [[Reachability reachabilityForInternetConnection] currentReachabilityStatus];
    if(wifi == NotReachable && gprs == NotReachable)
    {
        return NO;
    }
    return YES;
}

+ (void)showProgress:(UIView *) view
{
    [MBProgressHUD showHUDAddedTo:view animated:YES];
}

+ (void)showProgress:(UIView *) view showText:(NSString*)text
{
    MBProgressHUD * hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hud.labelText = text;
}

+ (void) showTips:(NSString *)text toView:(UIView *)view
{
    MBProgressHUD * hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
	// Configure for text only and offset down
	hud.mode = MBProgressHUDModeText;
	hud.labelText = text;
	[hud show:YES];
	[hud hide:YES afterDelay:1];
}

+ (void)showSuccessTips:(NSString *)text toView:(UIView *)view
{
    
}

+ (void)showErrorTips:(NSString *)text toView:(UIView *)view
{

}

+ (void)hideProgress:(UIView *)view
{
    [MBProgressHUD hideAllHUDsForView:view animated:YES];
}

- (void)checkVersion:(UIViewController *)viewController isShowAlert:(BOOL)isShow
{
    
//    NSDictionary *dict = @{};
//    
//    __weak ASIFormDataRequest *request = [XDTools postRequestWithDict:dict API:API_CHECKVERSION];
//    [request setCompletionBlock:^{
//        NSString *responseString = [request responseString];
//        NSDictionary *responseDic = [XDTools  JSonFromString:responseString];
//        DDLOG(@"responseDic:%@", responseDic);
//        NSString *  resultNum = [responseDic objectForKey:@"success_code"];
//        NSDictionary * success_message = [responseDic objectForKey:@"success_message"];
//        int seccesNum = [resultNum intValue];
//        if (seccesNum == 200) {
//            appDownloadUrl = [success_message objectForKey:@"downloadURL"];
//            NSString *version = [success_message objectForKey:@"currentVersion"];
//            NSString * oldversion = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
//            if ([oldversion compare:version] == NSOrderedAscending) {
//                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil
//                                                                message:@"有新的版本是否更新"
//                                                               delegate:self
//                                                      cancelButtonTitle:@"取消"
//                                                      otherButtonTitles:@"确定", nil];
//                alert.tag = version_tag;
//                [alert show];
//            }else{
//                //这已经是最新的版本
//                if (isShow) {
//                    [XDTools showAlertViewWithTitle:nil msg:@"已经是最新版本" viewController:viewController];
//                }
//            }
//        }
//        else
//        {
//            return ;
//        }
//    }];
//    
//    [request setFailedBlock:^{
//        NSError *error = [request error];
//        DDLOG_CURRENT_METHOD;
//        DDLOG(@"error=%@",error);
//    }];
//    [request startAsynchronous];
    
    UIAlertView * versionAlert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"有新的版本" delegate:self cancelButtonTitle:@"下次再说" otherButtonTitles:@"立即更新",nil];
    versionAlert.tag=version_tag;
    [versionAlert show];
}



+ (ASIHTTPRequest*)getRequestWithDict:(NSDictionary *)dict API:(NSString *)api
{
    NSMutableDictionary *muDict = [[NSMutableDictionary alloc] initWithDictionary:dict];
    NSMutableString *params = [[NSMutableString alloc] init];
    for (id keys in muDict) {
        [params appendFormat:@"&%@=%@",keys,[muDict objectForKey:keys]];
    }
    NSRange rang = [params rangeOfString:@"?"];
    if(rang.location == NSNotFound){
        NSRange rangAnd = [params rangeOfString:@"&"];
        [params replaceCharactersInRange:rangAnd withString:@"?"];
    }
    
    NSString *urlStr = [NSString stringWithFormat:@"%@%@%@",HOST_URL,api,params];
    urlStr = [urlStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    DDLOG(@"urlStr:%@", urlStr);
    NSURL *url = [NSURL URLWithString:urlStr];
    ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:url];
    [request setTimeOutSeconds:12];
    return request;
}

+ (ASIFormDataRequest*)postRequestWithDict:(NSDictionary *)dict API:(NSString *)api
{
//    kNotReachable = 0, // Apple's code depends upon 'NotReachable' being the same value as 'NO'.
//	kReachableViaWWAN, // Switched order from Apple's enum. WWAN is active before WiFi.
//	kReachableViaWiFi
    NSString * mustBeWifi = [[NSUserDefaults standardUserDefaults] objectForKey:@"wifi"];
    NSString * netType = @"";
    NetworkStatus wifi = [[Reachability reachabilityForLocalWiFi] currentReachabilityStatus];
    if(wifi == kReachableViaWWAN){
        netType = @"3G";
    }else if (wifi == kReachableViaWiFi) {
        netType = @"wifi";
    }

    NSDate* dat = [NSDate dateWithTimeIntervalSinceNow:0];
    NSTimeInterval a=[dat timeIntervalSince1970]*1000;
    NSString *timeString = [NSString stringWithFormat:@"%f", a];

    

    NSMutableDictionary * dict0 = [[NSMutableDictionary alloc] initWithDictionary:@{@"source": @"123",
                                                                                   @"os":@"iphone",
                                                                                   @"width":[NSString stringWithFormat:@"%f",UI_SCREEN_WIDTH],
                                                                                   @"height":[NSString stringWithFormat:@"%f",UI_SCREEN_HEIGHT],
                                                                                   @"phoneType":[self doDevicePlatform],
                                                                                   @"osType":[[UIDevice currentDevice] systemVersion],
                                                                                   @"ver":[[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"],
                                                                                   @"netType":netType,
                                                                                   @"timestamp":timeString,
                                                                                    @"imei":[[NSUserDefaults standardUserDefaults] objectForKey:MYUUID]
                                                                                    }];

    for (NSString * keys in dict.allKeys) {
        [dict0 setObject:dict[keys] forKey:keys];
    }

    //排序
    NSMutableArray * keyArrays = [NSMutableArray arrayWithArray:dict0.allKeys];
    DDLOG(@"%@",keyArrays);
    keyArrays = [self bubbleSortArray:keyArrays];


    //拼接
    NSMutableString *params = [[NSMutableString alloc] init];
    for (int i = 0; i < keyArrays.count; i++) {
        [params appendFormat:@"&%@=%@",keyArrays[i],dict0[keyArrays[i]]];
    }

    NSRange rang = [params rangeOfString:@"?"];
    if(rang.location == NSNotFound){
        NSRange rangAnd = [params rangeOfString:@"&"];
        [params replaceCharactersInRange:rangAnd withString:@"?"];
    }

    [params deleteCharactersInRange:NSMakeRange(0, 1)];

    [params appendString:@"qJ7nqKZbEf1rDtLvycjV1fJV0/VUyJmK"];

//    NSString * utf8Str = [params stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];


    NSString * signStr = [NSString md5:params];

    [dict0 setObject:signStr forKey:@"sign"];


    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@",HOST_URL,api]];
    ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:url];
    
    [request setRequestMethod:@"POST"];
    [request setTimeOutSeconds:12];
    for (id key in dict0) {
        [request setPostValue:[dict0 objectForKey:key] forKey:key];
//        [request setPostValue:[[dict0 objectForKey:key] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding] forKey:key];

    }
    DDLOG(@"post muDict :%@", dict0);
    return request;
}

+ (ASIFormDataRequest*)postRequestWithDict:(NSDictionary *)dict Data:(NSData *)data imageKey:(NSString *)imageKey API:(NSString *)api
{
    //    kNotReachable = 0, // Apple's code depends upon 'NotReachable' being the same value as 'NO'.
    //	kReachableViaWWAN, // Switched order from Apple's enum. WWAN is active before WiFi.
    //	kReachableViaWiFi
    NSString * mustBeWifi = [[NSUserDefaults standardUserDefaults] objectForKey:@"wifi"];
    NSString * netType = @"";
    NetworkStatus wifi = [[Reachability reachabilityForLocalWiFi] currentReachabilityStatus];
    if(wifi == kReachableViaWWAN){
        netType = @"3G";
    }else if (wifi == kReachableViaWiFi) {
        netType = @"wifi";
    }

    NSDate* dat = [NSDate dateWithTimeIntervalSinceNow:0];
    NSTimeInterval a=[dat timeIntervalSince1970]*1000;
    NSString *timeString = [NSString stringWithFormat:@"%f", a];

    NSMutableDictionary * dict0 = [[NSMutableDictionary alloc] initWithDictionary:@{@"source": @"123",
                                                                                    @"os":@"iphone",
                                                                                    @"width":[NSString stringWithFormat:@"%f",UI_SCREEN_WIDTH],
                                                                                    @"height":[NSString stringWithFormat:@"%f",UI_SCREEN_HEIGHT],
                                                                                    @"phoneType":[self doDevicePlatform],
                                                                                    @"osType":[[UIDevice currentDevice] systemVersion],
                                                                                    @"ver":[[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"],
                                                                                    @"netType":netType,
                                                                                    @"timestamp":timeString,
                                                                                    @"imei":[[NSUserDefaults standardUserDefaults] objectForKey:MYUUID]
                                                                                    }];

    for (NSString * keys in dict.allKeys) {
        [dict0 setObject:dict[keys] forKey:keys];
    }

    //排序
    NSMutableArray * keyArrays = [NSMutableArray arrayWithArray:dict0.allKeys];
    DDLOG(@"%@",keyArrays);
    keyArrays = [self bubbleSortArray:keyArrays];


    //拼接
    NSMutableString *params = [[NSMutableString alloc] init];
    for (int i = 0; i < keyArrays.count; i++) {
        [params appendFormat:@"&%@=%@",keyArrays[i],dict0[keyArrays[i]]];
    }

    NSRange rang = [params rangeOfString:@"?"];
    if(rang.location == NSNotFound){
        NSRange rangAnd = [params rangeOfString:@"&"];
        [params replaceCharactersInRange:rangAnd withString:@"?"];
    }

    [params deleteCharactersInRange:NSMakeRange(0, 1)];

    [params appendString:@"qJ7nqKZbEf1rDtLvycjV1fJV0/VUyJmK"];

    NSString * signStr = [NSString md5:params];

    [dict0 setObject:signStr forKey:@"sign"];


    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@",HOST_URL,api]];
    ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:url];






//    //分界线的标识符
//    NSString *TWITTERFON_FORM_BOUNDARY = @"AaB03x";
//
//    //分界线 --AaB03x
//    NSString *MPboundary=[[NSString alloc]initWithFormat:@"--%@",TWITTERFON_FORM_BOUNDARY];
//    //结束符 AaB03x--
//    NSString *endMPboundary=[[NSString alloc]initWithFormat:@"%@--",MPboundary];
//    
//    //http body的字符串
//    NSMutableString *body=[[NSMutableString alloc]init];
//    //参数的集合的所有key的集合
//    NSArray *keys= [dict0 allKeys];
//
//    //遍历keys
//    for(int i=0;i<[keys count];i++)
//    {
//        //得到当前key
//        NSString *key=[keys objectAtIndex:i];
//        //如果key不是pic，说明value是字符类型，比如name：Boris
//        if(![key isEqualToString:@"pic"])
//        {
//            //添加分界线，换行
//            [body appendFormat:@"%@\r\n",MPboundary];
//            //添加字段名称，换2行
//            [body appendFormat:@"Content-Disposition: form-data; name=\"%@\"\r\n\r\n",key];
//            //添加字段的值
//            [body appendFormat:@"%@\r\n",[dict0 objectForKey:key]];
//        }
//    }
//
//    ////添加分界线，换行
//    [body appendFormat:@"%@\r\n",MPboundary];
//    //声明pic字段，文件名为boris.png
//    [body appendFormat:@"Content-Disposition: form-data; name=\"pic\"; filename=\"boris.png\"\r\n"];
//    //声明上传文件的格式
//    [body appendFormat:@"Content-Type: image/png\r\n\r\n"];
//
//    //声明结束符：--AaB03x--
//    NSString *end=[[NSString alloc]initWithFormat:@"\r\n%@",endMPboundary];
//    //声明myRequestData，用来放入http body
//    NSMutableData *myRequestData=[NSMutableData data];
//    //将body字符串转化为UTF8格式的二进制
//    [myRequestData appendData:[body dataUsingEncoding:NSUTF8StringEncoding]];
//    //将image的data加入
//    [myRequestData appendData:data];
//    //加入结束符--AaB03x--
//    [myRequestData appendData:[end dataUsingEncoding:NSUTF8StringEncoding]];
//
//    //设置HTTPHeader中Content-Type的值
//    NSString *content=[[NSString alloc]initWithFormat:@"multipart/form-data; boundary=%@",TWITTERFON_FORM_BOUNDARY];
//    //设置HTTPHeader
//    [request setValue:content forHTTPHeaderField:@"Content-Type"];
//    //设置Content-Length
//    [request setValue:[NSString stringWithFormat:@"%d", [myRequestData length]] forHTTPHeaderField:@"Content-Length"];
//    //设置http body
//    [request setHTTPBody:myRequestData];
//    //http method
//    [request setHTTPMethod:@"POST"];



    [request setRequestMethod:@"POST"];
    [request setTimeOutSeconds:12];
    for (id key in dict0) {
        [request setPostValue:[dict0 objectForKey:key] forKey:key];
    }
    [request addData:data withFileName:@"KKK.png" andContentType:@"multipart/form-data" forKey:imageKey];
    DDLOG(@"post muDict :%@", dict0);
    return request;
}


+(NSMutableArray *)bubbleSortArray:(NSMutableArray *)list
{
    NSStringCompareOptions comparisonOptions = NSCaseInsensitiveSearch|NSNumericSearch|
    NSWidthInsensitiveSearch|NSForcedOrderingSearch;
    NSComparator sort = ^(NSString *obj1,NSString *obj2){
        NSRange range = NSMakeRange(0,obj1.length);
        return [obj1 compare:obj2 options:comparisonOptions range:range];
    };
    NSArray *resultArray2 = [list sortedArrayUsingComparator:sort];
    
    NSLog(@"array:%@", resultArray2);

    return list = [NSMutableArray arrayWithArray:resultArray2];
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (alertView.tag ==version_tag){
        if (buttonIndex==1){
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://www.google.com.hk/"]];
        }
    }
}


+(CGRect )xyAutoSizeOfWidget:(UILabel *)widget andSize:(CGSize)size andtextFont:(CGFloat )sizefont
{
    widget.numberOfLines = 0;
    CGRect rect = widget.frame;
    if ([widget.text length]==0){
        return CGRectMake(rect.origin.x, rect.origin.y, 0, 0);
    }
    // NSLog(@"rect = %f %f %f %f",rect.origin.x,rect.origin.y,rect.size.width,rect.size.height);
    if (IOS7){
        NSDictionary * tdic = [NSDictionary dictionaryWithObjectsAndKeys:[UIFont systemFontOfSize:sizefont],NSFontAttributeName,nil];
        CGSize  actualsize =[widget.text boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin  attributes:tdic context:nil].size;
        CGRect tmpRect = CGRectMake(rect.origin.x, rect.origin.y, actualsize.width, actualsize.height);
        return tmpRect;
    }else{
        CGSize strSize = [widget.text sizeWithFont:[UIFont systemFontOfSize:sizefont] constrainedToSize:size lineBreakMode:NSLineBreakByCharWrapping];
        CGRect tmpRect = CGRectMake(rect.origin.x, rect.origin.y, strSize.width, strSize.height);
        return tmpRect;
    }
}
+(CGRect )autoSizeOftext:(NSString *)text andSize:(CGSize)size andtextFont:(CGFloat)sizefont
{
    
    if (IOS7){
        NSDictionary * tdic = [NSDictionary dictionaryWithObjectsAndKeys:[UIFont systemFontOfSize:sizefont],NSFontAttributeName,nil];
        CGSize  actualsize =[text boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin  attributes:tdic context:nil].size;
        CGRect tmpRect = CGRectMake(0, 0, actualsize.width, actualsize.height);
        return tmpRect;
    }else{
        CGSize strSize = [text sizeWithFont:[UIFont systemFontOfSize:sizefont] constrainedToSize:size lineBreakMode:NSLineBreakByCharWrapping];
        CGRect tmpRect = CGRectMake(0, 0, strSize.width, strSize.height);
        return tmpRect;
    }
    
}
+(UIImage *)stretchableImag:(UIImage *)image
{
    //image = [image stretchableImageWithLeftCapWidth:2 topCapHeight:10];
    //上左下右
    //image = [UIImage imageNamed:@"homepage_cellodd_img"];
    image = [image resizableImageWithCapInsets:UIEdgeInsetsMake(2,2,2,2)];
    return image;
}

+(UIImage *)stretchableImag2:(UIImage *)image
{
    //image = [image stretchableImageWithLeftCapWidth:2 topCapHeight:10];
    //上左下右
    //image = [UIImage imageNamed:@"homepage_cellodd_img"];
    image = [image resizableImageWithCapInsets:UIEdgeInsetsMake(10,10,10,10)];
    return image;
}

+(void)moveFileToDocument:(NSString *)name andType:(NSString *)type
{
    //1.获取文件在工程中的路径--源路径
    NSString * sourcesPath = [[NSBundle mainBundle] pathForResource:name ofType:type];
    
    //2.获取沙盒中Document文件夹的路径--目的路径
    NSArray * paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString * documentPath = [paths objectAtIndex:0];
    NSString * desPath = [documentPath stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.%@",name,type]];
    DDLOG(@"desPath = %@",desPath);
    //3.通过NSFileManager类，将工程中的数据库文件复制到沙盒中。
    NSFileManager * fileManager  =[NSFileManager defaultManager];
    if (![fileManager fileExistsAtPath:desPath]){
        NSError * error;
        if ([fileManager copyItemAtPath:sourcesPath toPath:desPath error:&error]){
            DDLOG(@"文件移动成功");
        }else{
            DDLOG(@"文件移动失败");
        }
    }else{
        DDLOG(@"文件已存在");
    }
}

//获取数据库指针
+(FMDatabase*)getDb{
    //paths： ios下Document路径，Document为ios中可读写的文件夹
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentDirectory = [paths objectAtIndex:0];
    //dbPath： 数据库路径，在Document中。
    NSString *dbPath = [documentDirectory stringByAppendingPathComponent:@"area.db"];
    //创建数据库实例 db  这里说明下:如果路径中不存在"Test.db"的文件,sqlite会自动创建"Test.db"
    FMDatabase * db= [FMDatabase databaseWithPath:dbPath] ;
    return db;
}


//判断当前时间和过去时间的时间差
- (NSString *)intervalSinceNow:(NSString *) theDate
{
    
    if (!IS_NOT_EMPTY(theDate)){
        return nil;
    }
    if (theDate.length !=19){
        return @"时间格式错误";
    }
    NSString *yearStr = [theDate substringToIndex:4];
    
    
    NSDateFormatter *date=[[NSDateFormatter alloc] init];
    [date setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    
    NSString *timeString=@"";
    
    NSString *nowTime = [NSString stringWithFormat:@"%@",
                         [date stringFromDate:[NSDate date]]];
    NSString *nowYear = [nowTime substringToIndex:4];
    
    if (![nowYear isEqualToString:yearStr]) {
        return [theDate substringToIndex:11];
    }
    
    NSString * str1 = [theDate substringWithRange:NSMakeRange(8, 2)];
    NSString * str2 = [nowTime substringWithRange:NSMakeRange(8, 2)];
    if ([str2 compare:str1]==0){
        //今天
        timeString = [theDate substringWithRange:NSMakeRange(11, 5)];
    }else{
        timeString = [theDate substringWithRange:NSMakeRange(5, 11)];
    }
    
    return timeString;
}




//获取文件目录
+(NSString *)documentsPath:(NSString *)fileName {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    return [documentsDirectory stringByAppendingPathComponent:fileName];
}
//读文件
//+(NSArray *)readFileArray
//{
//    NSLog(@"readfile........\n");
//    //dataPath 表示当前目录下指定的一个文件 data.plist
//    //NSString *dataPath = [[NSBundle mainBundle] pathForResource:@"Data" ofType:@"plist"];
//    //filePath 表示程序目录下指定文件

////    NSString *filePath = [XDTools documentsPath:kMYCOOTEXT];
//    //从filePath 这个指定的文件里读
////    NSArray *userinfo = [NSArray arrayWithContentsOfFile:filePath];
//    NSString *filePath = [XDTools documentsPath:kMYCOOTEXT];
//    //从filePath 这个指定的文件里读
//    NSArray *userinfo = [NSArray arrayWithContentsOfFile:filePath];

//    return userinfo;
//
//}
+(NSString *)documentsPath {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    return documentsDirectory;
}

+(NSMutableArray *)productCookies{
    NSDictionary *user = [[NSUserDefaults standardUserDefaults] objectForKey:kMMyUserInfo];
    NSString *usename = [user objectForKey:@"username"];
    NSString *uid = [user objectForKey:@"uid"];
    NSString *password = [user objectForKey:@"password"];
    
    NSDictionary *properties = [[NSMutableDictionary alloc] init];
    [properties setValue:[XDTools encodedCookieValue:password] forKey:NSHTTPCookieValue];
    [properties setValue:[XDTools encodedCookieValue:@"leepetphone[password]"] forKey:NSHTTPCookieName];
    [properties setValue:[XDTools encodedCookieValue:@".chinapet.com"] forKey:NSHTTPCookieDomain];
    [properties setValue:[NSDate dateWithTimeIntervalSinceNow:60*60*24*365] forKey:NSHTTPCookieExpires];
    [properties setValue:@"/" forKey:NSHTTPCookiePath];
    NSHTTPCookie *cookie1 = [[NSHTTPCookie alloc] initWithProperties:properties];
    
    NSDictionary *properties1 = [[NSMutableDictionary alloc] init];
    [properties1 setValue:[XDTools encodedCookieValue:uid] forKey:NSHTTPCookieValue];
    [properties1 setValue:@"leepetphone[uid]" forKey:NSHTTPCookieName];
    [properties1 setValue:@".chinapet.com" forKey:NSHTTPCookieDomain];
    [properties1 setValue:[NSDate dateWithTimeIntervalSinceNow:60*60*24*365] forKey:NSHTTPCookieExpires];
    [properties1 setValue:@"/" forKey:NSHTTPCookiePath];
    
    NSHTTPCookie *cookie2 = [[NSHTTPCookie alloc] initWithProperties:properties1];
    
    NSDictionary *properties2 = [[NSMutableDictionary alloc] init];
    [properties2 setValue:[XDTools encodedCookieValue:usename] forKey:NSHTTPCookieValue];
    [properties2 setValue:@"leepetphone[username]" forKey:NSHTTPCookieName];
    [properties2 setValue:@".chinapet.com" forKey:NSHTTPCookieDomain];
    [properties2 setValue:[NSDate dateWithTimeIntervalSinceNow:60*60*24*365] forKey:NSHTTPCookieExpires];
    [properties2 setValue:@"/" forKey:NSHTTPCookiePath];
    
    NSHTTPCookie *cookie3 = [[NSHTTPCookie alloc] initWithProperties:properties2];
    NSMutableArray *cookies = [NSMutableArray arrayWithObjects:cookie1,cookie2,cookie3, nil];
    return cookies;
}
+ (NSString *)encodedCookieValue:(NSString *)str
{
	return [str stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
}

+ (NSString *)intervalSinceNow:(NSString *)theDate sign:(NSString *)sign
{
    NSDateFormatter * date=[[NSDateFormatter alloc] init];
    [date setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    
    NSString * todayStr = [[date stringFromDate:[NSDate date]] substringWithRange:NSMakeRange(5, 5)];
    NSString * theDateStr = [theDate substringWithRange:NSMakeRange(5, 5)];
    
    NSDate * d = [date dateFromString:theDate];
    NSTimeInterval late = [d timeIntervalSince1970]*1;
    NSDate * dat = [NSDate dateWithTimeIntervalSinceNow:0];
    NSTimeInterval now = [dat timeIntervalSince1970]*1;
    NSString * timeString = @"";
    NSTimeInterval cha = now - late;
    //发表在一小时之内
    if(cha/3600<1) {
        if ([sign intValue] == 1) {
            timeString = @"刚刚";
        }else{
            //            if(cha/60<1) {
            //                timeString = @"1";
            //            }
            //            else
            //            {
            //                timeString = [NSString stringWithFormat:@"%f", cha/60];
            //                timeString = [timeString substringToIndex:timeString.length-7];
            //            }
            //            if ([todayStr isEqualToString:theDateStr]) {
            //                timeString=[NSString stringWithFormat:@"%@分前", timeString];
            //            }else{
            //                NSArray*array = [theDate componentsSeparatedByString:@" "];
            //
            //                timeString = [array objectAtIndex:0];
            //
            //                NSString * yearStr = [timeString substringToIndex:4];
            //
            //                NSString * nowTimeStr = [NSString stringWithFormat:@"%@",[NSDate date]];
            //                NSString * nowYearStr = [nowTimeStr substringToIndex:4];
            //
            //                if ([nowYearStr isEqualToString:yearStr]) {
            //                    timeString = [timeString substringWithRange:NSMakeRange(5, [timeString length]-5)];
            //                }
            //            }
            NSArray*array = [theDate componentsSeparatedByString:@" "];
            
            timeString = [array objectAtIndex:1];
            
            timeString = [timeString substringToIndex:5];
        }
        
    }
    //在一小时以上24小以内
    else if (cha/3600 > 1 && cha/86400 < 1) {
        if ([todayStr isEqualToString:theDateStr]) {
            //            if ([sign intValue] == 1) {
            NSArray*array = [theDate componentsSeparatedByString:@" "];
            
            timeString = [array objectAtIndex:1];
            
            timeString = [timeString substringToIndex:5];
            
            //            }else{
            //                timeString = [NSString stringWithFormat:@"%f", cha/3600];
            //                timeString = [timeString substringToIndex:timeString.length-7];
            //                timeString=[NSString stringWithFormat:@"%@小时前", timeString];
            //            }
            
        }
        else{
            NSArray*array = [theDate componentsSeparatedByString:@" "];
            
            timeString = [array objectAtIndex:0];
            
            NSString * yearStr = [timeString substringToIndex:4];
            
            NSString * nowTimeStr = [NSString stringWithFormat:@"%@",[NSDate date]];
            NSString * nowYearStr = [nowTimeStr substringToIndex:4];
            
            if ([nowYearStr isEqualToString:yearStr]) {
                timeString = [timeString substringWithRange:NSMakeRange(5, 5)];
            }
        }
    }
    //发表在24以上10天以内
    //    else if (cha/86400 > 1 && cha/864000 < 1)
    //    {
    //        timeString = [NSString stringWithFormat:@"%f", cha/86400];
    //        timeString = [timeString substringToIndex:timeString.length-7];
    //        timeString=[NSString stringWithFormat:@"%@天前", timeString];
    //    }
    //发表时间大于10天
    else
    {
        NSArray*array = [theDate componentsSeparatedByString:@" "];
        
        timeString = [array objectAtIndex:0];
        
        NSString * yearStr = [timeString substringToIndex:4];
        
        NSString * nowTimeStr = [NSString stringWithFormat:@"%@",[NSDate date]];
        NSString * nowYearStr = [nowTimeStr substringToIndex:4];
        
        if ([nowYearStr isEqualToString:yearStr]) {
            timeString = [timeString substringWithRange:NSMakeRange(5, 5)];
        }
        
    }
    return timeString;
}

+ (NSArray *)intervalSinceNow:(NSString *)theDate WithDays:(BOOL)haveDays{
    
    NSString * days = @"";
    NSString * hours = @"";
    NSString * minutes = @"";
    NSString * seconds = @"";
    
    NSDateFormatter * date=[[NSDateFormatter alloc] init];
    [date setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    
    NSDate * d = [date dateFromString:theDate];
    NSTimeInterval end = [d timeIntervalSince1970]*1;
    NSDate * dat = [NSDate dateWithTimeIntervalSinceNow:0];
    NSTimeInterval now = [dat timeIntervalSince1970]*1;
    NSTimeInterval cha = end - now;
    if (cha < 0) {
        NSArray * array = [NSArray arrayWithObjects:@"00",@"00",@"00", nil];
        return array;
    }
    int sec = cha;
    //发表在一分钟之内
    if(cha < 60) {
        hours = @"00";
        minutes = @"00";
        seconds = [NSString stringWithFormat:@"%02d",sec];
    }
    //在一分钟以上1小时以内
    else if (cha > 59 && cha < 3600) {
        hours = @"00";
        minutes = [NSString stringWithFormat:@"%02d",sec/60];
        seconds = [NSString stringWithFormat:@"%02d",sec%60];
    }
    //发表在1小时以上
    else
    {
        if (haveDays) {
            if (cha < 3600 * 24) {
                hours = [NSString stringWithFormat:@"%d",sec/3600];
                minutes = [NSString stringWithFormat:@"%d",sec%3600/60];
                seconds = [NSString stringWithFormat:@"%d",sec%3600%60];
            }else{
                days = [NSString stringWithFormat:@"%d",sec/(3600*24)];
                hours = [NSString stringWithFormat:@"%d",sec%(3600*24)/3600];
                minutes = [NSString stringWithFormat:@"%d",sec%(3600*24)%3600/60];
                seconds = [NSString stringWithFormat:@"%d",sec%(3600*24)%3600%60];
            }
            
        }else{
            hours = [NSString stringWithFormat:@"%02d",sec/3600];
            minutes = [NSString stringWithFormat:@"%02d",sec%3600/60];
            seconds = [NSString stringWithFormat:@"%02d",sec%3600%60];
        }
        
        
    }
    NSArray * timeArray = [[NSArray alloc] init];
    if (haveDays) {
        if (days.length && ![days isEqualToString:@"00"]) {
            timeArray = [NSArray arrayWithObjects:days,hours,minutes,seconds, nil];
        }else if (hours.length  && ![hours isEqualToString:@"00"]) {
            timeArray = [NSArray arrayWithObjects:hours,minutes,seconds, nil];
        }else if (minutes.length  && ![minutes isEqualToString:@"00"]) {
            timeArray = [NSArray arrayWithObjects:minutes,seconds, nil];
        }else{
            timeArray = [NSArray arrayWithObjects:seconds, nil];
        }
        
    }else{
        timeArray = [NSArray arrayWithObjects:hours,minutes,seconds, nil];
    }
    return timeArray;
}

//判断是否是null
+(void)judgeIsNull:(NSString *)string{
    if ([string isKindOfClass:[NSNull class]]) {
        string = @"";
    }
}

//显示某个字符 颜色
+(NSMutableAttributedString *)getAcolorfulStringWithText1:(NSString *)text1 Color1:(UIColor *)color1 Font1:(UIFont *)font1 Text2:(NSString *)text2 Color2:(UIColor *)color2 Font2:(UIFont *)font2 AllText:(NSString *)allText
{
    NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:allText];
    [str beginEditing];
    if (text1) {
        NSRange range1 = [allText rangeOfString:text1];
        [str addAttribute:(NSString *)(NSForegroundColorAttributeName) value:color1 range:range1];
        if (font1) {
            //            CTFontRef helveticaBold = CTFontCreateWithName((CFStringRef)font1.fontName,font1.pointSize,NULL);
            //        [str addAttribute:(id)kCTFontAttributeName value:(id)helveticaBold range:range1];
            [str addAttribute:NSFontAttributeName value:font1 range:range1];
            
        }
    }
    
    if (text2) {
        NSRange range2 = [allText rangeOfString:text2];
        [str addAttribute:(NSString *)(NSForegroundColorAttributeName) value:color2 range:range2];
        if (font2) {
            [str addAttribute:NSFontAttributeName value:font2 range:range2];
            
        }
    }
    
    [str endEditing];
    
    return str;
}

+(NSMutableAttributedString *)getAcolorfulStringWithTextArray:(NSArray *)array Color:(UIColor *)color Font:(UIFont *)font AllText:(NSString *)allText
{
    NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:allText];
    [str beginEditing];

    for (NSString * string in array) {
        if (str.length) {
            NSRange range1 = [allText rangeOfString:string];
            [str addAttribute:(NSString *)(NSForegroundColorAttributeName) value:color range:range1];
            if (font) {
                [str addAttribute:NSFontAttributeName value:font range:range1];
            }
        }
    }
    

    [str endEditing];

    return str;
}

+ (UILabel *)addAlabelForAView:(UIView *)aView withText:(NSString *)labelText frame:(CGRect)labelFrame font:(UIFont *)labelFont textColor:(UIColor *)labelColor
{
    UILabel *label = [[UILabel alloc]initWithFrame:labelFrame];
    //    label.textAlignment = NSTextAlignmentLeft;
    label.numberOfLines = 0;
    label.text = labelText;
    label.lineBreakMode = NSLineBreakByCharWrapping;
    label.backgroundColor = [UIColor clearColor];
    label.font = labelFont;
    if (labelColor) {
        label.textColor = labelColor;
        
    }
    [aView addSubview:label];
    return label;
}

+ (UIButton *)getAButtonWithFrame:(CGRect)frame nomalTitle:(NSString *)title1 hlTitle:(NSString *)title2 titleColor:(UIColor *)tColor bgColor:(UIColor *)BgColor nbgImage:(NSString *)image1 hbgImage:(NSString *)image2 action:(SEL)selector target:(id)delegate buttonTpye:(UIButtonType)theButtonTpye
{
    UIButton *button = nil;
    if (theButtonTpye) {
        button = [UIButton buttonWithType:theButtonTpye];
        
    }else{
        button = [UIButton buttonWithType:UIButtonTypeCustom];
    }
    
    button.frame = frame;
    if (title1) {[button setTitle:title1 forState:UIControlStateNormal];}
    if (title2) {[button setTitle:title1 forState:UIControlStateHighlighted];}
    if (tColor) {
        [button setTitleColor:tColor forState:UIControlStateNormal];
    }
    
    if (BgColor) {
        [button setBackgroundColor:BgColor];
    }
    
    if (image1) {[button setBackgroundImage:[UIImage imageNamed:image1] forState:UIControlStateNormal];}
    if (image2) {[button setBackgroundImage:[UIImage imageNamed:image2] forState:UIControlStateHighlighted];}
    if (delegate && selector) {
        [button addTarget:delegate action:selector forControlEvents:UIControlEventTouchUpInside];
    }
    
    return button;
    
}

+ (void)addLineToView:(UIView *)view frame:(CGRect)frame color:(UIColor *)color
{
    UIView *line = [[UIView alloc]initWithFrame:frame];
    line.backgroundColor = color;
    [view addSubview:line];
}

//计算内存
+ (int)sizeOfFolder:(NSString*)folderPath
{
    NSArray *contents;
    NSEnumerator *enumerator;
    NSString *path;
    contents = [[NSFileManager defaultManager] subpathsAtPath:folderPath];
    enumerator = [contents objectEnumerator];
    int fileSizeInt = 0;
    while (path = [enumerator nextObject]) {
        NSError *error;
        NSDictionary *fattrib = [[NSFileManager defaultManager] attributesOfItemAtPath:[folderPath stringByAppendingPathComponent:path] error:&error];
        fileSizeInt +=[fattrib fileSize];
    }
    return fileSizeInt;
}

+(BOOL)chickIphoneNumberRight:(NSString *)str
{
    NSString *regex = @"^((13[0-9])|(147)|(15[0-9])|(17[0-9])|(18[0-9]))\\d{8}$";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    BOOL isMatch = [pred evaluateWithObject:str];
    return isMatch;

}

+(BOOL)chickTextIsChinese:(NSString *)str
{
    for (int i =0;i<str.length;i++){
        unichar c = [str characterAtIndex:i];
        if (c>=0x4E00 && c<=0x9FA5){
            
        }else{
            return NO;
        }
    }
    
    return YES;
}

+ (BOOL)validateIdentityCard: (NSString *)identityCard
{
    BOOL flag;
    if (identityCard.length <= 0) {
        flag = NO;
        return flag;
    }
    NSString *regex2 = @"^(\\d{17})(\\d|[xX])$";
    NSPredicate *identityCardPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex2];
    return [identityCardPredicate evaluateWithObject:identityCard];
}


+ (NSString *)changeStringOrCode:(NSString *)str type:(NSString *)type table:(NSString *)table
{
    FMDatabase * db = [XDTools getDb];
    if (![db open]){
        DDLOG(@"open fail!");
        return nil;
    }
    NSString * queryString = @"";
    NSString * returenStr = @"";

    if ([type isEqualToString:@"name"]) {

        if ([table isEqualToString:@"T_P_COLLAGE"]) {
            queryString = [NSString stringWithFormat:@"SELECT * FROM %@ WHERE COLLAGE_NAME = %@",table,str];
        }else{
            queryString = [NSString stringWithFormat:@"SELECT * FROM %@ WHERE CITY_NAME = %@",table,str];
        }


        FMResultSet * rs = [db executeQuery:queryString];

        while ([rs next]) {
            if ([table isEqualToString:@"T_P_COLLAGE"]) {
                returenStr = [rs objectForColumnName:@"COLLAGE_CODE"];
            }else{
                returenStr = [rs objectForColumnName:@"CITY_CODE"];
            }
        }
    }else if ([type isEqualToString:@"code"]) {

        if ([table isEqualToString:@"T_P_COLLAGE"]) {
            queryString = [NSString stringWithFormat:@"SELECT * FROM %@ WHERE COLLAGE_ID = %@",table,str];
        }else{
            queryString = [NSString stringWithFormat:@"SELECT * FROM %@ WHERE CITY_ID = %@",table,str];
        }


        FMResultSet * rs = [db executeQuery:queryString];

        while ([rs next]) {
            if ([table isEqualToString:@"T_P_COLLAGE"]) {
                returenStr = [rs objectForColumnName:@"COLLAGE_NAME"];
            }else{
                returenStr = [rs objectForColumnName:@"CITY_NAME"];
            }
        }
    }

    [db close];

    return returenStr;

}

+ (NSString *)doDevicePlatform
{
    size_t size;
    int nR = sysctlbyname("hw.machine", NULL, &size, NULL, 0);
    char *machine = (char *)malloc(size);
    nR = sysctlbyname("hw.machine", machine, &size, NULL, 0);
    NSString *platform = [NSString stringWithCString:machine encoding:NSUTF8StringEncoding];
    free(machine);

    if ([platform isEqualToString:@"iPhone1,1"]) {

        platform = @"iPhone";

    } else if ([platform isEqualToString:@"iPhone1,2"]) {

        platform = @"iPhone 3G";

    } else if ([platform isEqualToString:@"iPhone2,1"]) {

        platform = @"iPhone 3GS";

    } else if ([platform isEqualToString:@"iPhone3,1"]||[platform isEqualToString:@"iPhone3,2"]||[platform isEqualToString:@"iPhone3,3"]) {

        platform = @"iPhone 4";

    } else if ([platform isEqualToString:@"iPhone4,1"]) {

        platform = @"iPhone 4S";

    } else if ([platform isEqualToString:@"iPhone5,1"]||[platform isEqualToString:@"iPhone5,2"]) {

        platform = @"iPhone 5";

    }else if ([platform isEqualToString:@"iPhone5,3"]||[platform isEqualToString:@"iPhone5,4"]) {

        platform = @"iPhone 5C";

    }else if ([platform isEqualToString:@"iPhone6,2"]||[platform isEqualToString:@"iPhone6,1"]) {

        platform = @"iPhone 5S";

    }else if ([platform isEqualToString:@"iPod4,1"]) {

        platform = @"iPod touch 4";

    }else if ([platform isEqualToString:@"iPod5,1"]) {

        platform = @"iPod touch 5";

    }else if ([platform isEqualToString:@"iPod3,1"]) {

        platform = @"iPod touch 3";

    }else if ([platform isEqualToString:@"iPod2,1"]) {

        platform = @"iPod touch 2";

    }else if ([platform isEqualToString:@"iPod1,1"]) {

        platform = @"iPod touch";

    } else if ([platform isEqualToString:@"iPad3,2"]||[platform isEqualToString:@"iPad3,1"]) {

        platform = @"iPad 3";

    } else if ([platform isEqualToString:@"iPad2,2"]||[platform isEqualToString:@"iPad2,1"]||[platform isEqualToString:@"iPad2,3"]||[platform isEqualToString:@"iPad2,4"]) {

        platform = @"iPad 2";

    }else if ([platform isEqualToString:@"iPad1,1"]) {

        platform = @"iPad 1";

    }else if ([platform isEqualToString:@"iPad2,5"]||[platform isEqualToString:@"iPad2,6"]||[platform isEqualToString:@"iPad2,7"]) {

        platform = @"ipad mini";

    } else if ([platform isEqualToString:@"iPad3,3"]||[platform isEqualToString:@"iPad3,4"]||[platform isEqualToString:@"iPad3,5"]||[platform isEqualToString:@"iPad3,6"]) {

        platform = @"ipad 3";

    }

    return platform;
}


+(void)setPushInfoType:(NSString *)type andValue:(NSString *)value
{
    [[NSUserDefaults standardUserDefaults] setObject:value forKey:[NSString stringWithFormat:@"push%@",type]];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+(BOOL)getPushValueWithType:(NSString *)type
{
    NSString * value = [[NSUserDefaults standardUserDefaults] valueForKey:[NSString stringWithFormat:@"push%@",type]];
    if ([value intValue]==0){
        return NO;
    }else{
        return YES;
    }
}


@end
