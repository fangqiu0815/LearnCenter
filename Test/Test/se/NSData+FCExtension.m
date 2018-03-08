//
//  NSData+FCExtension.m
//  FCCore
//
//  Created by admin  on 2017/6/21.
//  Copyright © 2017年 admin . All rights reserved.
//

#import "NSData+FCExtension.h"
#import "NSString+FCSecurity.h"
#import "FCSecurity.h"

@implementation NSData (FCExtension)

- (id)jsonObject
{
    NSError *error;
    id obj =  [NSJSONSerialization JSONObjectWithData:self options:NSJSONReadingAllowFragments error:&error];
    return obj;
}

- (id)aesJsonObject
{
    NSString *dataResult =  [[NSString alloc] initWithData:self encoding:NSUTF8StringEncoding];
    NSString *jsonResult = [dataResult aesDecrypt];
    jsonResult = [jsonResult stringByReplacingOccurrencesOfString:@"\0" withString:@""];
    
    NSData *jsonData = [jsonResult dataUsingEncoding:NSUTF8StringEncoding];
    return jsonData.jsonObject;
}

@end
