//
//  MeCollectionModel.m
//  YDTX
//
//  Created by 舒通 on 16/9/29.
//  Copyright © 2016年 RookieHua. All rights reserved.
//

#import "MeTKCollectionModel.h"

@implementation MeTKCollectionModel : NSObject 
+(NSDictionary *)mj_replacedKeyFromPropertyName
{
    return @{
             
             @"ID" : @"id"
             };
}


@end
