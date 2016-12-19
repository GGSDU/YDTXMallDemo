//
//  ReceiveTableViewController.h
//  ReceivingGoods
//
//  Created by 舒通 on 2016/12/6.
//  Copyright © 2016年 yundiaoke. All rights reserved.
//

#import <UIKit/UIKit.h>

@class AddressListModel;

@interface ReceiveTableViewController : UITableViewController

@property (nonatomic, assign) BOOL isMe;//判断是否是从个人中心进入 true 个人中心  false 商城

@end
