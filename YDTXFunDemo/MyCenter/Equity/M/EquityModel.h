//
//  EquityModel.h
//  YDTXFunDemo
//
//  Created by 舒通 on 2016/12/14.
//  Copyright © 2016年 Story5. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface EquityModel : NSObject

@property (nonatomic, strong) NSArray *data;

- (instancetype)initData:(NSDictionary *) dic;

@end
