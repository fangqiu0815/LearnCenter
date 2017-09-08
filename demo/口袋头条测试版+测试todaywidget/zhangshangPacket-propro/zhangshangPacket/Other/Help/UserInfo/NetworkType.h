
#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger, TelStatus) {
    TelStatusNone,
    TelStatusGPRS,// GPRS
    TelStatusEdge,// E
    TelStatus2G,
    TelStatus3G,
    TelStatus4G
};

@interface NetworkType : NSObject

+ (instancetype)shareNetworkType;

// 蜂窝网络状态
@property (nonatomic, readonly) TelStatus status;

// 蜂窝网络状态描述
@property (nonatomic, readonly) NSString *statusDescripetion;

// 运营商名称
@property (nonatomic, readonly) NSString *carrierName;


@end
