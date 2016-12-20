//
//  SDReachability.m
//  SDNews
//
//  Created by JW on 16/6/13.
//  Copyright © 2016年 JW. All rights reserved.
//

#import "SDReachability.h"
#import "Reachability.h"

@implementation SDReachability

// 是否联网
+ (BOOL)connect
{
    
    if ([[Reachability reachabilityForInternetConnection] currentReachabilityStatus] == NotReachable) {
        return NO;
    }
    return YES;
}
// 当前网络类型
+(SDNetworkingType)currentNetworkingType {
    
    Reachability *reachablility =  [Reachability reachabilityWithHostName:@"www.baidu.com"];
    
    if ([reachablility currentReachabilityStatus] == ReachableViaWiFi) {
        return NetworkingTypeWiFi;
    } else if ([reachablility currentReachabilityStatus] == ReachableViaWWAN) {
        return NetworkingType3G;
    }
    // 不是WiFi和3G就返回 没联网
    return NetworkingTypeNoReachable;
}


@end
