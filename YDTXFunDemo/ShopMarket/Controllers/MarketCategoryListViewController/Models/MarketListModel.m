//
//  marketListModel.m
//  YDTXFunDemo
//
//  Created by RookieHua on 2016/12/15.
//  Copyright © 2016年 Story5. All rights reserved.
//

#import "MarketListModel.h"

@implementation MarketListModel

+(NSDictionary *)mj_replacedKeyFromPropertyName
{
    return @{
             
             @"ID" : @"id"
             };
}


-(void)setImages_url:(NSString *)images_url{

    _images_url = [NSString stringWithFormat:@"http://%@",images_url];
}

@end
