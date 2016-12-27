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
       
        NSLog(@"dic is :%@",dic);
        if (dic[@"mailNo"]) {
            
            self.mailNo = dic[@"mailNo"];
        }
        if (dic[@"state"]) {
            
            self.state = [dic[@"state"] intValue];
        }
        
        if (dic[@"courier"]) {
            
            self.courier = dic[@"courier"];
        }
        
        if ( dic[@"tel"]) {
            
            self.tel = dic[@"tel"];
        }
        if (dic[@"dataInfo"]) {
            
            self.dataInfo = dic[@"dataInfo"];
        }
        
//        for (NSDictionary *dic in self.dataInfo) {
//           self.detailModel = [[LogisticsDetailModel alloc]initData:dic];
//        }
//
        
        
    }

    return self;
}


@end
