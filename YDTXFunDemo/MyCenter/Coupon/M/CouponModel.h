//
//  CouponModel.h
//  YDTXFunDemo
//
//  Created by 舒通 on 2016/12/16.
//  Copyright © 2016年 Story5. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CouponModel : NSObject

@property (copy, nonatomic) NSString *ID;// 优惠券id
@property (copy, nonatomic) NSString *gid;// 商品id
@property (copy, nonatomic) NSString *name;// 优惠券名字
@property (copy, nonatomic) NSString *full;//满足优惠券的价格
@property (copy, nonatomic) NSString *cut;// 满减价格
@property (copy, nonatomic) NSString *discount;//折扣
@property (copy, nonatomic) NSString *start_time;//开始时间
@property (copy, nonatomic) NSString *end_time;//结束时间
@property (copy, nonatomic) NSString *type;//满减、折扣 的类型
@property (copy, nonatomic) NSString *status;//
@property (copy, nonatomic) NSString *create_time;//创建时间
@property (copy, nonatomic) NSString *is_del;// 是否删除


- (instancetype)initData:(NSDictionary *) dic;

@end
