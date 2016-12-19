//
//  LogisticsModel.m
//  YDTXFunDemo
//
//  Created by 舒通 on 2016/12/14.
//  Copyright © 2016年 Story5. All rights reserved.
//

#import "LogisticsModel.h"

@implementation LogisticsModel

-(instancetype)initData:(NSDictionary*)dic {
    if ([super init]) {
       
        self.status = dic[@"status"];
        self.address = dic[@"address"];
        self.creat_time = dic[@"creat_time"];
    }

    return self;
}


@end
