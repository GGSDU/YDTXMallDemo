//
//  EquityModel.m
//  YDTXFunDemo
//
//  Created by 舒通 on 2016/12/14.
//  Copyright © 2016年 Story5. All rights reserved.
//

#import "EquityModel.h"

@implementation EquityModel

- (instancetype)initData:(NSDictionary *) dic {
    
    if (self = [super init]) {
       
//        NSInteger integer = [dic[@"type"] integerValue];
        self.data = dic[@"data"];
        NSLog(@"self.type is :%@",self.data);
    }
    
    return self;
}
@end
