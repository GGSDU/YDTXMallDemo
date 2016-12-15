//
//  SDReachability.h
//  SDNews
//
//  Created by JW on 16/6/13.
//  Copyright © 2016年 JW. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger, SDNetworkingType) {
    NetworkingTypeNoReachable = 1,
    NetworkingType3G = 2,
    NetworkingTypeWiFi = 3,
};

@interface SDReachability : NSObject

// 是否  联网
+(BOOL)connect;

// 当前网络类型
+(SDNetworkingType)currentNetworkingType;

@end
