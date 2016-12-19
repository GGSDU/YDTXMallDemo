//
//  MyOrderGoodsModel.h
//  YDTX
//
//  Created by 舒通 on 16/9/28.
//  Copyright © 2016年 RookieHua. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MyOrderGoodsModel : NSObject


@property (nonatomic, strong) NSString *order_id;//订单id
@property (nonatomic, strong) NSString *order_num;//订单号
@property (nonatomic, strong) NSString *act_id;//活动id
@property (nonatomic, strong) NSString *act_theme;//活动的名称
@property (nonatomic, strong) NSString *price;//单价
@property (nonatomic, strong) NSString *num;//下单的数量
@property (nonatomic, strong) NSString *total_price;//总价格
@property (nonatomic, strong) NSString *act_address;//活动的地址
@property (nonatomic, strong) NSString *joindate;//活动的时间
@property (nonatomic, strong) NSString *jointime;//活动的时间段
@property (nonatomic, strong) NSString *create_time;//下单时间
@property (nonatomic, strong) NSString *content;//活动的图片地址
@property (nonatomic, assign) NSInteger status;//订单状态



@end
