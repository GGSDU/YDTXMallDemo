//
//  CouponModel.m
//  YDTXFunDemo
//
//  Created by 舒通 on 2016/12/16.
//  Copyright © 2016年 Story5. All rights reserved.
//

#import "CouponModel.h"

@implementation CouponModel


- (instancetype)initData:(NSDictionary *) dic {
   
    if (self = [super init]) {
       
        self.ID = dic[@"id"];
        self.gid = dic[@"gid"];
        self.name = dic[@"name"];
        self.full = dic[@"full"];
        self.cut = dic[@"cut"];
        self.discount = dic[@"discount"];
        self.start_time = dic[@"start_time"];
        self.end_time = dic[@"end_time"];
        self.type = dic[@"type"];
        self.status = dic[@"status"];
        self.create_time = dic[@"create_time"];
        self.is_del = dic[@"is_del"];
        
    }
    return self;
}


- (void)setValue:(id)value forKey:(NSString *)key {
    if ([key isEqualToString:@"id"]) {
        self.ID = value;
    }
}

@end
