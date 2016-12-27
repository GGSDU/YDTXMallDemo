//
//  RecommentSpotModel.h
//  YDTX
//
//  Created by 舒通 on 2016/12/22.
//  Copyright © 2016年 RookieHua. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RecommentSpotModel : NSObject


/**
* status : 200
* message : 请求成功
* data : [{"id":"1","uid":"69","name":"好糖","price":"100/天","person":"糖糖","phone":"13507075404","basan":"1","special":null,"img":"","content":"这是一个好糖","prov":"江西省","city":"九江市","area":"彭泽县","address":"县广场1010号","fishtype":"草鱼，鲫鱼，鲶鱼","create_time":"2016-12-07 11:31:56","status":"2","is_del":"0"}]
*/

@property (copy, nonatomic) NSString *ID;//数据id
@property (copy, nonatomic) NSString *prov;//省
@property (copy, nonatomic) NSString *status;//数据状态
@property (copy, nonatomic) NSString *uid;//用户id
@property (copy, nonatomic) NSString *phone;//电话
@property (copy, nonatomic) NSString *basan;//类型
@property (copy, nonatomic) NSString *area;//地区
@property (copy, nonatomic) NSString *img;//图片数组
@property (strong, nonatomic) NSArray *special;//特色
@property (copy, nonatomic) NSString *price;//价格
@property (copy, nonatomic) NSString *address;//地址
@property (copy, nonatomic) NSString *person;//负责人
@property (copy, nonatomic) NSString *city;//城市
@property (copy, nonatomic) NSString *fishtype;//塘口类型
@property (copy, nonatomic) NSString *id_del;//
@property (copy, nonatomic) NSString *create_time;//创建时间
@property (copy, nonatomic) NSString *name;//塘口名称
@property (copy, nonatomic) NSString *content;//塘口描述


- (instancetype)initData:(NSDictionary *) dic;

@end
