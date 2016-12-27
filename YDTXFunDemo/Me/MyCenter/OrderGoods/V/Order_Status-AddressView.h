//
//  Order_Status-AddressView.h
//  ReceivingGoods
//
//  Created by 舒通 on 2016/12/9.
//  Copyright © 2016年 yundiaoke. All rights reserved.
//

#import <UIKit/UIKit.h>
@class OrderGoodsModel;

@interface Order_Status_AddressView : UIImageView

// style : 订单状态
- (instancetype)initWithFrame:(CGRect)frame orderModel:(OrderGoodsModel *)model;

@end
