//
//  OrderGoodsModel.m
//  ReceivingGoods
//
//  Created by 舒通 on 2016/12/8.
//  Copyright © 2016年 yundiaoke. All rights reserved.
//

#import "OrderGoodsModel.h"

@implementation OrderGoodsModel

- (instancetype)initData:(NSDictionary *)dic {
    if (self = [super init]) {
        self.goods_order_id = dic[@"goods_order_id"];
        self.goods_order_num = dic[@"goods_order_num"];
        self.images_url = dic[@"images_url"];
        self.goods_name = dic[@"goods_name"];
        self.models = dic[@"models"];
        self.price = dic[@"price"];
        self.nums = dic[@"nums"];
        self.total_price = dic[@"total_price"];
        self.courier = dic[@"courier"];
        self.status = dic[@"status"];
        self.create_time = dic[@"create_time"];
        self.user_name = dic[@"user_name"];
        self.mobile = dic[@"mobile"];
        self.prov = dic[@"prov"];
        self.city = dic[@"city"];
        self.area = dic[@"area"];
        self.address = dic[@"address"];
    }
    
    return self;
}

- (CGFloat)cellHeight {
    if (!_cellHeight) {
      
        
        
    }
    
    
    return _cellHeight;
}


@end
