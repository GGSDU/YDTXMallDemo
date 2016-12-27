//
//  AddressListModel.h
//  ReceivingGoods
//
//  Created by 舒通 on 2016/12/9.
//  Copyright © 2016年 yundiaoke. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AddressListModel : NSObject
/*
 http://test.m.yundiaoke.cn/api/user/listAddress/user_id/55
 请求方式：get
 参数：User_id：当前用户ID
 返回字段：
 adres_id：数据id
 User_name：收货人名字
 Mobile：收货人电话
 Prov：省份
 City：城市
 Area：区
 Address：详细地址
 Zcode：邮编
 Status：是否设为默认收货地址，默认为0，1为设置该地址为默认地址
 200：成功，400：失败，401：数据不合法，403：非法参数
 
 */

//@property (nonatomic, copy) NSString *user_id;//
@property (nonatomic, copy) NSString *adres_id;//数据id
@property (nonatomic, copy) NSString *user_name;//收货人名字
@property (nonatomic, copy) NSString *mobile;//收货人电话
@property (nonatomic, copy) NSString *prov;//
@property (nonatomic, copy) NSString *city;//
@property (nonatomic, copy) NSString *area;//
@property (nonatomic, copy) NSString *address;//
@property (nonatomic, copy) NSString *zcode;//邮编
@property (nonatomic, copy) NSString *status;//是否设为默认收货地址，默认为0，1为设置该地址为默认地址

@end
