

#import "NetworkType.h"
#import <CoreTelephony/CTTelephonyNetworkInfo.h>
#import <CoreTelephony/CTCarrier.h>

static id _st_observer = nil;

@implementation NetworkType{
    CTTelephonyNetworkInfo *_networkInfo;
    TelStatus _status;
}


- (void)dealloc{
    [_st_observer removeObserver:self];
}

+ (instancetype)shareNetworkType{
    static dispatch_once_t onceToken;
    static NetworkType *_st_shared_netlisten = nil;
    dispatch_once(&onceToken, ^{
        _st_shared_netlisten = [self new];
    });
    return _st_shared_netlisten;
}

- (instancetype)init{
    if (self = [super init]){
        _networkInfo = [CTTelephonyNetworkInfo new];
        [self updateStatus];
        [self registerNotification];
    }
    return self;
}

- (void)registerNotification{
    NSNotificationCenter *nitifC = [NSNotificationCenter defaultCenter];
    _st_observer = [nitifC addObserverForName:CTRadioAccessTechnologyDidChangeNotification
                                       object:nil queue:[NSOperationQueue mainQueue]
                                   usingBlock:^(NSNotification *note) {
                                       [self updateStatus];
                                   }];
}

- (void)updateStatus{
    NSString *info = _networkInfo.currentRadioAccessTechnology;
    if ([info isEqualToString:CTRadioAccessTechnologyGPRS]){
        _status = TelStatusGPRS;
    }else if ([info isEqualToString:CTRadioAccessTechnologyEdge]){
        _status = TelStatusEdge;
    }else if ([info isEqualToString:CTRadioAccessTechnologyCDMA1x]){
        _status = TelStatus2G;
    }else if ([info isEqualToString:CTRadioAccessTechnologyWCDMA] ||
              [info isEqualToString:CTRadioAccessTechnologyHSDPA] ||
              [info isEqualToString:CTRadioAccessTechnologyHSUPA] ||
              [info isEqualToString:CTRadioAccessTechnologyCDMAEVDORev0] ||
              [info isEqualToString:CTRadioAccessTechnologyCDMAEVDORevA] ||
              [info isEqualToString:CTRadioAccessTechnologyCDMAEVDORevB] ||
              [info isEqualToString:CTRadioAccessTechnologyeHRPD]){
        _status = TelStatus3G;
    }else if ([info isEqualToString:CTRadioAccessTechnologyLTE]){
        _status = TelStatus4G;
    }else{
        _status = TelStatusNone;
    }
}

- (TelStatus)status{
    return _status;
}
- (NSString *)statusDescripetion{
    switch (_status) {
        case TelStatusGPRS:{
            return @"GPRS";
            break;
        }
        case TelStatusEdge:{
            return @"E";
            break;
        }
        case TelStatus2G:{
            return @"2G";
            break;
        }
        case TelStatus3G:{
            return @"3G";
            break;
        }
        case TelStatus4G:{
            return @"4G";
            break;
        }
        default:
            break;
    }
    return @"4G";
}

- (NSString *)carrierName{
    return _networkInfo.subscriberCellularProvider.carrierName;
}

- (NSString *)description{
    CTCarrier *c = _networkInfo.subscriberCellularProvider;
    return [NSString stringWithFormat:@"(%@)(%@-%@-%@-%@)",[self statusDescripetion],c.carrierName,c.mobileCountryCode,c.mobileNetworkCode,c.isoCountryCode];
}

@end
