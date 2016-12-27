//
//  RecommentActionModel.m
//  YDTX
//
//  Created by 舒通 on 2016/12/22.
//  Copyright © 2016年 RookieHua. All rights reserved.
//

#import "RecommentActionModel.h"

@implementation RecommentActionModel

- (instancetype)initData:(NSDictionary *)dic
{
    if (self = [super init]) {
        
   
    self.ID = dic[@"id"];
    self.uid = dic[@"uid"];
    self.type = dic[@"type"];
    self.name = dic[@"name"];
    self.person = dic[@"person"];
    self.mobile = dic[@"mobile"];
    self.content = dic[@"content"];
    self.create_time = dic[@"create_time"];
    self.status = dic[@"status"];
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
