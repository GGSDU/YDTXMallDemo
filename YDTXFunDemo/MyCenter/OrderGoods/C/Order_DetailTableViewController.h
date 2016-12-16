//
//  Order_DetailTableViewController.h
//  ReceivingGoods
//
//  Created by 舒通 on 2016/12/9.
//  Copyright © 2016年 yundiaoke. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Order_DetailTableViewController : UITableViewController

@property (nonatomic, assign) BOOL isFinish;//判断订单是否完成
@property (nonatomic, copy) NSString *goods_order_id;//订单号

@end
