//
//  OrderDrawBackViewController.h
//  YDTXFunDemo
//
//  Created by 舒通 on 2016/12/16.
//  Copyright © 2016年 Story5. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OrderDrawBackViewController : UIViewController
/*
 userid用户id
 order_id订单id
 goods_id商品id
 goods_name商品名称
 money商品金额
 */
@property (copy, nonatomic) NSString *order_id;
@property (copy, nonatomic) NSString *goods_id;
@property (copy, nonatomic) NSString *goods_name;
@property (copy, nonatomic) NSString *price;
@property (copy, nonatomic) NSString *total_price;
@property (copy, nonatomic) NSString *goods_model_id;//商品型号id
@property (copy, nonatomic) NSString *nums;


@end
