//
//  OrderGoodsModel.h
//  ReceivingGoods
//
//  Created by 舒通 on 2016/12/8.
//  Copyright © 2016年 yundiaoke. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface OrderGoodsModel : NSObject


 /*
 //订单详情
 http://test.m.yundiaoke.cn/api/goodsOrder/orderDetail/order_num/2016121317214114753534
 请求方式：GET
 参数：order_num：商品的订单号
 
 返回字段：
 goods_order_id：数据id
 goods_order_num：订单号
 images_url：商品图片
 goods_name：商品名称
 Models：商品型号
 Price：价格
 Nums:数量
 Total_price:总价格
 Courier:快递名称
 Status: -1为已取消，0为未付款 ，1为已付款， 2为待收货，3为退款，4为加入购物车
 create_time:下单时间
 User_name：收货人名字
 Mobile：收货人电话
 Prov：省份
 City：城市
 Area：区
 Address：详细地址
 
 */

@property (nonatomic, copy) NSString *goods_order_id;//数据id
@property (nonatomic, copy) NSString *goods_order_num;//订单号
@property (nonatomic, copy) NSString *images_url;//商品图片
@property (nonatomic, copy) NSString *goods_name;//商品名称
@property (nonatomic, copy) NSString *models;//商品型号
@property (nonatomic, copy) NSString *price;//价格
@property (nonatomic, copy) NSString *nums;// 数量
@property (nonatomic, copy) NSString *total_price;// 总价格
@property (nonatomic, copy) NSString *courier;//快递名称
@property (nonatomic, copy) NSString *status;//-1为已取消，0为未付款 ，1为已付款， 2为待收货，3为退款，4为加入购物车
@property (nonatomic, copy) NSString *create_time;//下单时间
@property (nonatomic, copy) NSString *user_name;//名字
@property (nonatomic, copy) NSString *mobile;//电话
@property (nonatomic, copy) NSString *prov;//省
@property (nonatomic, copy) NSString *city;//市
@property (nonatomic, copy) NSString *area;//区
@property (nonatomic, copy) NSString *address;//详细地址



@property (nonatomic, assign) CGFloat cellHeight;//cell的高度


- (instancetype)initData:(NSDictionary *)dic ;

@end
