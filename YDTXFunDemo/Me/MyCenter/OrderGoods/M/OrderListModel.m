//
//  OrderListModel.m
//  ReceivingGoods
//
//  Created by 舒通 on 2016/12/9.
//  Copyright © 2016年 yundiaoke. All rights reserved.
//

#import "OrderListModel.h"

@implementation OrderListModel


- (instancetype)initData:(NSDictionary *)dic {
    if (self = [super init]) {
        self.goods_order_id = dic[@"goods_order_id"];
        self.user_id = dic[@"user_id"];
        self.goods_id = dic[@"goods_id"];
        self.images_url = dic[@"images_url"];
        self.goods_name = dic[@"goods_name"];
        self.goods_model_id = dic[@"goods_model_id"];
        self.price = dic[@"price"];
        self.nums = dic[@"nums"];
        self.total_price = dic[@"total_price"];
        self.status = dic[@"status"];
        
        if (dic[@"state"]) {
            self.state = dic[@"state"];
        }
        
    }
    return self;
}

//- (CGFloat)cellHeight {
//    
//    
//    
//    
//}



@end
