//
//  RecommentSpotModel.m
//  YDTX
//
//  Created by 舒通 on 2016/12/22.
//  Copyright © 2016年 RookieHua. All rights reserved.
//

#import "RecommentSpotModel.h"

@implementation RecommentSpotModel


    
    

- (void)setValue:(id)value forKey:(NSString *)key {

    if ([key isEqualToString:@"id"]) {
        self.ID = value;
        
        
    }
}
- (instancetype)initData:(NSDictionary *)dic {
    
    if (self = [super init]) {
        
        self.ID = dic[@"id"];
        self.prov = dic[@"prov"];
        self.status = dic[@"status"];
        self.uid = dic[@"uid"];
        self.phone = dic[@"phone"];
        self.basan = dic[@"basan"];
        self.area = dic[@"area"];
        self.img = dic[@"img"];
        self.special = dic[@"special"];
        self.price = dic[@"price"];
        self.address = dic[@"address"];
        self.person = dic[@"person"];
        self.city = dic[@"city"];
        self.fishtype = dic[@"fishtype"];
        self.id_del = dic[@"id_del"];
        self.create_time = dic[@"create_time"];
        self.name = dic[@"name"];
        self.content = dic[@"content"];
        
    }
    return self;
}



@end
