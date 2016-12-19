//
//  LogisticsModel.h
//  YDTXFunDemo
//
//  Created by 舒通 on 2016/12/14.
//  Copyright © 2016年 Story5. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LogisticsModel : NSObject

@property (nonatomic, copy) NSString *status;//是否在当前位置
@property (nonatomic, copy) NSString *creat_time;
@property (nonatomic, copy) NSString *address;


-(instancetype)initData:(NSDictionary*)dic;
@end
