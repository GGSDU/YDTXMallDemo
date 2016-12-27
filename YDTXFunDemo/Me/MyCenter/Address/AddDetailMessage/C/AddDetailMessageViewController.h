//
//  AddDetailMessageViewController.h
//  ReceivingGoods
//
//  Created by 舒通 on 2016/12/6.
//  Copyright © 2016年 yundiaoke. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AddDetailMessageViewController : UIViewController

@property (nonatomic, assign) BOOL isEdit;//是否是修改地址 true 是修改地址   false 是添加地址
@property (nonatomic, copy) NSString *addressID;//地址的id

@end
