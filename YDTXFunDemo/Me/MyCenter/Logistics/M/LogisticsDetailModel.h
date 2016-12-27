//
//  LogisticsDetailModel.h
//  YDTX
//
//  Created by 舒通 on 2016/12/22.
//  Copyright © 2016年 RookieHua. All rights reserved.
//

#import <Foundation/Foundation.h>

/*
 "time": "2016-12-20 04:42:07",
 "context": "上海转运中心 已发出,下一站 上海市闵行九星"
 */

@interface LogisticsDetailModel : NSObject

@property (copy, nonatomic) NSString *time;
@property (copy, nonatomic) NSString *context;

- (instancetype)initData:(NSDictionary *)dic;

@end
