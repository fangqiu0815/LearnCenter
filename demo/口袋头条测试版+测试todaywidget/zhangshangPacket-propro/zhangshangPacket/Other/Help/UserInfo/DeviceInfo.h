//
//  DeviceInfo.h
//  MyLottery
//
//  Created by 项目 on 16/9/26.
//  Copyright © 2016年 项目. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import <AdSupport/AdSupport.h>
#import "sys/utsname.h"

#include <sys/socket.h> // Per msqr
#include <net/if.h>
#include <net/if_dl.h>

#import <CommonCrypto/CommonDigest.h>
#include <sys/types.h>
#include <sys/sysctl.h>
#include <mach/machine.h>
#include <sys/resource.h>
#include <sys/vm.h>
#include <stdio.h>
#include <stdlib.h>
#include <dlfcn.h>
#import "sys/utsname.h"
#import <device/device_types.h>
#include <sys/param.h>
#include <sys/mount.h>



#import <SystemConfiguration/CaptiveNetwork.h>
#import "Reachability.h"
#import "NetworkType.h"

#import <ifaddrs.h>


#import <CoreTelephony/CTTelephonyNetworkInfo.h>
#import <CoreTelephony/CTCarrier.h>

#import "STAFNetWorking.h"

#define DeviceInfo_shared [DeviceInfo sharedDeviceInfo]

typedef struct _DeviceInfo {
    NSString* (*_value)(void);
    NSString* (*getIDFA)(void);
    NSString* (*getMacAddress)(void);
    NSString* (*getOSVersion)(void);
    NSString* (*getDeviceType)(void);
    NSString* (*getYueYuState)(void);
    NSString* (*getCardState)(void);
    NSString* (*getLanguageType)(void);
    NSString* (*isVPNConnected)(void);
    NSString* (*getCarrierName)(void);
    NSString* (*getNetworkStatus)(void);
    NSString* (*getRouterName)(void);
    NSString* (*getRouterMac)(void);
    NSString* (*getAPPBundleId)(void);
    NSString* (*getAPPVersion)(void);
    NSString* (*getAPPIDFV)(void);
}DeviceInfo_t;



@interface DeviceInfo : NSObject


+(DeviceInfo_t *)sharedDeviceInfo;



@end
