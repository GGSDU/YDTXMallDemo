//
//  LogisticsDetailModel.m
//  YDTX
//
//  Created by 舒通 on 2016/12/22.
//  Copyright © 2016年 RookieHua. All rights reserved.
//

#import "LogisticsDetailModel.h"

@implementation LogisticsDetailModel

- (instancetype)initData:(NSDictionary *)dic {
    if (self = [super init]) {
        
        self.time = dic[@"time"];
        self.context = dic[@"context"];
        
    }
    
    return self;
}


@end
