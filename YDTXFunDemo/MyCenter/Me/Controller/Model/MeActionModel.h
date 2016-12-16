//
//  MeActionModel.h
//  YDTX
//
//  Created by 舒通 on 16/9/29.
//  Copyright © 2016年 RookieHua. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MeActionModel : NSObject


@property (nonatomic, strong) NSString *ID;//数据id
@property (nonatomic, strong) NSString *pid;//关联活动的id
@property (nonatomic, strong) NSString *userid;//用户id
@property (nonatomic, strong) NSString *is_del;//1为已收藏，0为未收藏
@property (nonatomic, strong) NSString *act_id;//活动id
@property (nonatomic, strong) NSString *theme;//活动名称
@property (nonatomic, strong) NSString *begin_time;//开始时间
@property (nonatomic, strong) NSString *end_time;//结束时间
@property (nonatomic, strong) NSString *act_prov;//省份
@property (nonatomic, strong) NSString *act_city;//城市
@property (nonatomic, strong) NSString *act_area;//区域
@property (nonatomic, strong) NSString *adress;//地址
@property (nonatomic, strong) NSString *content;//图片
@property (nonatomic, strong) NSString *biaoqian;//0为结束，1为满员，2为进行中


@end
