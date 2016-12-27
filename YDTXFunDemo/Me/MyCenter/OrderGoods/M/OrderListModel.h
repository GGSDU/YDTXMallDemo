//
//  OrderListModel.h
//  ReceivingGoods
//
//  Created by 舒通 on 2016/12/9.
//  Copyright © 2016年 yundiaoke. All rights reserved.
//


#import <Foundation/Foundation.h>

@interface OrderListModel : NSObject

@property (nonatomic, copy) NSString *goods_order_id;// 订单id

@property (nonatomic, copy) NSString *user_id;//用户id

@property (nonatomic, copy) NSString *goods_id;//商品id

@property (nonatomic, copy) NSString *images_url;//商品图片

@property (nonatomic, copy) NSString *goods_name;//商品名称

@property (nonatomic, copy) NSString *goods_model_id;//商品型号id

@property (nonatomic, copy) NSString *price;//价格

@property (nonatomic, copy) NSString *nums;//数量

@property (nonatomic, copy) NSString *total_price;//总价格

@property (nonatomic, copy) NSString *status;//-1为已取消，0为未付款 ，1为已付款， 2为待收货，3为退款，4为加入购物车
@property (nonatomic, copy) NSString *goods_order_num;//订单号
@property (nonatomic, copy) NSString *cou_id;//优惠券id 
//goods_order_num订单号
// cou_id优惠券id    0

@property (nonatomic, copy) NSString *state;//判定退款的状态


@property (nonatomic, assign) CGFloat cellHeight;

- (instancetype)initData:(NSDictionary *)dic;


@end
